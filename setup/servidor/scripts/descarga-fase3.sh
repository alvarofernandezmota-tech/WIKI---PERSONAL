#!/bin/bash
# =============================================================================
# descarga-fase3.sh — Descarga imágenes Fase 3 con reintentos
# Uso: bash descarga-fase3.sh
# =============================================================================

LOG="/tmp/descarga-fase3.log"
echo "" > $LOG

log()  { echo "[$(date '+%H:%M:%S')] $1" | tee -a $LOG; }
pull() {
  log "⬇️  $1"
  until docker pull $1 >> $LOG 2>&1; do
    log "⚠️  Reintentando $1..."; sleep 5
  done
  log "✅ $1"
}

log "--- FASE 3: Automatización + Dev remoto ---"
pull n8nio/n8n:latest
pull gitea/gitea:latest
pull lscr.io/linuxserver/code-server:latest
pull headscale/headscale:latest

log ""
log "✅ Fase 3 descargada. Levantar con:"
log "   docker compose -f setup/servidor/batcueva-fase3.yml up -d"
