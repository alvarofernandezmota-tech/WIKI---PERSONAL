#!/usr/bin/env bash
# =============================================================================
# inbox-clasificador.sh — Mueve archivos de inbox/drop/ al destino correcto
#                         según nombre y extensión.
#
# REGLAS DE CLASIFICACIÓN:
#   *.md con "sesion" o "cierre" en el nombre  → inbox/sesiones/
#   *.md con "diario" o fecha YYYY-MM-DD        → diarios/
#   *.md genérico                               → inbox/docs/
#   *.sh                                        → scripts/ (aviso, no mueve)
#   *.py                                        → inbox/code/
#   *.log                                       → inbox/logs/
#   *                                           → inbox/misc/
#
# USO:
#   bash scripts/inbox-clasificador.sh           # mover archivos
#   bash scripts/inbox-clasificador.sh --dry-run # solo mostrar qué haría
# =============================================================================
set -euo pipefail

DRY_RUN=false
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo "$HOME/yggdrasil-dew")"
DROP_DIR="$REPO_ROOT/inbox/drop"

mkdir -p \
  "$REPO_ROOT/inbox/sesiones" \
  "$REPO_ROOT/inbox/docs" \
  "$REPO_ROOT/inbox/code" \
  "$REPO_ROOT/inbox/logs" \
  "$REPO_ROOT/inbox/misc" \
  "$REPO_ROOT/diarios"

move_file() {
  local src="$1"
  local dst="$2"
  local filename
  filename="$(basename "$src")"
  if $DRY_RUN; then
    echo "[DRY-RUN] $src → $dst/$filename"
  else
    mv "$src" "$dst/$filename"
    echo "[clasificador] ✓ $filename → $dst/"
  fi
}

CLASIFICADOS=0

for file in "$DROP_DIR"/*; do
  [[ -f "$file" ]] || continue
  [[ "$(basename "$file")" == ".gitkeep" ]] && continue

  name="$(basename "$file")"
  ext="${name##*.}"
  name_lower="$(echo "$name" | tr '[:upper:]' '[:lower:]')"

  case "$ext" in
    md)
      if echo "$name_lower" | grep -qE '(sesion|cierre|log-)'; then
        move_file "$file" "$REPO_ROOT/inbox/sesiones"
      elif echo "$name_lower" | grep -qE '(diario|[0-9]{4}-[0-9]{2}-[0-9]{2})'; then
        move_file "$file" "$REPO_ROOT/diarios"
      else
        move_file "$file" "$REPO_ROOT/inbox/docs"
      fi
      ;;
    sh)
      echo "[clasificador] AVISO: $name es un .sh — muévelo manualmente a scripts/ con permisos adecuados."
      ;;
    py)
      move_file "$file" "$REPO_ROOT/inbox/code"
      ;;
    log)
      move_file "$file" "$REPO_ROOT/inbox/logs"
      ;;
    *)
      move_file "$file" "$REPO_ROOT/inbox/misc"
      ;;
  esac

  ((CLASIFICADOS++)) || true
done

if [[ $CLASIFICADOS -eq 0 ]]; then
  echo "[clasificador] inbox/drop/ estaba vacío. Nada que clasificar."
else
  echo "[clasificador] $CLASIFICADOS archivo(s) clasificado(s)."
  if ! $DRY_RUN; then
    echo "[clasificador] Recuerda: git add -A && git commit -m 'inbox: clasificación' && git push"
  fi
fi
