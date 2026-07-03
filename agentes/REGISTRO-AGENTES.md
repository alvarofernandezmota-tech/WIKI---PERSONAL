# 🤖 Registro de Agentes — Ecosistema

> **Fuente de verdad de todos los agentes planificados y activos.**  
> Actualizar aquí antes de implementar cualquier agente nuevo.  
> Un agente no existe hasta que tiene entrada en este registro.

---

## Principio fundamental

```
Bots = herramientas (sensors / actuators)
Agentes = cerebro (objetivo + memoria + decisión + herramientas)

Un agente orquesta múltiples bots. No al revés.
```

---

## Agentes planificados

### 🏥 health-agent
- **Estado:** 🔵 DISEÑO
- **Objetivo:** Mantener el ecosistema en estado OK
- **Skills/Tools:** check_containers, check_services, check_workflows, notify_telegram, create_issue
- **LLM:** Ollama phi3:mini (local, GTX 1060)
- **Memoria:** Qdrant + logs Markdown
- **Trigger:** n8n cron cada 10-15 min
- **Repo impl:** thdora-personal
- **Docs:** `agentes/health-agent/DISEÑO.md`
- **Guardrails:** No producción, no borrar, no merge sin humano, solo safe=true

---

### 🗺️ roadmap-agent
- **Estado:** 🔴 PENDIENTE — después de health-agent
- **Objetivo:** Avanzar el ROADMAP-MASTER.md de forma autónoma
- **Skills/Tools:** read_roadmap, create_pr, create_issue, update_docs, run_tests
- **LLM:** Por definir (Mistral 7B / Qwen local)
- **Memoria:** RAG sobre yggdrasil-dew + historial de PRs
- **Trigger:** Manual o cron semanal
- **Guardrails:** Solo tareas marcadas [AUTO], no merge sin humano, dry-run primero
- **Docs:** Pendiente crear `agentes/roadmap-agent/DISEÑO.md`

---

### 🔬 research-agent
- **Estado:** 🔴 PENDIENTE
- **Objetivo:** Investigar tecnologías, contrastar fuentes, actualizar docs
- **Skills/Tools:** searxng_search, fetch_url, rag_query, write_doc
- **LLM:** Por definir
- **Memoria:** RAG sobre corpus de investigación
- **Trigger:** Issue con label `[INVESTIGAR]` o manual
- **Guardrails:** Solo lectura web, no ejecutar código externo, fuentes primarias siempre
- **Docs:** Pendiente crear `agentes/research-agent/DISEÑO.md`

---

### 🛡️ security-agent
- **Estado:** 🔴 PENDIENTE — requiere SOC stack (Wazuh/Suricata)
- **Objetivo:** Detectar anomalías de seguridad y escalar incidentes
- **Skills/Tools:** check_logs, check_network, create_alert, quarantine_service
- **LLM:** Local, air-gapped
- **Guardrails:** Nunca acción destructiva automática, siempre escalar a humano primero
- **Docs:** Pendiente crear `agentes/security-agent/DISEÑO.md`

---

## Lo que NO es un agente (es un bot)

| Nombre | Por qué es bot, no agente |
|---|---|
| yggdrasilwatchdog | Reglas fijas, no decide |
| guardianbot | Solo notifica, no planifica |
| networkradar | Solo escanea, salida fija |
| logguardianbot | Patrones predefinidos |
| tailscalemonitor | Ping y reporta, nada más |

---

## Piezas de infraestructura necesarias para agentes

| Pieza | Estado | Urgencia |
|---|---|---|
| OpenTelemetry Collector | ❌ No existe | 🔴 Antes del primer agente |
| Loki (logs unificados) | ❌ No existe | 🔴 Antes del primer agente |
| Dry-run mode en tools | ❌ No existe | 🔴 Antes del primer agente |
| Registro de agentes (este fichero) | ✅ Creado | — |
| Identidad/credenciales por agente | ❌ No existe | 🟠 Primer sprint |
| Eval harness | ❌ No existe | 🟠 Primer sprint |
| Circuit breakers | ❌ No existe | 🟡 Segundo sprint |
| Policy engine (OPA) | ❌ No existe | 🟡 Segundo sprint |

---

*Actualizado: 2026-07-03*
