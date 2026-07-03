# 🏥 Health Agent — Diseño

> **Tipo:** Agente de salud del ecosistema  
> **Estado:** 🔵 DISEÑO — pendiente implementación  
> **Prioridad:** Alta — primer agente del ecosistema  
> **Repo de implementación:** thdora-personal (futuro health-agent-core)

---

## Objetivo

```
Goal: Mantener el ecosistema en estado OK
  - Contenedores activos
  - Bots sin crash-loop
  - Servicios accesibles vía Tailscale
  - GitHub Actions ejecutándose según plan
  - RAG actualizado
  - OSINT stack operativo
```

---

## Arquitectura de componentes

| Componente | Rol | Implementación |
|---|---|---|
| `health-agent-core` | Agente principal | FastAPI + Python + Ollama |
| `health-sensors` | Bots que recogen estado | Scripts Docker / n8n / Prometheus |
| `health-dashboard` | Visualización | Grafana + Prometheus |
| `health-notifier` | Notificaciones humanas | guardianbot (Telegram) |
| `health-rag` | Memoria de estado histórico | Qdrant + bge-m3 + Markdown |

---

## Flujo de decisión

```
[SENSORES] → snapshot JSON
     ↓
[AGENTE CORE]
  1. Recibe snapshot (n8n cada 10-15 min)
  2. Consulta RAG (últimos incidentes, cambios)
  3. LLM clasifica: OK / WARN / CRITICAL
  4. Propone acciones (solo safe=true)
  5. Llama tools:
     - Docker API (reinicio controlado)
     - GitHub API (crear issue)
     - n8n (disparar workflow)
     - guardianbot (Telegram)
     ↓
[MEMORIA]
  - Log Markdown: logs/health-agent/YYYY-MM-DD.md
  - Ingesta periódica en Qdrant
```

---

## Bots como skills del agente

| Bot existente | Skill del agente | Input → Output |
|---|---|---|
| yggdrasilwatchdog | `check_containers` | → lista containers + estado |
| tailscalemonitor | `check_services` | → latencias + reachable |
| logguardianbot | `check_logs` | → eventos auth.log, ufw.log |
| guardianbot | `notify_telegram` | mensaje → enviado/error |
| networkradar | `check_lan` | → mapa red LAN |

---

## Guardrails (NO-DO list)

- ❌ No tocar código de producción
- ❌ No borrar ficheros ni datos
- ❌ No hacer merge sin aprobación humana
- ❌ No abrir puertos ni modificar UFW
- ❌ No ejecutar acciones con `safe=false`
- ✅ Solo proponer acciones con `safe=true`
- ✅ Log obligatorio de cada decisión
- ✅ Dry-run mode disponible para todas las tools

---

## Integración n8n

```yaml
Workflow: ecosystem-snapshot (cron cada 10-15 min)
  1. Nodo Docker/HTTP: estado contenedores (Portainer API)
  2. Nodo HTTP: ping a servicios (madre, open-webui, n8n, gitea)
  3. Nodo GitHub: estado workflows clave
  4. Nodo HTTP POST: → http://madre:8000/health/evaluate
  5. Nodo Telegram: alerta si global_status != OK
```

---

## Pendientes antes de implementar

- [ ] OpenTelemetry Collector desplegado en Madre
- [ ] Loki para logs unificados
- [ ] Portainer API accesible desde n8n
- [ ] Dry-run mode definido en todas las tools
- [ ] Eval harness básico (tests de comportamiento del agente)
- [ ] Credenciales de agente separadas (no usar las del humano)

---

## Referencias

- Esqueleto de código: `agentes/health-agent/health_agent_core.py`
- Registro de agentes: `agentes/REGISTRO-AGENTES.md`
- Sesión de diseño: `docs/sesiones/2026-07-03-agentes-ecosistema.md`
