#!/bin/bash
# ==============================================================================
# health-check.sh — Diagnóstico rápido ecosistema Yggdrasil-DEW
# Nodo: cualquiera (Madre o Acer)
# Uso: bash scripts/maintenance/health-check.sh
# ==============================================================================

# Colores
TITULO='\033[1;35m'
SECCION='\033[0;36m'
VERDE='\033[0;32m'
AMARILLO='\033[0;33m'
ROJO='\033[0;31m'
NC='\033[0m'

echo -e "${TITULO}=== ECOSYSTEM HEALTH CHECK (Yggdrasil-DEW) ===${NC}"
echo -e "Fecha: $(date '+%Y-%m-%d %H:%M CEST')"
echo -e "Host: $(hostname) | Usuario: $(whoami)"
echo -e "Kernel: $(uname -r)"
echo "--------------------------------------------------------"

# 1. Tailscale
echo -e "\n${SECCION}[TAILSCALE] Estado de nodos${NC}"
if command -v tailscale &>/dev/null; then
    tailscale status 2>/dev/null | grep -E 'varpc|varo12f|100\.' || echo "Sin nodos detectados"
else
    echo -e "${ROJO}tailscale no instalado${NC}"
fi

# 2. Btrfs
echo -e "\n${SECCION}[BTRFS] Filesystem /${NC}"
if command -v btrfs &>/dev/null; then
    sudo btrfs filesystem usage / 2>/dev/null | head -10 || df -h /
else
    df -h /
fi

# 3. Docker NoCoW
echo -e "\n${SECCION}[BTRFS] Atributo NoCoW en /var/lib/docker${NC}"
if [ -d /var/lib/docker ]; then
    ATTR=$(lsattr -d /var/lib/docker 2>/dev/null | awk '{print $1}')
    if echo "$ATTR" | grep -q 'C'; then
        echo -e "${VERDE}NoCoW ACTIVO (+C): $ATTR${NC}"
    else
        echo -e "${AMARILLO}NoCoW NO aplicado: $ATTR${NC}"
        echo -e "  Ejecutar: sudo chattr +C /var/lib/docker"
    fi
else
    echo "Docker no inicializado aún"
fi

# 4. Docker containers
echo -e "\n${SECCION}[DOCKER] Contenedores activos${NC}"
if command -v docker &>/dev/null; then
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" 2>/dev/null || echo "Docker no accesible"
else
    echo "Docker no instalado"
fi

# 5. Ollama
echo -e "\n${SECCION}[OLLAMA] Estado y modelos${NC}"
if command -v ollama &>/dev/null; then
    systemctl is-active ollama 2>/dev/null
    ollama list 2>/dev/null || echo "Ollama no responde"
else
    echo "Ollama no instalado — Issue #20 pendiente"
fi

# 6. GPU NVIDIA
echo -e "\n${SECCION}[GPU] NVIDIA GTX 1060${NC}"
if command -v nvidia-smi &>/dev/null; then
    nvidia-smi --query-gpu=name,temperature.gpu,memory.used,memory.total,utilization.gpu \
        --format=csv,noheader,nounits 2>/dev/null | \
        awk -F',' '{printf "Modelo: %s | Temp: %s°C | VRAM: %s/%s MB | GPU: %s%%\n", $1,$2,$3,$4,$5}'
else
    echo "nvidia-smi no disponible"
fi

# 7. Puertos expuestos (seguridad)
echo -e "\n${SECCION}[SEGURIDAD] Puertos escuchando en 0.0.0.0 (riesgo)${NC}"
ss -tlnp 2>/dev/null | grep '0.0.0.0' | grep -v '127.0.0.1' | \
    awk '{print $4, $6}' | grep -v '^$' || echo -e "${VERDE}Ningún puerto expuesto en 0.0.0.0${NC}"

# 8. UFW
echo -e "\n${SECCION}[UFW] Estado del firewall${NC}"
if command -v ufw &>/dev/null; then
    sudo ufw status 2>/dev/null | head -20
else
    echo "UFW no instalado"
fi

# 9. Disco SMART (HDD salud)
echo -e "\n${SECCION}[HDD] Salud SMART${NC}"
if command -v smartctl &>/dev/null; then
    sudo smartctl -H /dev/sda 2>/dev/null | grep 'SMART overall' || echo "Verificar manualmente: sudo smartctl -H /dev/sda"
else
    echo "smartmontools no instalado"
fi

# 10. Resumen pendientes críticos
echo -e "\n${SECCION}[PENDIENTES] Issues críticos del ecosistema${NC}"
echo -e "  ${ROJO}#14 P0${NC} — Puerto 21 FTP: cerrar en router 192.168.1.1"
echo -e "  ${AMARILLO}#13 P1${NC} — SSH hardening: PasswordAuthentication no"
echo -e "  ${AMARILLO}#15 P1${NC} — Cursor + MCP en Acer"
echo -e "  ${AMARILLO}#20 P2${NC} — Ollama en Madre (GTX 1060 lista)"

echo -e "\n${TITULO}==========================================${NC}"
echo -e "${VERDE}Health check completado: $(date '+%H:%M CEST')${NC}"
