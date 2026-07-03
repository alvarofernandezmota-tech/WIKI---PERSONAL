#!/bin/bash
# ================================================================
# BACKUP REPO — Backup completo del ecosistema a disco local
# Crea tar.gz con fecha en ~/backups/
# Uso: bash ~/yggdrasil-dew/scripts/maintenance/backup-repo.sh
# ================================================================
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
BACKUP_DIR=~/backups
FECHA=$(date '+%Y-%m-%d_%H%M')
FILE="$BACKUP_DIR/yggdrasil-dew_$FECHA.tar.gz"

mkdir -p $BACKUP_DIR

echo -e "\n${YELLOW}Creando backup — $FILE${NC}"
tar --exclude='~/yggdrasil-dew/.git' \
    --exclude='~/yggdrasil-dew/.obsidian/cache' \
    -czf "$FILE" ~/yggdrasil-dew 2>/dev/null

SIZE=$(du -sh "$FILE" | cut -f1)
echo -e "${GREEN}✅ Backup OK — $SIZE → $FILE${NC}"

# Borrar backups con más de 7 días
find $BACKUP_DIR -name '*.tar.gz' -mtime +7 -delete
echo -e "${GREEN}✅ Backups antiguos limpiados (>7días)${NC}"
ls -lh $BACKUP_DIR
echo ""
