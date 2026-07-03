#!/bin/bash
# ================================================================
# SESSION CLOSE — Cierre de sesion profesional Yggdrasil
# RUTA ABSOLUTA: /home/varopc/yggdrasil-dew/scripts/maintenance/session-close.sh
# Uso desde Madre: bash /home/varopc/yggdrasil-dew/scripts/maintenance/session-close.sh
# ================================================================
REPO=/home/varopc/yggdrasil-dew
cd $REPO || { echo "ERROR: cd $REPO fallo"; exit 1; }

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'

echo -e "\n${CYAN}== CIERRE DE SESION — $(date '+%Y-%m-%d %H:%M CEST') ==${NC}\n"

# Estado git
CHANGES=$(git status --porcelain | wc -l)
echo -e "${YELLOW}[1/4] Cambios pendientes: $CHANGES${NC}"
git status --short | head -15

# Commit automatico
echo -e "\n${YELLOW}[2/4] Commit de cierre${NC}"
if [ "$CHANGES" -gt 0 ]; then
  git add -A
  git commit -m "chore: cierre sesion $(date '+%Y-%m-%d %H:%M CEST') — $CHANGES archivos"
  echo -e "${GREEN}  ✅ Commit creado${NC}"
else
  echo -e "${GREEN}  ✅ Repo limpio${NC}"
fi

# Push
echo -e "\n${YELLOW}[3/4] Push a GitHub${NC}"
git push origin main && echo -e "${GREEN}  ✅ Push OK${NC}" || echo -e "${YELLOW}  ⚠️  Push fallo${NC}"

# Resumen
echo -e "\n${YELLOW}[4/4] Commits hoy${NC}"
git log --since='today' --oneline | head -10 | sed 's/^/  /'

echo -e "\n${GREEN}== ✅ SESION CERRADA. MADRE TRABAJA. DUERME BIEN 🌙 ==${NC}\n"
