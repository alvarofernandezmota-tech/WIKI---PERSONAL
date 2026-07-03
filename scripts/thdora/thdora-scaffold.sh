#!/bin/bash
# ================================================================
# THDORA SCAFFOLD — Crea estructura base del agente Thdora
# Ejecutar una vez para preparar el entorno Python
# Uso: bash ~/yggdrasil-dew/scripts/thdora/thdora-scaffold.sh
# ================================================================
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
REPO=~/yggdrasil-dew

echo -e "\n${CYAN}=== THDORA SCAFFOLD ===${NC}\n"

# 1. Python venv
cd $REPO
if [ ! -d "thdora/.venv" ]; then
  python3 -m venv thdora/.venv && echo -e "${GREEN}✅ venv creado${NC}"
else
  echo -e "${GREEN}✅ venv ya existe${NC}"
fi

# 2. Instalar dependencias base
source thdora/.venv/bin/activate
pip install -q llama-index llama-index-llms-ollama gitpython watchdog python-dotenv
echo -e "${GREEN}✅ Dependencias instaladas${NC}"

# 3. Crear archivos base si no existen
cat > thdora/thdora.py << 'PYEOF'
"""
Thdora — Agente IA central del ecosistema Yggdrasil
Estado: SCAFFOLD (pendiente issue #1)
"""
import os
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent
INBOX_PATH = REPO_ROOT / "inbox"

def main():
    print("Thdora iniciando...")
    print(f"Repo: {REPO_ROOT}")
    print(f"Inbox: {INBOX_PATH}")
    files = list(INBOX_PATH.glob("*.md"))
    print(f"Archivos en inbox: {len(files)}")
    for f in files:
        print(f" - {f.name}")

if __name__ == "__main__":
    main()
PYEOF

cat > thdora/inbox_processor.py << 'PYEOF'
"""
Inbox Processor — Lee inbox/ y procesa archivos con Ollama
Estado: SCAFFOLD
"""
from pathlib import Path

def process_inbox(inbox_path: Path):
    files = list(inbox_path.glob("*.md"))
    print(f"{len(files)} archivos en inbox")
    # TODO: conectar con Ollama para clasificar y resumir
    return files
PYEOF

echo -e "${GREEN}✅ thdora/thdora.py creado${NC}"
echo -e "${GREEN}✅ thdora/inbox_processor.py creado${NC}"

deactivate
echo -e "\n${YELLOW}Thdora scaffold completo. Próximo paso: issue #1${NC}\n"
