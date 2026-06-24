#!/bin/bash
# =============================================================================
# descargas-nocturnas-madre.sh
# Descarga en background modelos Ollama + imágenes Docker pendientes.
#
# CARACTERÍSTICAS:
#   - Reintentos automáticos (5 intentos por item, espera entre reintentos)
#   - Salta Fase 1 — ollama/ollama, open-webui, qdrant ya están activos
#   - Salta modelos Ollama ya descargados (qwen2.5:3b)
#   - Log detallado en /tmp/descargas-madre.log
#   - Seguro con Acer apagado — usar con nohup
#
# USO:
#   nohup bash descargas-nocturnas-madre.sh &
#   tail -f /tmp/descargas-madre.log
# =============================================================================

set -euo pipefail

LOG="/tmp/descargas-madre.log"
MAX_INTENTOS=5
ESPERA_REINTENTO=30  # segundos entre reintentos

# Colores para log
OK="\u2705"
ERR="\u274c"
INFO="\u27a4"
WARN="\u26a0️"

log() { echo "[$(date +%H:%M:%S)] $*" | tee -a "$LOG"; }

# Función de descarga con reintentos
desc_con_reintentos() {
  local TIPO="$1"   # ollama | docker
  local ITEM="$2"
  local INTENTO=1

  while [ $INTENTO -le $MAX_INTENTOS ]; do
    log "$INFO [$INTENTO/$MAX_INTENTOS] $TIPO pull: $ITEM"

    if [ "$TIPO" = "ollama" ]; then
      ollama pull "$ITEM" >> "$LOG" 2>&1 && {
        log "$OK $ITEM descargado"
        return 0
      }
    elif [ "$TIPO" = "docker" ]; then
      docker pull "$ITEM" >> "$LOG" 2>&1 && {
        log "$OK $ITEM descargado"
        return 0
      }
    fi

    log "$WARN Fallo intento $INTENTO. Esperando ${ESPERA_REINTENTO}s..."
    sleep $ESPERA_REINTENTO
    INTENTO=$((INTENTO + 1))
  done

  log "$ERR FALLIDO tras $MAX_INTENTOS intentos: $ITEM — continuando con el siguiente"
  return 1  # no aborta el script, solo registra el fallo
}

# =============================================================================
# INICIO
# =============================================================================
> "$LOG"
log "======================================================"
log " DESCARGAS NOCTURNAS MADRE — $(date)"
log "======================================================"
log ""
log "Madre CPU-only. Fase 1 ya activa (ollama/qdrant/open-webui). Skipping."
log ""

# =============================================================================
# 1. MODELOS OLLAMA
#    Embeddings primero (críticos para local-brain RAG), luego LLMs por tamaño
#    qwen2.5:3b ya descargado — se salta automáticamente
# =============================================================================
log "--- OLLAMA: MODELOS ---"

OLLAMA_MODELS=(
  "nomic-embed-text"   # 274 MB  — embeddings ligeros    (local-brain RAG)
  "bge-m3"             # 1.2 GB  — embeddings multiling  (local-brain RAG)
  "qwen2.5:7b"         # 4.7 GB  — LLM general Madre
  "qwen2.5:14b"        # 9.0 GB  — LLM razonamiento
  "llama3.1:8b"        # 4.7 GB  — fallback open source
  "mistral:7b"         # 4.1 GB  — alternativa ligera
)

YA_INSTALADOS=$(ollama list 2>/dev/null | awk 'NR>1 {print $1}')

for MODEL in "${OLLAMA_MODELS[@]}"; do
  # Extraer nombre base para comparar (qwen2.5:7b → qwen2.5:7b)
  if echo "$YA_INSTALADOS" | grep -q "^${MODEL}"; then
    log "$INFO SKIP (ya instalado): $MODEL"
  else
    desc_con_reintentos "ollama" "$MODEL"
  fi
done

# =============================================================================
# 2. DOCKER IMAGES — Fase 3 + Fase 4 + osint-stack
#    Fase 1 (ollama/qdrant/open-webui) ya activa — no se incluye
# =============================================================================
log ""
log "--- DOCKER: FASE 3 ---"

FASE3_IMAGES=(
  "n8nio/n8n:latest"                         # :5678 — workflows automatización
  "ghcr.io/paperless-ngx/paperless-ngx:latest" # :8010 — gestión documentos
  "vaultwarden/server:latest"                 # :8888 — gestor contraseñas
)

for IMG in "${FASE3_IMAGES[@]}"; do
  desc_con_reintentos "docker" "$IMG"
done

log ""
log "--- DOCKER: FASE 4 ---"

FASE4_IMAGES=(
  "jc21/nginx-proxy-manager:latest"           # :81   — proxy inverso
  "containrrr/watchtower:latest"              # auto-update contenedores
)

for IMG in "${FASE4_IMAGES[@]}"; do
  desc_con_reintentos "docker" "$IMG"
done

log ""
log "--- DOCKER: OSINT-STACK ---"

OSINT_IMAGES=(
  "spiderfoot/spiderfoot:latest"              # OSINT framework
  "caffix/amass:latest"                       # reconocimiento subdominios
)

for IMG in "${OSINT_IMAGES[@]}"; do
  desc_con_reintentos "docker" "$IMG"
done

# =============================================================================
# 3. RESUMEN FINAL
# =============================================================================
log ""
log "======================================================"
log " RESUMEN FINAL — $(date)"
log "======================================================"
log ""
log "Modelos Ollama en Madre:"
ollama list 2>/dev/null | tee -a "$LOG"
log ""
log "Imágenes Docker disponibles:"
docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" 2>/dev/null | tee -a "$LOG"
log ""
log "$OK Script completado: $(date)"
log "$INFO Log completo: $LOG"
