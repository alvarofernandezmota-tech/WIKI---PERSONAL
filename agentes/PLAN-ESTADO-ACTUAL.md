---
tipo: plan-estado
version: 1.0
fecha: 2026-07-03
tags: [plan, estado, roadmap, issues]
---

# Plan y Estado Actual del Ecosistema

> Este fichero es la fuente de verdad del estado del plan.
> Se actualiza al cerrar cada sesión.

---

## Fase 1 — Fundamentos ✅ COMPLETADA

- [x] Hardening seguridad base (UFW, SSH, fail2ban)
- [x] Stack batcueva (Portainer, n8n, Ollama, Qdrant, Open WebUI)
- [x] Backup Restic + scripts mantenimiento
- [x] ROADMAP-MASTER.md
- [x] REGLAS-AGENTES.md

## Fase 2 — Automatización GitOps ✅ COMPLETADA

- [x] 27 GitHub Actions activas
- [x] Inbox pipeline completo (entrada → clasificación → diary → archivo)
- [x] Scripts cierre/apertura de sesión
- [x] Scripts mantenimiento (inbox-audit-cleanup, ecosystem-reality-check, repo-analyzer)
- [x] Cron autónomo 24/7 (autonomous-cron.yml)
- [x] Macro-spec ecosistema (MACRO-SPEC-ECOSISTEMA.md)
- [x] AI-CONTEXT.md para Gemini/Copilot

## Fase 3 — Agentes Core 🔨 EN PROGRESO

- [ ] **MCP server corriendo en Madre** ← SIGUIENTE PASO
  - Archivo: `agentes/mcp-server/mcp_server.py` (esqueleto listo)
  - Falta: docker-compose, despliegue, test
- [ ] **health-agent en Docker** ← SIGUIENTE PASO
  - Archivo: `agentes/ecosystem-snapshot/` (esqueleto listo)
  - Falta: docker-compose, conectar con n8n
- [ ] **ecosystem-snapshot en n8n** ← importar workflow JSON
  - Archivo: `agentes/ecosystem-snapshot/n8n-workflow.json`

## Fase 4 — Agentes de Docs y Roadmap ❌ PENDIENTE (Semana 2)

- [ ] Roadmap-agent (GitHub Actions)
- [ ] Docs-agent (GitHub Actions)

## Fase 5 — Agentes de Investigación y Seguridad ❌ PENDIENTE (Semana 3)

- [ ] OSINT-agent (Docker + Spiderfoot + n8n)
- [ ] Security-agent (Docker + n8n + logs)

## Fase 6 — Agentes Avanzados ❌ PENDIENTE (Semana 4)

- [ ] Obsidian-agent (Docker + RAG + MCP)
- [ ] PERFIL-ALVARO.md
- [ ] Álvaro-agent (Docker + RAG + MCP + n8n)
- [ ] Optimization-agent (métricas + recomendaciones)

---

## Regla de oro sobre quién genera código

| Actor | Puede generar código | Dónde |
|-------|---------------------|-------|
| Álvaro + Cursor/Copilot/Gemini | Sí | Localmente, en branches |
| Scripts `[AUTO]` | NO (solo docs, reports, issues) | GitHub Actions |
| health-agent | Solo propuestas en branches `agent/` | Nunca a main |
| roadmap-agent | Solo actualizaciones ROADMAP | Branch + PR |

Los scripts son sensores y orquestadores. Los humanos + IAs asistidas generan el código.

---

## Issues pendientes de crear [AUTO]

- [ ] `[FASE3] Desplegar MCP server en Madre` — alta prioridad
- [ ] `[FASE3] Desplegar health-agent en Docker` — alta prioridad
- [ ] `[FASE3] Importar ecosystem-snapshot en n8n` — alta prioridad
- [ ] `[FASE4] Roadmap-agent implementation`
- [ ] `[FASE4] Docs-agent implementation`

---

*Última actualización: 2026-07-03 [AUTO]*
