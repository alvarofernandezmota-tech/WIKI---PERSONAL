#!/bin/bash
# ================================================================
# MACRO NOCHE — Script maestro multifase para Madre
# RUTA ABSOLUTA: /home/varopc/yggdrasil-dew/macro-noche.sh
# Uso desde Madre: bash /home/varopc/yggdrasil-dew/macro-noche.sh
#
# Fases:
#   1. Sync repo con GitHub
#   2. Estado descargas Ollama
#   3. Auditoria del sistema (disco, RAM, GPU, git)
#   4. Limpieza y permisos
#   5. Procesar inbox
#   6. Investigacion autonoma con Ollama
#   7. Commit y push de todo
#   8. Informe final
# ================================================================
REPO=/home/varopc/yggdrasil-dew
LOG=$REPO/logs/macro-noche-$(date '+%Y-%m-%d').log
mkdir -p $REPO/logs

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; RED='\033[0;31m'; NC='\033[0m'
log() { echo -e "$1" | tee -a $LOG; }

log "\n${CYAN}==================================================${NC}"
log "${CYAN}  YGGDRASIL — MACRO NOCHE$(date '+%Y-%m-%d %H:%M CEST')${NC}"
log "${CYAN}==================================================${NC}\n"

# FASE 1 — Sync repo
log "${YELLOW}[1/8] Sincronizando repo...${NC}"
cd $REPO || { log "${RED}ERROR: no se encuentra $REPO — ejecuta bootstrap primero${NC}"; exit 1; }
git pull origin main >> $LOG 2>&1 \
  && log "${GREEN}  ✅ Repo actualizado${NC}" \
  || log "${YELLOW}  ⚠️  Pull falló (sin red o token caducado)${NC}"

# FASE 2 — Estado Ollama y descargas
log "\n${YELLOW}[2/8] Verificando Ollama y descargas...${NC}"
if curl -s http://localhost:11434/api/tags > /tmp/ollama_tags.json 2>/dev/null; then
  MODELOS=$(python3 -c "import json; d=json.load(open('/tmp/ollama_tags.json')); [print('  ✅',m['name']) for m in d.get('models',[])]" 2>/dev/null)
  log "${GREEN}  Ollama activo. Modelos:${NC}"
  log "$MODELOS"
else
  log "${YELLOW}  ⚠️  Ollama no responde${NC}"
fi
tmux has-session -t trabajo 2>/dev/null \
  && log "${GREEN}  ✅ tmux 'trabajo' activo (descarga en curso)${NC}" \
  || log "  ℹ️  Sin sesion tmux 'trabajo'"

# FASE 3 — Auditoria sistema
log "\n${YELLOW}[3/8] Auditoria del sistema...${NC}"
log "  💾 Disco: $(df -h / | awk 'NR==2{print $3"/"$2" ("$5")"}')" 
log "  🧠 RAM:   $(free -h | awk '/^Mem:/{print $3"/"$2}')" 
command -v nvidia-smi &>/dev/null && \
  log "  🎮 VRAM:  $(nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader,nounits | awk '{print $1"MB / "$2"MB"}')"
AHEAD=$(git rev-list origin/main..HEAD --count 2>/dev/null || echo 0)
[ "$AHEAD" -gt 0 ] && log "${YELLOW}  ⚠️  $AHEAD commits sin push${NC}" || log "${GREEN}  ✅ Git sincronizado${NC}"

# FASE 4 — Limpieza
log "\n${YELLOW}[4/8] Limpieza y permisos...${NC}"
[ -f "$REPO/ssh" ] && rm -f $REPO/ssh && log "  ✅ Archivo 'ssh' vacio eliminado"
find $REPO -name '.DS_Store' -delete 2>/dev/null
find $REPO -name '*.tmp' -delete 2>/dev/null
find $REPO/scripts -name '*.sh' -exec chmod +x {} \;
chmod +x $REPO/bootstrap.sh $REPO/macro-noche.sh 2>/dev/null
log "${GREEN}  ✅ Limpieza completa + permisos actualizados${NC}"

