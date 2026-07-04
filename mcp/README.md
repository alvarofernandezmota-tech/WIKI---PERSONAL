# MCP Server — Yggdrasil-Dew

Servidor MCP ligero que expone las tools del ecosistema por **stdio** y opcionalmente por **HTTP**.

## Instalación

```bash
pip3 install -r mcp/requirements.txt

# Compilar cliente C (opcional)
gcc -Wall -O2 -o mcp_client mcp/mcp_client.c
```

## Arranque

```bash
export YGGDRASIL_ROOT="$(pwd)"
export MCP_TOKEN="tu-token-secreto"   # opcional

# Solo stdio
python3 mcp/server.py

# Stdio + HTTP en puerto 8080
python3 mcp/server.py --port 8080
```

## Tools disponibles

| Tool | Descripción | Args |
|---|---|---|
| `orquestador_total` | Ejecuta orquestador-total.sh | `phase`: all\|audit\|inbox\|health |
| `llm_router` | Enruta prompt al mejor LLM disponible | `prompt`, `mode`: auto\|ollama\|openai\|anthropic |
| `agent_test` | Corre test.sh de un agente | `agent`: nombre del agente |
| `inbox_commit` | Commitea inbox/drop | `description`: texto del commit |

## Ejemplos de llamadas JSON

```bash
# Listar tools
echo '{"type":"list_tools"}' | python3 mcp/server.py

# Llamar orquestador
echo '{"type":"call_tool","tool":"orquestador_total","arguments":{"phase":"audit"}}' | python3 mcp/server.py

# Llamar llm_router
echo '{"type":"call_tool","tool":"llm_router","arguments":{"prompt":"estado del sistema","mode":"auto"}}' | python3 mcp/server.py

# Via HTTP (si arrancado con --port)
curl -s -X POST http://localhost:8080 \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer tu-token' \
  -d '{"type":"call_tool","tool":"agent_test","arguments":{"agent":"agent-docs"}}'

# Health check
curl http://localhost:8080/health
```

## Cliente C

```bash
# Listar tools
echo '{"type":"list_tools"}' | ./mcp_client list_tools '{}'

# Llamar tool directamente
./mcp_client orquestador_total '{"phase":"audit"}'
```

## Seguridad

- Setear `MCP_TOKEN` para requerir `Authorization: Bearer <token>` en HTTP.
- Sin token, el servidor HTTP es abierto — úsalo solo en red local.
- Stdio no requiere autenticación (aislado por proceso).
- El router LLM sanitiza emails, API keys y números largos antes de loggear.
