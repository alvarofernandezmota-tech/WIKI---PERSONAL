# SÍNTESIS MAESTRA — Sesión 2026-07-03

> **Estado**: CONSOLIDADO — listo para siguiente fase  
> **Generado por**: Perplexity + análisis del inbox completo  
> **Próxima acción**: Ver sección 6 → MCP server de Madre

---

## 1. Qué hay en el inbox — inventario analizado

| Archivo | Tema central | Estado |
|---|---|---|
| `2026-07-03-arquitectura-bots-ecosistema.md` | Spec completo: bot vs agente, bucles, health-agent FastAPI | ✅ SPEC LISTO |
| `2026-07-03-enjambre-rag-llm-filosofia.md` | Filosofía enjambre, RAG, LLM local, segundo cerebro | ✅ REFERENCIA |
| `2026-07-03-bots-telegram-ollama-rag-local.md` | Implementación técnica bots + Ollama + RAG | ✅ REFERENCIA |
| `2026-07-03-plan-fases-ecosistema.md` | Fases 1-4 del ecosistema autónomo | ✅ ROADMAP BASE |
| `2026-07-03-reality-check.md` | Qué funciona, qué falta, prioridades reales | ✅ AUDITORÍA |
| `2026-07-03-reglas-orquestacion.md` | Reglas de orquestación n8n + agentes | ✅ REGLAS |
| `2026-07-03-alerting-inteligente.md` | Stack alerting: Prometheus + Alertmanager + Telegram | ⚙️ EN PROGRESO |
| `2026-07-03-repo-research.md` | Repos relevantes investigados | ✅ REFERENCIA |
| `2026-07-03-regla-escalado.md` | Regla SINE: cuándo escalar cada componente | ✅ REGLA FIJA |
| `2026-07-03-sesion2-regla-SINE.md` | Variante SINE sesión 2 | ✅ CONSOLIDADO |
| `2026-07-03-tareas-ecosistema.md` | Lista de tareas pendientes del ecosistema | ⚙️ EN PROGRESO |
| `2026-07-03-auditoria-estructura.md` | Auditoría estructura repos | ✅ REVISADO |
| `2026-07-03-ideas-bots-agentes-overflow.md` | Ideas overflow de la sesión | 📋 BACKLOG |
| `2026-07-03-fix-madre-setup.md` | Fixes pendientes en Madre | 🔴 ACCIÓN URGENTE |
| `PENDIENTES-S21.md` | Pendientes semana 21 | ⚙️ REVISAR |
| `PLAN-ESTRUCTURA-ISLAS.md` | Plan arquitectura islas | ✅ REFERENCIA |
| `SIGUIENTE-PASO.md` | Siguiente paso definido (MCP server) | 🎯 ACTIVO |
| `2026-07-03-inbox-audit-consolidado.md` | Audit consolidado previo | ✅ SUSTITUIDO POR ESTE |

---

## 2. Qué ha quedado claro en esta sesión

### 2.1 El cambio de paradigma

```
ANTES:   humano → script → acción
AHORA:   humano → agente → tool (script) → acción  
FUTURO:  trigger → agente → agente → tool → acción  (sin humano)
```

Los scripts NO desaparecen. **Se convierten en tools** que el agente orquesta.
El 80% del trabajo duro ya está hecho — los scripts son la capa de ejecución.

### 2.2 Diferencia bot / agente (consolidada)

| Concepto | Bot | Agente |
|---|---|---|
| Rol | Ejecuta tareas fijas | Persigue objetivos, decide con qué tool |
| Memoria | Stateless | Vector store + logs + DB |
| Herramientas | APIs/scripts predefinidos | Orquesta bots + APIs + MCP tools |
| Riesgo | Bajo | Mayor → requiere guardrails |

**Bots activos en el ecosistema:**
- yggdrasilwatchdog, guardianbot, networkradar
- tailscalemonitor, logguardianbot, localtripwire

**Agentes a construir (en orden):**
1. `health-agent` — salud del ecosistema (FastAPI + Ollama) ← **PRIMERO**
2. `roadmap-agent` — actualiza ROADMAP-MASTER.md autónomamente
3. `research-agent` — síntesis de investigación + RAG
4. `gatekeeper-agent` — orquestador maestro (multi-agent)

### 2.3 Stack confirmado

```
Orquestación:  n8n (cron + webhooks + AI Agent node)
Cerebro:       FastAPI (agent-core) + Ollama (LLMs locales)
Memoria:       Qdrant + bge-m3 + Markdown en yggdrasil-dew
Sensores:      bots existentes
Acción:        Docker API + GitHub API + n8n workflows + Telegram
Observabilidad: Prometheus + Grafana + Loki (pendiente)
```

---

## 3. Qué falta — análisis honesto

### 🔴 Urgente (bloquea el bucle autónomo)

1. **MCP server propio en Madre** — sin esto, ninguna IA puede hablar con el ecosistema real
2. **Despliegue health-agent** — el FastAPI ya tiene el código, falta docker-compose + cron n8n
3. **Workflow ecosystem-snapshot** — el n8n que alimenta al agente con el estado real
4. **Fixes pendientes Madre** — ver `2026-07-03-fix-madre-setup.md`

