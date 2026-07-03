#!/usr/bin/env bash
# ================================================================
# cierre-sesion.sh v3 — Cierre COMPLETO de sesión de trabajo
# FUNCIÓN ÚNICA: Documenta, audita, sincroniza, commitea, pushea
# y deja el ecosistema en estado limpio y auditado al cerrar.
#
# Uso:              bash scripts/cierre-sesion.sh
# Con descripción: bash scripts/cierre-sesion.sh "lo que hiciste"
#
# Autor: alvarofernandezmota-tech | Repo: yggdrasil-dew
# ================================================================
set -euo pipefail

# ── Variables base ──────────────────────────────────────────────
REPO_DIR="${REPO_DIR:-$(git -C "$(dirname "$0")" rev-parse --show-toplevel 2>/dev/null || pwd)}"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M)
SESSION_MSG="${1:-sin-descripcion}"
DIARY_LOG="$REPO_DIR/diary/${DATE}-sesion-cierre.md"
INBOX_LOG="$REPO_DIR/inbox/${DATE}-cierre-sesion.md"

RED='\033[0;31m'; GRN='\033[0;32m'; YLW='\033[1;33m'; BLU='\033[0;34m'; NC='\033[0m'

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║   CIERRE DE SESIÓN v3 — ${DATE} ${TIME}                  ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

cd "$REPO_DIR"

# ── BLOQUE 0 (NUEVO): Sincronizar con remoto ANTES de todo ──────
echo -e "${BLU}[0/9]${NC} Sincronizando con remoto (evita push rejected)..."
git fetch origin 2>/dev/null || echo -e "${YLW}[⚠]${NC} fetch fallido — sin red?"
LOCAL_SHA=$(git rev-parse HEAD 2>/dev/null || echo 'x')
REMOTE_SHA=$(git rev-parse origin/main 2>/dev/null || echo 'y')
if [ "$LOCAL_SHA" != "$REMOTE_SHA" ]; then
  echo -e "${YLW}[⚠]${NC} Divergencia detectada — haciendo rebase..."
  git stash 2>/dev/null || true
  git pull --rebase origin main 2>/dev/null \
    && echo -e "${GRN}[✓]${NC} Rebase completado" \
    || echo -e "${RED}[✗]${NC} Rebase fallido — resuelve conflictos manualmente"
  git stash pop 2>/dev/null || true
else
  echo -e "${GRN}[✓]${NC} Repo en sync con origin/main"
fi

# ── BLOQUE 1: Verificar inbox ───────────────────────────────────
echo -e "${BLU}[1/9]${NC} Verificando inbox..."
INBOX_COUNT=$(find inbox/ -maxdepth 1 -name '*.md' \
  ! -name 'README.md' ! -name 'PLANTILLA*.md' \
  ! -name 'APLAZADO*.md' ! -name 'SIGUIENTE*.md' \
  ! -name 'PENDIENTES*.md' ! -name 'PLAN-*.md' \
  2>/dev/null | wc -l | tr -d ' ')
echo -e "${BLU}[→]${NC} Ficheros en inbox/: $INBOX_COUNT"
if [ "$INBOX_COUNT" -gt 10 ]; then
  echo -e "${YLW}[⚠]${NC} Supera umbral 10 — ejecutando limpieza..."
  bash "$REPO_DIR/scripts/clasificador-maestro.sh" 2>/dev/null || true
fi

# ── BLOQUE 2: Detectar carpetas duplicadas ─────────────────────
echo -e "${BLU}[2/9]${NC} Detectando carpetas duplicadas/fantasma..."
DUPS=""
for PAIR in "diary diarios" "osint osint-stack" "docs documentos" "scripts script"; do
  A=$(echo $PAIR | cut -d' ' -f1)
  B=$(echo $PAIR | cut -d' ' -f2)
  if [ -d "$REPO_DIR/$A" ] && [ -d "$REPO_DIR/$B" ]; then
    DUPS="$DUPS\n  ⚠️ Duplicado: $A/ y $B/ — consolidar"
    echo -e "${YLW}[⚠]${NC} Duplicado detectado: $A/ y $B/"
  fi
done
if [ -z "$DUPS" ]; then
  echo -e "${GRN}[✓]${NC} Sin carpetas duplicadas"
fi

# ── BLOQUE 3: Auditoría estructural ────────────────────────────
echo -e "${BLU}[3/9]${NC} Auditoría estructural..."
STRUCT_OUT=$(bash "$REPO_DIR/scripts/struct-auditor.sh" 2>&1 || echo 'struct-auditor: pendiente de crear')
echo -e "${GRN}[✓]${NC} struct-auditor completado"

# ── BLOQUE 4: Archivos fantasma ────────────────────────────────
echo -e "${BLU}[4/9]${NC} Detectando archivos fantasma (vacíos/huérfanos)..."
GHOST_OUT=$(bash "$REPO_DIR/scripts/ghost-file-detector.sh" 2>&1 || true)
# Fallback si el script no existe: búsqueda directa
if echo "$GHOST_OUT" | grep -q 'pendiente de crear\|No such file'; then
  GHOST_OUT=$(find . -name '*.md' -empty -not -path './.git/*' 2>/dev/null | head -20 || echo 'Sin archivos vacíos')
  echo -e "${YLW}[⚠]${NC} ghost-file-detector.sh no existe — usando find como fallback"
fi
echo -e "${GRN}[✓]${NC} Ghost detector completado"

# ── BLOQUE 5: Verificar MCP server ─────────────────────────────
echo -e "${BLU}[5/9]${NC} Verificando MCP server..."
if pgrep -f "node server.js" > /dev/null 2>&1; then
  MCP_STATUS="UP ✅"
elif pgrep -f "mcp" > /dev/null 2>&1; then
  MCP_STATUS="UP (proceso mcp) ✅"
