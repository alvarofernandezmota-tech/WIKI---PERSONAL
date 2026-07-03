# Laboratorio de Agentes Yggdrasil — MCP Generación 3

> **Estado:** Activo · **Versión:** 2.0.0 · **Última revisión:** 2026-07-03  
> **Mantenedor:** Perplexity + Álvaro  
> **Filosofía:** _El ecosistema que se mantiene, investiga y documenta a sí mismo._

---

## 0. Por qué este documento existe

Copilot generó v1. Este documento la supera en tres dimensiones:

1. **Está anclado a la repo real** — cada referencia apunta a un path existente en `yggdrasil-dew`.
2. **Incorpora patrones 2026** — Google A2A, MCP SDK 1.x, OTel traces para agentes, dry-run por ley.
3. **Es accionable** — cada sección termina con un comando o un archivo concreto.

---

## 1. Arquitectura general — La Trinidad

```
┌─────────────────────────────────────────────────────────────────┐
│                     YGGDRASIL ECOSYSTEM                         │
│                                                                 │
│  ┌──────────────┐   MCP/SSE    ┌─────────────────────────────┐  │
│  │  CLIENTES    │ ──────────▶  │   MCP SERVER (Madre:8765)   │  │
│  │  Cursor      │              │   agentes/mcp-server/       │  │
│  │  Claude      │              │                             │  │
│  │  Perplexity  │              │  tools:                     │  │
│  │  Open WebUI  │              │  · check_docker             │  │
│  └──────────────┘              │  · get_ecosystem_state      │  │
│                                │  · read_roadmap             │  │
│  ┌──────────────┐              │  · list_services            │  │
│  │  INBOX       │              │  · query_rag                │  │
│  │  (entrada    │              │  · run_script_safe          │  │
│  │   unificada) │              │  · create_issue             │  │
│  └──────┬───────┘              │  · get_logs                 │  │
│         │                      └────────────┬────────────────┘  │
│         ▼                                   │                   │
│  ┌─────────────────────────────────────────▼───────────────┐   │
│  │                  CAPA DE AGENTES                        │   │
│  │                                                         │   │
│  │  GATEKEEPER-AGENT  ──▶  health-agent                    │   │
│  │  (orquestador)     ──▶  roadmap-agent                   │   │
│  │                    ──▶  osint-agent                     │   │
│  │                    ──▶  security-agent                  │   │
│  │                    ──▶  docs-agent                      │   │
│  │                    ──▶  optimization-agent              │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  ┌──────────────┐   ┌──────────────┐   ┌─────────────────────┐  │
│  │  OLLAMA      │   │  QDRANT      │   │  n8n (orquestador)  │  │
│  │  (cerebro)   │   │  (memoria)   │   │  (scheduler/hooks)  │  │
│  └──────────────┘   └──────────────┘   └─────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

---

## 2. MCP Server — Generación 3

### 2.1 Diferencias generacionales

| Gen | Año | Patrón | Estado en Madre |
|-----|-----|--------|-----------------|
| 1 | 2024 | stdio process, tools básicas | No existe |
| 2 | 2025 | HTTP/SSE, tool schemas, auth básica | Esqueleto en `agentes/mcp-server/` |
| **3** | **2026** | **SSE + streamable HTTP, OAuth2, tool scopes, OTel traces, A2A-compatible** | **← Objetivo** |

### 2.2 Principios de diseño (irrenunciables)

1. **Tool = contrato** — cada tool declara: `input_schema`, `output_schema`, `scope`, `risk_level`, `dry_run_supported`.
2. **Audit log inmutable** — cada llamada → append-only en `logs/mcp-audit/YYYY-MM-DD.jsonl`.
3. **Dry-run por defecto** — si `risk_level >= medium`, la tool ejecuta en dry-run salvo flag explícito `{"dry_run": false}`.
4. **Scopes granulares** — cliente Cursor tiene scope `read:*`, agentes internos tienen scope `read:* write:safe exec:safe`.
5. **Zero-trust entre agentes** — incluso el gatekeeper necesita token para hablar con las tools.

### 2.3 Mapa de tools — Categorías y riesgo

#### Categoría READ (riesgo: bajo, nunca dry-run)
```
check_docker         → estado contenedores (nombre, status, uptime)
get_ecosystem_state  → snapshot completo: docker + servicios + workflows
read_roadmap         → lee ROADMAP-MASTER.md, devuelve estructura parseable
list_services        → ping HTTP a todos los servicios registrados
get_logs             → últimas N líneas de log por servicio
query_rag            → pregunta al RAG de Qdrant (solo lectura)
get_inbox_items      → lista ficheros en inbox/ sin procesarlos
```

#### Categoría WRITE-SAFE (riesgo: medio, dry-run disponible)
```
create_issue         → crea issue en yggdrasil-secops o yggdrasil-dew
append_log           → añade entrada a log estructurado
update_roadmap_task  → marca tarea [AUTO] como completada
send_telegram        → notificación via guardianbot
```

#### Categoría EXEC-SAFE (riesgo: alto, dry-run OBLIGATORIO antes)
```
restart_container    → docker restart <name> — solo contenedores whitelisted
run_script_safe      → ejecuta script de scripts/safe/ con timeout 30s
trigger_n8n_workflow → dispara workflow específico via webhook
```

#### Categoría HUMAN-REQUIRED (jamás ejecutado por agente)
```
merge_branch         → requiere confirmación humana explícita
deploy_production    → bloqueado en agentes
delete_data          → bloqueado en agentes
```

### 2.4 Estructura de ficheros del MCP server

```
agentes/mcp-server/
├── mcp_server.py          # Entry point (FastAPI + MCP SDK 1.x)
├── tools/
│   ├── docker_tools.py    # check_docker, restart_container
│   ├── ecosystem_tools.py # get_ecosystem_state, list_services
│   ├── roadmap_tools.py   # read_roadmap, update_roadmap_task
│   ├── rag_tools.py       # query_rag
│   ├── github_tools.py    # create_issue
│   ├── notif_tools.py     # send_telegram
│   └── script_tools.py    # run_script_safe
├── middleware/
│   ├── audit.py           # audit log middleware
│   ├── auth.py            # token validation + scopes
│   └── dry_run.py         # dry-run interceptor
├── config/
│   ├── scopes.yaml        # scope definitions por cliente
│   ├── whitelist.yaml     # contenedores/scripts permitidos
│   └── services.yaml      # mapa de servicios y endpoints
├── requirements.txt
├── Dockerfile
└── README.md
```

### 2.5 Integración con Cursor (`.cursor/mcp.json`)

```json
{
  "mcpServers": {
    "madre-ecosystem": {
      "url": "http://madre.local:8765/mcp",
      "transport": "sse",
      "headers": {
        "Authorization": "Bearer ${MADRE_MCP_TOKEN}"
      },
      "description": "Yggdrasil Ecosystem — Docker, Roadmap, RAG, Servicios"
    }
  }
}
```

---

## 3. Gatekeeper-Agent — El orquestador central

Este es el patrón que Copilot no implementó. El gatekeeper es la pieza nueva clave.

### 3.1 Qué hace el gatekeeper

```
INBOX (nuevo fichero) → gatekeeper lee
                      → clasifica intención (salud / roadmap / osint / docs / seguridad)
                      → verifica scope del agente destino
                      → delega al agente especializado
                      → espera resultado
                      → loguea decisión + resultado
                      → opcional: notifica via Telegram
