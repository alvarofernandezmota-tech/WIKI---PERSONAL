#!/usr/bin/env bash
# ============================================================
# ARCHIVO      : inbox-commit.sh
# VERSIÓN      : 1.0.0
# FUNCIÓN ÚNICA: Un comando para commitar TODO lo que haya
#                en inbox/drop/ directamente desde la terminal.
#                Uso: bash scripts/inbox-commit.sh "descripcion"
#                El archivo entra en inbox/drop/, este script
#                lo commitea y el clasificador lo mueve al
#                destino correcto del ecosistema.
# FLUJO        :
#   [tú] → copia archivo a inbox/drop/
#   [tú] → bash scripts/inbox-commit.sh "descripcion"
#           → git add + commit + push automático
#   [GitHub Actions] → inbox-clasificador.sh lo procesa
#                     y mueve al destino final
# AUTOR        : alvarofernandezmota-tech
# ============================================================

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
DROP_DIR="$REPO_ROOT/inbox/drop"
DESC="${1:-entrada sin descripción}"
STAMP=$(date "+%Y-%m-%d %H:%M")
DATE_TAG=$(date "+%Y%m%dT%H%M%S")

RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'
BOLD='\033[1m'; RESET='\033[0m'

log()  { echo -e "${CYAN}[inbox-commit]${RESET} $1"; }
ok()   { echo -e "${GREEN}✓${RESET} $1"; }
fail() { echo -e "${RED}✗${RESET} $1"; exit 1; }

# --- Verificaciones ---
cd "$REPO_ROOT" || fail "No se puede acceder al repo"

if [ ! -d "$DROP_DIR" ]; then
  log "inbox/drop/ no existe — creándola..."
  mkdir -p "$DROP_DIR"
  touch "$DROP_DIR/.gitkeep"
fi

# Contar archivos reales (excluir .gitkeep)
FILE_COUNT=$(find "$DROP_DIR" -type f ! -name '.gitkeep' | wc -l | tr -d ' ')

if [ "$FILE_COUNT" -eq 0 ]; then
  fail "inbox/drop/ está vacía. Copia primero tus archivos ahí."
fi

# --- Mostrar qué va a commitear ---
echo -e "${BOLD}================================================${RESET}"
echo -e "${CYAN}${BOLD}  INBOX COMMIT — yggdrasil-dew${RESET}"
echo -e "${BOLD}================================================${RESET}"
log "Archivos detectados en inbox/drop/ ($FILE_COUNT):"
find "$DROP_DIR" -type f ! -name '.gitkeep' | while read -r f; do
  echo "  → ${f#$REPO_ROOT/}"
done
echo ""

# --- Generar nota de entrada en _meta ---
META_DIR="$REPO_ROOT/inbox/_meta"
mkdir -p "$META_DIR"
NOTA_FILE="$META_DIR/drop-entrada-${DATE_TAG}.md"

cat > "$NOTA_FILE" << EOF
# Entrada inbox/drop — ${STAMP}

## Descripción
${DESC}

## Archivos entrados
$(find "$DROP_DIR" -type f ! -name '.gitkeep' | while read -r f; do echo "- ${f#$REPO_ROOT/}"; done)

## Estado
- [ ] Clasificado por inbox-clasificador.sh
- [ ] Movido a destino final

> Generado automáticamente por inbox-commit.sh
EOF

# --- Git add + commit + push ---
log "Añadiendo archivos al staging..."
git add inbox/drop/ inbox/_meta/drop-entrada-${DATE_TAG}.md

log "Commiteando..."
git commit -m "inbox(drop): ${DESC} — ${STAMP} [${FILE_COUNT} archivos]"

log "Pusheando a origin main..."
git push origin main

echo ""
echo -e "${GREEN}${BOLD}✅ Push completado. GitHub Actions procesará inbox/drop/ automáticamente.${RESET}"
echo -e "   Sigue el progreso en: https://github.com/alvarofernandezmota-tech/yggdrasil-dew/actions"
