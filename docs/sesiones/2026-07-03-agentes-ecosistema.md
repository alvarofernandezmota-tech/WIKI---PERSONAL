# 🧠 Sesión 2026-07-03 — Agentes, piezas faltantes y arquitectura

> **Tipo:** Sesión de arquitectura profunda  
> **Fecha:** 2026-07-03  
> **Participantes:** Álvaro + Perplexity  
> **Contexto:** Después de auditar thdora → thdora-personal y revisar el ecosistema completo

---

## 🎯 Conclusión principal

**Los agentes son la pieza que faltaba — pero no la única.**

Los scripts del ecosistema se convierten en **tools/skills** que los agentes invocan.  
El salto cualitativo: pasar de scripts reactivos → agentes con objetivo, memoria y loop de decisión.

---

## 1. Bot vs Agente — distinción clara

| Concepto | Bot | Agente |
|---|---|---|
| **Autonomía** | Baja–media, flujo predefinido | Media–alta, decide qué hacer y en qué orden |
| **Memoria** | Stateless o muy limitada | Explícita (vector store, DB, logs) |
| **Orquestación** | Sigue scripts, reglas, triggers | Orquesta herramientas (APIs, MCP tools, workflows) |
| **Objetivo** | Responder, notificar, ejecutar tareas | Alcanzar metas con planificación |
| **Riesgo** | Bajo (no decide mucho) | Mayor — necesita guardrails y auditoría |

### En el ecosistema:
- **Bots** = yggdrasilwatchdog, guardianbot, networkradar, logguardianbot
- **Agente** = entidad con objetivo, estado, memoria y herramientas que usa los bots como sensors/actuators

> ⚠️ No es "cada bot lleva un agente".  
> Es: **un agente puede usar varios bots como herramientas.**

---

## 2. Estructura bot vs agente en el stack

### Bot (estructura típica)
```
Trigger (cron/webhook/evento)
    ↓
Script Python/Bash (reglas fijas)
    ↓
Salida (Telegram / log / metric / commit)
```

### Agente (estructura completa)
```
Objetivo declarado
    ↓
Memoria (Qdrant + logs + estado)
    ↓
Herramientas:
  - Docker API
  - GitHub API
  - n8n workflows
  - RAG sobre yggdrasil-dew
  - OSINT stack
    ↓
Motor de decisión (LLM + lógica)
    ↓
Guardrails:
  - No tocar producción
  - No borrar nada
  - No merge sin humano
```

---

## 3. Las 5 piezas que faltan (además de los agentes)

### Pieza 1: Agentes (la conocida)
- Scripts → tools/skills
- Falta: cerebro orquestador con objetivo, memoria y loop
- Ver: `agentes/health-agent/DISEÑO.md`

### Pieza 2: Observabilidad real — OpenTelemetry
| Tienes | Falta |
|---|---|
| Prometheus métricas básicas | Trazas distribuidas |
| Grafana dashboards | Logs unificados (Loki) |
| Logs sueltos por contenedor | OpenTelemetry Collector central |
| Alertas Telegram manuales | Alertmanager con reglas |

**Sin trazas: cuando el agente falle en paso 3 de 5, no sabrás por qué.**

### Pieza 3: Guardrails + Governance
| Guardrail | Estado | Falta |
|---|---|---|
| No tocar producción | Solo en docs | Policy engine (OPA) |
| Audit trail | Logs Markdown | Immutable append-only log |
| Rollback | No existe | Dry-run mode en todas las tools |
| Rate limiting agente | No existe | Circuit breakers |
| Identidad agente | No existe | Credenciales únicas por agente |

### Pieza 4: Orchestration layer
```
health-agent ──┐
roadmap-agent ──┤── ORCHESTRATOR ── human approval gate ── actions
research-agent ─┘        │
                    registro de agentes
                    (qué existe, qué hace, qué corre)
```
n8n puede ser el orquestador ahora — pero falta el **registro de agentes**.

### Pieza 5: Evals (subestimada)
Cuando el agente toma decisiones con LLM, ¿cómo sabes que son correctas?  
Sin evals, el agente es una caja negra que no puedes mejorar de forma medible.

```python
# Ejemplo eval básico
def test_agent_detects_critical():
    snapshot = make_snapshot(containers=["crashed-container"])
    result = evaluate(snapshot)
    assert result["global_status"] == "CRITICAL"
    assert any(a["severity"] == "high" for a in result["actions"])
```

---

## 4. Mapa de evolución

```
HOY (Jul 2026)                    PRÓXIMOS MESES
─────────────────                 ──────────────────────────
Bots (scripts)          →         Skills/Tools del agente
n8n workflows           →         Orchestration layer
Logs sueltos            →         OpenTelemetry unificado
Docs Markdown           →         RAG + memoria de agente
CI/CD GitHub Actions    →         Agent identity + governance
Manual Telegram         →         Agente notifica con contexto
```

---

## 5. Cosas que podemos seguir investigando

### 🔴 Urgente (antes de primer agente)
- [ ] OpenTelemetry Collector en docker-compose de Madre
- [ ] Loki para logs unificados
- [ ] Dry-run mode — todas las tools del agente lo necesitan
- [ ] Modelo de identidad de agentes (qué credenciales, qué permisos)

### 🟠 Próximo sprint
- [ ] Registro de agentes (YAML con qué existe y qué puede hacer)
- [ ] Circuit breakers para el loop del agente
- [ ] Eval harness básico para health-agent
- [ ] Policy simple en código (no solo en docs)

### 🟢 Investigación paralela
- [ ] MCP server propio en Madre (tools locales para Cursor/Claude)
- [ ] A2A protocol (Google) — comunicación agente-a-agente estándar
- [ ] eBPF + Beyla para observabilidad sin código
- [ ] Wazuh vs Suricata para IDS/SOC en Madre
- [ ] Modelo de memoria episódica vs semántica para agentes
- [ ] Semantic kernel vs LangGraph vs loop custom — qué encaja mejor con Ollama local

---

## 6. Ficheros del repo relacionados

- `agentes/health-agent/DISEÑO.md` — arquitectura completa del agente de salud
- `agentes/health-agent/health_agent_core.py` — esqueleto FastAPI
- `agentes/REGISTRO-AGENTES.md` — registro maestro de agentes
- `docs/investigacion/2026-07-03-gaps-ecosistema.md` — gaps técnicos detallados
- `ECOSYSTEM-ARCHITECTURE.md` — arquitectura general

---

*Sesión cerrada 2026-07-03 15:12 CEST*
