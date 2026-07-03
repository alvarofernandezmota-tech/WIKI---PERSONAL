#!/usr/bin/env bash
# ================================================================
# cierre-sesion.sh — Cierre oficial de sesión de trabajo
# Documenta, commitea, pushea y deja el repo limpio
# Uso: bash scripts/cierre-sesion.sh
# ================================================================
set -euo pipefail

REPO_DIR="${REPO_DIR:-$(git -C "$(dirname "$0")" rev-parse --show-toplevel 2>/dev/null || pwd)}"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M)
SESSION_LOG="$REPO_DIR/diary/${DATE}-sesion-cierre.md"

RED='\033[0;31m'; GRN='\033[0;32m'; YLW='\033[1;33m'; BLU='\033[0;34m'; NC='\033[0m'

echo ""
echo "╔═════════════════════════════════════════════╗"
echo "║   CIERRE DE SESIÓN — ${DATE} ${TIME}           ║"
echo "╚═════════════════════════════════════════════╝"
echo ""

cd "$REPO_DIR"

# 1. Limpiar inbox si supera umbral
echo -e "${BLU}[→]${NC} Verificando inbox..."
INBOX_COUNT=$(find inbox/ -maxdepth 1 -name '*.md' ! -name 'README.md' ! -name 'PLANTILLA*.md' \
  ! -name 'APLAZADO*.md' ! -name 'SIGUIENTE*.md' ! -name 'PENDIENTES*.md' ! -name 'PLAN-*.md' \
  | wc -l | tr -d ' ')
echo -e "${BLU}[→]${NC} Ficheros en inbox/: $INBOX_COUNT"
if [ "$INBOX_COUNT" -gt 10 ]; then
  echo -e "${YLW}[⚠]${NC} Supera umbral — limpiando..."
  bash "$REPO_DIR/scripts/maintenance/inbox-audit-cleanup.sh" || true
fi

# 2. Estado de git
echo -e "${BLU}[→]${NC} Estado del repo:"
git status --short 2>/dev/null | head -20 || true

# 3. Resumen de commits de la sesión
COMMITS_HOY=$(git log --oneline --since="${DATE} 00:00" 2>/dev/null | wc -l | tr -d ' ')
echo -e "${BLU}[→]${NC} Commits hoy: $COMMITS_HOY"

# 4. Generar nota de cierre
mkdir -p "$(dirname "$SESSION_LOG")"
cat > "$SESSION_LOG" << EOF
---
date: ${DATE}
hora-cierre: ${TIME}
tipo: cierre-sesion
---

# Cierre de Sesión — ${DATE} ${TIME}

## Commits de hoy ($COMMITS_HOY)

\`\`\`
$(git log --oneline --since="${DATE} 00:00" 2>/dev/null | head -30 || echo 'Sin commits')
\`\`\`

## Estado inbox al cierre

- Ficheros procesados: $INBOX_COUNT → archivados
- Próxima limpieza automática: 6h (cron)

## Comando para retomar sesión

\`\`\`bash
cd /srv/yggdrasil-dew && git fetch origin && git reset --hard origin/main
bash scripts/maintenance/ecosystem-reality-check.sh
\`\`\`

## Servicios activos al cierre

\`\`\`
$(curl -sf http://localhost:11434 > /dev/null 2>&1 && echo 'Ollama: UP' || echo 'Ollama: DOWN')
$(curl -sf http://localhost:5678 > /dev/null 2>&1 && echo 'n8n: UP' || echo 'n8n: DOWN')
$(curl -sf http://localhost:9000 > /dev/null 2>&1 && echo 'Portainer: UP' || echo 'Portainer: DOWN')
$(curl -sf http://localhost:3001 > /dev/null 2>&1 && echo 'Uptime-Kuma: UP' || echo 'Uptime-Kuma: DOWN')
\`\`\`

*Sesión cerrada automáticamente por cierre-sesion.sh [AUTO]*
EOF

echo -e "${GRN}[✓]${NC} Nota de cierre generada: $(basename $SESSION_LOG)"

# 5. Commit y push
git add -A 2>/dev/null || true
if ! git diff --staged --quiet; then
  git commit -m "chore(session): cierre ${DATE} ${TIME} — ${COMMITS_HOY} commits hoy [AUTO]"
  git push && echo -e "${GRN}[✓]${NC} Push completado" || echo -e "${YLW}[⚠]${NC} Push fallido — push manual"
else
  echo -e "${BLU}[→]${NC} Sin cambios pendientes"
fi

echo ""
echo "╔═════════════════════════════════════════════╗"
echo "║   SESIÓN CERRADA ✅                           ║"
echo "║   Para retomar:                             ║"
echo "║   git reset --hard origin/main              ║"
echo "║   bash scripts/maintenance/ecosystem-       ║"
echo "║        reality-check.sh                    ║"
echo "╚═════════════════════════════════════════════╝"
echo ""