```

### 3.2 Política de delegación

| Tipo de tarea | Agente destino | Condición de ejecución |
|---------------|---------------|------------------------|
| Estado contenedores / servicios | health-agent | Siempre autónomo |
| Tareas `[AUTO]` en ROADMAP | roadmap-agent | Solo en branch `agent/autoupdate-*` |
| Escaneo OSINT | osint-agent | Solo con red disponible |
| Análisis de logs sospechosos | security-agent | Siempre autónomo |
| Actualización docs | docs-agent | Solo ficheros en `docs/` |
| Métricas de rendimiento | optimization-agent | Solo lectura |
| **CRITICAL / [RISKY] / [HUMAN]** | **→ Telegram al humano** | **Bloqueo total** |

### 3.3 Protocolo A2A (agent-to-agent) — Estándar Google 2026

El gatekeeper habla con los agentes especializados via protocolo A2A (JSON-RPC sobre HTTP):

```json
// gatekeeper → health-agent
{
  "jsonrpc": "2.0",
  "method": "tasks/send",
  "params": {
    "task": {
      "id": "task-2026-07-03-001",
      "message": {
        "role": "user",
        "parts": [{"text": "Evalúa estado del ecosistema. Snapshot adjunto."}]
      },
      "metadata": {
        "source": "gatekeeper",
        "priority": "normal",
        "dry_run": true
      }
    }
  }
}
```

Cada agente expone un endpoint `/a2a` que acepta este protocolo. Esto permite intercambio entre agentes locales (Madre) y agentes externos futuros.

---

## 4. El Inbox como sistema nervioso de entrada

El inbox (`inbox/`) es el punto de entrada unificado para todo. La regla es simple:

**Si algo ocurre en el ecosistema → primero pasa por inbox → luego el gatekeeper lo procesa.**

### 4.1 Flujo de entrada

```
[Fuente externa]
     │
     ├── Telegram (guardianbot) → inbox/telegram/YYYY-MM-DD-HH-MM.md
     ├── GitHub Actions         → inbox/github/YYYY-MM-DD-HH-MM.md
     ├── n8n cron trigger       → inbox/cron/YYYY-MM-DD-HH-MM.md
     ├── Alerta Prometheus      → inbox/alerts/YYYY-MM-DD-HH-MM.md
     └── Manual (tú)           → inbox/manual/YYYY-MM-DD-HH-MM.md
          │
          ▼
   GATEKEEPER (n8n webhook watcher)
          │
          ▼
   Clasifica → Delega → Ejecuta → Loguea → [Notifica si WARN/CRITICAL]
