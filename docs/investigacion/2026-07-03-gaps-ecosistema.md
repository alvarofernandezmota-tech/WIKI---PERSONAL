# 🔍 Gaps del Ecosistema — Investigación 2026-07-03

> Resultado de sesión de arquitectura: qué falta más allá de los agentes.

---

## Gap 1: Observabilidad distribuida

### Problema
Los servicios de Madre corren como contenedores Docker aislados. Cuando algo falla, los logs están dispersos y no hay trazas entre servicios.

### Lo que hay
- Prometheus config en `monitoring/` (parcial, `/metrics` da 404)
- Grafana desplegado
- Logs sueltos por contenedor (`docker logs`)

### Lo que falta
- **OpenTelemetry Collector** como pipeline central
- **Loki** para logs unificados con etiquetas
- **Jaeger o Tempo** para trazas distribuidas
- **Alertmanager** con reglas automáticas

### Referencia técnica
- [Grafana Beyla](https://grafana.com/docs/beyla/latest/) — eBPF, cero código, auto-instrumentación
- [Grafana Alloy](https://grafana.com/docs/alloy/) — collector unificado para homelab
- OTEL stack completo: Collector → Prometheus (métricas) + Loki (logs) + Tempo (trazas) → Grafana

### Orden de implementación
```
1. OTel Collector en docker-compose
2. Loki + Promtail para logs
3. Alertmanager básico
4. Beyla para auto-instrumentación sin tocar código
5. Tempo para trazas (cuando haya agentes)
```

---

## Gap 2: Governance y guardrails de agentes

### Problema
Los agentes con LLM pueden tomar decisiones incorrectas o destructivas. Sin guardrails en código (no solo en docs), no hay protección real.

### Lo que hay
- Guardrails documentados en ECOSYSTEM-STATE.md y CONVENCIONES.md
- Ningún guardrail técnico implementado

### Lo que falta
- **Dry-run mode** en todas las tools del agente
- **Immutable audit log** (append-only, idealmente firmado)
- **Circuit breakers** — límite de llamadas a una tool por ciclo
- **Agent identity** — credenciales separadas, no las del humano
- **Policy engine** simple — OPA o equivalente Python

### Patrón recomendado
```python
# Ejemplo dry-run en tool
def restart_container(name: str, dry_run: bool = True):
    if dry_run:
        return {"action": "restart", "target": name, "dry_run": True, "executed": False}
    # ejecución real solo si dry_run=False y aprobado
    subprocess.run(["docker", "restart", name])
    return {"action": "restart", "target": name, "executed": True}
```

---

## Gap 3: Orchestration layer

### Problema
Cuando haya múltiples agentes (health, roadmap, research, security), necesitan coordinarse sin conflictos.

### Lo que hay
- n8n como orquestador de workflows
- Sin registro formal de agentes

### Lo que falta
- **Registro de agentes** (YAML/JSON: qué existe, qué puede hacer, qué está activo)
- **Protocolo de coordinación** entre agentes (quién tiene lock sobre un recurso)
- **Human-in-the-loop gate** para acciones de alto impacto

### Referencia
- Google A2A Protocol (Agent-to-Agent) — estándar emergente 2025-2026
- MCP (Model Context Protocol) de Anthropic — tools estándar para agentes
- n8n como bus de eventos entre agentes es válido para el stack actual

---

## Gap 4: Evals (evaluación de comportamiento)

### Problema
Sin evals, no se puede saber si el agente mejora o empeora con cambios de modelo/prompt.

### Lo que hay
- Sin sistema de evals

### Lo que falta
- **Eval harness** básico en pytest
- **Casos de prueba** para cada agente (escenarios OK, WARN, CRITICAL)
- **Baseline de comportamiento** — primera versión del agente establece la barra
- **Regresión automática** — CI falla si el agente cambia comportamiento inesperadamente

---

## Gap 5: MCP Server propio en Madre

### Problema
Cursor y otros clientes MCP no tienen acceso a tools locales de Madre.

### Lo que hay
- Cursor instalado con MCP tools externas
- Sin MCP server local

### Lo que falta
- **MCP server** que exponga las tools del ecosistema
- Tools: `check_docker`, `query_rag`, `read_roadmap`, `create_issue`, `run_script`
- Permite que Cursor/Claude actúen sobre Madre directamente

### Referencia
- Anthropic MCP SDK Python: `pip install mcp`
- FastAPI + MCP se pueden combinar en el mismo servicio

---

## Cosas a investigar próximamente

### Tecnología
- [ ] eBPF + Grafana Beyla para observabilidad sin código
- [ ] Wazuh homelab setup — IDS completo
- [ ] Suricata en Madre — IDS de red
- [ ] Open Policy Agent (OPA) para guardrails declarativos
- [ ] Google A2A vs MCP — qué protocolo usar para agentes locales
- [ ] LangGraph vs loop custom con Ollama — qué es más liviano para GTX 1060

### Arquitectura
- [ ] Modelo de memoria episódica vs semántica para agentes
- [ ] Event sourcing para audit log inmutable
- [ ] Separación de credenciales humano/agente en Madre
- [ ] Schema de snapshot del ecosistema (input del health-agent)

### Seguridad
- [ ] Threat model del ecosistema (qué atacar primero en pentest interno)
- [ ] LUKS + Btrfs hardening checklist
- [ ] UFW rules audit automatizado
- [ ] Tailscale ACLs — qué puede hablar con qué

---

*Generado en sesión 2026-07-03 · Ver: `docs/sesiones/2026-07-03-agentes-ecosistema.md`*
