# MCP Server — yggdrasil-dew

Expone **todos los agentes y herramientas** del ecosistema como tools MCP.

## Instalación

```bash
cd mcp
pip install -r requirements.txt
```

## Uso

```bash
# Modo HTTP (para clientes remotos o Claude Desktop)
python3 mcp/server.py --port 8080

# Modo stdio (para integración directa con agentes)
python3 mcp/server.py --stdio
```

## Variables de entorno

| Variable | Descripción | Requerida |
|---|---|---|
| `YGGDRASIL_ROOT` | Ruta raíz del repo | No (autodetectada) |
| `OPENAI_API_KEY` | API key de OpenAI | Solo si se usa OpenAI |
| `ANTHROPIC_API_KEY` | API key de Anthropic | Solo si se usa Anthropic |

## Tools disponibles

| Tool | Función |
|---|---|
| `orquestador_total` | Orquesta todo el ecosistema |
| `galatea_fabrica_agente` | Genera agentes con plantilla estándar |
| `agente_meta_deep` | Auditoría profunda con LLM |
| `llm_router` | Enruta a Ollama/OpenAI/Anthropic |
| `struct_auditor` | Detecta duplicados y fantasmas |
| `ghost_file_detector` | Archivos huérfanos |
| `isla_sync_validator` | Valida mapas de islas |
| `watchdog` | Monitor de SLAs |
| `diary_writer` | Escribe diario automático |
| `issue_creator` | Crea issues GitHub |
| `health_check` | Pulso del ecosistema |

## Integración con Claude Desktop

```json
{
  "mcpServers": {
    "yggdrasil": {
      "url": "http://localhost:8080/sse"
    }
  }
}
```