```

### 4.2 Formato estándar de fichero inbox

```yaml
---
fecha: 2026-07-03T15:30:00
fuente: cron
tipo: health-check
prioridad: normal
dry_run: true
---

Ejecutar evaluación completa del ecosistema.
Adjunto snapshot de contenedores.
```

---

## 5. Agentes especializados — Fichas técnicas

### 5.1 health-agent
- **Ruta:** `agentes/health-agent/`
- **Modelo recomendado:** `phi4:mini` (rápido, 4GB VRAM)
- **Trigger:** n8n cron cada 15 min
- **Input:** EcosystemSnapshot (JSON via MCP tool `get_ecosystem_state`)
- **Output:** `{global_status, analysis, actions[]}`
- **Acciones safe:** restart container, create issue, send telegram, trigger n8n workflow
- **Fichero principal:** `agentes/health-agent/main.py`

### 5.2 roadmap-agent
- **Ruta:** `agentes/` (pendiente subdirectorio)
- **Modelo recomendado:** `qwen2.5:7b` (razonamiento, 8GB VRAM)
- **Trigger:** n8n cron diario + webhook en push a `ROADMAP-MASTER.md`
- **Input:** `ROADMAP-MASTER.md` filtrado por `[AUTO]`
- **Output:** commits en branch `agent/autoupdate-YYYY-MM-DD`
- **Nunca:** merge directo a main, tocar código fuente

### 5.3 osint-agent
- **Ruta:** `agentes/osint-agent/`
- **Modelo recomendado:** `mistral:7b`
- **Trigger:** manual o cron semanal
- **Tools usadas:** Spiderfoot API, Shodan (si disponible), theHarvester
- **Output:** issues en yggdrasil-secops

### 5.4 security-agent
- **Ruta:** `agentes/security-agent/`
- **Modelo recomendado:** `llama3.2:3b` (solo clasificación, muy ligero)
- **Trigger:** inotify sobre `/var/log/auth.log`, `/var/log/ufw.log`
- **Output:** alertas Telegram + issues automáticos

### 5.5 docs-agent _(nuevo — no estaba en v1)_
- **Ruta:** `agentes/docs-agent/` _(crear)_
- **Modelo recomendado:** `gemma3:4b`
- **Trigger:** webhook en push al repo
- **Input:** diff del commit
- **Output:** actualiza `CHANGELOG.md`, resumen en `sesiones/`, ingesta en Qdrant

### 5.6 optimization-agent _(nuevo — no estaba en v1)_
- **Ruta:** `agentes/optimization-agent/` _(crear)_
- **Modelo recomendado:** cualquiera (solo lee métricas)
- **Trigger:** cron semanal
- **Input:** métricas Prometheus (CPU, GPU, RAM, latencia Ollama)
- **Output:** recomendaciones en `inbox/cron/` + actualiza `hardware/PERFORMANCE.md`

---

## 6. Observabilidad — Stack OTel + Loki + Grafana

Cada agente instrumenta con OpenTelemetry. El flujo:

```
Agente (Python) → OTel SDK
                 → traces: Tempo (Grafana)
                 → logs: Loki (Grafana)
                 → métricas: Prometheus

