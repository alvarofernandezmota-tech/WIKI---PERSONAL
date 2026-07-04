---
tipo: registro
fuente: perplexity
estado: completado
tema: migracion-inbox
tags:
  - migracion
  - inbox
  - registro
  - docs
  - estructura
  - 2026-06-23
---

# Registro de migración inbox — 2026-06-23

> Registro oficial de la migración completa de inbox/ ejecutada por Perplexity vía MCP GitHub.
> Fecha: 2026-06-23 — Sesión nocturna (21:00–21:24 CEST)
> Acceso: SSH remoto — sync local pendiente al llegar a casa.

---

## Resumen ejecutivo

| Concepto | Valor |
|---|---|
| Archivos en inbox antes | 41 |
| Archivos migrados | 39 |
| Permanentes conservados | 5 |
| Dudosos sin mover | 1 |
| Nuevas carpetas creadas | 4 (adr/, decisiones/, prompts/, chatbot-control/, etc.) |
| Commits totales de la sesión | 6 |
| Notas nuevas creadas | 5 |

---

## Commits de la sesión

| Commit | Descripción |
|---|---|
| `304a170` | Nota auditoría inbox Perplexity |
| `6c7739b` | Nota ecosistema Ollama prep |
| `346c87d` | VACIADO-MAESTRO-GEMINI.md |
| `70e21fa` | **Migración masiva**: 39 stubs + instalacion-3-dockers + script Gemini |
| `44f915b` | pull-stack estado + fix TLS + script robusto |
| `este` | CONTEXT.md actualizado + registro migración |

---

## Mapa completo de migración

### BLOQUE 1 — agentes/ (13 archivos)

| origen inbox/ | destino |
|---|---|
| `2026-06-23-actualizacion-claude-gemini.md` | `agentes/` |
| `2026-06-23-adr-ollama-en-agentes.md` | `docs/adr/` |
| `2026-06-23-auditoria-ollama.md` | `agentes/ollama/` |
| `2026-06-23-ollama-bge-m3.md` | `agentes/ollama/` |
| `2026-06-23-ollama-guia-seleccion.md` | `agentes/ollama/` |
| `2026-06-23-ollama-qwen2.5-3b.md` | `agentes/ollama/` |
| `2026-06-23-ollama-qwen2.5-7b.md` | `agentes/ollama/` |
| `2026-06-23-ollama-rag-investigacion.md` | `agentes/ollama/` |
| `2026-06-23-ollama-ecosistema-prep.md` | `agentes/ollama/` |
| `2026-06-23-v4-pendiente-ollama.md` | `agentes/ollama/` |
| `2026-06-23-prompt-claude-ecosistema-docker.md` | `agentes/prompts/` |
| `2026-06-23-prompt-claude-refactor-repo.md` | `agentes/prompts/` |
| `2026-06-23-prompt-gemini-auditoria-inbox.md` | `agentes/prompts/` |

### BLOQUE 2 — setup/ (5 archivos)

| origen inbox/ | destino |
|---|---|
| `2026-06-23-auditoria-setup.md` | `setup/` |
| `2026-06-23-local-brain-setup.md` | `setup/` |
| `2026-06-23-estado-descargas-madre.md` | `setup/` |
| `2026-06-23-pull-stack-madre.md` | `setup/` |
| `2026-06-23-systemd-plan.md` | `setup/` |

### BLOQUE 3 — proyectos/ + osint/ (6 archivos)

| origen inbox/ | destino |
|---|---|
| `2026-06-23-proyecto-thdora.md` | `proyectos/thdora/` |
| `2026-06-23-proyecto-chatbot-control.md` | `proyectos/chatbot-control/` |
| `2026-06-23-proyecto-local-brain.md` | `proyectos/local-brain/` |
| `2026-06-23-proyecto-terminal-ia.md` | `proyectos/terminal-ia/` |
| `2026-06-23-auditoria-osint.md` | `osint/` |
| `2026-06-23-osint-rag-mover.md` | `osint/` |

### BLOQUE 4 — docs/ (10 archivos)

