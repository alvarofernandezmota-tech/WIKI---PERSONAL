#!/bin/bash
# ============================================================
# SYNC REPO — pull + status + push pendientes
# Uso: bash ~/yggdrasil-dew/scripts/maintenance/sync-repo.sh
# ============================================================

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'
cd ~/yggdrasil-dew || exit 1

echo ""
echo -e "${YELLOW}[SYNC] $(date '+%H:%M:%S')${NC}"

git fetch origin
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/main)

if [ "$LOCAL" = "$REMOTE" ]; then
  echo -e "${GREEN}✅ Ya sincronizado — nada que hacer${NC}"
else
  git pull --rebase && echo -e "${GREEN}✅ Pull OK${NC}" || echo -e "${RED}❌ Conflicto en pull${NC}"
fi

# Push cambios locales pendientes
AHEAD=$(git rev-list origin/main..HEAD --count)
if [ "$AHEAD" -gt 0 ]; then
  echo -e "${YELLOW}⚠️  $AHEAD commit(s) pendientes de push — ejecutando push...${NC}"
  git push && echo -e "${GREEN}✅ Push OK${NC}"
fi

git log --oneline -3
echo ""
