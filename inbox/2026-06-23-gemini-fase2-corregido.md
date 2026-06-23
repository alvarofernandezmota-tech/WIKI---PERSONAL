---
tags: [inbox, batcueva, docker, gemini, script, fase2, ollama, kismet, osiris]
fecha: 2026-06-23
estado: LISTO-PARA-EJECUTAR
fuente: Gemini
validado-por: Perplexity
---

# 🤖 Gemini — Script Fase 2 Batcueva (Corregido)

> Script validado y listo para ejecutar en Madre.
> Correcciones aplicadas respecto al script de Grok.

## ✅ Cambios clave respecto a Grok

| Item | Grok (incorrecto) | Gemini (correcto) |
|---|---|---|
| IP Tailscale Madre | 100.86.119.102 ❌ | 100.91.112.32 ✅ |
| Osiris imagen | ghcr.io/simplifaisoul/osiris (no existe) ❌ | ghcr.io/sdr-enthusiasts/docker-tar1090 ✅ |
| Servicios ya instalados | Los duplicaba ❌ | No los toca ✅ |
| Ollama | Lo marcaba como ya instalado ❌ | Lo incluye correctamente ✅ |
| Caddy | En Docker (conflicto) ❌ | Nativo en host ✅ |

---

## 🚀 Script completo

```bash
#!/bin/bash
# =========================================================================
# SCRIPT MAESTRO - DESPLIEGUE FASE 2 (MADRE)
# Arch Linux | IP Tailscale: 100.91.112.32
# Componentes: NVIDIA Toolkit + USB Kismet + Docker Compose + Caddy
# =========================================================================

set -e

DIR_PROYECTO="/home/alvaro/docker/batcueva-fase2"
INTERFAZ_WIFI="wlan0"

echo "=== [1/5] NVIDIA Container Toolkit ==="
if ! pacman -Qs nvidia-container-toolkit > /dev/null; then
    sudo pacman -S --noconfirm nvidia-container-toolkit
    sudo nvidia-ctk runtime configure --runtime=docker
    sudo systemctl restart docker
fi

echo "=== [2/5] Aislar antena USB de NetworkManager ==="
if [ -d "/etc/NetworkManager/conf.d" ]; then
    sudo bash -c "cat << 'NMK' > /etc/NetworkManager/conf.d/99-unmanaged-devices.conf
[keyfile]
unmanaged-devices=interface-name:$INTERFAZ_WIFI
NMK"
    sudo systemctl restart NetworkManager || true
fi

echo "=== [3/5] Instalar Caddy nativo ==="
if ! command -v caddy &> /dev/null; then
    sudo pacman -S --noconfirm caddy
    sudo usermod -aG tailscale caddy
fi

echo "=== [4/5] Crear docker-compose.yml ==="
mkdir -p "$DIR_PROYECTO"
cd "$DIR_PROYECTO"

cat << 'EOF' > docker-compose.yml
version: '3.8'

services:
  ollama:
    image: ollama/ollama:latest
    container_name: batcueva-ollama
    restart: unless-stopped
    ports:
      - "11434:11434"
    environment:
      - TZ=Europe/Madrid
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
    volumes:
      - ollama_data:/root/.ollama

  osiris-globe:
    image: ghcr.io/sdr-enthusiasts/docker-tar1090:latest
    container_name: osiris-globe
    restart: unless-stopped
    ports:
      - "8085:80"
    environment:
      - TZ=Europe/Madrid
      - LAT=40.4167
      - LON=-3.7037
      - NAME=Batcueva_Station
    volumes:
      - osiris_globe_data:/var/globe_history

  kismet:
    image: kismet/kismet:latest
    container_name: kismet-server
    restart: unless-stopped
    network_mode: "host"
    privileged: true
    cap_add:
      - NET_ADMIN
    environment:
      - TZ=Europe/Madrid
    volumes:
      - kismet_data:/rxtx
      - /dev/bus/usb:/dev/bus/usb

volumes:
  ollama_data:
  osiris_globe_data:
  kismet_data:
EOF

echo "=== [5/5] Caddyfile + arrancar servicios ==="
sudo bash -c "cat << 'CAD' > /etc/caddy/Caddyfile
osiris.madre.tailscale    { reverse_proxy 127.0.0.1:8085 }
kismet.madre.tailscale    { reverse_proxy 127.0.0.1:2501 }
ollama.madre.tailscale    { reverse_proxy 127.0.0.1:11434 }
thdora.madre.tailscale    { reverse_proxy 127.0.0.1:8000 }
grafana.madre.tailscale   { reverse_proxy 127.0.0.1:3000 }
prometheus.madre.tailscale{ reverse_proxy 127.0.0.1:9090 }
portainer.madre.tailscale { reverse_proxy 127.0.0.1:9000 }
uptime.madre.tailscale    { reverse_proxy 127.0.0.1:3002 }
openwebui.madre.tailscale { reverse_proxy 127.0.0.1:3001 }
spiderfoot.madre.tailscale{ reverse_proxy 127.0.0.1:5001 }
CAD"

docker compose up -d
sudo systemctl enable --now caddy
sudo systemctl reload caddy

echo "✅ Fase 2 completada"
echo " -> http://osiris.madre.tailscale"
echo " -> http://kismet.madre.tailscale"
echo " -> http://openwebui.madre.tailscale"
```

---

## ⚠️ Antes de ejecutar

1. Conectar antena USB WiFi externa a Madre (modo monitor)
2. Verificar que Tailscale MagicDNS está activo en Madre
3. Cambiar `INTERFAZ_WIFI="wlan0"` por la interfaz real de la antena
   (comprobarlo con `ip link` cuando esté conectada)
4. Tener presente que `tar1090` es un visualizador ADS-B de aviones —
   necesita un receptor SDR (RTL-SDR ~25€) para datos en tiempo real,
   o puede conectarse a feeds públicos de ADS-B Exchange

---

_Fuente: Gemini (23/06/2026) · Validado por Perplexity · MCP GitHub_