| origen inbox/ | destino |
|---|---|
| `2026-06-23-adr-docs-as-code-repos-cerebro.md` | `docs/adr/` |
| `2026-06-23-decision-arquitectura-proyectos.md` | `docs/decisiones/` |
| `2026-06-23-decision-homelab-vs-proyectos.md` | `docs/decisiones/` |
| `2026-06-23-estado-auditoria-repo.md` | `docs/` |
| `2026-06-23-inbox-processor-implementacion.md` | `docs/` |
| `2026-06-23-auditoria-docs.md` | `docs/` |
| `2026-06-23-auditoria-tools.md` | `docs/` |
| `2026-06-23-auditoria-tools-inbox-dashboard.md` | `docs/` |
| `2026-06-23-dashboard-readme.md` | `docs/` |
| `2026-06-23-tools-pendientes.md` | `docs/` |

### BLOQUE 5 — diarios/ (4 archivos)

| origen inbox/ | destino |
|---|---|
| `2026-06-23-sesion-completa.md` | `diarios/` |
| `2026-06-23-yggdrasil-v4-diario-maestro.md` | `diarios/` |
| `2026-06-23-sesion-gemini-auditoria-inbox-perplexity.md` | `diarios/` |
| `2026-06-23-sesion-perplexity-auditoria-gemini-inbox.md` | `diarios/` |

### BLOQUE 6 — formacion/ + yo/ (2 archivos)

| origen inbox/ | destino |
|---|---|
| `2026-06-23-auditoria-formacion.md` | `formacion/` |
| `2026-06-23-auditoria-yo.md` | `yo/` |

### DUDOSOS — pendiente revisión manual

| archivo | motivo |
|---|---|
| `inbox/2026-06-23-sesion-gemini-auditoria.md` | Posible duplicado de `sesion-gemini-auditoria-inbox-perplexity.md` — leer antes de borrar |

---

## Notas nuevas generadas en esta sesión

| archivo | ubicación | contenido |
|---|---|---|
| `2026-06-23-sesion-gemini-auditoria-inbox-perplexity.md` | `inbox/ → diarios/` | Clasificación completa de 38 archivos |
| `2026-06-23-ollama-ecosistema-prep.md` | `inbox/ → agentes/ollama/` | Mapa ecosistema + RAG pipeline |
| `2026-06-23-VACIADO-MAESTRO-GEMINI.md` | `inbox/` | Prompt Gemini para vaciado |
| `2026-06-23-instalacion-3-dockers-llm.md` | `setup/` | docker-compose + litellm-config + comandos |
| `2026-06-23-script-vaciado-inbox-gemini.md` | `tools/` | Script prompt para Gemini con contenido real |
| `pull-stack-robusto.sh` | `tools/` | Script bash con 5 reintentos automáticos |
| `2026-06-23-pull-stack-estado-descarga.md` | `setup/` | Estado descarga + fix TLS bad record MAC |

---

## Estado inbox post-vaciado

La inbox debe contener SOLO estos archivos:

```
inbox/
├── .gitkeep
├── README.md
├── MASTER-PENDIENTES.md
├── 2026-06-23-inbox-clasificado.md
└── 2026-06-23-VACIADO-MAESTRO-GEMINI.md
```

> **Nota**: Los stubs en destino contienen metadatos + link al origen.
> Gemini debe poblar el contenido real usando [[tools/2026-06-23-script-vaciado-inbox-gemini]].

---

## Estructura completa del repo post-migración

