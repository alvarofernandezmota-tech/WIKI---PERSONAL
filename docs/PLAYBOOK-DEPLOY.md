# PLAYBOOK DE DESPLIEGUE — Yggdrasil-Dew

## Requisitos previos

```bash
# Dependencias del sistema
sudo apt-get install -y git curl jq gcc

# Ollama (LLM local)
curl -fsSL https://ollama.com/install.sh | sh
ollama pull llama3

# Python (adaptadores LLM)
pip3 install requests

# Compilar cliente MCP C
gcc -Wall -O2 -o mcp_client mcp/mcp_client.c
```

## Variables de entorno

Copiar `.env.template` a `.env` y rellenar:

```bash
cp .env.template .env
# Editar:
# YGGDRASIL_ROOT=/ruta/al/repo
# GITHUB_TOKEN=ghp_...
# OPENAI_API_KEY=sk-...       (opcional)
# ANTHROPIC_API_KEY=sk-ant-... (opcional)
```

## Arranque del sistema

```bash
# 1. Sincronizar repo
git pull origin main

# 2. Arrancar Ollama
ollama serve &
sleep 3

# 3. Arrancar MCP server (cuando esté disponible mcp/server.py)
export YGGDRASIL_ROOT="$(pwd)"
# python3 mcp/server.py --port 8080 &

# 4. Test del router LLM
bash scripts/agentes/llm-router.sh "estado del sistema" auto
```

## Ejecución de tests de agentes

```bash
chmod +x agentes/*/test.sh
bash agentes/agent-docs/test.sh
bash agentes/agent-islas/test.sh
bash agentes/agent-tareas/test.sh

# Ver reportes generados
ls reports/*/
```

## Galatea — crear PR de agente nuevo

```bash
# Requiere GITHUB_TOKEN en el entorno
export GITHUB_TOKEN=ghp_...
bash scripts/agentes/galatea-create-pr-sample.sh
```

## Flujo de un agente nuevo

1. Copiar `agentes/PLANTILLA-AGENTE.md` → `agentes/agent-<nombre>/DISEÑO.md`
2. Crear `scripts/agentes/agent-<nombre>.sh`
3. Añadir `agentes/agent-<nombre>/test.sh`
4. Añadir entrada en `.github/workflows/ci-agentes.yml`
5. PR → revisar test CI → merge

## Router LLM — modos disponibles

| Modo | Descripción |
|---|---|
| `auto` | Prueba ollama → openai → anthropic en orden |
| `ollama` | Solo Ollama local |
| `openai` | Solo OpenAI API |
| `anthropic` | Solo Anthropic API |

```bash
bash scripts/agentes/llm-router.sh "tu prompt aquí" ollama
bash scripts/agentes/llm-router.sh "tu prompt aquí" openai
```

## Logs

Todos los logs del router en `logs/llm-router/llm-router-YYYYMMDDTHHMMSS.log`.
Todos los reportes de agentes en `reports/<agent>/test-YYYYMMDDTHHMMSS.md`.
