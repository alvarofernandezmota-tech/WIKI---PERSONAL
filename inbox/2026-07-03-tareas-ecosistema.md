---
type: task-batch
date: 2026-07-03
source: perplexity-session
priority: high
status: pending
processed_by: gatekeeper-agent
---

# Tareas generadas en sesión 2026-07-03

## Tarea 1 — Deploy MCP server en Madre

```
fase: 0
prioridad: CRITICA
estado: pending
agente: humano
```

**Acción:**
```bash
cd /srv/yggdrasil-dew && git pull
cd agentes/mcp-server
docker compose -f docker-compose.mcp.yml up -d --build
```

**Verificación:** `curl http://localhost:8765/health`

---

## Tarea 2 — Configurar Cursor con MCP de Madre

```
fase: 0
prioridad: CRITICA
estado: pending
agente: humano
```

**Acción:** Añadir a `.cursor/mcp.json`:
```json
{
  "mcpServers": {
    "madre-ecosystem": {
      "url": "http://MADRE_IP:8765/mcp",
      "headers": {
        "Authorization": "Bearer TU_MADRE_MCP_TOKEN"
      }
    }
  }
}
```

---

## Tarea 3 — Archivar scripts obsoletos

```
fase: 0
prioridad: MEDIA
estado: pending
agente: humano o roadmap-agent
```

**Acción:**
```bash
mkdir -p scripts/archive
mv scripts/inbox-cleanup-jun2024.sh scripts/archive/
mv scripts/migrar-inbox.sh scripts/archive/
```

---

## Tarea 4 — Crear n8n workflow ecosystem-snapshot

```
fase: 1
prioridad: ALTA
estado: pending
agente: humano + n8n
```

**Acción:** Importar `n8n/workflows/ecosystem-snapshot.json` en n8n (a crear en próxima sesión)

---

## Tarea 5 — Crear .env de Madre con secretos MCP

```
fase: 0
prioridad: CRITICA
estado: pending
agente: humano (NUNCA al repo)
```

**Acción:** Crear `/srv/yggdrasil-dew/agentes/mcp-server/.env` con:
```
MADRE_MCP_TOKEN=genera-uno-con-openssl-rand-hex-32
GITHUB_TOKEN=tu-token
TELEGRAM_BOT_TOKEN=tu-token
TELEGRAM_CHAT_ID=tu-chat-id
```

**⚠ï¸ .env ya está en .gitignore. NUNCA pushear.**

---

_Generado por Perplexity · sesión 2026-07-03_