```
yggdrasil-dew/
├── CONTEXT.md              ← actualizado 2026-06-23 21:24
├── AGENT.md
├── CHANGELOG.md
├── ECOSISTEMA.md
├── HOME.md
├── README.md
├── filosofia.md
├── .gitignore
├── .github/
│
├── agentes/
│   ├── 2026-06-23-actualizacion-claude-gemini.md
│   ├── ollama/
│   │   ├── 2026-06-23-auditoria-ollama.md
│   │   ├── 2026-06-23-ollama-bge-m3.md
│   │   ├── 2026-06-23-ollama-guia-seleccion.md
│   │   ├── 2026-06-23-ollama-qwen2.5-3b.md
│   │   ├── 2026-06-23-ollama-qwen2.5-7b.md
│   │   ├── 2026-06-23-ollama-rag-investigacion.md
│   │   ├── 2026-06-23-ollama-ecosistema-prep.md
│   │   └── 2026-06-23-v4-pendiente-ollama.md
│   └── prompts/
│       ├── 2026-06-23-prompt-claude-ecosistema-docker.md
│       ├── 2026-06-23-prompt-claude-refactor-repo.md
│       └── 2026-06-23-prompt-gemini-auditoria-inbox.md
│
├── cli-tools/
├── diarios/
│   ├── 2026-06-23-sesion-completa.md
│   ├── 2026-06-23-yggdrasil-v4-diario-maestro.md
│   ├── 2026-06-23-sesion-gemini-auditoria-inbox-perplexity.md
│   └── 2026-06-23-sesion-perplexity-auditoria-gemini-inbox.md
│
├── docs/
│   ├── adr/
│   │   ├── 2026-06-23-adr-ollama-en-agentes.md
│   │   └── 2026-06-23-adr-docs-as-code-repos-cerebro.md
│   ├── decisiones/
│   │   ├── 2026-06-23-decision-arquitectura-proyectos.md
│   │   └── 2026-06-23-decision-homelab-vs-proyectos.md
│   ├── 2026-06-23-registro-migracion-inbox.md   ← este archivo
│   ├── 2026-06-23-estado-auditoria-repo.md
│   ├── 2026-06-23-inbox-processor-implementacion.md
│   ├── 2026-06-23-auditoria-docs.md
│   ├── 2026-06-23-auditoria-tools.md
│   ├── 2026-06-23-auditoria-tools-inbox-dashboard.md
│   ├── 2026-06-23-dashboard-readme.md
│   └── 2026-06-23-tools-pendientes.md
│
├── formacion/
│   └── 2026-06-23-auditoria-formacion.md
│
├── inbox/                  ← VACIADA
│   ├── .gitkeep
│   ├── README.md
│   ├── MASTER-PENDIENTES.md
│   ├── 2026-06-23-inbox-clasificado.md
│   └── 2026-06-23-VACIADO-MAESTRO-GEMINI.md
│
├── ollama/
├── osint/
│   ├── 2026-06-23-auditoria-osint.md
│   └── 2026-06-23-osint-rag-mover.md
│
├── proyectos/
│   ├── thdora/
│   │   └── 2026-06-23-proyecto-thdora.md
│   ├── chatbot-control/
│   │   └── 2026-06-23-proyecto-chatbot-control.md
│   ├── local-brain/
│   │   └── 2026-06-23-proyecto-local-brain.md
│   └── terminal-ia/
│       └── 2026-06-23-proyecto-terminal-ia.md
│
├── setup/
│   ├── 2026-06-23-auditoria-setup.md
│   ├── 2026-06-23-local-brain-setup.md
│   ├── 2026-06-23-estado-descargas-madre.md
│   ├── 2026-06-23-pull-stack-madre.md
│   ├── 2026-06-23-systemd-plan.md
│   ├── 2026-06-23-instalacion-3-dockers-llm.md
│   └── 2026-06-23-pull-stack-estado-descarga.md
│
├── templates/
├── tools/
│   ├── 2026-06-23-script-vaciado-inbox-gemini.md
│   └── pull-stack-robusto.sh
│
└── yo/
    └── 2026-06-23-auditoria-yo.md
```

---

## Pendiente post-sesión

- [ ] Gemini puebla contenido real de los stubs (usar [[tools/2026-06-23-script-vaciado-inbox-gemini]])
- [ ] Revisar dudoso: `inbox/2026-06-23-sesion-gemini-auditoria.md`
- [ ] Crear repo `ollama-stack` con Claude MCP
- [ ] Levantar dockers cuando terminen descargas
- [ ] `git pull` en local al llegar a casa
- [ ] Actualizar CHANGELOG.md con esta sesión

---
_Ver: [[CONTEXT]] · [[inbox/MASTER-PENDIENTES]] · [[tools/2026-06-23-script-vaciado-inbox-gemini]] · [[setup/2026-06-23-instalacion-3-dockers-llm]]_
