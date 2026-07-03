#!/usr/bin/env bash
# ================================================================
# agente-cierre-sesion.sh — Agente especializado en cierre
# FUNCIÓN ÚNICA: Verificar milimétricamente que el cierre está
# completo y correcto antes de cerrar la terminal.
# No cierra él solo — verifica que cierre-sesion.sh lo hizo bien.
#
# Uso: bash scripts/agentes/agente-cierre-sesion.sh
# ================================================================
set -euo pipefail

REPO_DIR="${REPO_DIR:-$(git -C "$(dirname "$0")" rev-parse --show-toplevel 2>/dev/null || pwd)}"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M)

RED='\033[0;31m'; GRN='\033[0;32m'; YLW='\033[1;33m'; BLU='\033[0;34m'; NC='\033[0m'
ERRORS=0; WARNS=0

echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║   AGENTE CIERRE-SESION — ${DATE} ${TIME}             ║"
echo "║   9 checks milimétricos antes de cerrar terminal      ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""

cd "$REPO_DIR"

# ── CHECK 1: diary de cierre de hoy existe ───────────────────
echo -e "${BLU}[1/9]${NC} Diary de cierre generado hoy..."
if ls diary/${DATE}-sesion-cierre.md 2>/dev/null | grep -q .; then
  echo -e "${GRN}[✓]${NC} OK — diary/${DATE}-sesion-cierre.md"
else
  echo -e "${RED}[✗]${NC} FALTA diary — ejecuta: bash scripts/cierre-sesion.sh"
  ERRORS=$((ERRORS+1))
fi

# ── CHECK 2: nota inbox de hoy existe ────────────────────────
echo -e "${BLU}[2/9]${NC} Nota inbox de cierre hoy..."
if ls inbox/${DATE}-cierre-sesion.md 2>/dev/null | grep -q .; then
  echo -e "${GRN}[✓]${NC} OK — inbox/${DATE}-cierre-sesion.md"
else
  echo -e "${YLW}[⚠]${NC} FALTA nota inbox (usa cierre-sesion.sh v3)"
  WARNS=$((WARNS+1))
fi

# ── CHECK 3: repo limpio ────────────────────────────────────
echo -e "${BLU}[3/9]${NC} Repo limpio (sin uncommitted)..."
GIT_DIRTY=$(git status --short 2>/dev/null | wc -l | tr -d ' ')
if [ "$GIT_DIRTY" -eq 0 ]; then
  echo -e "${GRN}[✓]${NC} OK — working tree limpio"
else
  echo -e "${RED}[✗]${NC} $GIT_DIRTY ficheros sin commitear:"
  git status --short | head -10
  ERRORS=$((ERRORS+1))
fi

# ── CHECK 4: sincronizado con origin/main ────────────────────
echo -e "${BLU}[4/9]${NC} Sincronizado con origin/main..."
git fetch origin 2>/dev/null || true
LOCAL=$(git rev-parse HEAD 2>/dev/null || echo 'x')
REMOTE=$(git rev-parse origin/main 2>/dev/null || echo 'y')
if [ "$LOCAL" = "$REMOTE" ]; then
  echo -e "${GRN}[✓]${NC} OK — en sync con origin/main"
else
  echo -e "${RED}[✗]${NC} DIVERGENCIA: local ($LOCAL) ≠ remote ($REMOTE)"
  echo -e "       Ejecuta: git pull --rebase origin main && git push"
  ERRORS=$((ERRORS+1))
fi

# ── CHECK 5: inbox no desbordado ──────────────────────────────
echo -e "${BLU}[5/9]${NC} Inbox no desbordado..."
INBOX_N=$(find inbox/ -maxdepth 1 -name '*.md' \
  ! -name 'README.md' ! -name 'PLANTILLA*.md' \
  2>/dev/null | wc -l | tr -d ' ')
if [ "$INBOX_N" -le 15 ]; then
  echo -e "${GRN}[✓]${NC} OK — inbox: $INBOX_N ficheros"
else
  echo -e "${YLW}[⚠]${NC} inbox tiene $INBOX_N ficheros — revisar próxima sesión"
  WARNS=$((WARNS+1))
fi

# ── CHECK 6: carpetas duplicadas ──────────────────────────────
echo -e "${BLU}[6/9]${NC} Carpetas duplicadas/fantasma..."
DUP_FOUND=0
for PAIR in "diary diarios" "osint osint-stack" "docs documentos" "scripts script"; do
  A=$(echo $PAIR | cut -d' ' -f1)
  B=$(echo $PAIR | cut -d' ' -f2)
  if [ -d "$A" ] && [ -d "$B" ]; then
    echo -e "${YLW}[⚠]${NC} Duplicado: $A/ y $B/ coexisten — consolidar"
    DUP_FOUND=$((DUP_FOUND+1))
    WARNS=$((WARNS+1))
  fi
done
if [ $DUP_FOUND -eq 0 ]; then
  echo -e "${GRN}[✓]${NC} OK — sin carpetas duplicadas"
fi

# ── CHECK 7: MCP server status ───────────────────────────────
echo -e "${BLU}[7/9]${NC} MCP server status..."
if pgrep -f "node server.js" > /dev/null 2>&1 || pgrep -f "mcp" > /dev/null 2>&1; then
  echo -e "${GRN}[✓]${NC} MCP server activo"
else
  echo -e "${YLW}[⚠]${NC} MCP server no activo (normal si no se usa ahora)"
fi

# ── CHECK 8: GitHub Action session-close.yml existe ───────────
echo -e "${BLU}[8/9]${NC} GitHub Action session-close.yml existe..."
if [ -f ".github/workflows/session-close.yml" ]; then
  echo -e "${GRN}[✓]${NC} OK — session-close.yml presente"
else
  echo -e "${RED}[✗]${NC} FALTA .github/workflows/session-close.yml"
  ERRORS=$((ERRORS+1))
fi

# ── CHECK 9: scripts críticos existen ─────────────────────────
echo -e "${BLU}[9/9]${NC} Scripts críticos presentes..."
SCRIPTS_CRITICOS="scripts/cierre-sesion.sh scripts/apertura-sesion.sh scripts/clasificador-maestro.sh"
for S in $SCRIPTS_CRITICOS; do
  if [ -f "$S" ]; then
    echo -e "${GRN}[✓]${NC} $S"
  else
    echo -e "${YLW}[⚠]${NC} FALTA $S"
    WARNS=$((WARNS+1))
  fi
done

# ── RESULTADO FINAL ────────────────────────────────────────────
echo ""
echo "══════════════════════════════════════════════════════"
if [ $ERRORS -eq 0 ] && [ $WARNS -eq 0 ]; then
  echo -e "${GRN}✔ CIERRE VERIFICADO ✅ — Todo correcto. Puedes cerrar la terminal.${NC}"
elif [ $ERRORS -eq 0 ]; then
  echo -e "${YLW}⚠ CIERRE OK con $WARNS advertencias — Revisa los puntos amarillos.${NC}"
  echo -e "${YLW}  Puedes cerrar la terminal pero revisa antes de la próxima sesión.${NC}"
else
  echo -e "${RED}✘ CIERRE INCOMPLETO ❌ — $ERRORS errores críticos encontrados.${NC}"
  echo -e "${RED}  NO cierres la terminal hasta resolver los puntos rojos.${NC}"
fi
echo "══════════════════════════════════════════════════════"
echo ""

exit $ERRORS
