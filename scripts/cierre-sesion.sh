#!/usr/bin/env bash
# ================================================================
# cierre-sesion.sh v2 — Cierre COMPLETO de sesión de trabajo
# FUNCIÓN ÚNICA: Documenta, audita, commitea, pushea, dispara Action
# y deja el ecosistema en estado limpio y auditado al cerrar.
#
# Uso:  bash scripts/cierre-sesion.sh
# Uso con mensaje: bash scripts/cierre-sesion.sh "resumen de sesión"
#
# Autor: alvarofernandezmota-tech
# Repo:  yggdrasil-dew
# ================================================================
set -euo pipefail

# ── Variables base ──────────────────────────────────────────────
REPO_DIR="${REPO_DIR:-$(git -C "$(dirname "$0")" rev-parse --show-toplevel 2>/dev/null || pwd)}"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M)
SESSION_MSG="${1:-sin-descripcion}"
DIARY_LOG="$REPO_DIR/diary/${DATE}-sesion-cierre.md"
INBOX_LOG="$REPO_DIR/inbox/${DATE}-cierre-sesion.md"

RED='\033[0;31m'; GRN='\033[0;32m'; YLW='\033[1;33m'; BLU='\033[0;34m'; MAG='\033[0;35m'; NC='\033[0m'

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║   CIERRE DE SESIÓN v2 — ${DATE} ${TIME}                 ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

cd "$REPO_DIR"

# ── BLOQUE 1: Verificar inbox ───────────────────────────────────
echo -e "${BLU}[1/8]${NC} Verificando inbox..."
INBOX_COUNT=$(find inbox/ -maxdepth 1 -name '*.md' \
  ! -name 'README.md' ! -name 'PLANTILLA*.md' \
  ! -name 'APLAZADO*.md' ! -name 'SIGUIENTE*.md' \
  ! -name 'PENDIENTES*.md' ! -name 'PLAN-*.md' \
  2>/dev/null | wc -l | tr -d ' ')
echo -e "${BLU}[→]${NC} Ficheros en inbox/: $INBOX_COUNT"
if [ "$INBOX_COUNT" -gt 10 ]; then
  echo -e "${YLW}[⚠]${NC} Supera umbral 10 — ejecutando limpieza..."
  bash "$REPO_DIR/scripts/clasificador-maestro.sh" || true
fi

# ── BLOQUE 2: Auditoría estructural ────────────────────────────
echo -e "${BLU}[2/8]${NC} Auditoría estructural del repo..."
STRUCT_OUT=$(bash "$REPO_DIR/scripts/struct-auditor.sh" 2>&1 || echo 'struct-auditor: no ejecutable')
echo -e "${GRN}[✓]${NC} struct-auditor completado"

# ── BLOQUE 3: Archivos fantasma ────────────────────────────────
echo -e "${BLU}[3/8]${NC} Detectando archivos fantasma..."
GHOST_OUT=$(bash "$REPO_DIR/scripts/ghost-file-detector.sh" 2>&1 || echo 'ghost-detector: no ejecutable')
echo -e "${GRN}[✓]${NC} ghost-detector completado"

# ── BLOQUE 4: Verificar MCP server ─────────────────────────────
echo -e "${BLU}[4/8]${NC} Verificando MCP server..."
if pgrep -f "node server.js" > /dev/null 2>&1; then
  MCP_STATUS="UP ✅"
else
  MCP_STATUS="DOWN ⚠️ — arrancar con: node /srv/yggdrasil-dew/server.js"
fi
echo -e "${BLU}[→]${NC} MCP server: $MCP_STATUS"

