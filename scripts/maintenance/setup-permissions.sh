#!/bin/bash
# ============================================================
# SETUP PERMISSIONS — da permisos de ejecución a todos los scripts
# Uso: bash ~/yggdrasil-dew/scripts/maintenance/setup-permissions.sh
# ============================================================

GREEN='\033[0;32m'; NC='\033[0m'
cd ~/yggdrasil-dew || exit 1
find scripts/ -name '*.sh' -exec chmod +x {} \; -print | while read f; do
  echo -e "${GREEN}✅ chmod +x $f${NC}"
done
echo ""
echo -e "${GREEN}Todos los scripts listos para ejecutar.${NC}"
echo ""
