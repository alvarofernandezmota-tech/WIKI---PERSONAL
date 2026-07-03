#!/bin/bash
# Fase 9 — OSINT + Pentest stack

set -euo pipefail

REPO_DIR="$HOME/yggdrasil-dew"
DOCKER_DIR="$REPO_DIR/docker"
OSINT_STACK_DIR="$REPO_DIR/osint-stack"

echo "🔄 [10] Fase 9 — OSINT + Pentest stack"

# Este script asume que ya existe configuración docker-compose
# para Kali Desktop, SpiderFoot, SearXNG, PiHole, Wazuh, Suricata, DefectDojo, etc.

if [ ! -d "$DOCKER_DIR" ]; then
  echo "❌ No existe directorio docker en $DOCKER_DIR"
  exit 1
fi

if [ ! -d "$OSINT_STACK_DIR" ]; then
  echo "⚠️ No existe directorio osint-stack en $OSINT_STACK_DIR (asegúrate de clonarlo)."
fi

# Prerequisito Wazuh (vm.max_map_count)
echo "→ Aplicando prerequisito vm.max_map_count para Wazuh (si procede)…"
if command -v sysctl >/dev/null 2>&1; then
  sudo sysctl -w vm.max_map_count=262144 || echo "⚠️ No se pudo aplicar vm.max_map_count, revisa permisos."
else
  echo "⚠️ sysctl no disponible, no se aplica vm.max_map_count."
fi

# Ejemplo de levantamiento de stack OSINT/Pentest
# Ajusta nombres de ficheros docker-compose según tu layout real.

echo "→ Levantando Kali Desktop y SpiderFoot (ejemplo)…"
if [ -f "$OSINT_STACK_DIR/docker-compose.kali.yml" ]; then
  cd "$OSINT_STACK_DIR"
  docker compose -f docker-compose.kali.yml up -d || echo "⚠️ No se pudo levantar docker-compose.kali.yml"
  cd "$REPO_DIR"
else
  echo "⚠️ Falta $OSINT_STACK_DIR/docker-compose.kali.yml"
fi

# Aquí podrías añadir bloques similares para otras herramientas:
# - SearXNG
# - PiHole
# - Wazuh
# - Suricata
# - DefectDojo

echo "⚠️ Completa este script con los docker-compose reales de tu stack OSINT/Pentest."

echo "✅ Fase 9 — OSINT/Pentest stack preparado: $(date '+%d-%m-%Y %H:%M CEST')"
echo "📝 Documenta primer uso (Kali, SpiderFoot, Nmap, etc.) en diarios/ y MASTER-PENDIENTES.md."
