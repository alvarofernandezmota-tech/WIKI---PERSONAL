#!/bin/bash
# ================================================================
# BOOTSTRAP — Primer arranque desde Madre de cero
# RUTA ABSOLUTA: /home/varopc/yggdrasil-dew/bootstrap.sh
# Uso: bash /home/varopc/yggdrasil-dew/bootstrap.sh
#
# Este script es el UNICO que se ejecuta con ruta absoluta manual.
# El resto de scripts se lanzan desde aqui.
# ================================================================
REPO=/home/varopc/yggdrasil-dew

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; RED='\033[0;31m'; NC='\033[0m'

echo -e "\n${CYAN}===================================================${NC}"
echo -e "${CYAN}  YGGDRASIL BOOTSTRAP — Madre${NC}"
echo -e "${CYAN}  $(date '+%Y-%m-%d %H:%M CEST')${NC}"
echo -e "${CYAN}===================================================${NC}\n"

# 1. Verificar que el repo existe
if [ ! -d "$REPO" ]; then
    echo -e "${YELLOW}[1/5] Repo no encontrado. Clonando...${NC}"
    git clone https://github.com/alvarofernandezmota-tech/yggdrasil-dew.git $REPO \
        && echo -e "${GREEN}  ✅ Clonado en $REPO${NC}" \
        || { echo -e "${RED}  ❌ Error al clonar. Verifica SSH key y red.${NC}"; exit 1; }
else
    echo -e "${GREEN}[1/5] Repo encontrado en $REPO${NC}"
fi

# 2. Sincronizar con GitHub
echo -e "\n${YELLOW}[2/5] Sincronizando con GitHub...${NC}"
cd $REPO
git pull origin main && echo -e "${GREEN}  ✅ Repo actualizado${NC}" || echo -e "${RED}  ⚠️  Pull falló (verifica red/token)${NC}"

# 3. Permisos a todos los scripts
echo -e "\n${YELLOW}[3/5] Dando permisos a scripts...${NC}"
find $REPO/scripts -name '*.sh' -exec chmod +x {} \;
chmod +x $REPO/bootstrap.sh 2>/dev/null
SCRIPTS=$(find $REPO/scripts -name '*.sh' | wc -l)
echo -e "${GREEN}  ✅ $SCRIPTS scripts con chmod +x${NC}"

# 4. Instalar alias en ~/.zshrc si no existen
echo -e "\n${YELLOW}[4/5] Configurando alias en ~/.zshrc...${NC}"
if ! grep -q 'REPO=/home/varopc/yggdrasil-dew' ~/.zshrc 2>/dev/null; then
cat >> ~/.zshrc << 'ALIASES'

# === YGGDRASIL ECOSYSTEM ===
export REPO=/home/varopc/yggdrasil-dew
alias repo='cd $REPO && git pull origin main && find $REPO/scripts -name "*.sh" -exec chmod +x {} \;'
alias close='bash $REPO/scripts/maintenance/session-close.sh'
alias morning='bash $REPO/scripts/maintenance/morning-check.sh'
alias audit='bash $REPO/scripts/maintenance/audit-full.sh'
alias gitpull='cd $REPO && git pull origin main'
alias inbox='ls $REPO/inbox/*.md 2>/dev/null | head -20'
# === FIN YGGDRASIL ===
ALIASES
    echo -e "${GREEN}  ✅ Alias instalados en ~/.zshrc${NC}"
    echo -e "${YELLOW}  Recarga con: source ~/.zshrc${NC}"
else
    echo -e "${GREEN}  ✅ Alias ya existen en ~/.zshrc${NC}"
fi

# 5. Verificar Ollama
echo -e "\n${YELLOW}[5/5] Estado de Ollama...${NC}"
if systemctl is-active --quiet ollama 2>/dev/null; then
    echo -e "${GREEN}  ✅ Ollama activo${NC}"
    ollama list 2>/dev/null | head -10 | sed 's/^/    /'
elif curl -s http://localhost:11434/api/tags &>/dev/null; then
    echo -e "${GREEN}  ✅ Ollama responde en :11434${NC}"
else
    echo -e "${YELLOW}  ⚠️  Ollama no activo. Inicia con: ollama serve${NC}"
fi

echo -e "\n${GREEN}===================================================${NC}"
echo -e "${GREEN}  BOOTSTRAP COMPLETO${NC}"
echo -e "${GREEN}===================================================${NC}"
echo -e "\n${CYAN}Proximos comandos disponibles:${NC}"
echo -e "  source ~/.zshrc          ← activar alias ahora mismo"
echo -e "  repo                     ← ir al repo + pull + permisos"
echo -e "  morning                  ← estado completo del sistema"
echo -e "  close                    ← cierre de sesion con commit\n"
