#!/bin/bash

# Reset y políticas base
ufw --force reset
ufw default deny incoming
ufw default allow outgoing

# Permitir SSH (gestionado fuera de la lista de puertos por seguridad)
ufw allow 22/tcp

# Lista de puertos a abrir
PORTS="3001 5678 8443 3003 9000 3002 3000 9090 11434 6333 8000 5001 6901 6334"
RANGES=("192.168.1.0/24" "100.64.0.0/10")

# Aplicar reglas
for range in "${RANGES[@]}"; do
    for port in $PORTS; do
        ufw allow from $range to any port $port proto tcp
    done
done

# Activar firewall
ufw --force enable
ufw status verbose
