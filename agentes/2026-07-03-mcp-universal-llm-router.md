---
fecha: 2026-07-03
tipo: sesion
tags: [mcp, llm-router, arquitectura, ia-local, c, ollama, openai, anthropic, groq, lmstudio]
estado: pendiente-clasificar
---

# Sesión: MCP Universal + LLM Router

## Resumen ejecutivo

Se ha definido y construido el MCP server universal para yggdrasil-dew:
- Expone el ecosistema completo como toolbox MCP (15 tools)
- Añade `llm_router` para llamar cualquier modelo (local o remoto) desde cualquier IA
- Define el protocolo para que la IA local en C hable MCP por stdin/stdout
- `core_estado` cierra el círculo CORE ↔ realidad del repo

## Arquitectura decidida

```
Repo Yggdrasil (scripts, agentes, CORE)
        ↓
   MCP Server (server.js)
        ↓
  ┌─────┴──────┐
  │            │
Tools       llm_router
(scripts)   (Ollama/OpenAI/Anthropic/Groq/LMStudio)
  ↑            ↑
  └─────┬──────┘
        │
  Cualquier IA cliente
  (Claude, Copilot, IA en C, Perplexity...)
```

## Tools MCP disponibles

| Tool | Función |
|------|--------|
| `orquestador_supremo` | Ciclo completo del ecosistema |
| `watchdog_monitor` | Salud del sistema |
| `clasificador_maestro` | Procesa inbox/ |
| `struct_auditor` | Detecta duplicados y carpetas fantasma |
| `ghost_file_detector` | Archivos vacíos y links rotos |
| `isla_sync_validator` | MAPA-ISLAS.md vs realidad |
| `tool_inventory_auditor` | Cada script tiene FUNCIÓN declarada |
| `agent_docs` | Sincroniza documentación |
| `agent_islas` | Orquesta islas |
| `agent_tareas` | Gestiona MASTER-PENDIENTES.md |
| `agent_investigacion` | Consolida osint/ y osint-stack/ |
| `agent_ecosistema` | Auditoría global |
| `core_estado` | Compara CORE vs realidad |
| `leer_doc` | Lee cualquier .md del repo |
| `estado_completo` | Snapshot rápido de todo |
| `llm_router` | Llama cualquier LLM (Ollama/OpenAI/Anthropic/Groq/LMStudio) |

## LLM Router — providers soportados

| Prefijo | Provider | Ejemplo |
|---------|----------|--------|
| `ollama:` | Ollama local | `ollama:llama3` |
| `openai:` | OpenAI API | `openai:gpt-4.1` |
| `anthropic:` | Anthropic API | `anthropic:claude-opus-4-5` |
| `groq:` | Groq API | `groq:llama3-70b-8192` |
| `lmstudio:` | LM Studio local | `lmstudio:mistral-7b` |

## Protocolo MCP para IA en C

Ver: `mcp/client-c-example.md`

## Ficheros commiteados

- `server.js` — MCP server actualizado con llm_router completo
- `mcp/llm-router.js` — módulo router aislado
- `mcp/client-c-example.md` — guía protocolo para C
- `mcp-config.json` — config universal
- `.github/copilot-mcp.json` — config Copilot
- `scripts/struct-auditor.sh`
- `scripts/ghost-file-detector.sh`
- `scripts/isla-sync-validator.sh`
- `scripts/tool-inventory-auditor.sh`

## Próximos pasos

- [ ] Implementar cliente MCP en C (ver mcp/client-c-example.md)
- [ ] Añadir soporte provider `local:` para modelo propio compilado
- [ ] Conectar llm_router a GitHub Actions para workflows con IA
- [ ] Activar MCP server en Madre: `cd /srv/yggdrasil-dew && npm install && npm start`
