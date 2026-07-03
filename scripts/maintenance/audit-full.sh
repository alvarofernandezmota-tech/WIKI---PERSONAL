#!/bin/bash
# ============================================================
# AUDIT FULL — Yggdrasil Ecosystem
# Auditoría completa: repo, inbox, docs, issues, disco, red
# Uso: bash ~/yggdrasil-dew/scripts/maintenance/audit-full.sh
# ============================================================

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m'; NC='\033[0m'
ok()   { echo -e "${GREEN}✅ $1${NC}"; }
fail() { echo -e "${RED}❌ $1${NC}"; }
warn() { echo -e "${YELLOW}⚠️  $1${NC}"; }
info() { echo -e "${CYAN}ℹ️  $1${NC}"; }
sec()  { echo -e "\n${BLUE}══════════════════════════════${NC}"; echo -e "${BLUE}  $1${NC}"; echo -e "${BLUE}══════════════════════════════${NC}"; }

REPO=~/yggdrasil-dew
cd $REPO || { fail "Repo no encontrado"; exit 1; }

echo ""
echo -e "${BLUE}╔══════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   AUDIT FULL — $(date '+%Y-%m-%d %H:%M CEST')         ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════╝${NC}"

# === 1. GIT STATUS ===
sec "GIT STATUS"
BRANCH=$(git branch --show-current)
LAST=$(git log --oneline -1)
info "Rama: $BRANCH"
info "Último commit: $LAST"
DIRTY=$(git status --short)
[ -z "$DIRTY" ] && ok "Working tree limpio" || { warn "Cambios sin commitear:"; git status --short; }
info "Últimos 5 commits:"
git log --oneline -5

# === 2. ESTRUCTURA REPO ===
sec "ESTRUCTURA REPO"
info "Directorios raíz:"
ls -d */ 2>/dev/null | sort
info "Archivos raíz sueltos (no directorios, no ocultos):"
ls -p | grep -v / | grep -v '^\.'
# Detectar archivos vacíos sueltos
EMPTY=$(find . -maxdepth 1 -type f -empty ! -name '.*' 2>/dev/null)
[ -n "$EMPTY" ] && warn "Archivos vacíos en raíz: $EMPTY" || ok "Sin archivos vacíos en raíz"

# === 3. INBOX ===
sec "INBOX"
PENDIENTES=$(find inbox/ -maxdepth 1 -name '*.md' ! -name 'README*' 2>/dev/null)
[ -z "$PENDIENTES" ] && ok "Inbox limpio ✅" || { warn "Pendientes en inbox:"; echo "$PENDIENTES"; }
PROCESADOS=$(find inbox/procesado/ -name '*.md' 2>/dev/null | wc -l)
info "Archivos procesados: $PROCESADOS"

# === 4. DOCS ===
sec "DOCS"
info "Estructura docs/:"
find docs/ -type f -name '*.md' 2>/dev/null | sort
info "Diarios existentes:"
find docs/diarios/ -name '*.md' 2>/dev/null | sort 2>/dev/null || warn "Sin docs/diarios/ todavía"

# === 5. SCRIPTS ===
sec "SCRIPTS"
info "Scripts disponibles:"
find scripts/ -name '*.sh' 2>/dev/null | sort
NOEXEC=$(find scripts/ -name '*.sh' ! -executable 2>/dev/null)
[ -n "$NOEXEC" ] && warn "Scripts sin permisos de ejecución (run: chmod +x):\n$NOEXEC"

# === 6. OLLAMA ===
sec "OLLAMA"
if command -v ollama &>/dev/null; then
  MODS=$(ollama list 2>/dev/null | tail -n +2 | awk '{print $1}')
  COUNT=$(echo "$MODS" | grep -c . 2>/dev/null || echo 0)
  [ "$COUNT" -gt 0 ] && ok "$COUNT modelos disponibles:" && ollama list || warn "Sin modelos todavía"
else
  fail "Ollama no instalado"
fi

# === 7. TMUX ===
sec "TMUX"
if tmux ls 2>/dev/null | grep -q .; then
  ok "Sesiones tmux activas:"
  tmux ls
else
  info "Sin sesiones tmux activas"
fi

# === 8. SISTEMA ===
sec "SISTEMA"
info "Disco:"
df -h / | tail -1 | awk '{printf "  Usado: %s / %s (%s)\n", $3, $2, $5}'
info "RAM:"
free -h | grep Mem | awk '{printf "  Usada: %s / %s\n", $3, $2}'
if command -v nvidia-smi &>/dev/null; then
  info "GPU:"
  nvidia-smi --query-gpu=name,temperature.gpu,utilization.gpu,memory.used,memory.total --format=csv,noheader | sed 's/^/  /'
fi

# === 9. RED / TAILSCALE ===
sec "RED & TAILSCALE"
if command -v tailscale &>/dev/null; then
  ok "Tailscale:"
  tailscale status 2>/dev/null | head -8
else
  warn "Tailscale no encontrado"
fi

# === 10. SSH ===
sec "SSH HARDENING"
systemctl is-active --quiet sshd && ok "sshd activo" || fail "sshd parado"
PA=$(grep -E '^PasswordAuthentication' /etc/ssh/sshd_config 2>/dev/null | head -1)
echo "$PA" | grep -q 'no' && ok "PasswordAuthentication no" || warn "Revisar: $PA"
RA=$(grep -E '^PermitRootLogin' /etc/ssh/sshd_config 2>/dev/null | head -1)
echo "$RA" | grep -qi 'no' && ok "PermitRootLogin no" || warn "Revisar: $RA"

# === RESUMEN FINAL ===
echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║           AUDITORÍA COMPLETA OK              ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════╝${NC}"
echo ""
echo "  Siguiente: bash scripts/maintenance/morning-check.sh"
echo "  Issues:    https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues"
echo ""