# Configuración mínima en cada agente:
from opentelemetry import trace
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.trace import TracerProvider

tracer = trace.get_tracer("health-agent")

with tracer.start_as_current_span("evaluate_ecosystem") as span:
    span.set_attribute("agent.version", "1.0")
    span.set_attribute("snapshot.containers", len(containers))
    # ... lógica del agente
```

**Dashboard objetivo en Grafana:** un panel unificado que muestre:
- Frecuencia de llamadas por tool MCP
- Latencia media por agente
- Estado global del ecosistema en tiempo real
- Alertas pendientes de revisión humana

---

## 7. Evals — Cómo medir que los agentes funcionan bien

Esta es la parte que más falta tiene en el ecosistema. Un agente sin evals es una caja negra.

### 7.1 Framework de evaluación

```
agentes/evals/
├── fixtures/
│   ├── snapshot_ok.json        # Ecosistema sano
│   ├── snapshot_warn.json      # 1 contenedor caído
│   ├── snapshot_critical.json  # 3+ fallos simultáneos
│   └── snapshot_empty.json     # Sin datos
├── test_health_agent.py
├── test_roadmap_agent.py
├── test_gatekeeper.py
└── README.md
```

### 7.2 Tipos de eval

| Tipo | Qué mide | Frecuencia |
|------|----------|------------|
| **Unit** | Una tool MCP devuelve el schema correcto | En cada commit |
| **Behavioral** | El agente clasifica el estado correcto dado el snapshot | Diario |
| **Regression** | El agente no toma acciones destructivas en ningún fixture | En cada commit |
| **Golden set** | Comparación output actual vs output de referencia | Semanal |

---

## 8. Plan de implementación — Sprint real

### Sprint 0 — Esta semana (ya)

```bash
# 1. MCP server base
cd /srv && mkdir -p mcp-server
pip install mcp fastapi uvicorn opentelemetry-sdk

# 2. Copiar estructura desde agentes/mcp-server/ de la repo
git clone --sparse https://github.com/alvarofernandezmota-tech/yggdrasil-dew

# 3. Verificar en Cursor
# .cursor/mcp.json → añadir entrada madre-ecosystem
# Reiniciar Cursor → verificar tools visibles
```

### Sprint 1 — Semana 1
- [ ] MCP server deployado en Docker en Madre
- [ ] Tools READ funcionando (check_docker, get_ecosystem_state, read_roadmap)
- [ ] Audit log escribiendo en `logs/mcp-audit/`
- [ ] Cursor puede preguntar "¿qué contenedores están corriendo?" y recibe respuesta real

### Sprint 2 — Semana 2
- [ ] health-agent containerizado y conectado al MCP
- [ ] n8n workflow `ecosystem-snapshot` activo (cron cada 15min)
- [ ] Primer alert real por Telegram desde el agente
- [ ] OTel Collector recibiendo traces

### Sprint 3 — Semana 3
- [ ] Gatekeeper-agent operativo
- [ ] Inbox como entrada unificada (n8n watcher sobre `inbox/`)
- [ ] roadmap-agent leyendo `[AUTO]` tasks
- [ ] Evals básicas (fixtures OK/WARN/CRITICAL)

### Sprint 4 — Semana 4
- [ ] docs-agent activo (resúmenes de commits automáticos)
- [ ] optimization-agent reportando semanalmente
- [ ] Dashboard Grafana unificado
- [ ] REGLAS-AGENTES.md v2 actualizado con A2A y scopes

---

## 9. Lo que este ecosistema puede convertirse

Esto no es solo infraestructura personal. Con las piezas correctas:

- **Producto SaaS:** MCP server como servicio para otros homelabs soberanos
- **Framework open-source:** `yggdrasil-agents` — arquitectura de referencia para ecosistemas autónomos locales
- **Consultoría:** arquitectura de agentes para empresas que quieren soberanía de datos

Las reglas están en `agentes/REGLAS-AGENTES.md`. La arquitectura está en `ECOSYSTEM-ARCHITECTURE.md`. El next step está en `ROADMAP-MASTER.md`.

---

_Documento generado y mantenido por Perplexity + Álvaro · yggdrasil-dew · 2026_
