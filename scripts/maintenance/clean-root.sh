#!/bin/bash
# ============================================================
# CLEAN ROOT — elimina archivos vacíos y basura en raíz repo
# Uso: bash ~/yggdrasil-dew/scripts/maintenance/clean-root.sh
# ============================================================

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
cd ~/yggdrasil-dew || exit 1

echo ""
echo -e "${YELLOW}[CLEAN ROOT]${NC}"

# Eliminar archivos vacíos en raíz (no ocultos, no README, no .md importantes)
for f in $(find . -maxdepth 1 -type f -empty ! -name '.*'); do
  git rm "$f" && echo -e "${GREEN}✅ Eliminado: $f${NC}"
done

git add -A
if ! git diff --cached --quiet; then
  git commit -m "chore: clean root — eliminar archivos vacíos $(date '+%Y-%m-%d')"
  git push && echo -e "${GREEN}✅ Push OK${NC}"
else
  echo -e "${YELLOW}ℹ️  Raíz ya limpia${NC}"
fi
echo ""
