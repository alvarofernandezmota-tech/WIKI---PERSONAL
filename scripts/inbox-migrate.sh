#!/bin/bash
# ============================================================
# inbox-migrate.sh — Yggdrasil-Dew
# Regla: la inbox es solo para el DIA DE HOY.
# Todo lo de mas de 24h va a su carpeta definitiva.
# Uso: ./scripts/inbox-migrate.sh
#      ./scripts/inbox-migrate.sh --dry-run
# ============================================================

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
INBOX="$REPO_DIR/inbox"
ARCHIVO="$REPO_DIR/diarios/archivo-jun2026"
HOY=$(date +%Y-%m-%d)
DRY_RUN=false

[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

mkdir -p "$ARCHIVO"

echo "======================================"
echo "  inbox-migrate.sh — $(date '+%Y-%m-%d %H:%M')"
echo "  Hoy: $HOY"
echo "  Dry-run: $DRY_RUN"
echo "======================================"

MOVIDOS=0
YA_HOY=0

for f in "$INBOX"/*.md; do
    [[ -f "$f" ]] || continue
    nombre=$(basename "$f")

    # Ignorar ficheros permanentes del inbox
    case "$nombre" in
        MASTER-PENDIENTES.md|README.md) continue ;;
    esac

    # Extraer fecha del nombre (formato YYYY-MM-DD-*.md)
    fecha=$(echo "$nombre" | grep -oP '^\d{4}-\d{2}-\d{2}' || echo "")

    if [[ -z "$fecha" || "$fecha" == "$HOY" ]]; then
        YA_HOY=$((YA_HOY + 1))
        continue
    fi

    # Determinar mes para subcarpeta archivo
    mes=$(echo "$fecha" | grep -oP '^\d{4}-\d{2}')
    destino="$REPO_DIR/diarios/archivo-$mes"
    mkdir -p "$destino"

    if [[ "$DRY_RUN" == true ]]; then
        echo "  [DRY] $nombre  ->  diarios/archivo-$mes/"
    else
        mv "$f" "$destino/$nombre"
        echo "  [OK]  $nombre  ->  diarios/archivo-$mes/"
        MOVIDOS=$((MOVIDOS + 1))
    fi
done

echo "--------------------------------------"
echo "  Archivos de hoy ($HOY): $YA_HOY"
if [[ "$DRY_RUN" == true ]]; then
    echo "  (dry-run: nada movido)"
else
    echo "  Archivos migrados: $MOVIDOS"
    if [[ $MOVIDOS -gt 0 ]]; then
        cd "$REPO_DIR"
        git add -A
        git commit -m "chore: inbox-migrate automatico $HOY — $MOVIDOS ficheros"
        echo "  Commit creado. Haz git push cuando quieras."
    else
        echo "  Nada que migrar — inbox ya limpio."
    fi
fi
echo "======================================"
