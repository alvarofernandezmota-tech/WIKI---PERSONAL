# Sesión 2026-07-03 — Ecosistema Autónomo: Scripts → Tools, MCP, Inbox, Docker

> **Tipo:** Sesión de diseño arquitectónico  
> **Estado:** Documentado ✅  
> **Filtro humano pendiente:** sí — revisar antes de ejecutar

---

## 1. Conclusión principal

**Los scripts NO desaparecen — se convierten en tools del agente.**

El ecosistema ya tiene el 80% construido. Lo que faltaba era el cerebro (agente) que los orqueste.

```
ANTES:   humano → script → acción
AHORA:   humano → agente → script (como tool) → acción
FUTURO:  agente → agente → tool → acción   (sin humano en la mayoría de casos)
```

---

## 2. Diferencia bot vs agente (definición acordada)

| Concepto | Bot | Agente |
|---|---|---|
| **Rol** | Ejecuta tareas concretas, flujo fijo | Persigue objetivos, decide qué hacer y con qué herramienta |
| **Memoria** | Casi siempre stateless | Memoria explícita (vector store, logs, DB) |
| **Herramientas** | Usa APIs o scripts predefinidos | Orquesta bots, APIs, MCP tools, workflows |
| **Riesgo** | Bajo | Mayor — requiere guardrails y auditoría |

### Bots existentes en el ecosistema
- `yggdrasilwatchdog`
- `guardianbot`
- `networkradar`
- `tailscalemonitor`
- `logguardianbot`
- `localtripwire`

### Agentes deseados
- Agente de salud del ecosistema
- Agente ROADMAP-autónomo
- Agente de síntesis de investigación
- Agente RAG-second-brain

---

## 3. Qué falta — inventario honesto

| Categoría | Tienes | Falta |
|---|---|---|
| Scripts/tools | ~40 scripts en yggdrasil-dew | Exponerlos como tools/MCP skills |
| LLM local | Ollama en Madre | Modelos elegidos por agente |
| Orquestador | n8n funcionando | Workflow `ecosystem-snapshot` |
| Agente cerebro | Esqueleto FastAPI (health-agent) | Despliegue real en Madre + docker-compose |
| Observabilidad | Prometheus parcial, Grafana | OTel Collector + Loki + Alertmanager |
| Guardrails | Solo en docs | Dry-run mode en código |
| MCP server | GitHub MCP externo (Cursor) | **MCP propio de Madre** para IAs locales |
| Evals | Nada | Pytest harness para comportamiento de agentes |
| Registro agentes | ✅ Creado | Mantenerlo actualizado |

---

## 4. MCP propio de Madre — pieza más estratégica

Cursor ahora habla con GitHub vía MCP externo pero **no puede hablar con Madre**.
Con un MCP server propio en Madre, cualquier IA que soporte MCP (Cursor, Claude Desktop, Open WebUI) contesta desde el contexto real del ecosistema.

```
Cursor / Claude / cualquier IA
         ↓
    MCP server (Madre:3000)
         ↓
  ┌──────────────────────┐
  │ check_docker         │
  │ query_rag            │
  │ read_roadmap         │
  │ create_issue         │
  │ run_script (safe)    │
  │ list_containers      │
  └──────────────────────┘
```

Todas las IAs que soporten MCP tendrán acceso al ecosistema real. Responden en Cursor y en cualquier cliente MCP compatible.

---

## 5. Inbox como cerebro de entrada

```
Inbox (yggdrasil-dew/inbox/)
    ↓ bot clasificador
    ↓ agente decide
    ↓ tools ejecutan
    ↓ log en Markdown
    ↓ RAG actualizado
```

**Bot y agente trabajan al unísono:**
- El **bot** es sensor: detecta algo en el inbox
- El **agente** es cerebro: decide qué hacer y con qué tool

Todo entra y sale por el inbox. Bots y agentes operan en paralelo bajo un único punto de entrada.

---

## 6. Capas del sistema (arquitectura acordada)

| Capa | Componentes principales |
|---|---|
| **Sensores** | Bots: watchdog, tailscalemonitor, logguardianbot, networkradar |
| **Orquestación** | n8n (cron, webhooks, AI Agent node) |
| **Cerebro** | FastAPI (agent-core) + Ollama (LLMs locales) |
| **Memoria** | Qdrant + bge-m3 + Markdown en yggdrasil-dew |
| **Acción** | Docker API, GitHub API, n8n workflows, Telegram (guardianbot) |

### Bucle autónomo (sin supervisión constante)

```
1. n8n (cron) → EcosystemSnapshot (JSON)
2. health-agent-core (FastAPI + LLM) → clasifica: OK / WARN / CRITICAL
3. n8n ejecuta acciones safe:
   - Reinicios controlados
   - Issues en GitHub
   - Notificaciones Telegram
4. Log en Markdown → ingesta en Qdrant (RAG actualizado)
```

**Supervisión humana solo cuando:**
- Estado CRITICAL
- Tareas `[HUMAN]` o `[RISKY]`
- Vía Telegram (guardianbot)

---

## 7. Roadmap de investigación (acordado en sesión)

### Sprint inmediato
- `MCP server Python SDK` en Madre — `pip install mcp`, 5 tools básicas
- `OpenTelemetry Collector` docker-compose config mínima para Madre
- `Dry-run mode pattern` en todas las tools del agente

### Próximo sprint
- `Google A2A protocol` — cómo agentes se hablan entre sí (estándar emergente 2026)
- `Grafana Beyla + eBPF` — observabilidad sin tocar código
- `Wazuh homelab setup` — SOC completo, complementa pentest stack

### Investigación paralela abierta
- Modelos locales por rol: qué aguanta la GTX 1060 por agente
- `LangGraph vs loop custom` — cuál es más ligero para Ollama local
- `Event sourcing` para audit log inmutable (append-only)

---

## 8. ⚠️ REGLA OPERACIONAL — Docker siempre en terminal separada

> **REGLA FIJA — nunca se rompe:**  
> **Docker siempre se lanza en otra terminal.**

### Motivo

Cualquier proceso que ocupe el foreground bloquea el contexto de trabajo actual. Docker en foreground:
- Mezcla logs de contenedor con output del agente/shell activo
- Impide leer el estado del proceso desde el mismo contexto
- Dificulta el kill limpio sin afectar al entorno padre
- Rompe la separación sensor → orquestador → cerebro

### Aplicación

```bash
# ❌ MAL — bloquea la terminal activa
docker compose up

# ✅ BIEN — terminal separada o modo detached
docker compose up -d

# ✅ BIEN — nueva terminal con tmux/screen si se necesitan logs en vivo
tmux new-session -d -s docker-agents 'docker compose up'
```

### Scope
Esta regla aplica a:
- `docker compose up`
- `docker run` interactivo
- `docker exec` con procesos de larga duración
- Cualquier servicio/bot que arranque un contenedor

---

## 9. Próximo paso acordado

**Decisión pendiente (filtro humano):**
- Opción A: MCP server de Madre primero
- Opción B: `ecosystem-snapshot` workflow en n8n primero
- Opción C: Las dos en paralelo

---

*Sesión documentada automáticamente — revisar antes de ejecutar cualquier acción derivada.*
