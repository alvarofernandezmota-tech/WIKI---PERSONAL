#!/usr/bin/env bash
# ================================================================
# agente-cierre-sesion.sh — Agente especializado en cierre
# FUNCIÓN ÚNICA: Verificar que el cierre de sesión está completo
# y correcto antes de cerrar la terminal. Complementa al script
# principal cierre-sesion.sh — no lo reemplaza.
#
# Uso: bash scripts/agentes/agente-cierre-sesion.sh
# ================================================================
set -euo pipefail

REPO_DIR="${REPO_DIR:-$(git -C "$(dirname "$0")" rev-parse --show-toplevel 2>/dev/null || pwd)}"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M)

RED='\033[0;31m'; GRN='\033[0;32m'; YLW='\033[1;33m'; BLU='\033[0;34m'; NC='\033[0m'

ERRORS=0
WARNS=0

echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║   AGENTE CIERRE-SESION — ${DATE} ${TIME}            ║"
echo "║   Verificando que el cierre está completo...        ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""

cd "$REPO_DIR"

# ── CHECK 1: diary de hoy existe ───────────────────────────────
echo -e "${BLU}[CHECK 1]${NC} Diary de cierre generado hoy..."
if find diary/ -name "${DATE}-sesion-cierre.md" -maxdepth 1 2>/dev/null | grep -q .; then
  echo -e "${GRN}[✓]${NC} diary/${DATE}-sesion-cierre.md existe"
else
  echo -e "${RED}[✗]${NC} FALTA diary de cierre — ejecuta: bash scripts/cierre-sesion.sh"
  ERRORS=$((ERRORS+1))
fi

# ── CHECK 2: nota en inbox de hoy existe ───────────────────────
echo -e "${BLU}[CHECK 2]${NC} Nota en inbox de cierre generada hoy..."
if find inbox/ -name "${DATE}-cierre-sesion.md" -maxdepth 1 2>/dev/null | grep -q .; then
  echo -e "${GRN}[✓]${NC} inbox/${DATE}-cierre-sesion.md existe"
else
  echo -e "${YLW}[⚠]${NC} FALTA nota en inbox — se genera automáticamente con cierre-sesion.sh v2"
  WARNS=$((WARNS+1))
fi

# ── CHECK 3: repo limpio (nada sin commitear) ───────────────────
echo -e "${BLU}[CHECK 3]${NC} Repo limpio (nada pendiente de commit)..."
GIT_STATUS=$(git status --short 2>/dev/null | wc -l | tr -d ' ')
if [ "$GIT_STATUS" -eq 0 ]; then
  echo -e "${GRN}[✓]${NC} Repo limpio — nada sin commitear"
else
  echo -e "${RED}[✗]${NC} Hay $GIT_STATUS ficheros sin commitear:"
  git status --short | head -10
  ERRORS=$((ERRORS+1))
fi

# ── CHECK 4: último push reciente (menos de 10 min) ────────────
echo -e "${BLU}[CHECK 4]${NC} Último commit pusheado..."
LAST_COMMIT=$(git log -1 --format='%cr' 2>/dev/null || echo 'desconocido')
echo -e "${BLU}[→]${NC} Último commit: $LAST_COMMIT"
if git log -1 --format='%cr' 2>/dev/null | grep -qE '^[0-9]+ (second|minute)'; then
  echo -e "${GRN}[✓]${NC} Commit reciente"
else
  echo -e "${YLW}[⚠]${NC} Commit no parece reciente — verifica que se hizo push"
  WARNS=$((WARNS+1))
fi

# ── CHECK 5: inbox no desbordado ───────────────────────────────
echo -e "${BLU}[CHECK 5]${NC} Inbox no desbordado..."
INBOX_N=$(find inbox/ -maxdepth 1 -name '*.md' ! -name 'README.md' ! -name 'PLANTILLA*.md' 2>/dev/null | wc -l | tr -d ' ')
if [ "$INBOX_N" -le 15 ]; then
  echo -e "${GRN}[✓]${NC} Inbox OK: $INBOX_N ficheros"
else
  echo -e "${YLW}[⚠]${NC} Inbox tiene $INBOX_N ficheros — revisar en próxima sesión"
  WARNS=$((WARNS+1))
fi

# ── CHECK 6: MCP server ────────────────────────────────────────
echo -e "${BLU}[CHECK 6]${NC} MCP server status..."
if pgrep -f "node server.js" > /dev/null 2>&1; then
  echo -e "${GRN}[✓]${NC} MCP server corriendo"
else
  echo -e "${YLW}[⚠]${NC} MCP server no activo (normal si no se usa ahora)"
fi

# ── CHECK 7: Action session-close.yml existe ───────────────────
echo -e "${BLU}[CHECK 7]${NC} GitHub Action session-close.yml existe..."
if [ -f "$REPO_DIR/.github/workflows/session-close.yml" ]; then
  echo -e "${GRN}[✓]${NC} session-close.yml presente"
else
  echo -e "${RED}[✗]${NC} FALTA .github/workflows/session-close.yml"
  ERRORS=$((ERRORS+1))
fi

# ── RESULTADO FINAL ────────────────────────────────────────────
echo ""
echo "══════════════════════════════════════════════════════"
if [ $ERRORS -eq 0 ] && [ $WARNS -eq 0 ]; then
  echo -e "${GRN}CIERRE VERIFICADO ✅ — Todo correcto. Puedes cerrar la terminal.${NC}"
elif [ $ERRORS -eq 0 ]; then
  echo -e "${YLW}CIERRE OK con $WARNS advertencias ⚠️ — Revisa los puntos amarillos.${NC}"
else
  echo -e "${RED}CIERRE INCOMPLETO ❌ — $ERRORS errores críticos. NO cierres hasta resolverlos.${NC}"
fi
echo "══════════════════════════════════════════════════════"
echo ""

exit $ERRORS
