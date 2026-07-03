# 🗺️ ROADMAP MASTER — Ecosistema Yggdrasil

> Fuente de verdad del plan estratégico.  
> Actualizado en sesión 2026-07-03.  
> Estado: **FASE AGENTES activa**

---

## 💡 Principio de evolución

```
Scripts → Tools de agentes
Bots → Sensores / actuadores
Agentes → Cerebros autónomos
Humano → Árbitro final
```

---

## 🟢 FASE ACTUAL: AGENTES

### Objetivo
Transformar el ecosistema de scripts reactivos a agentes autónomos con memoria, herramientas y guardrails.

### Sub-fases

#### A1 — MCP Server de Madre [EN DISEÑO]
- [ ] Implementar `agentes/mcp-server/mcp_server.py`
- [ ] Tools MVP: check_docker, get_ecosystem_state, read_roadmap, list_services
- [ ] Configurar en Cursor local
- [ ] Desplegar en docker-compose de Madre

#### A2 — Health Agent [ESQUELETO LISTO]
- [ ] Desplegar `agentes/health-agent/health_agent_core.py` en Madre
- [ ] Implementar n8n workflow `agentes/ecosystem-snapshot/n8n-workflow.json`
- [ ] Test en dry_run durante 48h
- [ ] Activar acciones automáticas safe

#### A3 — Observabilidad (OTel)
- [ ] OTel Collector en docker-compose
- [ ] Loki para logs unificados
- [ ] Alertmanager con reglas básicas
- [ ] Beyla para auto-instrumentación sin código

#### A4 — Guardrails en código
- [ ] Dry-run mode en todas las tools
- [ ] Circuit breakers implementados
- [ ] Audit log inmutable (append-only)
- [ ] Identidad de agente separada

#### A5 — Eval harness
- [ ] Pytest harness básico para health-agent
- [ ] Casos: OK, WARN, CRITICAL
- [ ] Regresión en CI (GitHub Actions)

---

## ✅ FASES COMPLETADAS

### FASE INFRA
- [x] Madre operativa (LUKS+Btrfs, GTX 1060, Tailscale)
- [x] Docker stack (contenedores, healthchecks)
- [x] GitHub repos (yggdrasil-dew, thdora-personal)
- [x] n8n operativo
- [x] Ollama con modelos locales
- [x] Open WebUI
- [x] Qdrant desplegado
- [x] Gitea (mirror local)

### FASE BOTS
- [x] yggdrasilwatchdog — monitor de contenedores
- [x] guardianbot — notificaciones Telegram
- [x] networkradar — escaneo LAN
- [x] tailscalemonitor — estado nodos Tailscale
- [x] logguardianbot — auth.log / ufw.log
- [x] localtripwire — detección cambios ficheros

### FASE DOCS Y CI/CD
- [x] yggdrasil-dew como second brain
- [x] ROADMAP-MASTER.md
- [x] CONVENCIONES.md
- [x] ecosystem-guardian.yml (auditoría nocturna)
- [x] new-file-bootstrap.yml (headers automáticos)
- [x] bge-m3 + RAG base configurado

### FASE thdora-personal (antes: thdora)
- [x] API FastAPI operativa
- [x] Bot Telegram single-user
- [x] Docker healthcheck resuelto (issue #17)
- [x] Alembic migrations
- [ ] F10 Multi-usuario — BLOQUEADOR ACTIVO

---

## 🔴 PRÓXIMAS FASES (post-Agentes)

### FASE SOC / SEGURIDAD
- [ ] Wazuh homelab setup
- [ ] Suricata IDS de red
- [ ] Threat model del ecosistema
- [ ] UFW rules audit automatizado
- [ ] Pentest interno de la infra

### FASE ROADMAP-AGÉNTICO
- [ ] Agente roadmap — lee ROADMAP-MASTER.md y avanza tareas [AUTO]
- [ ] Agente research — investiga y actualiza docs
- [ ] Multi-agent orchestration con n8n como bus
- [ ] A2A protocol (Google) para comunicación entre agentes

### FASE thdora-personal MULTI-USUARIO (F10+)
- [ ] F10 Multi-usuario (BLOQUEADOR)
- [ ] F11 Scheduler APScheduler
- [ ] F12 IA lenguaje natural
- [ ] F13 Análisis IA hábitos
- [ ] F14 Llamadas Twilio
- [ ] F15 Voz Whisper
- [ ] F16 Onboarding completo

---

## 📅 Historial de sesiones

| Fecha | Hito |
|---|---|
| 2026-06-27 | Sesión Gemini — auditoría ecosistema base |
| 2026-06-28 | Auditoría completa + inventario islas |
| 2026-06-30 | Cierre sesión + estado thdora |
| 2026-07-01 | Gemini auditoría ecosistema V2 |
| 2026-07-02 | Auditoría herramientas GitHub + migración inbox |
| 2026-07-03 | **Diseño arquitectura agentes + MCP server + rename thdora-personal** |

---

*Última actualización: 2026-07-03 · Fase activa: AGENTES*
