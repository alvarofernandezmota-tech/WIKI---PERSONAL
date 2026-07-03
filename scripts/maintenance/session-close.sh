#!/bin/bash
# ================================================================
# SESSION CLOSE — Script de cierre de sesión Yggdrasil
# Ejecutar SIEMPRE al terminar una sesión de trabajo
# Uso: bash ~/yggdrasil-dew/scripts/maintenance/session-close.sh
# ================================================================

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m'; NC='\033[0m'
ok()   { echo -e "${GREEN}✅ $1${NC}"; }
warn() { echo -e "${YELLOW}⚠️  $1${NC}"; }
info() { echo -e "${CYAN}ℹ️  $1${NC}"; }
fail() { echo -e "${RED}❌ $1${NC}"; }

REPO=~/yggdrasil-dew
FECHA=$(date '+%Y-%m-%d')
HORA=$(date '+%H:%M')

echo ""
echo -e "${BLUE}╔══════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   SESSION CLOSE — $FECHA $HORA CEST          ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════╝${NC}"
echo ""

cd $REPO || { fail "Repo no encontrado en $REPO"; exit 1; }

# === PASO 1: INBOX CHECK ===
echo -e "${YELLOW}[1/6] INBOX${NC}"
PENDIENTES=$(find inbox/ -maxdepth 1 -name '*.md' ! -name 'README*' 2>/dev/null)
if [ -n "$PENDIENTES" ]; then
  warn "Inbox tiene archivos sin procesar:"
  echo "$PENDIENTES" | while read f; do echo "  • $f"; done
  echo ""
  read -p "  ¿Procesar ahora? (s/N): " PROC
  if [[ "$PROC" =~ ^[Ss]$ ]]; then
    for f in inbox/*.md; do
      [[ "$f" == *README* ]] && continue
      mv "$f" "inbox/procesado/" && ok "Movido: $f"
    done
  fi
else
  ok "Inbox limpio ✅"
fi

# === PASO 2: GIT STATUS ===
echo ""
echo -e "${YELLOW}[2/6] GIT STATUS${NC}"
DIRTY=$(git status --short)
if [ -n "$DIRTY" ]; then
  warn "Cambios sin commitear:"
  git status --short
  echo ""
  read -p "  Mensaje de commit (Enter para auto): " MSG
  [ -z "$MSG" ] && MSG="chore: cierre sesión $FECHA $HORA"
  git add -A
  git commit -m "$MSG"
  ok "Commit: $MSG"
else
  ok "Working tree limpio"
fi

# === PASO 3: GIT PUSH ===
echo ""
echo -e "${YELLOW}[3/6] GIT PUSH${NC}"
AHEAD=$(git rev-list origin/main..HEAD --count 2>/dev/null)
if [ "$AHEAD" -gt 0 ]; then
  git push && ok "Push OK — $AHEAD commit(s) subidos" || fail "Push fallido — revisar conexión"
else
  ok "Repo ya sincronizado con GitHub"
fi

# === PASO 4: PROCESOS EN BACKGROUND ===
echo ""
echo -e "${YELLOW}[4/6] PROCESOS ACTIVOS${NC}"
if tmux ls 2>/dev/null | grep -q .; then
  ok "Sesiones tmux activas (dejar correr):"
  tmux ls
else
  info "Sin sesiones tmux activas"
fi

# === PASO 5: ESTADO OLLAMA ===
echo ""
echo -e "${YELLOW}[5/6] OLLAMA${NC}"
if command -v ollama &>/dev/null; then
  MODS=$(ollama list 2>/dev/null | tail -n +2 | wc -l)
  if [ "$MODS" -gt 0 ]; then
    ok "$MODS modelo(s) disponibles en Ollama"
  else
    info "Ollama instalado pero sin modelos todavía (descargando en background)"
  fi
else
  warn "Ollama no instalado todavía"
fi

# === PASO 6: RESUMEN + SIGUIENTE SESIÓN ===
echo ""
echo -e "${YELLOW}[6/6] RESUMEN DE CIERRE${NC}"
echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  SESIÓN CERRADA — $FECHA $HORA              ║${NC}"
echo -e "${GREEN}║  Madre sigue trabajando. Buenas noches 🌙    ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════╝${NC}"
echo ""
echo "  Al despertar:"
echo "  bash $REPO/scripts/maintenance/morning-check.sh"
echo ""
