# 🧪 Laboratorio de Agentes Yggdrasil

> **Versión:** 2.0 — va más allá del diseño inicial  
> **Estado:** ACTIVO — implementación en curso  
> **Fuente de verdad:** Este documento + `agentes/REGISTRO-AGENTES.md`  
> **Actualizado:** 2026-07-03

---

## Arquitectura de capas

```
┌───────────────────────────────────────────────────┐
│  CAPA 0: HUMANO — árbitro final, define roadmap    │
└───────────────────────────────────────────────────┘
         ↓ Cursor + Claude + Open WebUI
┌───────────────────────────────────────────────────┐
│  CAPA 1: MCP SERVER v2 (Madre:3001)               │
│  └ Gatekeeper + RBAC + Rate limiting + Audit      │
└───────────────────────────────────────────────────┘
         ↓ Orquestación
┌───────────────────────────────────────────────────┐
│  CAPA 2: n8n ORQUESTADOR                          │
│  ├ cron triggers                                  │
│  ├ webhook triggers                               │
│  └ AI Agent node (Ollama)                         │
└───────────────────────────────────────────────────┘
         ↓ Llamadas a agentes
┌───────────────────────────────────────────────────┐
│  CAPA 3: AGENTES (FastAPI + Ollama)                │
│  ├ health-agent   (phi3:mini)   :8001             │
│  ├ roadmap-agent  (mistral:7b)  :8002             │
│  ├ osint-agent    (qwen2.5:14b) :8003             │
│  ├ security-agent (phi3:mini)   :8004             │
│  └ docs-agent     (mistral:7b)  :8005             │
└───────────────────────────────────────────────────┘
         ↓ Tools (scripts promovidos)
┌───────────────────────────────────────────────────┐
│  CAPA 4: SENSORES/BOTS + SCRIPTS                  │
│  ├ yggdrasilwatchdog  ├ networkradar              │
│  ├ guardianbot        ├ tailscalemonitor          │
│  ├ logguardianbot     ├ localtripwire             │
│  └ 30+ scripts → tools de agentes                 │
└───────────────────────────────────────────────────┘
         ↓ Datos
┌───────────────────────────────────────────────────┐
│  CAPA 5: DATOS + MEMORIA                          │
│  ├ Qdrant (bge-m3) — RAG del ecosistema           │
│  ├ yggdrasil-dew — second brain documental        │
│  └ audit.log (append-only) — memoria inmutable    │
└───────────────────────────────────────────────────┘
```

---

## Los 6 agentes del laboratorio

### 1. health-agent — Médico del ecosistema
- **Modelo:** `phi3:mini` (3GB VRAM, bajo latencia)
- **Trigger:** n8n cron cada 15 min
- **Tools:** check_docker, ping_service, get_logs, create_issue, notify_telegram
- **Output:** JSON clasificado OK/WARN/CRITICAL + acciones safe
- **Doc:** `agentes/health-agent/DISEÑO.md`
- **Estado:** ⚠️ Esqueleto listo, pendiente despliegue

### 2. roadmap-agent — Planificador autónomo
- **Modelo:** `mistral:7b Q4`
- **Trigger:** n8n cron semanal (lunes 09:00)
- **Tools:** read_roadmap, read_issues, update_docs, create_pr, sync_labels
- **Output:** PR `agent/autoupdate-*` con cambios documentales
- **Regla clave:** Solo toca tareas [AUTO]. Escala [HUMAN] y [BLOCKER].
- **Doc:** `agentes/prompts/ROADMAP-AGENT-PROMPT.md`
- **Estado:** 🔵 Diseñado, pendiente implementación

### 3. osint-agent — Inteligencia de amenazas
- **Modelo:** `qwen2.5:14b Q4` (máximo contexto)
- **Trigger:** n8n cron diario (03:00)
- **Tools:** spiderfoot_scan, nmap_scan, shodan_query, create_security_issue
- **Output:** Informe de amenazas + issues de seguridad
- **Doc:** `agentes/osint-agent/DISEÑO.md`
- **Estado:** 🔵 Diseñado, pendiente implementación

### 4. security-agent — Vigilante de logs
- **Modelo:** `phi3:mini` (respuesta rápida)
- **Trigger:** n8n cron cada 5 min + webhook Fail2ban
- **Tools:** read_auth_log, read_ufw_log, check_fail2ban, check_open_ports, alert_telegram
- **Output:** Alertas de seguridad + informe diario
- **Doc:** `agentes/security-agent/DISEÑO.md`
- **Estado:** 🔵 Diseñado, pendiente implementación

