#!/bin/bash
# ================================================================
# OBSIDIAN VAULT CHECK
# Verifica que el vault Obsidian está alineado con el repo
# Comprueba rutas, archivos rotos, links huerfanos
# Uso: bash ~/yggdrasil-dew/scripts/maintenance/obsidian-vault-check.sh
# ================================================================

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; CYAN='\033[0;36m'; NC='\033[0m'
REPO=~/yggdrasil-dew
cd $REPO || exit 1

echo ""
echo -e "${CYAN}=====================================${NC}"
echo -e "${CYAN}  OBSIDIAN VAULT CHECK${NC}"
echo -e "${CYAN}=====================================${NC}"
echo ""

# 1. Verificar .obsidian existe
if [ -d ".obsidian" ]; then
  echo -e "${GREEN}✅ .obsidian/ existe${NC}"
else
  echo -e "${RED}❌ .obsidian/ no encontrado — no es un vault Obsidian válido${NC}"
fi

# 2. Contar archivos .md en el repo
TOTAL=$(find . -name '*.md' ! -path './.git/*' | wc -l)
echo -e "${GREEN}ℹ️  Total archivos .md: $TOTAL${NC}"

# 3. Listar archivos .md recientes (modificados hoy)
HOY=$(date '+%Y-%m-%d')
echo ""
echo -e "${YELLOW}Archivos .md modificados hoy ($HOY):${NC}"
find . -name '*.md' ! -path './.git/*' -newer .git/index 2>/dev/null | head -20

# 4. Detectar links rotos en markdown ([[wikilink]])
echo ""
echo -e "${YELLOW}Detectando wikilinks internos...${NC}"
BROKEN=0
find . -name '*.md' ! -path './.git/*' | while read FILE; do
  grep -oP '\[\[\K[^\]]+(?=\]\])' "$FILE" 2>/dev/null | while read LINK; do
    CLEAN=$(echo "$LINK" | sed 's/|.*//' | sed 's/ /-/g')
    TARGET=$(find . -name "${CLEAN}.md" ! -path './.git/*' 2>/dev/null | head -1)
    if [ -z "$TARGET" ]; then
      echo -e "  ${RED}❌ Link roto: [[$LINK]] en $FILE${NC}"
      BROKEN=$((BROKEN+1))
    fi
  done
done
[ "$BROKEN" -eq 0 ] && echo -e "${GREEN}✅ Sin wikilinks rotos detectados${NC}"

# 5. Verificar archivos clave existen y no están vacíos
echo ""
echo -e "${YELLOW}Archivos clave del ecosistema:${NC}"
CLAVES=(
  "README.md"
  "ECOSISTEMA.md"
  "ESTADO-SISTEMA.md"
  "ROADMAP.md"
  "MASTER-PENDIENTES.md"
  "docs/diarios/2026-07-03.md"
  "inbox/README.md"
)
for F in "${CLAVES[@]}"; do
  if [ -s "$F" ]; then
    LINES=$(wc -l < "$F")
    echo -e "  ${GREEN}✅ $F ($LINES líneas)${NC}"
  elif [ -f "$F" ]; then
    echo -e "  ${RED}❌ $F está VACÍO${NC}"
  else
    echo -e "  ${YELLOW}⚠️  $F no existe aún${NC}"
  fi
done

echo ""
echo -e "${GREEN}Vault check completo.${NC}"
echo ""
