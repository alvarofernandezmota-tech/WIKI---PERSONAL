#!/bin/bash
# =============================================================================
# configurar-fase2.sh — Levanta + configura Fase 2 completa
# Uso: bash configurar-fase2.sh
# Requiere: Fase 1 activa
# =============================================================================

LOG="/tmp/configurar-fase2.log"
echo "" > $LOG
log() { echo "[$(date '+%H:%M:%S')] $1" | tee -a $LOG; }

cd ~/yggdrasil-dew

log "--- Creando red batcueva ---"
docker network create batcueva 2>/dev/null || log "Red batcueva ya existe"

log "--- Levantando Fase 2 ---"
docker compose -f setup/servidor/batcueva-fase2.yml up -d >> $LOG 2>&1

log "--- Esperando servicios (30s) ---"
sleep 30

log "--- UFW: reglas Fase 2 ---"
sudo ufw allow 9000   # Portainer
sudo ufw allow 9443   # Portainer HTTPS
sudo ufw allow 3001   # Uptime Kuma
sudo ufw allow 5001   # SpiderFoot
sudo ufw allow 8090   # Heimdall
sudo ufw reload

log "--- Estado servicios ---"
docker compose -f setup/servidor/batcueva-fase2.yml ps | tee -a $LOG

IP=$(hostname -I | awk '{print $1}')
log ""
log "✅ Fase 2 lista:"
log "   Portainer:   http://$IP:9000"
log "   Uptime Kuma: http://$IP:3001"
log "   SpiderFoot:  http://$IP:5001"
log "   Heimdall:    http://$IP:8090"
