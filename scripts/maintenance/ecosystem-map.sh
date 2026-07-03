
#!/bin/bash
# ================================================================
# ECOSYSTEM MAP — Árbol completo del repo con estado
# Muestra estructura, tamaños, últimas modificaciones
# Uso: bash ~/yggdrasil-dew/scripts/maintenance/ecosystem-map.sh
# ================================================================

CYAN='\033[0;36m'; YELLOW='\033[1;33m'; GREEN='\033[0;32m'; NC='\033[0m'
REPO=~/yggdrasil-dew
cd $REPO || exit 1

echo ""
echo -e "${CYAN}================================================================${NC}"
echo -e "${CYAN}  ECOSYSTEM MAP — $(date '+%Y-%m-%d %H:%M')${NC}"
echo -e "${CYAN}================================================================${NC}"
echo ""

# 1. Árbol de directorios principales
echo -e "${YELLOW}─── ESTRUCTURA PRINCIPAL ───${NC}"
ls -d */ 2>/dev/null | sort | while read DIR; do
  COUNT=$(find "$DIR" -name '*.md' 2>/dev/null | wc -l)
  SCRIPTS=$(find "$DIR" -name '*.sh' 2>/dev/null | wc -l)
  echo -e "  📁 ${CYAN}$DIR${NC} — ${COUNT} .md, ${SCRIPTS} .sh"
done

# 2. Documentos raíz importantes
echo ""
echo -e "${YELLOW}─── DOCS RAÍZ ───${NC}"
for F in README.md ECOSISTEMA.md ESTADO-SISTEMA.md ROADMAP.md MASTER-PENDIENTES.md CONTEXT.md AGENT.md CHANGELOG.md; do
  if [ -s "$F" ]; then
    MOD=$(git log -1 --format='%ar' -- "$F" 2>/dev/null)
    echo -e "  ✅ $F — ${MOD}"
  else
    echo -e "  ⚠️  $F — no existe o vacío"
  fi
done

# 3. Scripts disponibles
echo ""
echo -e "${YELLOW}─── SCRIPTS DISPONIBLES ───${NC}"
find scripts/ -name '*.sh' 2>/dev/null | sort | while read S; do
  [ -x "$S" ] && EXEC="✅" || EXEC="⚠️ no ejecutable"
  echo -e "  $EXEC $S"
done

# 4. Thdora status
echo ""
echo -e "${YELLOW}─── THDORA STATUS ───${NC}"
if [ -d "thdora" ]; then
  echo -e "  🤖 thdora/ existe"
  find thdora/ -type f 2>/dev/null | sort | while read F; do
    echo -e "    • $F"
  done
else
  echo -e "  ⚠️  thdora/ no existe todavía"
fi

# 5. Inbox snapshot
echo ""
echo -e "${YELLOW}─── INBOX SNAPSHOT ───${NC}"
PENDING=$(find inbox/ -maxdepth 1 -name '*.md' ! -name 'README*' 2>/dev/null | wc -l)
PROCESED=$(find inbox/procesado/ -name '*.md' 2>/dev/null | wc -l)
echo -e "  Pendientes: ${PENDING} | Procesados: ${PROCESSED}"

# 6. Git resumen
echo ""
echo -e "${YELLOW}─── GIT RESUMEN ───${NC}"
git log --oneline -5
echo ""
echo -e "${GREEN}Ecosystem map completo. ✅${NC}"
echo ""
