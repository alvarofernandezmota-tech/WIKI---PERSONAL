#!/bin/bash
# ============================================
# MORNING CHECK — Yggdrasil Ecosystem
# Ejecutar al despertar para ver estado completo
# Uso: bash ~/yggdrasil-dew/scripts/maintenance/morning-check.sh
# ============================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

ok()   { echo -e "${GREEN}✅ $1${NC}"; }
fail() { echo -e "${RED}❌ $1${NC}"; }
warn() { echo -e "${YELLOW}⚠️  $1${NC}"; }
info() { echo -e "${BLUE}ℹ️  $1${NC}"; }

echo ""
echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}  MORNING CHECK — $(date '+%Y-%m-%d %H:%M CEST')${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

# ---- 1. TMUX ----
echo -e "${YELLOW}[ TMUX ]${NC}"
if tmux ls 2>/dev/null | grep -q trabajo; then
  ok "Sesión 'trabajo' activa"
  tmux ls
else
  fail "Sesión 'trabajo' no encontrada — las descargas pueden haber terminado"
fi
echo ""

# ---- 2. OLLAMA ----
echo -e "${YELLOW}[ OLLAMA ]${NC}"
if command -v ollama &>/dev/null; then
  ok "Ollama instalado: $(ollama --version 2>/dev/null)"
  MODELOS=$(ollama list 2>/dev/null | tail -n +2)
  if [ -n "$MODELOS" ]; then
    ok "Modelos disponibles:"
    ollama list
  else
    warn "Sin modelos todavía — puede seguir descargando"
    info "Ver progreso: tmux attach -t trabajo"
  fi
else
  fail "Ollama no instalado"
fi
echo ""

# ---- 3. TAILSCALE ----
echo -e "${YELLOW}[ TAILSCALE ]${NC}"
if command -v tailscale &>/dev/null; then
  STATUS=$(tailscale status 2>/dev/null | head -10)
  ok "Tailscale activo"
  echo "$STATUS"
else
  fail "Tailscale no encontrado"
fi
echo ""

# ---- 4. SSH ----
echo -e "${YELLOW}[ SSH ]${NC}"
if systemctl is-active --quiet sshd; then
  ok "sshd corriendo"
else
  fail "sshd parado — ejecuta: sudo systemctl start sshd"
fi
PWDAUTH=$(grep 'PasswordAuthentication' /etc/ssh/sshd_config | grep -v '#' | head -1)
if echo "$PWDAUTH" | grep -q 'no'; then
  ok "PasswordAuthentication no (hardening OK)"
else
  warn "PasswordAuthentication puede estar habilitado: $PWDAUTH"
fi
echo ""

# ---- 5. GIT REPO ----
echo -e "${YELLOW}[ REPO YGGDRASIL-DEW ]${NC}"
cd ~/yggdrasil-dew 2>/dev/null || { fail "Repo no encontrado en ~/yggdrasil-dew"; }
GIT_STATUS=$(git status --short 2>/dev/null)
if [ -z "$GIT_STATUS" ]; then
  ok "Repo limpio — todo sincronizado"
else
  warn "Cambios pendientes:"
  git status --short
fi
LAST_COMMIT=$(git log --oneline -3 2>/dev/null)
info "Últimos commits:"
echo "$LAST_COMMIT"
echo ""

# ---- 6. INBOX ----
echo -e "${YELLOW}[ INBOX ]${NC}"
INBOX=$(ls ~/yggdrasil-dew/inbox/*.md 2>/dev/null | grep -v README)
if [ -z "$INBOX" ]; then
  ok "Inbox limpio ✅"
else
  warn "Archivos pendientes en inbox:"
  ls ~/yggdrasil-dew/inbox/*.md 2>/dev/null | grep -v README
fi
echo ""

# ---- 7. DISCO ----
echo -e "${YELLOW}[ DISCO ]${NC}"
df -h / | tail -1 | awk '{print "Usado: "$3" / "$2" ("$5" lleno)"}'
echo ""

# ---- 8. MEMORIA ----
echo -e "${YELLOW}[ MEMORIA RAM ]${NC}"
free -h | grep Mem | awk '{print "Usada: "$3" / "$2}'
echo ""

# ---- 9. GPU ----
echo -e "${YELLOW}[ GPU GTX 1060 ]${NC}"
if command -v nvidia-smi &>/dev/null; then
  nvidia-smi --query-gpu=name,temperature.gpu,utilization.gpu,memory.used,memory.total --format=csv,noheader
else
  warn "nvidia-smi no disponible"
fi
echo ""

# ---- RESUMEN ----
echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}  SIGUIENTE PASO RECOMENDADO${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""
echo "  1. Ver Ollama:    tmux attach -t trabajo"
echo "  2. Test modelo:   ollama run mistral:7b 'hola'"
echo "  3. Sync repo:     cd ~/yggdrasil-dew && git pull"
echo "  4. Issues open:   https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues"
echo ""
echo -e "${GREEN}Buenos días! 🌞${NC}"
echo ""
