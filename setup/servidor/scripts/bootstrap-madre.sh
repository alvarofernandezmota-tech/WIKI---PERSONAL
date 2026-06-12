#!/bin/bash
# =============================================================================
# bootstrap-madre.sh — Instalación completa del servidor Madre
# Arch Linux / Hyprland / GTX 1060 6GB / i5-8400 / 16GB RAM
# Ejecutar como usuario varo (con sudo disponible)
# Uso: bash bootstrap-madre.sh
# Doc: setup/servidor/arquitectura.md
# =============================================================================

set -e
echo "=== BOOTSTRAP MADRE === $(date) ==="

# -----------------------------------------------------------------------------
# FASE 0 — ACTUALIZACION DEL SISTEMA
# -----------------------------------------------------------------------------
echo "[0/6] Actualizando sistema..."
sudo pacman -Syu --noconfirm

# -----------------------------------------------------------------------------
# FASE 1 — ACCESO REMOTO (P1 — obligatorio primero)
# -----------------------------------------------------------------------------
echo "[1/6] SSH..."
sudo pacman -S --noconfirm openssh
sudo systemctl enable --now sshd

echo "[1/6] Tailscale..."
sudo pacman -S --noconfirm tailscale
sudo systemctl enable --now tailscaled
sudo tailscale up

# -----------------------------------------------------------------------------
# FASE 2 — FIREWALL Y PROTECCION
# -----------------------------------------------------------------------------
echo "[2/6] UFW..."
sudo pacman -S --noconfirm ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow from 100.86.119.102 to any port 22
sudo ufw allow from 100.86.119.102 to any port 5900
sudo ufw enable
sudo systemctl enable ufw

echo "[2/6] fail2ban..."
sudo pacman -S --noconfirm fail2ban
sudo systemctl enable --now fail2ban
sudo tee /etc/fail2ban/jail.local > /dev/null <<EOF
[sshd]
enabled = true
port = ssh
maxretry = 5
bantime = 3600
findtime = 600
EOF
sudo systemctl restart fail2ban

# -----------------------------------------------------------------------------
# FASE 3 — DOCKER
# -----------------------------------------------------------------------------
echo "[3/6] Docker..."
sudo pacman -S --noconfirm docker docker-compose
sudo systemctl enable --now docker
sudo usermod -aG docker varo

if command -v yay &> /dev/null; then
    yay -S --noconfirm nvidia-container-toolkit
    sudo systemctl restart docker
else
    echo "AVISO: yay no encontrado. Instalar nvidia-container-toolkit manualmente."
fi

# -----------------------------------------------------------------------------
# FASE 4 — SERVICIOS
# -----------------------------------------------------------------------------
echo "[4/6] PostgreSQL..."
sudo pacman -S --noconfirm postgresql
sudo -u postgres initdb -D /var/lib/postgres/data
sudo systemctl enable --now postgresql

echo "[4/6] Pi-hole..."
mkdir -p ~/servidor/pihole
tee ~/servidor/pihole/docker-compose.yml > /dev/null <<EOF
services:
  pihole:
    image: pihole/pihole:latest
    container_name: pihole
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "80:80"
    environment:
      TZ: 'Europe/Madrid'
      WEBPASSWORD: 'cambiar_esto'
    volumes:
      - ./etc-pihole:/etc/pihole
      - ./etc-dnsmasq.d:/etc/dnsmasq.d
    restart: unless-stopped
EOF
cd ~/servidor/pihole && docker compose up -d

echo "[4/6] Ollama + Open WebUI..."
mkdir -p ~/servidor/ollama
tee ~/servidor/ollama/docker-compose.yml > /dev/null <<EOF
services:
  ollama:
    image: ollama/ollama:latest
    container_name: ollama
    ports:
      - "11434:11434"
    volumes:
      - ./ollama:/root/.ollama
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
    restart: unless-stopped
  open-webui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: open-webui
    ports:
      - "3000:8080"
    environment:
      - OLLAMA_BASE_URL=http://ollama:11434
    volumes:
      - ./webui:/app/backend/data
    depends_on:
      - ollama
    restart: unless-stopped
EOF
cd ~/servidor/ollama && docker compose up -d

echo "[4/6] Uptime Kuma..."
mkdir -p ~/servidor/uptime-kuma
tee ~/servidor/uptime-kuma/docker-compose.yml > /dev/null <<EOF
services:
  uptime-kuma:
    image: louislam/uptime-kuma:latest
    container_name: uptime-kuma
    ports:
      - "3001:3001"
    volumes:
      - ./data:/app/data
    restart: unless-stopped
EOF
cd ~/servidor/uptime-kuma && docker compose up -d

# -----------------------------------------------------------------------------
# FASE 5 — AUDITORIA
# -----------------------------------------------------------------------------
echo "[5/6] Auditoría..."
sudo pacman -S --noconfirm lynis rkhunter btop
sudo lynis audit system --quick

# -----------------------------------------------------------------------------
# FASE 6 — ESCRITORIO REMOTO
# -----------------------------------------------------------------------------
echo "[6/6] wayvnc autostart..."
HYPR_CONF="$HOME/.config/hypr/hyprland.conf"
if ! grep -q 'wayvnc' "$HYPR_CONF" 2>/dev/null; then
    echo "exec-once = /usr/bin/wayvnc --seat=seat0 --output=DP-1 0.0.0.0 5900" >> "$HYPR_CONF"
fi

# -----------------------------------------------------------------------------
# RESUMEN
# -----------------------------------------------------------------------------
echo ""
echo "======================================="
echo " BOOTSTRAP COMPLETADO — $(date)"
echo "======================================="
echo " SSH:        $(systemctl is-active sshd)"
echo " Tailscale:  $(systemctl is-active tailscaled)"
echo " UFW:        $(systemctl is-active ufw)"
echo " fail2ban:   $(systemctl is-active fail2ban)"
echo " Docker:     $(systemctl is-active docker)"
echo " PostgreSQL: $(systemctl is-active postgresql)"
echo ""
docker ps --format 'table {{.Names}}\t{{.Status}}'
echo ""
ss -tlnp
echo ""
echo " ⚠️  Reinicia sesión para que el grupo docker tenga efecto"
echo " ⚠️  Cambia WEBPASSWORD de Pi-hole"
echo "======================================="
