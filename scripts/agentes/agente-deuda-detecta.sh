#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# =============================================================================
# Nombre:       agente-deuda-detecta.sh
# Función única: Escanea el repo entero y detecta deuda técnica de 9 categorías
# Rol:          auditor
# Versión:      1.0
# Autor:        Perplexity-MCP <alvarofernandezmota@gmail.com>
# Creado:       2026-07-03 23:55 CEST
# Actualizado:  2026-07-03 23:55 CEST
# Ruta:         scripts/agentes/agente-deuda-detecta.sh
# Tags:         [deuda-tecnica, auditor, automatico]
# Flags:
#   --dry-run   Simula sin escribir nada
#   --verbose   Log detallado
#   --out DIR   Directorio de salida (default: inbox/deuda/)
# =============================================================================

REPO_ROOT="${REPO_ROOT:-.}"
OUT_DIR="${OUT_DIR:-inbox/deuda}"
DRY_RUN=false
VERBOSE=false

log(){ printf '%s %s\n' "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "$*"; }
on_err(){ log "ERROR at line $1"; exit 2; }
trap 'on_err $LINENO' ERR

while [[ "${1:-}" != "" ]]; do
  case "$1" in
    --dry-run) DRY_RUN=true; shift ;;
    --verbose) VERBOSE=true; shift ;;
    --out) OUT_DIR="$2"; shift 2 ;;
    *) shift ;;
  esac
done

$DRY_RUN || mkdir -p "$OUT_DIR"
TS=$(date -u +'%Y%m%dT%H%M%SZ')
REPORT="$OUT_DIR/${TS}-deuda-detectada.json"
DEUDA_ITEMS=()

add_item(){
  local cat="$1" file="$2" msg="$3" prio="$4"
  DEUDA_ITEMS+=("$(jq -n \
    --arg cat "$cat" --arg file "$file" --arg msg "$msg" --arg prio "$prio" \
    '{categoria:$cat, archivo:$file, mensaje:$msg, prioridad:$prio}')")
  $VERBOSE && log "[$prio] [$cat] $file — $msg"
}

# --- 1. Duplicados de carpetas clave ---
for pair in "diary:docs/diarios" "diarios:docs/diarios" "osint-stack:osint" "agentes:scripts/agentes"; do
  src="${pair%%:*}"
  if [[ -d "$REPO_ROOT/$src" ]]; then
    add_item "duplicados" "$src/" "Carpeta duplicada de ${pair##*:}" "ALTA"
  fi
done

# --- 2. Scripts sin shebang ---
while IFS= read -r -d '' f; do
  if ! head -n1 "$f" | grep -q '^#!/usr/bin/env bash'; then
    add_item "sin-shebang" "$f" "Falta #!/usr/bin/env bash" "ALTA"
  fi
done < <(find "$REPO_ROOT/scripts" -name '*.sh' -print0 2>/dev/null)

# --- 3. Scripts sin set -euo pipefail ---
while IFS= read -r -d '' f; do
  if ! grep -q 'set -euo pipefail' "$f"; then
    add_item "sin-strict" "$f" "Falta set -euo pipefail" "ALTA"
  fi
done < <(find "$REPO_ROOT/scripts" -name '*.sh' -print0 2>/dev/null)

# --- 4. Scripts sin cabecera de autoría ---
while IFS= read -r -d '' f; do
  if ! grep -q 'Función única:' "$f" && ! grep -q 'Descripción:' "$f"; then
    add_item "sin-cabecera" "$f" "Sin bloque de autoría/función única" "MEDIA"
  fi
done < <(find "$REPO_ROOT/scripts" -name '*.sh' -print0 2>/dev/null)

# --- 5. Scripts sin test correspondiente ---
while IFS= read -r -d '' f; do
  base=$(basename "$f" .sh)
  if [[ ! -f "$REPO_ROOT/tests/test-${base}.sh" ]]; then
    add_item "sin-tests" "$f" "No existe tests/test-${base}.sh" "MEDIA"
  fi
done < <(find "$REPO_ROOT/scripts/agentes" -name '*.sh' -print0 2>/dev/null)

# --- 6. TODOs y FIXMEs ---
while IFS= read -r -d '' f; do
  count=$(grep -c 'TODO\|FIXME\|HACK\|XXX' "$f" 2>/dev/null || true)
  if [[ "$count" -gt 0 ]]; then
    add_item "todos-fixmes" "$f" "${count} TODO/FIXME/HACK encontrados" "BAJA"
  fi
done < <(find "$REPO_ROOT/scripts" -name '*.sh' -print0 2>/dev/null)

# --- 7. Archivos vacíos ---
while IFS= read -r -d '' f; do
  if [[ ! -s "$f" ]]; then
    add_item "archivos-vacios" "$f" "Archivo vacío (0 bytes)" "ALTA"
  fi
done < <(find "$REPO_ROOT" -not -path '*/.git/*' -not -path '*/node_modules/*' -type f -print0 2>/dev/null)

# --- 8. Docs sin frontmatter de autoría ---
while IFS= read -r -d '' f; do
  if ! head -5 "$f" | grep -q '^---'; then
    add_item "sin-docs" "$f" "Documento sin frontmatter YAML" "MEDIA"
  fi
done < <(find "$REPO_ROOT/docs" -name '*.md' -print0 2>/dev/null)

# --- Generar reporte ---
total=${#DEUDA_ITEMS[@]}
log "Deuda detectada: $total items"

if $DRY_RUN; then
  log "[DRY-RUN] Escribiría en $REPORT"
else
  printf '[%s]' "$(IFS=,; echo "${DEUDA_ITEMS[*]}")" \
    | jq --argjson total "$total" --arg ts "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
      '{total:$total, ts:$ts, items:.}' > "$REPORT"
  log "Reporte guardado → $REPORT"
fi

log "agente-deuda-detecta finalizado"