# ── BLOQUE 5: Estado de servicios ──────────────────────────────
echo -e "${BLU}[5/8]${NC} Comprobando servicios..."
OLLAMA=$(curl -sf http://localhost:11434 > /dev/null 2>&1 && echo 'UP ✅' || echo 'DOWN ❌')
N8N=$(curl -sf http://localhost:5678 > /dev/null 2>&1 && echo 'UP ✅' || echo 'DOWN ❌')
PORTAINER=$(curl -sf http://localhost:9000 > /dev/null 2>&1 && echo 'UP ✅' || echo 'DOWN ❌')
UPTIME=$(curl -sf http://localhost:3001 > /dev/null 2>&1 && echo 'UP ✅' || echo 'DOWN ❌')

# ── BLOQUE 6: Resumen de commits ───────────────────────────────
echo -e "${BLU}[6/8]${NC} Contando commits de la sesión..."
COMMITS_HOY=$(git log --oneline --since="${DATE} 00:00" 2>/dev/null | wc -l | tr -d ' ')
COMMITS_LISTA=$(git log --oneline --since="${DATE} 00:00" 2>/dev/null | head -30 || echo 'Sin commits')

# ── BLOQUE 7: Generar notas de cierre (diary + inbox) ──────────
echo -e "${BLU}[7/8]${NC} Generando notas de cierre..."

mkdir -p "$(dirname "$DIARY_LOG")" "$(dirname "$INBOX_LOG")"

# Nota en diary/
cat > "$DIARY_LOG" << DIARY
---
date: ${DATE}
hora-cierre: ${TIME}
tipo: cierre-sesion
version: v2
---

# Cierre de Sesión — ${DATE} ${TIME}

## Descripción de sesión
${SESSION_MSG}

## Commits de hoy (${COMMITS_HOY})
\`\`\`
${COMMITS_LISTA}
\`\`\`

## Auditoría estructural
\`\`\`
${STRUCT_OUT}
\`\`\`

## Archivos fantasma detectados
\`\`\`
${GHOST_OUT}
\`\`\`

## Servicios al cierre
| Servicio | Estado |
|----------|--------|
| Ollama   | ${OLLAMA} |
| n8n      | ${N8N} |
| Portainer| ${PORTAINER} |
| Uptime-Kuma | ${UPTIME} |
| MCP server | ${MCP_STATUS} |

## Inbox al cierre
- Ficheros activos: ${INBOX_COUNT}

## Retomar sesión
\`\`\`bash
cd /srv/yggdrasil-dew && git pull --rebase
bash scripts/apertura-sesion.sh
\`\`\`

*Generado por cierre-sesion.sh v2 [AUTO]*
DIARY

# Nota en inbox/ (norma del repo: todo pasa por inbox)
cat > "$INBOX_LOG" << INBOX
---
date: ${DATE}
hora: ${TIME}
tipo: cierre-sesion
estado: pendiente-revision
---

# Cierre ${DATE} ${TIME}

- Commits hoy: ${COMMITS_HOY}
- Inbox activo: ${INBOX_COUNT} ficheros
- MCP: ${MCP_STATUS}
- Ollama: ${OLLAMA} | n8n: ${N8N}

**Acción requerida:** revisar auditoría estructural y fantasmas en diary/

*[AUTO] cierre-sesion.sh v2*
INBOX

echo -e "${GRN}[✓]${NC} diary/ e inbox/ actualizados"

# ── BLOQUE 8: Commit, push y disparar Action ───────────────────
echo -e "${BLU}[8/8]${NC} Commiteando, pusheando y disparando Action..."

git add -A 2>/dev/null || true
if ! git diff --staged --quiet; then
  git commit -m "chore(session): cierre ${DATE} ${TIME} — ${COMMITS_HOY} commits — ${SESSION_MSG} [AUTO]"
  git push \
    && echo -e "${GRN}[✓]${NC} Push completado" \
    || echo -e "${YLW}[⚠]${NC} Push fallido — haz push manual: git push"
else
  echo -e "${BLU}[→]${NC} Sin cambios pendientes — solo disparando Action"
  git push 2>/dev/null || true
fi

# Disparar GitHub Action de auditoría post-cierre (requiere gh CLI)
if command -v gh &>/dev/null; then
  gh workflow run session-close.yml \
    --repo alvarofernandezmota-tech/yggdrasil-dew \
    --field fecha="${DATE}" \
    --field hora="${TIME}" \
    2>/dev/null \
    && echo -e "${GRN}[✓]${NC} GitHub Action session-close.yml disparada" \
    || echo -e "${YLW}[⚠]${NC} gh CLI no autenticado — Action se dispara por push automáticamente"
else
  echo -e "${YLW}[⚠]${NC} gh CLI no instalado — Action se dispara por push automáticamente"
fi

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║   SESIÓN CERRADA ✅  v2                                  ║"
echo "║                                                          ║"
echo "║   Commits hoy:  ${COMMITS_HOY}                                       ║"
echo "║   Inbox activo: ${INBOX_COUNT} ficheros                               ║"
echo "║   MCP server:   ${MCP_STATUS}                           ║"
echo "║                                                          ║"
echo "║   Para retomar:                                          ║"
echo "║     cd /srv/yggdrasil-dew && git pull --rebase           ║"
echo "║     bash scripts/apertura-sesion.sh                      ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
