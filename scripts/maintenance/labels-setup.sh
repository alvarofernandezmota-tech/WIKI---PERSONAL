#!/bin/bash
# ================================================================
# LABELS SETUP — Crea labels personalizados en GitHub (issue #22)
# Requiere: gh CLI autenticado
# Uso: bash ~/yggdrasil-dew/scripts/maintenance/labels-setup.sh
# ================================================================
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
REPO="alvarofernandezmota-tech/yggdrasil-dew"

command -v gh &>/dev/null || { echo "Instala gh CLI: https://cli.github.com"; exit 1; }

echo -e "\n${YELLOW}Creando labels en $REPO...${NC}\n"

declare -A LABELS=(
  ["infra"]="0075ca:Infraestructura y sistema"
  ["ai"]="6f42c1:Inteligencia artificial y modelos"
  ["seguridad"]="d93f0b:Seguridad y hardening"
  ["docs"]="0e8a16:Documentación"
  ["osint"]="e4e669:OSINT y reconocimiento"
  ["thdora"]="1d76db:Agente Thdora"
  ["automatizacion"]="f9d0c4:Automatización y scripts"
  ["p1"]="b60205:Prioridad alta P1"
  ["p2"]="ff9800:Prioridad media P2"
  ["p3"]="eeeeee:Prioridad baja P3"
  ["bloqueado"]="e11d48:Bloqueado por dependencia"
  ["investigacion"]="84b6eb:Investigación y decisión"
)

for NAME in "${!LABELS[@]}"; do
  IFS=':' read -r COLOR DESC <<< "${LABELS[$NAME]}"
  gh label create "$NAME" --color "$COLOR" --description "$DESC" --repo "$REPO" --force \
    && echo -e "${GREEN}✅ $NAME${NC}" \
    || echo -e "${YELLOW}⚠️  $NAME (ya existe o error)${NC}"
done

echo -e "\n${GREEN}Labels creados. Cerrando issue #22...${NC}"
gh issue close 22 --repo "$REPO" --comment "Labels creados automáticamente con labels-setup.sh" 2>/dev/null
echo ""