# FASE 5 — Procesar inbox
log "\n${YELLOW}[5/8] Procesando inbox...${NC}"
INBOX_N=$(ls $REPO/inbox/*.md 2>/dev/null | grep -v README | wc -l)
if [ "$INBOX_N" -gt 0 ]; then
  mkdir -p $REPO/inbox/procesado
  for f in $REPO/inbox/*.md; do
    [ "$(basename $f)" = "README.md" ] && continue
    mv "$f" $REPO/inbox/procesado/
    log "  → Movido: $(basename $f)"
  done
  log "${GREEN}  ✅ $INBOX_N archivos procesados${NC}"
else
  log "  ℹ️  Inbox vacio"
fi

# FASE 6 — Investigacion autonoma Ollama
log "\n${YELLOW}[6/8] Investigacion autonoma con Ollama...${NC}"
if curl -s http://localhost:11434/api/tags > /dev/null 2>&1; then
  CONFIG=$REPO/config/router_llm.json
  if [ -f "$CONFIG" ]; then
    MODELO=$(python3 -c "import json; print(json.load(open('$CONFIG'))['MODELO_DEFAULT_LOCAL'])" 2>/dev/null)
  fi
  [ -z "$MODELO" ] && MODELO=$(ollama list 2>/dev/null | awk 'NR==2{print $1}')
  [ -z "$MODELO" ] && MODELO="qwen2.5-coder:7b"
  log "  🤖 Modelo: $MODELO"
  PROMPT="Genera un resumen tecnico de 5 puntos sobre mejores practicas para homelab multi-agente con Ollama, LangGraph y n8n en Arch Linux con GTX 1060. Responde en espanol, maximo 300 palabras."
  RESPUESTA=$(curl -s -X POST http://localhost:11434/api/generate \
    -d "{\"model\": \"$MODELO\", \"prompt\": \"$PROMPT\", \"stream\": false, \"options\": {\"temperature\": 0.3, \"num_predict\": 400}}" \
    | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('response','ERROR'))" 2>/dev/null)
  if [ -n "$RESPUESTA" ]; then
    OUTFILE=$REPO/docs/investigacion/auto-research-$(date '+%Y-%m-%d').md
    printf '# Auto-Research Nocturno — %s\n\n> Modelo: %s\n> Fecha: %s\n\n%s\n' \
      "$(date '+%Y-%m-%d')" "$MODELO" "$(date '+%Y-%m-%d %H:%M CEST')" "$RESPUESTA" > "$OUTFILE"
    log "${GREEN}  ✅ Guardado: $OUTFILE${NC}"
  else
    log "${YELLOW}  ⚠️  Sin respuesta de Ollama${NC}"
  fi
else
  log "  ⏭️  Ollama no disponible, saltando fase 6"
fi

# FASE 7 — Commit y push
log "\n${YELLOW}[7/8] Commit y push...${NC}"
CHANGES=$(git status --porcelain | wc -l)
if [ "$CHANGES" -gt 0 ]; then
  git add -A
  git commit -m "chore: macro-noche $(date '+%Y-%m-%d %H:%M') — $CHANGES archivos"
  git push origin main >> $LOG 2>&1 \
    && log "${GREEN}  ✅ Push completado ($CHANGES archivos)${NC}" \
    || log "${YELLOW}  ⚠️  Push falló${NC}"
else
  log "  ℹ️  Sin cambios que commitear"
fi

# FASE 8 — Informe final
log "\n${CYAN}==================================================${NC}"
log "${CYAN}  ✅ MACRO NOCHE COMPLETADA${NC}"
log "${CYAN}  Log completo: $LOG${NC}"
log "${CYAN}  Madre trabajando. Duerme bien, Álvaro. 🌙${NC}"
log "${CYAN}==================================================${NC}\n"
