# 🔌 MCP Server — Madre

> **Estado:** 🔵 DISEÑO — implementación pendiente  
> **Prioridad:** 🔴 Máxima — es la pieza que conecta todas las IAs con el ecosistema  
> **Ubicación en Madre:** `/srv/mcp-server/`  
> **Puerto:** `3001` (no colisiona con thdora-personal en 8000)

---

## ¿Por qué es la pieza más estratégica?

Ahora mismo las IAs (Cursor, Claude, Open WebUI) **no ven Madre**.
Con el MCP server propio:

```
Cursor / Claude / Open WebUI / cualquier IA MCP-compatible
         ↓
    MCP server (madre:3001)
         ↓
  ┌──────────────────────┐
  │ check_docker          │
  │ query_rag             │
  │ read_roadmap          │
  │ create_issue          │
  │ run_script_safe       │
  │ list_containers       │
  │ get_ecosystem_state   │
  │ search_yggdrasil_dew  │
  └──────────────────────┘
```

Cualquier IA que soporte MCP responde desde el **contexto real** del ecosistema.

---

## Tools expuestas (MVP)

| Tool | Input | Output | Safe |
|---|---|---|---|
| `check_docker` | `container?: string` | lista de containers + estado | ✅ |
| `get_ecosystem_state` | nada | ECOSYSTEM-STATE.md actual | ✅ |
| `read_roadmap` | nada | ROADMAP-MASTER.md actual | ✅ |
| `query_rag` | `query: string` | fragmentos relevantes de yggdrasil-dew | ✅ |
| `list_services` | nada | servicios Tailscale + ping | ✅ |
| `create_issue` | `title, body, repo` | URL del issue creado | ⚠️ human approval |
| `run_script_safe` | `script_name, dry_run=true` | output del script | ⚠️ solo dry_run por defecto |

---

## Stack técnico

```
pip install mcp fastapi uvicorn
```

- MCP SDK oficial de Anthropic (Python)
- Transport: **stdio** (para Cursor local) o **SSE** (para Open WebUI / red)
- FastAPI opcional para el endpoint HTTP si se quiere acceso remoto
- Config en `.env` (no hardcodear paths)

---

## Integración con Cursor

En `.cursor/mcp.json` de Madre:

```json
{
  "mcpServers": {
    "madre-ecosystem": {
      "command": "python",
      "args": ["/srv/mcp-server/mcp_server.py"],
      "env": {
        "YGGDRASIL_DEW_PATH": "/srv/yggdrasil-dew",
        "DOCKER_SOCKET": "/var/run/docker.sock"
      }
    }
  }
}
```

---

## Integración con Open WebUI

Añadir en Open WebUI → Settings → Tools:
- URL: `http://madre:3001/mcp/sse`
- Las tools aparecen disponibles para todos los modelos de Ollama

---

## Fases de implementación

### Fase 1 — MVP (esta semana)
- [ ] `check_docker` — lee `docker ps` y devuelve JSON
- [ ] `get_ecosystem_state` — lee ECOSYSTEM-STATE.md
- [ ] `read_roadmap` — lee ROADMAP-MASTER.md
- [ ] Config Cursor local en Madre

### Fase 2 — RAG + Issues
- [ ] `query_rag` — conectar con Qdrant
- [ ] `create_issue` — GitHub API con human approval
- [ ] Config Open WebUI

### Fase 3 — Ejecución segura
- [ ] `run_script_safe` con dry_run obligatorio
- [ ] Circuit breaker (máx N llamadas por hora)
- [ ] Audit log de cada llamada a tool

---

## Referencia de implementación

- Código: `agentes/mcp-server/mcp_server.py`
- Reglas: `agentes/REGLAS-AGENTES.md`
- Registro: `agentes/REGISTRO-AGENTES.md`
