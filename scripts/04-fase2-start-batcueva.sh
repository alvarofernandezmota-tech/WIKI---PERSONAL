#!/bin/bash
# ==============================================================================
# SCRIPT: 04-fase2-start-batcueva.sh
# OBJETIVO: Inicializar redes, volúmenes y levantar el stack de 13 contenedores.
# ==============================================================================

set -e

echo "[+] Iniciando Fase 2: Despliegue de la Batcueva Docker en Madre..."

# 1. Crear redes Docker para aislamiento de servicios
echo "[+] Configurando redes virtuales..."
docker network create batcueva-net 2>/dev/null || echo "[*] Red batcueva-net ya existe."
docker network create ai-net 2>/dev/null || echo "[*] Red ai-net ya existe."
docker network create monitor-net 2>/dev/null || echo "[*] Red monitor-net ya existe."

# 2. Asegurar directorios de persistencia
echo "[+] Verificando directorios de datos locales..."
mkdir -p ./data/{ollama,qdrant,gitea,open-webui,uptime-kuma,grafana,prometheus,n8n,code-server}

# 3. Validar sintaxis del archivo de composición
if [ -f "docker-compose.yml" ]; then
    echo "[+] Validando configuración de docker-compose.yml..."
    docker compose config > /dev/null
else
    echo "[!] Error: No se encuentra docker-compose.yml en el directorio actual."
    exit 1
fi

# 4. Levantar el stack en segundo plano
echo "[+] Levantando los 13 contenedores principales..."
docker compose up -d

# 5. Verificación rápida del estado
echo "[+] Esperando inicialización de servicios críticos..."
sleep 5
docker compose ps

echo "[+] Fase 2 ejecutada correctamente. Contenedores en proceso de estabilización."
echo "    Portainer:   http://100.91.112.32:9000"
echo "    Open WebUI:  http://100.91.112.32:3001"
echo "    Uptime Kuma: http://100.91.112.32:3002"
echo "    Grafana:     http://100.91.112.32:3000"
