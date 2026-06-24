#!/bin/bash
# =============================================================================
# descarga-fase2.sh — Descarga imágenes Fase 2 con reintentos
# Uso: bash descarga-fase2.sh
# =============================================================================

LOG="/tmp/descarga-fase2.log"
echo "" > $LOG

log()  { echo "[$(date '+%H:%M:%S')] $1" | tee -a $LOG; }
pull() {
  log "⬇️  $1"
  until docker pull $1 >> $LOG 2>&1; do
    log "⚠️  Reintentando $1..."; sleep 5
  done
  log "✅ $1"
}

log "--- FASE 2: Batcueva Monitoring + OSINT ---"
pull portainer/portainer-ce:latest
pull louislam/uptime-kuma:latest
pull smicallef/spiderfoot:latest
pull linuxserver/heimdall:latest

log ""
log "✅ Fase 2 descargada. Levantar con:"
log "   docker compose -f setup/servidor/batcueva-fase2.yml up -d"
