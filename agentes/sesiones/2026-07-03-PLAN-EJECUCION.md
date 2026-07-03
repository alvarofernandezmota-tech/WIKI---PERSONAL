# Plan de Ejecución Inmediata — 2026-07-03

> **Estado:** LISTO PARA EJECUTAR — filtro humano aplicado ✅  
> **Origen:** Sesión de diseño [2026-07-03-ecosistema-autonomo.md](./2026-07-03-ecosistema-autonomo.md)  
> **Regla base:** Docker siempre en terminal separada (`-d` o tmux)

---

## ⚡ Sprint 0 — Antes de todo (verificar estado real)

```bash
# En Madre — verificar que Ollama responde
curl http://localhost:11434/api/tags

# Verificar contenedores activos
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'

# Verificar n8n
curl -s http://localhost:5678/healthz

# Verificar Qdrant
curl -s http://localhost:6333/collections
```

---

## 🔴 Sprint 1 — MCP Server de Madre (PRIORITARIO)

> Objetivo: que Cursor y cualquier IA hablen directamente con Madre.

### 1.1 Preparar entorno

```bash
# En Madre
cd /srv/yggdrasil-dew/agentes/mcp-server

# Crear venv aislado
python3 -m venv .venv
source .venv/bin/activate

# Instalar dependencias
pip install mcp fastapi uvicorn docker requests
```

### 1.2 Estructura de archivos

```
agentes/mcp-server/
├── main.py              ← servidor MCP principal
├── tools/
│   ├── docker_tools.py  ← check_docker, list_containers, restart_container
│   ├── github_tools.py  ← create_issue, read_roadmap
│   ├── rag_tools.py     ← query_rag, ingest_doc
│   └── script_tools.py  ← run_script (safe mode only)
├── requirements.txt
└── docker-compose.mcp.yml
```

### 1.3 Arrancar (TERMINAL SEPARADA)

```bash
# ✅ Opción 1 — detached
docker compose -f docker-compose.mcp.yml up -d

# ✅ Opción 2 — tmux para ver logs
tmux new-session -d -s mcp-server \
  'cd /srv/yggdrasil-dew/agentes/mcp-server && \
   source .venv/bin/activate && \
   uvicorn main:app --host 0.0.0.0 --port 3000 --reload'

# Ver logs si usas tmux
tmux attach -t mcp-server

# Verificar que responde
curl http://localhost:3000/health
curl http://localhost:3000/tools
```

### 1.4 Conectar en Cursor

En `.cursor/mcp.json` del proyecto (o global `~/.cursor/mcp.json`):

```json
{
  "mcpServers": {
    "madre": {
      "url": "http://MADRE_IP:3000/mcp",
      "description": "MCP server del ecosistema Yggdrasil en Madre"
    }
  }
}
```

> Sustituir `MADRE_IP` por la IP real de Madre en Tailscale.

---

## 🟡 Sprint 2 — Health Agent desplegado

> Objetivo: el agente de salud corriendo real en Madre.

### 2.1 Levantar el health-agent

```bash
cd /srv/yggdrasil-dew/agentes/health-agent

# ✅ Terminal separada — modo detached
docker compose up -d

# Verificar
curl -X POST http://localhost:8000/health/evaluate \
  -H 'Content-Type: application/json' \
  -d '{
    "timestamp": "2026-07-03T17:30:00Z",
    "containers": [{"name": "test", "status": "running"}],
    "services": [{"name": "n8n", "reachable": true, "latency_ms": 12}],
    "workflows": [{"name": "test-wf", "last_run": "2026-07-03", "status": "success"}]
  }'
```

### 2.2 Verificar log generado

```bash
ls -la /srv/yggdrasil-dew/logs/health-agent/
cat /srv/yggdrasil-dew/logs/health-agent/$(date +%Y-%m-%d).md
```

---

## 🟡 Sprint 3 — Ecosystem Snapshot en n8n

> Objetivo: n8n recolecta estado del ecosistema cada X minutos y alimenta el health-agent.

### 3.1 Workflow JSON a importar en n8n

Nombre: `ecosystem-snapshot-cron`

Flujo:
```
Cron (cada 5 min)
  → HTTP Request: GET http://localhost:9000/containers  (Portainer API)
  → HTTP Request: GET http://localhost:5678/healthz     (n8n self)
  → HTTP Request: GET http://localhost:11434/api/tags   (Ollama)
  → Code node: construir EcosystemSnapshot JSON
  → HTTP Request: POST http://localhost:8000/health/evaluate
  → IF node: global_status == CRITICAL
      → Telegram node: notificar guardianbot
```

### 3.2 Importar workflow

