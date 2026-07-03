#!/usr/bin/env bash
# ================================================================
# apertura-sesion.sh — Apertura oficial de sesión de trabajo
# Sincroniza repo, audita estado y muestra contexto de la sesión
# Uso: bash scripts/apertura-sesion.sh
# ================================================================
set -euo pipefail

REPO_DIR="${REPO_DIR:-$(git -C "$(dirname "$0")" rev-parse --show-toplevel 2>/dev/null || pwd)}"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M)

GRN='\033[0;32m'; YLW='\033[1;33m'; BLU='\033[0;34m'; NC='\033[0m'

echo ""
echo "╔═════════════════════════════════════════════╗"
echo "║   APERTURA DE SESIÓN — ${DATE} ${TIME}        ║"
echo "╚═════════════════════════════════════════════╝"
echo ""

cd "$REPO_DIR"

# 1. Sync con origin
echo -e "${BLU}[→]${NC} Sincronizando con origin..."
git fetch origin 2>/dev/null
git reset --hard origin/main 2>/dev/null
echo -e "${GRN}[✓]${NC} Repo sincronizado"

# 2. Mostrar últimos commits
echo -e "\n${BLU}[→]${NC} Úlotimos commits:"
git log --oneline -8 2>/dev/null

# 3. Estado inbox
INBOX_COUNT=$(find inbox/ -maxdepth 1 -name '*.md' ! -name 'README.md' ! -name 'PLANTILLA*.md' \
  ! -name 'APLAZADO*.md' ! -name 'SIGUIENTE*.md' ! -name 'PENDIENTES*.md' ! -name 'PLAN-*.md' \
  | wc -l | tr -d ' ')
echo -e "\n${BLU}[→]${NC} Inbox: $INBOX_COUNT ficheros"
[ "$INBOX_COUNT" -gt 10 ] && echo -e "${YLW}[⚠]${NC} Inbox supera umbral — considera limpiar" || true

# 4. Servicios activos
echo -e "\n${BLU}[→]${NC} Servicios:"
for SVC_PORT in "Ollama:11434" "n8n:5678" "Portainer:9000" "Grafana:3000" "Uptime-Kuma:3001" "Qdrant:6333" "health-agent:8000"; do
  SVC=$(echo $SVC_PORT | cut -d: -f1)
  PORT=$(echo $SVC_PORT | cut -d: -f2)
  curl -sf --max-time 1 "http://localhost:$PORT" > /dev/null 2>&1 \
    && echo -e "  ${GRN}✓${NC} $SVC" \
    || echo -e "  ${YLW}●${NC} $SVC (down)"
done

# 5. Mostrar diary de última sesión
LAST_DIARY=$(find "$REPO_DIR/diary" -name '*.md' ! -name 'README*' | sort | tail -1 2>/dev/null || echo "")
if [ -n "$LAST_DIARY" ]; then
  echo -e "\n${BLU}[→]${NC} Última entrada diary: $(basename $LAST_DIARY)"
  head -30 "$LAST_DIARY" 2>/dev/null | tail -20
fi

# 6. Reality check rápido
echo -e "\n${BLU}[→]${NC} Ejecutando reality check..."
bash "$REPO_DIR/scripts/maintenance/ecosystem-reality-check.sh" 2>/dev/null || \
  echo -e "${YLW}[⚠]${NC} Reality check fallido — ejecutar manualmente"

echo ""
echo "╔═════════════════════════════════════════════╗"
echo "║   SESIÓN ABIERTA ✅                           ║"
echo "║   Contexto cargado. A trabajar.             ║"
echo "╚═════════════════════════════════════════════╝"
echo ""
