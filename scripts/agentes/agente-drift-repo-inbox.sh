#!/usr/bin/env bash
# =============================================================================
# AGENTE: agente-drift-repo-inbox
# FUNCIÓN ÚNICA: Detecta drift entre la estructura lógica de la repo principal
#                y la estructura espejo de inbox/.
# TIPO: auditor
# VERSIÓN: 1.0.0
# USO: bash scripts/agentes/agente-drift-repo-inbox.sh [--apply] [--dry-run]
# =============================================================================
set -euo pipefail
IFS=$'\n\t'

REPO_ROOT="${REPO_ROOT:-.}"
INBOX="${REPO_ROOT}/inbox"
META="${INBOX}/_meta"
FECHA=$(date -u +'%Y-%m-%dT%H:%M:%SZ')
APPLY=false
DRY_RUN=false

log(){ printf '%s [drift-repo-inbox] %s\n' "$FECHA" "$*"; }
err(){ log "ERROR: $*" >&2; exit 1; }
trap 'err "Error inesperado en línea $LINENO"' ERR

while [[ "${1:-}" != "" ]]; do
  case "$1" in
    --apply) APPLY=true; shift ;;
    --dry-run) DRY_RUN=true; shift ;;
    -h|--help) grep '^#' "$0" | head -20; exit 0 ;;
    *) shift ;;
  esac
done

mkdir -p "$META"
REPORT="$META/drift-repo-inbox-$(date -u +%Y%m%dT%H%M%SZ).md"

# Carpetas que NO deben contar como ecosistemas de negocio
EXCLUIR_REPO='^\.(git|github|vscode|obsidian)$|^(scripts|docs|templates|assets|docker|mcp|setup|sesiones|inbox)$'
EXCLUIR_INBOX='^(_meta|descartados|clasificados|investigaciones|sesiones)$'

# Obtener ecosistemas de la repo
mapfile -t REPO_DIRS < <(
  find "$REPO_ROOT" -maxdepth 1 -mindepth 1 -type d -printf '%f\n' \
  | grep -Ev "$EXCLUIR_REPO" \
  | sort
)

# Obtener ecosistemas de inbox
mapfile -t INBOX_DIRS < <(
  find "$INBOX" -maxdepth 1 -mindepth 1 -type d -printf '%f\n' 2>/dev/null \
  | grep -Ev "$EXCLUIR_INBOX" \
  | sort
)

{
  echo "# Drift repo ↔ inbox"
  echo "- Fecha: $FECHA"
  echo "- Repo root: $REPO_ROOT"
  echo "- Inbox: $INBOX"
  echo
} > "$REPORT"

# 1) En repo pero no en inbox
echo "## Ecosistemas en repo pero ausentes en inbox" >> "$REPORT"
for d in "${REPO_DIRS[@]}"; do
  if ! printf '%s\n' "${INBOX_DIRS[@]}" | grep -qx "$d"; then
    echo "- FALTA en inbox: $d" >> "$REPORT"
    log "Falta en inbox: $d"
    if $APPLY; then
      if $DRY_RUN; then
        log "[DRY-RUN] mkdir -p \"$INBOX/$d\""
      else
        mkdir -p "$INBOX/$d"
        touch "$INBOX/$d/.keep"
        log "Creado inbox/$d"
      fi
    fi
  fi
done
echo >> "$REPORT"

# 2) En inbox pero no en repo
echo "## Ecosistemas en inbox pero ausentes en repo" >> "$REPORT"
for d in "${INBOX_DIRS[@]}"; do
  if ! printf '%s\n' "${REPO_DIRS[@]}" | grep -qx "$d"; then
    echo "- SOBRA en inbox o está obsoleto: $d" >> "$REPORT"
    log "Existe en inbox pero no en repo: $d"
  fi
done
echo >> "$REPORT"

# 3) Archivos huérfanos en raíz inbox
echo "## Archivos huérfanos en raíz de inbox" >> "$REPORT"
find "$INBOX" -maxdepth 1 -type f ! -name '.keep' -printf '%f\n' | while read -r f; do
  echo "- HUÉRFANO: $f" >> "$REPORT"
  log "Archivo huérfano en inbox/: $f"
done
echo >> "$REPORT"

# 4) Nombres sospechosos / duplicados semánticos
echo "## Nombres sospechosos" >> "$REPORT"
for pareja in "diary diarios" "osint osint-stack" "tool tools" "cli-tools scripts"; do
  a=$(echo "$pareja" | awk '{print $1}')
  b=$(echo "$pareja" | awk '{print $2}')
  if [[ -d "$REPO_ROOT/$a" && -d "$REPO_ROOT/$b" ]]; then
    echo "- POSIBLE DRIFT SEMÁNTICO: $a / $b" >> "$REPORT"
    log "Drift semántico detectado: $a / $b"
  fi
done
echo >> "$REPORT"

log "Reporte generado en $REPORT"
