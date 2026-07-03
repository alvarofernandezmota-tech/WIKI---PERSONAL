#!/bin/bash
# ================================================================
# CRON SETUP — Configura automatización en Madre
# Instala cron jobs para sync, audit, morning-check
# Uso: bash ~/yggdrasil-dew/scripts/maintenance/cron-setup.sh
# ================================================================
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
REPO=~/yggdrasil-dew
SCR=$REPO/scripts/maintenance
LOG=~/yggdrasil-dew/logs

mkdir -p $LOG

echo -e "\n${CYAN}=== CRON SETUP ===${NC}"
echo -e "${YELLOW}Instalando cron jobs en Madre...${NC}\n"

# Dar permisos a todos los scripts
find $REPO/scripts -name '*.sh' -exec chmod +x {} \;

# Definir cron jobs
CRONJOBS="
# Yggdrasil Ecosystem — Automatización
# Sync repo cada 2 horas
0 */2 * * * bash $SCR/sync-repo.sh >> $LOG/sync.log 2>&1
# Audit completo cada domingo a las 10:00
0 10 * * 0 bash $SCR/audit-full.sh >> $LOG/audit.log 2>&1
# Morning check cada día a las 08:00
0 8 * * * bash $SCR/morning-check.sh >> $LOG/morning.log 2>&1
# Obsidian vault check cada lunes a las 09:00
0 9 * * 1 bash $SCR/obsidian-vault-check.sh >> $LOG/obsidian.log 2>&1
"

# Añadir a crontab sin duplicar
(crontab -l 2>/dev/null | grep -v 'Yggdrasil'; echo "$CRONJOBS") | crontab -

echo -e "${GREEN}✅ Cron jobs instalados:${NC}"
crontab -l | grep -A1 'Yggdrasil'
echo -e "\n${YELLOW}Logs en: $LOG/${NC}\n"
