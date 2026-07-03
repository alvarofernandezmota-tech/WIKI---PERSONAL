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
ORANGE='\033[0;33m'
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

# ---- 1. INBOX APLAZADOS ----
echo -e "${YELLOW}[ 📥 INBOX — APLAZADOS ]${NC}"
REPO=~/yggdrasil-dew
HOY=$(date +%s)
CRITICOS=0
ALTOS=0
HAY_APLAZADOS=false

for f in $REPO/inbox/APLAZADO-*.md; do
  [ -f "$f" ] || continue
  HAY_APLAZADOS=true
  NOMBRE=$(basename "$f")

  # Leer frontmatter
  TITULO=$(grep '^titulo:' "$f" | head -1 | sed 's/titulo: *"\?//;s/"\?$//')
  FECHA=$(grep '^fecha_creacion:' "$f" | head -1 | sed 's/fecha_creacion: *"\?//;s/"\?$//')
  ESTADO=$(grep '^estado:' "$f" | head -1 | sed 's/estado: *"\?//;s/"\?.*$//' | tr -d ' ')
  ISSUE=$(grep '^issue_ref:' "$f" | head -1 | sed 's/issue_ref: *"\?//;s/"\?$//' | tr -d ' ')
  URGENCIA_MANUAL=$(grep '^urgencia_manual:' "$f" | head -1 | sed 's/urgencia_manual: *"\?//;s/"\?$//' | tr -d ' ')

  # Calcular días aplazado
  if [ -n "$FECHA" ] && [ "$FECHA" != "YYYY-MM-DD" ]; then
    FECHA_S=$(date -d "$FECHA" +%s 2>/dev/null)
    DIAS=$(( (HOY - FECHA_S) / 86400 ))
  else
    DIAS=0
  fi

  # Determinar urgencia
  if [ -n "$URGENCIA_MANUAL" ] && [ "$URGENCIA_MANUAL" != "\"\"" ]; then
    URG="$URGENCIA_MANUAL"
  elif [ "$DIAS" -ge 7 ]; then
    URG="critica"
  elif [ "$DIAS" -ge 4 ]; then
    URG="alta"
  elif [ "$DIAS" -ge 2 ]; then
    URG="media"
  else
    URG="baja"
  fi

  # Emoji urgencia
  case "$URG" in
    critica) EMOJI="🔴" ; ((CRITICOS++)) ;;
    alta)    EMOJI="🟠" ; ((ALTOS++)) ;;
    media)   EMOJI="🟡" ;;
    *)       EMOJI="🟢" ;;
  esac

  # Estado emoji
  case "$ESTADO" in
    completado)   EST_EMOJI="✅" ;;
    en_progreso)  EST_EMOJI="🔄" ;;
    *)            EST_EMOJI="⏳" ;;
  esac

  ISSUE_LABEL=""
  [ -n "$ISSUE" ] && [ "$ISSUE" != "\"\"" ] && ISSUE_LABEL=" → issue $ISSUE"

  printf "  %s %s [%s días] %s %s%s\n" "$EMOJI" "$EST_EMOJI" "$DIAS" "$TITULO" "" "$ISSUE_LABEL"
done

if [ "$HAY_APLAZADOS" = false ]; then
  ok "Inbox sin aplazados pendientes 🎉"
fi

if [ "$CRITICOS" -gt 0 ]; then
  echo ""
  echo -e "${RED}  ⚠️  $CRITICOS CRÍTICOS — resolver antes de cualquier otra cosa${NC}"
fi
if [ "$ALTOS" -gt 0 ]; then
  echo -e "${ORANGE}  ⚡ $ALTOS de alta urgencia — para hoy${NC}"
fi
echo ""

# ---- 2. INBOX ARCHIVOS SIN PROCESAR ----
echo -e "${YELLOW}[ 📬 INBOX — Sin procesar ]${NC}"
SIN_PROC=$(ls $REPO/inbox/*.md 2>/dev/null | grep -v README | grep -v APLAZADO)
if [ -z "$SIN_PROC" ]; then
  ok "Inbox limpio — nada sin procesar"
else
  warn "Archivos sin clasificar:"
  echo "$SIN_PROC" | while read f; do echo "  📄 $(basename $f)"; done
fi
echo ""

# ---- 3. TMUX ----
echo -e "${YELLOW}[ TMUX ]${NC}"
if tmux ls 2>/dev/null | grep -q trabajo; then
  ok "Sesión 'trabajo' activa"
  tmux ls
else
  info "Sesión 'trabajo' no activa"
fi
echo ""

# ---- 4. OLLAMA ----
echo -e "${YELLOW}[ OLLAMA ]${NC}"
if command -v ollama &>/dev/null; then
  ok "Ollama instalado: $(ollama --version 2>/dev/null)"
  MODELOS=$(ollama list 2>/dev/null | tail -n +2)
  if [ -n "$MODELOS" ]; then
    ok "Modelos disponibles:"
    ollama list
  else
    warn "Sin modelos — ver: tmux attach -t trabajo"
  fi
else
  fail "Ollama no instalado"
fi
echo ""

# ---- 5. TAILSCALE ----
echo -e "${YELLOW}[ TAILSCALE ]${NC}"
if command -v tailscale &>/dev/null; then
  ok "Tailscale activo"
  tailscale status 2>/dev/null | head -5
else
  fail "Tailscale no encontrado"
fi
echo ""

# ---- 6. SSH ----
echo -e "${YELLOW}[ SSH ]${NC}"
if systemctl is-active --quiet sshd; then
  ok "sshd corriendo"
else
  fail "sshd parado — sudo systemctl start sshd"
fi
echo ""

# ---- 7. GIT REPO ----
echo -e "${YELLOW}[ REPO YGGDRASIL-DEW ]${NC}"
cd $REPO 2>/dev/null || { fail "Repo no encontrado"; exit 1; }
GIT_STATUS=$(git status --short 2>/dev/null)
if [ -z "$GIT_STATUS" ]; then
  ok "Repo limpio — todo sincronizado"
else
  warn "Cambios pendientes:"
  git status --short
fi
info "Últimos commits:"
git log --oneline -3 2>/dev/null
echo ""

# ---- 8. SISTEMA ----
echo -e "${YELLOW}[ SISTEMA ]${NC}"
df -h / | tail -1 | awk '{print "  💾 Disco: "$3" / "$2" ("$5" lleno)"}'
free -h | grep Mem | awk '{print "  🧠 RAM: "$3" / "$2}'
if command -v nvidia-smi &>/dev/null; then
  nvidia-smi --query-gpu=temperature.gpu,utilization.gpu,memory.used,memory.total --format=csv,noheader | \
    awk -F',' '{print "  🎮 GPU: "$1"°C | "$2" uso | "$3"/"$4" VRAM"}'
fi
echo ""

# ---- RESUMEN ----
echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}  SIGUIENTE PASO RECOMENDADO${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""
if [ "$CRITICOS" -gt 0 ]; then
  echo -e "  ${RED}1. Resolver aplazados CRÍTICOS primero${NC}"
  echo "  2. git pull && bash scripts/maintenance/audit-full.sh"
else
  echo "  1. git pull"
  echo "  2. bash scripts/maintenance/audit-full.sh"
  echo "  3. Ver issues: https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues"
fi
echo ""
echo -e "${GREEN}Buenos días! 🌞${NC}"
echo ""
