#!/bin/bash
# =============================================================================
# configurar-fase3.sh — Levanta + configura Fase 3 completa
# Uso: bash configurar-fase3.sh
# Requiere: Fases 1 y 2 activas
# =============================================================================

LOG="/tmp/configurar-fase3.log"
echo "" > $LOG
log() { echo "[$(date '+%H:%M:%S')] $1" | tee -a $LOG; }

cd ~/yggdrasil-dew

# --- Headscale config ---
log "--- Configurando Headscale ---"
mkdir -p ~/.config/headscale
cat > ~/.config/headscale/config.yaml << 'EOF'
server_url: http://100.91.112.32:8085
listen_addr: 0.0.0.0:8080
metrics_listen_addr: 0.0.0.0:9090
grpc_listen_addr: 0.0.0.0:50443
ip_prefixes:
  - 100.64.0.0/10
dns_config:
  nameservers:
    - 1.1.1.1
  magic_dns: true
  base_domain: batcueva.local
EOF

log "--- Levantando Fase 3 ---"
docker compose -f setup/servidor/batcueva-fase3.yml up -d >> $LOG 2>&1

log "--- Esperando servicios (30s) ---"
sleep 30

# --- Headscale: crear namespace ---
log "--- Headscale: namespace alvaro ---"
docker exec headscale headscale namespaces create alvaro >> $LOG 2>&1 || true
log "--- Headscale: generar authkey reutilizable ---"
docker exec headscale headscale preauthkeys create \
  --namespace alvaro --reusable --expiration 999d 2>&1 | tee -a $LOG

log "--- UFW: reglas Fase 3 ---"
# Solo desde LAN o Tailscale
sudo ufw allow from 192.168.1.0/24 to any port 5678  # n8n
sudo ufw allow from 100.64.0.0/10  to any port 5678
sudo ufw allow from 192.168.1.0/24 to any port 3003  # Gitea
sudo ufw allow from 100.64.0.0/10  to any port 3003
sudo ufw allow from 192.168.1.0/24 to any port 8443  # Code Server
sudo ufw allow from 100.64.0.0/10  to any port 8443
sudo ufw allow 8085  # Headscale público
sudo ufw reload

log "--- Estado servicios ---"
docker compose -f setup/servidor/batcueva-fase3.yml ps | tee -a $LOG

IP=$(hostname -I | awk '{print $1}')
log ""
log "✅ Fase 3 lista:"
log "   n8n:         http://$IP:5678"
log "   Gitea:       http://$IP:3003"
log "   Code Server: http://$IP:8443"
log "   Headscale:   http://$IP:8085"