### 5. docs-agent — Documentalista autónomo
- **Modelo:** `mistral:7b`
- **Trigger:** GitHub webhook (push a main)
- **Tools:** read_commit, read_files_changed, update_session_log, update_changelog
- **Output:** Actualización automática de historial de sesión
- **Estado:** 🔵 Concepto, pendiente sprint 2

### 6. research-agent — Investigador continuo
- **Modelo:** `qwen2.5:14b Q4`
- **Trigger:** n8n cron semanal + on-demand
- **Tools:** web_search, read_rss, synthesize, ingest_qdrant, create_research_doc
- **Output:** Documentos de investigación en `docs/investigacion/`
- **Doc:** `agentes/prompts/RESEARCH-AGENT-PROMPT.md`
- **Estado:** 🔵 Prompt listo, pendiente implementación

---

## MCP v2 — Mejoras sobre v1

### Lo que añade v2

| Feature | v1 | v2 |
|---|---|---|
| Tools | 4 básicas | 12+ con RBAC |
| Gatekeeper | No | Sí — valida CADA llamada |
| Rate limiting | No | Sí — por tool y por caller |
| Tool registry | Estático | Dinámico (descubrimiento en runtime) |
| Transport | Solo stdio | stdio + SSE (Open WebUI, n8n) |
| Audit | JSON simple | Structured + trace_id |

### Principio gatekeeper
```python
# Antes de CUALQUIER tool, el gatekeeper valida:
def gatekeeper(caller: str, tool: str, args: dict) -> bool:
    # 1. ¿El caller tiene permiso para esta tool?
    if not rbac.can(caller, tool): return False
    # 2. ¿Ha superado el rate limit?
    if rate_limiter.exceeded(caller, tool): return False
    # 3. ¿Los args pasan el schema validation?
    if not schema_valid(tool, args): return False
    # 4. Audit
    audit(caller, tool, args)
    return True
```

---

## Filosofía del laboratorio

### Autonomía con límites
Los agentes actúan solos pero **no deciden sobre producción ni seguridad crítica**.
El humano solo interviene cuando el sistema lo pide.

### Transparencia radical
Todo se loguea. Todo se documenta. El ecosistema puede reconstruirse desde cero
con los logs y la documentación.

### Soberanía total
Ningún dato sale de Madre. Sin cloud, sin SaaS externos, sin costos mensuales.
Los modelos corren local. Los datos quedan local.

### Un agente = un rol
Cada agente es experto en su campo. No hay agentes genéricos.
La especialización mejora el rendimiento y reduce el riesgo.

---

## Plan de implementación (4 semanas)

### Semana 1 — Núcleo MCP v2 + Health Agent
- [ ] Desplegar `mcp_server_v2.py` en Madre (:3001)
- [ ] Configurar `.cursor/mcp.json`
- [ ] Añadir health-agent a `docker-compose.agents.yml`
- [ ] Importar workflow `ecosystem-snapshot` en n8n
- [ ] Test dry_run 48h
- [ ] Activar acciones automáticas safe

### Semana 2 — Roadmap Agent + Qdrant ingesta
- [ ] Ejecutar `ingest_yggdrasil.py` → Qdrant lleno
- [ ] Implementar roadmap-agent loop en n8n
- [ ] Primer ciclo automático semanal
- [ ] Tool `query_rag` en MCP v2 conectada a Qdrant

### Semana 3 — Security Agent + OSINT Agent
- [ ] Desplegar security-agent (:8004)
- [ ] Desplegar osint-agent (:8003)
- [ ] Conectar Spiderfoot como tool MCP
- [ ] Primer informe de seguridad automático

### Semana 4 — Docs Agent + Research Agent + Observabilidad
- [ ] Docs-agent: webhook GitHub → actualización automática
- [ ] Research-agent: primer ciclo semanal
- [ ] OTel Collector básico
- [ ] Dashboard Grafana estado agentes
- [ ] Retrospectiva del laboratorio

---

## Preguntas que el ecosistema debería poder responder solo

Cuando el RAG y los agentes estén funcionando, cualquier IA podrá preguntar:

- “¿Qué ha pasado en el ecosistema esta semana?”
- “¿Qué contenedores han fallado en el último mes?”
- “¿Qué tareas [AUTO] quedan por completar?”
- “¿Cuál es el modelo más eficiente para el health-agent?”
- “¿Qué vulnerabilidades ha detectado el security-agent?”
- “Resume las últimas 10 sesiones de desarrollo.”

Eso es el ecosistema autónomo total.

---

*Laboratorio v2.0 — 2026-07-03*
