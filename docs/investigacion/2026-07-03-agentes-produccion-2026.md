# 🔬 Investigación: Agentes en Producción 2026

> **Fecha:** 2026-07-03  
> **Fuentes:** Digital Applied, Fast.io, AI-AgentsPlus, ZeonEdge, BitPixel  
> **Aplicación:** Ecosistema Yggdrasil

---

## Lo que cambió en 2026

Dos cosas hicieron que los agentes funcionen de verdad en producción:

1. **Los modelos de razonamiento son fiables** — Claude 3.5, Gemini 2.0, y modelos locales como Qwen2.5 aguantan tareas multi-step sin hand-holding constante.
2. **Los guardrails y el tooling maduraron** — MCP, OTel, circuit breakers y audit logs son estándar, no lujo.

La arquitectura que FUNCIONA en producción (verificada con deployments reales):

```
Humano propone → Agente decide → Tool ejecuta → Log inmutable
                                     ↓
                              Human approval si riesgo > umbral
```

---

## Patrón ganador: Tool-as-a-Service

Cada tool es un servicio externo. El agente solo enruta llamadas.
Aplica directamente a nuestro ecosistema:

```
health-agent (cerebro)
    ├── check_docker()     ← llama a Docker API
    ├── ping_service()     ← llama a HTTP endpoint
    ├── create_issue()     ← llama a GitHub API
    └── notify_telegram()  ← llama a guardianbot
```

Ventaja: si falla una tool, el agente no falla. Circuit breaker en cada tool.

---

## Patrón ganador: Orchestrator-Worker

Un agente 'jefe' usa modelos fuertes (Mistral, Qwen2.5-72B).
Los workers usan modelos ligeros (phi3:mini, Llama3.2:3b).

```
n8n (orquestador) → selecciona qué agente según tarea
    ├── health-agent (phi3:mini) — salud, bajo costo inferencia
    ├── roadmap-agent (mistral:7b) — planificación, más razonamiento
    └── research-agent (qwen2.5:14b) — síntesis, máximo contexto
```

Esto es crítico para la GTX 1060: no usar el modelo grande para todo.

---

## MCP como estándar de facto 2026

MCP resuelve el problema de "interface explosion":
- Sin MCP: cada agente necesita código custom para cada tool
- Con MCP: el agente pregunta al servidor qué tools hay y las usa con protocolo estándar

Patrones MCP empresariales 2026 (Digital Applied):
1. **Tool Registry dinámico** — el servidor MCP expone un catálogo; el agente descubre tools en runtime
2. **RBAC por tool** — cada tool tiene permisos declarados
3. **Rate limiting por tool** — evita bucles y costos inesperados
4. **Audit por tool** — cada llamada logueada inmutablemente

Nuestro `mcp_server.py` ya implementa la base de esto.

---

## Guardrails que funcionan de verdad (no en docs, en código)

Fuente: AI-AgentsPlus, ZeonEdge

```python
# El patrón que funciona en producción
class AgentAction:
    action: str
    target: str
    severity: Literal["low", "medium", "high", "critical"]
    safe: bool
    dry_run: bool = True
    requires_human: bool = False

# Guardrail pipeline (obligatorio antes de ejecutar)
def guardrail_pipeline(action: AgentAction) -> bool:
    if action.severity == "critical":  return False  # bloqueo duro
    if not action.safe:               return False  # bloqueo duro
    if action.requires_human:         escalate(); return False
    if circuit_breaker.triggered():   return False
    return True
```

---

## Observabilidad: lo mínimo que necesitas

Sin observabilidad no puedes mejorar. El stack mínimo para 2026:

| Componente | Para qué | Alternativa ligera |
|---|---|---|
| OTel Collector | trace_id por cada ciclo de agente | Prometheus básico |
| Loki | logs estructurados de tools | JSON files append-only |
| Grafana | dashboard estado agentes | Solo alertas Telegram |
| Alertmanager | reglas de alerta | n8n IF node |

**Para Madre (GTX 1060, recursos limitados):** empezar con JSON append-only + alertas Telegram.
OTel Collector añadir cuando haya headroom.

---

## Modelos locales: qué asignar a qué agente

Basado en benchmarks 2026 con Ollama local:

| Modelo | VRAM | Mejor para | Latencia |
|---|---|---|---|
| `phi3:mini` (3.8B) | 3GB | health checks, clasificación, JSON | ~2s |
| `llama3.2:3b` | 2.5GB | resumir logs cortos | ~1.5s |
| `mistral:7b` | 5GB | roadmap, planificación | ~8s |
| `qwen2.5:14b` | 9GB (quantizado) | research, síntesis larga | ~20s |
| `deepseek-r1:7b` | 5GB | razonamiento, decisiones complejas | ~12s |

GTX 1060 tiene 6GB VRAM → phi3:mini o llama3.2 para agentes críticos.
mistral:7b con quantización Q4 cabe si se descarga otro.

---

## Los 5 errores que matan agentes en producción

1. **"Funciona en test" ilusión** — datos reales son más sucios. Planificar edge cases.
2. **Scope creep** — el agente de salud no debe hacer roadmap. Un agente, un rol.
3. **Sin feedback loop** — si el humano corrige, esa corrección debe informar el futuro.
4. **Seguridad como afterthought** — agentes con acceso a datos pueden filtrar datos.
5. **Rollout al 100% día 1** — empezar siempre con shadow mode / dry_run 48h.

---

## Aplicación al ecosistema Yggdrasil

### Lo que ya tenemos bien
- ✅ dry_run por defecto
- ✅ audit log append-only
- ✅ circuit breakers diseñados
- ✅ human-in-the-loop para acciones RISKY
- ✅ un agente = un rol

### Lo que hay que añadir urgente
- ⬜ trace_id en cada ciclo (aunque sea UUID simple)
- ⬜ shadow mode 48h antes de activar acciones reales
- ⬜ modelos asignados por agente (no usar el mismo para todo)
- ⬜ feedback loop: cuando humano corrige → issue con etiqueta `agent-correction`

---

*Investigación aplicada — 2026-07-03*
