#!/bin/bash
# =============================================================================
# pre-descarga-todo.sh — Pre-descarga TODAS las imágenes de todas las fases
# Ejecutar en Madre en background: nohup bash pre-descarga-todo.sh &
# Log en: /tmp/pre-descarga.log
# =============================================================================

LOG="/tmp/pre-descarga.log"
echo "" > $LOG

log() { echo "[$(date '+%H:%M:%S')] $1" | tee -a $LOG; }
pull() {
  local img=$1
  log "⬇️  Descargando: $img"
  until docker pull $img >> $LOG 2>&1; do
    log "⚠️  Error TLS, reintentando $img en 5s..."
    sleep 5
  done
  log "✅  OK: $img"
}

log "====================================================="
log " BATCUEVA — Pre-descarga completa de todas las fases"
log "====================================================="

# -------------------------------------------------------------------
# FASE 1 — Stack IA core (Ollama + Open WebUI + Qdrant)
# -------------------------------------------------------------------
log ""
log "--- FASE 1: Stack IA Core ---"
pull ollama/ollama:latest
pull ghcr.io/open-webui/open-webui:main
pull qdrant/qdrant:latest

# -------------------------------------------------------------------
# FASE 2 — Batcueva: monitoring + OSINT + gestión
# -------------------------------------------------------------------
log ""
log "--- FASE 2: Batcueva (monitoring + OSINT) ---"
pull portainer/portainer-ce:latest
pull louislam/uptime-kuma:latest
pull smicallef/spiderfoot:latest
pull linuxserver/heimdall:latest

# -------------------------------------------------------------------
# FASE 3 — Automatización + dev remoto
# -------------------------------------------------------------------
log ""
log "--- FASE 3: Automatización + Dev remoto ---"
pull n8nio/n8n:latest
pull lscr.io/linuxserver/code-server:latest
pull ghcr.io/ajnart/homarr:latest
pull gitea/gitea:latest

# -------------------------------------------------------------------
# FASE 4 — LiteLLM + Paperless + Vaultwarden + Watchtower
# -------------------------------------------------------------------
log ""
log "--- FASE 4: LiteLLM + Paperless + Seguridad ---"
pull ghcr.io/berriai/litellm:main-latest
pull ghcr.io/paperless-ngx/paperless-ngx:latest
pull vaultwarden/server:latest
pull containrrr/watchtower:latest
pull jc21/nginx-proxy-manager:latest
pull redis:7-alpine
pull postgres:15-alpine

# -------------------------------------------------------------------
# MODELOS OLLAMA — descargar via ollama pull
# -------------------------------------------------------------------
log ""
log "--- MODELOS OLLAMA ---"
log "⚠️  Requiere que el contenedor ollama esté corriendo"

if docker ps | grep -q ollama; then
  log "✅ Ollama detectado — descargando modelos..."
  docker exec ollama ollama pull qwen2.5:3b      && log "✅ qwen2.5:3b OK"
  docker exec ollama ollama pull qwen2.5:7b      && log "✅ qwen2.5:7b OK"
  docker exec ollama ollama pull nomic-embed-text && log "✅ nomic-embed-text OK"
  docker exec ollama ollama pull bge-m3           && log "✅ bge-m3 OK"
  docker exec ollama ollama pull llama3:8b        && log "✅ llama3:8b OK"
else
  log "⚠️  Ollama no está corriendo — salta modelos"
  log "   Ejecuta manualmente cuando esté activo:"
  log "   docker exec ollama ollama pull qwen2.5:3b"
  log "   docker exec ollama ollama pull nomic-embed-text"
  log "   docker exec ollama ollama pull bge-m3"
fi

# -------------------------------------------------------------------
# RESUMEN FINAL
# -------------------------------------------------------------------
log ""
log "====================================================="
log " RESUMEN — Imágenes descargadas:"
log "====================================================="
docker images --format "table {{.Repository}}:{{.Tag}}\t{{.Size}}" | tee -a $LOG

log ""
log "🎯 Pre-descarga completada. Ver log completo: cat $LOG"
