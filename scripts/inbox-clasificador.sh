#!/usr/bin/env bash
# ============================================================
# ARCHIVO      : inbox-clasificador.sh
# VERSIÓN      : 1.0.0
# FUNCIÓN ÚNICA: Clasifica cada archivo en inbox/drop/ y lo
#                mueve al destino correcto del ecosistema
#                según su nombre, extensión y contenido.
#
# REGLAS DE CLASIFICACIÓN (en orden de prioridad):
#   nombre contiene fecha YYYY-MM-DD → diarios/
#   nombre contiene 'sesion' o 'cierre' → sesiones/
#   extensión .sh → scripts/ (requiere revisión manual)
#   nombre contiene 'osint' → osint-stack/
#   nombre contiene 'infra' o 'docker' o 'service' → infra/
#   nombre contiene 'investigacion' o 'research' → investigacion/
#   nombre contiene 'formacion' o 'curso' → formacion/
#   nombre contiene 'proyecto' → proyectos/
#   nombre contiene 'hardware' → hardware/
#   nombre contiene 'doc' o 'docs' → docs/
#   nombre contiene 'template' → templates/
#   resto → inbox/sin-clasificar/ (para revisión manual)
#
# MODO DRY-RUN: bash scripts/inbox-clasificador.sh --dry-run
# MODO REAL   : bash scripts/inbox-clasificador.sh
# AUTOR       : alvarofernandezmota-tech
# ============================================================

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
DROP_DIR="$REPO_ROOT/inbox/drop"
SIN_CLASIFICAR="$REPO_ROOT/inbox/sin-clasificar"
META_DIR="$REPO_ROOT/inbox/_meta"
STAMP=$(date "+%Y%m%dT%H%M%S")
DRY_RUN=false
MOVED=0
SKIPPED=0

[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BOLD='\033[1m'; RESET='\033[0m'

log()  { echo -e "${CYAN}[clasificador]${RESET} $1"; }
ok()   { echo -e "${GREEN}✓${RESET} $1"; }
warn() { echo -e "${YELLOW}⚠${RESET} $1"; }

echo -e "${BOLD}================================================${RESET}"
echo -e "${CYAN}${BOLD}  INBOX CLASIFICADOR — yggdrasil-dew${RESET}"
$DRY_RUN && echo -e "  ${YELLOW}[DRY-RUN activado — no se mueven archivos]${RESET}"
echo -e "${BOLD}================================================${RESET}"

mkdir -p "$SIN_CLASIFICAR" "$META_DIR"

REPORT="$META_DIR/clasificador-${STAMP}.md"
cat > "$REPORT" << EOF
# Informe clasificador — ${STAMP}
$( $DRY_RUN && echo '> Modo DRY-RUN' )

## Archivos procesados

EOF

# Función que decide el destino
destino_para() {
  local nombre="$1"
  local base
  base=$(basename "$nombre" | tr '[:upper:]' '[:lower:]')
  local ext="${base##*.}"

  # Por nombre
  [[ "$base" =~ [0-9]{4}-[0-9]{2}-[0-9]{2} ]] && { echo "diarios"; return; }
  [[ "$base" =~ (sesion|cierre|session) ]]      && { echo "sesiones"; return; }
  [[ "$base" =~ (osint) ]]                      && { echo "osint-stack"; return; }
  [[ "$base" =~ (infra|docker|service|systemd) ]] && { echo "infra"; return; }
  [[ "$base" =~ (investigacion|research|grok) ]] && { echo "investigacion"; return; }
  [[ "$base" =~ (formacion|curso|tutorial) ]]   && { echo "formacion"; return; }
  [[ "$base" =~ (proyecto|project) ]]            && { echo "proyectos"; return; }
  [[ "$base" =~ (hardware|disco|ssd|hdd) ]]      && { echo "hardware"; return; }
  [[ "$base" =~ (doc|docs|readme|manual) ]]      && { echo "docs"; return; }
  [[ "$base" =~ (template|plantilla) ]]          && { echo "templates"; return; }

  # Por extensión
  case "$ext" in
    sh)    echo "scripts"; return ;;
    py)    echo "tools"; return ;;
    json)  echo "core"; return ;;
    yml|yaml) echo ".github/workflows"; return ;;
    md)    echo "inbox/sin-clasificar"; return ;;
    *)     echo "inbox/sin-clasificar"; return ;;
  esac
}

# Procesar cada archivo en drop/
for ARCHIVO in "$DROP_DIR"/*; do
  [ -f "$ARCHIVO" ] || continue
  [ "$(basename "$ARCHIVO")" = ".gitkeep" ] && continue

  NOMBRE=$(basename "$ARCHIVO")
  DESTINO=$(destino_para "$NOMBRE")
  DESTINO_PATH="$REPO_ROOT/$DESTINO"

  log "$NOMBRE → $DESTINO/"
  echo "- \`$NOMBRE\` → \`$DESTINO/\`" >> "$REPORT"

  if $DRY_RUN; then
    warn "  [DRY-RUN] NO movido"
    ((SKIPPED++)) || true
  else
    mkdir -p "$DESTINO_PATH"
    mv "$ARCHIVO" "$DESTINO_PATH/$NOMBRE"
    ok "  Movido a $DESTINO/$NOMBRE"
    ((MOVED++)) || true
  fi
done

# Resumen
echo "" >> "$REPORT"
cat >> "$REPORT" << EOF
## Resumen
- Movidos: ${MOVED}
- DRY-RUN (no movidos): ${SKIPPED}
- Timestamp: $(date '+%Y-%m-%d %H:%M:%S')
EOF

echo ""
echo -e "${BOLD}================================================${RESET}"
if $DRY_RUN; then
  echo -e "${YELLOW}[DRY-RUN] Se habrían movido $SKIPPED archivos${RESET}"
else
  echo -e "${GREEN}${BOLD}✅ $MOVED archivos clasificados y movidos${RESET}"
fi
echo -e "Reporte: $REPORT"