```bash
# El JSON del workflow estará en:
# agentes/ecosystem-snapshot/n8n-workflow.json

# Importar via API de n8n
curl -X POST http://localhost:5678/api/v1/workflows \
  -H 'Content-Type: application/json' \
  -H 'X-N8N-API-KEY: TU_API_KEY' \
  -d @agentes/ecosystem-snapshot/n8n-workflow.json
```

---

## 🟢 Sprint 4 — OTel Collector (observabilidad)

> Objetivo: trazas y logs unificados.

### 4.1 docker-compose.otel.yml mínimo

```yaml
# Guardar en /srv/yggdrasil-dew/infra/docker-compose.otel.yml
services:
  otel-collector:
    image: otel/opentelemetry-collector-contrib:latest
    ports:
      - "4317:4317"   # gRPC
      - "4318:4318"   # HTTP
      - "8888:8888"   # metrics
    volumes:
      - ./otel-config.yaml:/etc/otelcol-contrib/config.yaml
    restart: unless-stopped

  loki:
    image: grafana/loki:latest
    ports:
      - "3100:3100"
    restart: unless-stopped

  promtail:
    image: grafana/promtail:latest
    volumes:
      - /var/log:/var/log:ro
      - /srv/yggdrasil-dew/logs:/app-logs:ro
    restart: unless-stopped
```

```bash
# ✅ Terminal separada
cd /srv/yggdrasil-dew/infra
docker compose -f docker-compose.otel.yml up -d

# Verificar Loki
curl http://localhost:3100/ready
```

---

## 🔵 Sprint 5 — Dry-run mode en todas las tools

> Objetivo: ninguna tool del agente ejecuta acciones reales sin `dry_run=False` explícito.

### Patrón a aplicar en todos los tools del agente

```python
# En cualquier tool del agente
def restart_container(name: str, dry_run: bool = True) -> dict:
    if dry_run:
        return {"action": "restart", "target": name, "executed": False, "reason": "dry_run=True"}
    
    # Solo llega aquí si dry_run=False explícito
    client = docker.from_env()
    container = client.containers.get(name)
    container.restart()
    return {"action": "restart", "target": name, "executed": True}
```

### Verificar dry_run en health-agent

```bash
# Test — debe retornar executed: false
curl -X POST http://localhost:8000/health/evaluate \
  -H 'Content-Type: application/json' \
  -d '{...snapshot...}' | jq '.actions[] | select(.safe == false)'
```

---

## 📋 Checklist de estado — rellenar conforme se ejecuta

```
[ ] Sprint 0 — Estado real verificado en Madre
[ ] Sprint 1 — MCP server arrancado en Madre:3000
[ ] Sprint 1 — Cursor conectado a Madre vía MCP
[ ] Sprint 2 — health-agent respondiendo en Madre:8000
[ ] Sprint 2 — Logs generándose en /logs/health-agent/
[ ] Sprint 3 — Workflow ecosystem-snapshot importado en n8n
[ ] Sprint 3 — Cron cada 5 min activo
[ ] Sprint 3 — Notificación Telegram en CRITICAL funcionando
[ ] Sprint 4 — OTel Collector + Loki levantados
[ ] Sprint 4 — Grafana viendo logs de Loki
[ ] Sprint 5 — Dry-run mode en todas las tools del agente
[ ] Sprint 5 — Pytest harness básico para el health-agent
```

---

## 🚨 Reglas operacionales que aplican a TODO este plan

| Regla | Descripción |
|---|---|
| **Docker en terminal separada** | `docker compose up` siempre con `-d` o en tmux — nunca bloqueando la terminal activa |
| **Dry-run por defecto** | Todas las tools del agente ejecutan con `dry_run=True` hasta que se valide el comportamiento |
| **Sin merges automáticos** | El agente nunca hace merge en main — solo branches `agent/autoupdate-*` + PR |
| **Supervisión por Telegram** | Cualquier acción CRITICAL o RISKY llega a guardianbot antes de ejecutarse |
| **Logs siempre en Markdown** | Todo log del agente va a `/logs/health-agent/YYYY-MM-DD.md` + ingesta Qdrant |

---

## 🔗 Referencias clave

- Arquitectura sesión: [2026-07-03-ecosistema-autonomo.md](./2026-07-03-ecosistema-autonomo.md)
- Health agent base: [agentes/health-agent/](../health-agent/)
- MCP server: [agentes/mcp-server/](../mcp-server/)
- Ecosystem snapshot: [agentes/ecosystem-snapshot/](../ecosystem-snapshot/)
- Reglas generales agentes: [REGLAS-AGENTES.md](../REGLAS-AGENTES.md)

---

*Este documento es el plan de acción ejecutable — marcar cada checkbox conforme se completa.*
