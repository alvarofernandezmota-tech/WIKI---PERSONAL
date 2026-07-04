---
tags: [auditoria, estado, repo, estructura, pendiente]
fecha: 2026-06-23
estado: en-progreso
tipo: master-auditoria
ruta-obsidian: inbox/2026-06-23-estado-auditoria-repo.md
---

# Estado auditoría repo — 2026-06-23

> Sesión activa — auditoría completa para escalar todo al nivel de `agentes/`

## Progreso

| Carpeta | Estado | Doc inbox |
|---|---|---|
| `agentes/` | ✅ Referencia — no tocar | — |
| `proyectos/batcueva/` | ✅ Reclasificada → `setup/servidor/` | ADR homelab |
| `diarios/` | ✅ Auditada | [auditoria-diarios](2026-06-23-auditoria-diarios.md) |
| `ollama/` | ✅ Auditada | [auditoria-ollama](2026-06-23-auditoria-ollama.md) |
| `osint/` | ⏳ Pendiente | — |
| `formacion/` | ⏳ Pendiente | — |
| `tools/` + `cli-tools/` | ⏳ Pendiente | — |
| `docs/` | ⏳ Pendiente | — |
| `yo/` | ⏳ Pendiente | — |
| `setup/` | ⏳ Pendiente | — |

## Decisiones arquitectura tomadas hoy

- [x] `filosofia.md v3.0` — 3 leyes repos, ingeniero software organizado
- [x] ADR Homelab vs Proyectos — Batcueva = homelab, no proyecto
- [x] ADR docs-as-code — cómo enlazar repos Docker con cerebro
- [x] Ollama = modelos locales + RAG + Qdrant + Open WebUI
- [x] Agentes = IAs externas con API únicamente
- [x] osint/ = proyecto Docker (repo propia) + doc conocimiento en cerebro
- [x] Patrón: todo Docker → repo propia + entrada en `proyectos/` + doc en cerebro

## Repos GitHub a crear (pendiente)

- [ ] `alvarofernandezmota-tech/ollama-stack` — docker-compose Ollama+WebUI+Qdrant
- [ ] `alvarofernandezmota-tech/osint-stack` — docker-compose OSINT suite
- [ ] `alvarofernandezmota-tech/local-brain` — cerebro IA local
- [ ] `alvarofernandezmota-tech/chatbot-control` — chatbot control personal
- [ ] `alvarofernandezmota-tech/terminal-ia` — terminal con IA

## Auditorías pendientes de ejecutar

- [ ] `osint/` — listar, diagnosticar, generar plan
- [ ] `formacion/` — listar, diagnosticar, generar plan
- [ ] `tools/` + `cli-tools/` — listar, diagnosticar, reclasificar
- [ ] `docs/` — listar, diagnosticar
- [ ] `yo/` — listar, diagnosticar
- [ ] `setup/` — listar, diagnosticar, añadir `servidor/` con batcueva

## Investigar (de ADR docs-as-code)

- [ ] Obsidian Git — sincronización automática yggdrasil-dew
- [ ] Obsidian Dataview — queries estado proyectos
- [ ] GitHub submodules — referenciar repos desde cerebro
- [ ] Patrón monorepo vs multirepo para el ecosistema

## Referencias
- [[inbox/2026-06-23-decision-homelab-vs-proyectos]]
- [[inbox/2026-06-23-adr-docs-as-code-repos-cerebro]]
- [[filosofia]]
