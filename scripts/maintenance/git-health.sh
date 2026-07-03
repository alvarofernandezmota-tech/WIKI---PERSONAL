#!/bin/bash
# ================================================================
# GIT HEALTH — Auditoría profunda del repositorio git
# Detecta problemas, objetos huérfanos, ramas sucias, historial
# Uso: bash ~/yggdrasil-dew/scripts/maintenance/git-health.sh
# ================================================================
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; CYAN='\033[0;36m'; NC='\033[0m'
cd ~/yggdrasil-dew || exit 1
echo -e "\n${CYAN}=== GIT HEALTH CHECK ===${NC}\n"

# 1. Verifica integridad del repo
echo -e "${YELLOW}[1] Integridad${NC}"
git fsck --no-dangling 2>&1 | head -20 && echo -e "${GREEN}✅ Integridad OK${NC}"

# 2. Ramas remotas sin merge
echo -e "\n${YELLOW}[2] Ramas sin merge en remote${NC}"
git branch -r --no-merged main 2>/dev/null | head -10

# 3. Archivos grandes (>1MB)
echo -e "\n${YELLOW}[3] Archivos grandes en historial (>500KB)${NC}"
git rev-list --objects --all 2>/dev/null | \
  git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' 2>/dev/null | \
  awk '/^blob/ && $3>500000 {printf "%s KB\t%s\n", int($3/1024), $4}' | sort -rn | head -10

# 4. Commits sin push
AHEAD=$(git rev-list origin/main..HEAD --count 2>/dev/null || echo 0)
[ "$AHEAD" -gt 0 ] && echo -e "${YELLOW}⚠️  $AHEAD commits sin push${NC}" || echo -e "${GREEN}✅ Sincronizado con remote${NC}"

# 5. Commits del último mes
echo -e "\n${YELLOW}[5] Actividad últimos 30 días${NC}"
git log --since='30 days ago' --oneline | wc -l | xargs echo "Commits:"
git log --since='30 days ago' --format='%an' | sort | uniq -c | sort -rn | head -5

# 6. Archivos con conflictos sin resolver
CONF=$(grep -rl '<<<<<<< ' . --include='*.md' --include='*.py' --include='*.sh' 2>/dev/null | grep -v '.git')
[ -n "$CONF" ] && echo -e "${RED}❌ Conflictos sin resolver: $CONF${NC}" || echo -e "${GREEN}✅ Sin conflictos${NC}"

echo -e "\n${GREEN}Git health check completo.${NC}\n"
