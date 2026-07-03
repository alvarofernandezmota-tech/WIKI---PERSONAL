---
tags: [roadmap, fases, planificacion]
fecha-actualizacion: 2026-07-03T05:49
---

# 🗺️ ROADMAP — Ecosistema yggdrasil-dew

> Actualizado: 03-jul-2026 05:49 CEST
> SSOT de fases y objetivos. Para tareas detalladas ver MASTER-PENDIENTES.md

---

## Visión

Construir un ecosistema tecnológico personal soberano:
- Infraestructura propia y segura (Madre como home lab)
- IA local y conectada (Ollama + RAG + agentes)
- Automatización total vía bots y GitHub Actions
- Acceso móvil completo desde cualquier lugar
- Documentación viva y automática

---

## 🔴 FASE 1 — Seguridad base Madre
**Estado: 90% — Issue #3**

Objetivo: Madre es inaccesible desde el exterior salvo Tailscale.

- [x] UFW activo con reglas estrictas
- [x] fail2ban jail sshd
- [x] Tailscale VPN autoarranque
- [ ] SSH: solo clave pública, password deshabilitado
- [ ] Auditoría final puertos expuestos

---

## 🔴 FASE 2 — GitHub profesional
**Estado: 70% — Issue #10**

Objetivo: El repo tiene nivel senior real.

- [x] CONVENCIONES.md nivel senior
- [x] AGENT.md completo
- [x] CONTRIBUTING.md
- [x] Issue templates (.github/ISSUE_TEMPLATE/)
- [ ] PR template
- [ ] Labels personalizados (20+)
- [ ] Milestones por fase (0–9)
- [ ] CODEOWNERS
- [ ] CHANGELOG.md formato Keep a Changelog
- [ ] Profile README repo (alvarofernandezmota-tech)
- [ ] Pinear repos relevantes

---

## 🔴 FASE 3 — Governance repo
**Estado: 50% — Issue #10**

Objetivo: Todos los archivos del repo están actualizados, enlazados y tienen frontmatter.

- [x] CONVENCIONES.md auditado
- [x] CONTEXT.md actualizado
- [x] MASTER-PENDIENTES.md SSOT
- [ ] HOME.md con árbol visual real
- [ ] ECOSISTEMA.md referencias cruzadas completas
- [ ] ESTADO-SISTEMA.md en tiempo real
- [ ] ROADMAP.md SSOT (este fichero)
- [ ] Frontmatter en todos los .md (needs-terminal)
- [ ] Migración estructura: diarios/, cli-tools/, mocs/, setup/, thdora/ → destinos correctos

---

## 🔴 FASE 4 — Stack técnico Madre
**Estado: 10% — Issue #9**

Objetivo: Madre tiene el stack completo corriendo y seguro.

- [ ] Hardening batcueva (0.0.0.0 → Tailscale only)
- [ ] Wazuh: fix vm.max_map_count + despliegue
- [ ] Suricata IDS activo
- [ ] Kali KasmWeb accesible vía Tailscale
- [ ] Pihole DNS privado
- [ ] SearXNG instancia privada
- [ ] start-batcueva.sh ejecutado y estable

---

## 🟡 FASE 5 — GitHub Actions
**Estado: 30% — Issue #11**

Objetivo: La repo se gestiona sola. Bots automatizan commits, docs e historial.

- [x] lint-commits.yml (draftado)
- [x] update-diario-index.yml (draftado)
- [x] context-reminder.yml (draftado)
- [x] repo-health-check.yml (draftado)
- [x] update-perplexity-docs.yml (draftado)
- [ ] Desplegar todos desde Thdora
- [ ] Configurar branch protection

---

## 🟡 FASE 6 — Thdora Guardián + n8n
**Estado: 20% — Issue #12**

Objetivo: Thdora Guardián monitoriza Madre y alerta vía Telegram.

- [x] Thdora FastAPI base corriendo
- [ ] Handlers: /estado, /inbox, /pendientes
- [ ] n8n hardening (0.0.0.0 → Tailscale)
- [ ] Flow: commit nuevo → Telegram
- [ ] Flow: Docker caído → alerta Telegram
- [ ] Fix httpx==0.27.0 en requirements.txt
- [ ] Thdora Dev bot GitHub completo

---

## 🟡 FASE 6d — Multi-IA vía n8n
**Estado: 0% — Issue #13 (pendiente crear)**

Objetivo: Gemini, DeepSeek y otras IAs pueden actuar sobre el repo vía n8n.

- [ ] Flow n8n: Gemini → webhook → GitHub API
- [ ] Flow n8n: DeepSeek → webhook → GitHub API
- [ ] Token PAT GitHub en n8n secrets
- [ ] Prueba end-to-end: Gemini crea issue en yggdrasil-dew

---

## 🟡 FASE 7 — Ollama + RAG
**Estado: 20% — Issue #14 (pendiente crear)**

Objetivo: Agente local que lee la repo y responde preguntas sobre el ecosistema.

- [x] qwen2.5:7b descargado
- [x] qwen2.5:3b descargado
- [ ] llama3.1:8b pull
- [ ] bge-m3 pull (embeddings)
- [ ] nomic-embed-text pull
- [ ] Qdrant desplegado en Madre
- [ ] RAG funcional sobre docs/
- [ ] Agente autónomo v1

---

## 🟡 FASE 8 — MCP server propio en Madre
**Estado: 0% — Issue #15 (pendiente crear)**

Objetivo: Cualquier IA (Claude, Cursor, Ollama) conecta directamente a Madre vía MCP.

- [ ] Instalar Node.js/Python MCP server en Madre
- [ ] Configurar github-mcp-server o servidor propio
- [ ] Conectar Claude Desktop → MCP Madre
- [ ] Conectar Cursor → MCP Madre
- [ ] Prueba end-to-end: Claude crea issue desde terminal

---

## 🟡 FASE 9 — Mobile completo
**Estado: 30% — Issue #8**

Objetivo: SSH desde iPhone a Madre, Tailscale en todos los dispositivos.

- [x] Tailscale iPhone activo
- [ ] Termius iPhone configurado
- [ ] SSH funcional iPhone → Madre
- [ ] Tailscale Redmi A5

---

## 🟢 THDORA — Deuda técnica (Sprint actual)

> Auditado 2026-07-03. Cerrado en sesión mañana.

- [x] **#10** — Fix timeout /config: `asyncio.wait_for(timeout=5.0)` + bugs B22-B25 corregidos ✅
- [x] **#12** — Código zombie: `src/bot/agents/` eliminado, `ollama_router.py` y `llm_backend.py` eliminados ✅
- [x] Pipeline NLP 3 niveles funcional: regex → Ollama local → Groq cloud ✅
- [ ] **Sprint 6** — Implementar `MessageLog` real (memoria a largo plazo en scheduler_tasks.py)
- [ ] **Sprint 6** — Tests de regresión de handlers
- [ ] `pytest` no instalado en Madre — añadir a requirements-dev.txt

> Ver también: [issue #26 en yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/26) — espejo maestro de deuda thdora

---

## Próximos hitos

| Hito | Fases | Cuándo |
|---|---|---|
| Madre 100% segura | 1 | Próxima sesión terminal |
| Repo nivel senior completo | 2+3 | Próxima sesión terminal |
| Stack completo desplegado | 4+5 | Esta semana |
| Bots operativos | 6+6d | Esta semana |
| IA local funcional | 7+8 | Próximo sprint |
| Mobile completo | 9 | Próximo sprint |

---

_Actualizado: 03-jul-2026 05:49 CEST — Perplexity vía MCP — deuda thdora cerrada_
