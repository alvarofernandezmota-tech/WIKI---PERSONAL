#!/usr/bin/env bash
# ==============================================================================
# yggdrasil-dew/scripts/setup/servidor/ufw-reglas-completas.sh
# Propósito: Firewall Zero-Trust — solo Tailscale y LAN
# OS: Arch Linux
# Generado: Sesión Gemini 2026-06-27
# ==============================================================================

set -euo pipefail

SSH_PORT="2222"
TAILSCALE_NET="100.64.0.0/10"
LAN_NET="192.168.1.0/24"

echo "[*] Configurando UFW en Madre..."

ufw --force reset
ufw default deny incoming
ufw default allow outgoing
ufw allow in on lo
ufw allow out on lo
ufw allow 41641/udp comment 'Tailscale port'

for NET in "$TAILSCALE_NET" "$LAN_NET"; do
    ufw allow from $NET to any port $SSH_PORT proto tcp comment 'SSH Personalizado'
    ufw allow from $NET to any port 9000 proto tcp comment 'Portainer'
    ufw allow from $NET to any port 11434 proto tcp comment 'Ollama'
    ufw allow from $NET to any port 8080 proto tcp comment 'Open WebUI'
    ufw allow from $NET to any port 6333 proto tcp comment 'Qdrant'
    ufw allow from $NET to any port 8000 proto tcp comment 'THDORA API'
    ufw allow from $NET to any port 3000 proto tcp comment 'Grafana'
    ufw allow from $NET to any port 9090 proto tcp comment 'Prometheus'
    ufw allow from $NET to any port 3002 proto tcp comment 'Uptime Kuma'
    ufw allow from $NET to any port 6901 proto tcp comment 'Kali VNC'
done

ufw --force enable
echo "[+] Perímetro asegurado. Estado:"
ufw status numbered