### 🟡 Importante (siguiente sprint)

5. **OTel Collector + Loki** — observabilidad completa del ecosistema
6. **Dry-run mode** — guardrail en todas las tools del agente (safe=true enforcement)
7. **Evals/pytest harness** — verificar comportamiento de agentes antes de producción
8. **Modelos por rol** — qué modelo corre en cada agente (GTX 1060 constraint)

### 🟢 Backlog (cuando el bucle esté estable)

9. Multi-agent gatekeeper
10. Self-healing avanzado (backoff + RAG de fallos)
11. Google A2A protocol — agentes hablándose entre sí
12. Wazuh SOC completo

---

## 4. El MCP server de Madre — arquitectura

Esta es la pieza más estratégica. Con ella, **cualquier IA que soporte MCP** (Cursor, Claude Desktop, Open WebUI) contesta desde el contexto real del ecosistema.

```
Cursor / Claude / Open WebUI
         ↓  MCP protocol
    madre-mcp-server (Madre:3100)
         ↓
  ┌─────────────────────────────────┐
  │  check_containers()             │  → Docker API
  │  get_services_health()          │  → HTTP pings
  │  query_rag(question)            │  → Qdrant + bge-m3
  │  read_roadmap()                 │  → yggdrasil-dew
  │  create_issue(title, body)      │  → GitHub API
  │  run_safe_script(name)          │  → scripts whitelist
  │  get_logs(service, lines)       │  → Loki / journald
  │  get_ecosystem_snapshot()       │  → EcosystemSnapshot JSON
  └─────────────────────────────────┘
```

**Implementación mínima viable:**
```bash
pip install mcp fastapi uvicorn
# Exponer en Madre via Tailscale o tunnel seguro
# docker-compose.yml con puerto 3100 solo en red interna
```

**Repo destino:** `yggdrasil-madre` o nuevo repo `madre-mcp-server`

---

## 5. Bucle autónomo completo — estado actual

```
[SENSORES]          [ORQUESTADOR]       [CEREBRO]          [ACCIÓN]

bots → datos    →   n8n cron        →   health-agent   →   Docker restart
                    (falta: ❌)          (falta deploy: ❌)  issue GitHub
                                                            Telegram alert
                                    ↓
                                [MEMORIA]
                                logs/health-agent/YYYY-MM-DD.md
                                Qdrant (falta ingest: ❌)
```

**El bucle no está cerrado aún.** Faltan 3 piezas:
1. n8n workflow que construye EcosystemSnapshot
2. Deploy del health-agent en Madre
3. Ingestión automática de logs en Qdrant

---

## 6. SIGUIENTE PASO — concreto y ejecutable

### Opción A: MCP server de Madre (recomendado)
**Por qué primero:** multiplica las capacidades de TODAS las IAs inmediatamente.

```bash
# En Madre:
git clone ... madre-mcp-server
cd madre-mcp-server
pip install mcp uvicorn fastapi docker
# Implementar 5 tools básicas
# Configurar en Cursor → Settings → MCP Servers
```

**Tiempo estimado:** 2-3 horas para MVP funcional

### Opción B: Ecosystem-snapshot workflow en n8n
**Por qué:** cierra el bucle del health-agent sin depender de código nuevo.

```
n8n cron (cada 5min)
  → HTTP node → Docker API → containers status
  → HTTP node → service pings
  → HTTP node → GitHub API → workflows status
  → Set node → EcosystemSnapshot JSON
  → HTTP node → health-agent /health/evaluate
  → IF node → acciones safe
```

**Tiempo estimado:** 1-2 horas en la UI de n8n

---

## 7. Investigación pendiente (para research-agent)

- `MCP Python SDK` — docs oficiales + ejemplos
- `Google A2A protocol` — agentes inter-comunicados 2026
- `Grafana Beyla + eBPF` — observabilidad sin instrumentar código
- `OpenTelemetry Collector` config mínima para homelab
- `LangGraph vs loop custom` — overhead vs control
- `Modelos Ollama por rol` — phi3:mini / qwen2.5:1.5b / gemma3:1b para GTX 1060
- `Event sourcing audit log` — append-only, sin borrado

---

## 8. Reglas del ecosistema consolidadas

### Regla SINE (cuándo escalar)
- **S**imple → prueba en local sin docker
- **I**ntegrado → añade docker cuando funciona
- **N**odo → añade al stack n8n cuando está estable
- **E**njambre → conecta con RAG/agente cuando tiene historia

### Regla de seguridad del agente
- Todo agente opera en dry-run por defecto
- Solo ejecuta si `safe: true` en la acción
- Acciones `safe: false` → notifica por Telegram → espera confirmación humana
- Nada toca producción sin confirmación [HUMAN]

### Regla de inbox
- Todo llega al inbox como Markdown
- Bot clasificador procesa y enruta
- Lo procesado va a `/inbox/archive/`
- El roadmap-agent lee el inbox diariamente

---

*Generado: 2026-07-03 17:18 CEST | Sesión: ecosistema autónomo | Próxima acción: MCP server Madre*