else
  MCP_STATUS="DOWN ⚠️"
fi
echo -e "${BLU}[→]${NC} MCP server: $MCP_STATUS"

# ── BLOQUE 6: Estado de servicios docker ─────────────────────
echo -e "${BLU}[6/9]${NC} Comprobando servicios..."
OLLAMA=$(curl -sf --max-time 3 http://localhost:11434 > /dev/null 2>&1 && echo 'UP ✅' || echo 'DOWN ❌')
N8N=$(curl -sf --max-time 3 http://localhost:5678 > /dev/null 2>&1 && echo 'UP ✅' || echo 'DOWN ❌')
PORTAINER=$(curl -sf --max-time 3 http://localhost:9000 > /dev/null 2>&1 && echo 'UP ✅' || echo 'DOWN ❌')
UPTIME=$(curl -sf --max-time 3 http://localhost:3001 > /dev/null 2>&1 && echo 'UP ✅' || echo 'DOWN ❌')
echo -e "  Ollama: $OLLAMA | n8n: $N8N | Portainer: $PORTAINER | Uptime-Kuma: $UPTIME"

# ── BLOQUE 7: Resumen de commits + próxima sesión ─────────────
echo -e "${BLU}[7/9]${NC} Resumen de commits..."
COMMITS_HOY=$(git log --oneline --since="${DATE} 00:00" 2>/dev/null | wc -l | tr -d ' ')
COMMITS_LISTA=$(git log --oneline --since="${DATE} 00:00" 2>/dev/null | head -30 || echo 'Sin commits')
ULTIMO_COMMIT=$(git log -1 --format='%s' 2>/dev/null || echo 'desconocido')

# ── BLOQUE 8: Generar notas (diary + inbox) ──────────────────
echo -e "${BLU}[8/9]${NC} Generando notas de cierre..."
mkdir -p "$(dirname "$DIARY_LOG")" "$(dirname "$INBOX_LOG")"

cat > "$DIARY_LOG" << DIARY
---
date: ${DATE}
hora-cierre: ${TIME}
tipo: cierre-sesion
version: v3
---

# Cierre de Sesión — ${DATE} ${TIME}

## Descripción
${SESSION_MSG}

## Commits hoy (${COMMITS_HOY})
\`\`\`
${COMMITS_LISTA}
\`\`\`

## Carpetas duplicadas
${DUPS:-Sin duplicados detectados}

## Auditoría estructural
\`\`\`
${STRUCT_OUT}
\`\`\`

## Archivos fantasma
\`\`\`
${GHOST_OUT}
\`\`\`

## Servicios
| Servicio | Estado |
|----------|--------|
| Ollama | ${OLLAMA} |
| n8n | ${N8N} |
| Portainer | ${PORTAINER} |
| Uptime-Kuma | ${UPTIME} |
| MCP server | ${MCP_STATUS} |

## Inbox al cierre
- Ficheros: ${INBOX_COUNT}

## Próxima sesión — retomar con
\`\`\`bash
cd /srv/yggdrasil-dew
git pull --rebase origin main
bash scripts/apertura-sesion.sh
bash scripts/agentes/agente-cierre-sesion.sh  # verifica estado
\`\`\`

*[AUTO] cierre-sesion.sh v3*
DIARY

cat > "$INBOX_LOG" << INBOX
---
date: ${DATE}
hora: ${TIME}
tipo: cierre-sesion
estado: pendiente-revision
---

# Cierre ${DATE} ${TIME}
- Commits: ${COMMITS_HOY} | Inbox: ${INBOX_COUNT} | MCP: ${MCP_STATUS}
- Último commit: ${ULTIMO_COMMIT}
- Ollama: ${OLLAMA} | n8n: ${N8N}
${DUPS:+\n**Duplicados:**${DUPS}}

*[AUTO] cierre-sesion.sh v3*
INBOX

echo -e "${GRN}[✓]${NC} diary/ e inbox/ actualizados"

# ── BLOQUE 9: Commit + push (con rebase automático) ───────────
echo -e "${BLU}[9/9]${NC} Commit, push y Action..."

git add -A 2>/dev/null || true
if ! git diff --staged --quiet; then
  git commit -m "chore(session): cierre ${DATE} ${TIME} — ${COMMITS_HOY} commits — ${SESSION_MSG} [AUTO]"
fi

# Push con rebase automático si hay divergencia
git push origin main 2>/dev/null \
  || ( echo -e "${YLW}[⚠]${NC} Push fallido — haciendo pull --rebase y reintentando..." \
       && git pull --rebase origin main \
       && git push origin main \
       && echo -e "${GRN}[✓]${NC} Push completado tras rebase" ) \
  || echo -e "${RED}[✗]${NC} Push fallido definitivo — revisa conflictos"

# Disparar GitHub Action (requiere gh CLI autenticado)
if command -v gh &>/dev/null; then
  gh workflow run session-close.yml \
    --repo alvarofernandezmota-tech/yggdrasil-dew 2>/dev/null \
    && echo -e "${GRN}[✓]${NC} Action session-close.yml disparada" \
    || echo -e "${YLW}[⚠]${NC} gh CLI no autenticado — Action se dispara por push"
else
  echo -e "${BLU}[→]${NC} gh CLI no instalado — Action se dispara automáticamente por push"
fi

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║   SESIÓN CERRADA ✅  v3 — ${DATE} ${TIME}             ║"
echo "║   Commits hoy: ${COMMITS_HOY}   Inbox: ${INBOX_COUNT}                           ║"
echo "║   MCP: ${MCP_STATUS}                                    ║"
echo "║                                                          ║"
echo "║   Para retomar:                                          ║"
echo "║     git pull --rebase && bash scripts/apertura-sesion.sh  ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
