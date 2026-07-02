---
tags: [diario, sesion, perplexity, mcp, fase2, documentacion]
fecha: 2026-07-02
hora-inicio: 19:30
hora-fin: 19:54
maquina: theodora (Acer)
estado: cerrado
---

# 📓 Diario — 02-jul-2026 — Sesión tarde

> Sesión de documentación y avance de fases vía Perplexity + MCP GitHub.
> Todo ejecutado remotamente desde Perplexity sin tocar terminal.

---

## ✅ Completado esta sesión

### 1. Inbox vaciado — 22 ficheros cristalizados

Todos los ficheros del inbox (25-jun → 02-jul) movidos a `inbox/procesado/` y cristalizados en sus destinos definitivos:

| Destino | Contenido |
|---|---|
| `hardware/acer.md` | Bluetooth Theodora resuelto + comandos |
| `docs/infra/bluetooth-arch.md` | Diagnóstico bluez 5.86 Arch Linux |
| `docs/herramientas/chromium-perplexity.md` | Conectores Perplexity no persisten en Chromium 148 |
| `docs/infra/fase1-seguridad.md` | Estado real Fase 1 + SSH hardening pendiente |
| `docs/infra/engineering-excellence.md` | Auditoría 4 pilares (IaC, SecOps, MLOps, Observabilidad) |
| `docs/infra/procedimiento-madre.md` | Procedimiento 8 bloques con estado por bloque |

### 2. Fase 2 GitHub profesional — 70%

| Fichero | Estado |
|---|---|
| `.github/ISSUE_TEMPLATE/bug.md` | ✅ Creado |
| `.github/ISSUE_TEMPLATE/task.md` | ✅ Creado |
| `.github/ISSUE_TEMPLATE/security.md` | ✅ Creado |
| `.github/PULL_REQUEST_TEMPLATE.md` | ✅ Creado |
| `docs/github/labels.md` | ✅ Labels doc + script `gh` CLI |
| `MASTER-PENDIENTES.md` | ✅ Actualizado con 7 fases y estado real |

Pendiente Fase 2: crear labels en GitHub UI/CLI + Profile README.

### 3. docs/herramientas/perplexity.md — creado

Documentación completa de Perplexity como herramienta:
- Tabla de motores LLM disponibles (Claude, GPT-4o, Gemini, Grok, Sonar, DeepSeek)
- Cuándo usar cada motor
- Cómo funciona el MCP (por sesión + cuenta, no por motor)
- Uso con @GitHub y problema Chromium
- Spaces y contexto persistente

---

## 💬 Conceptos aclarados esta sesión

### MCPs y motores LLM
- El MCP de GitHub se configura **una vez en Perplexity** y funciona con **todos los motores** (Claude, Grok, Gemini, Sonar, DeepSeek).
- El motor es el “cerebro” — las herramientas (repo, Drive, web) las aporta la plataforma Perplexity.
- Otras IAs externas (Claude.ai, Grok.com) **NO** tienen acceso al repo salvo que configures el MCP en esa plataforma también.
- El repo es la **memoria persistente** entre IAs: si le pasas el contexto de MASTER-PENDIENTES.md, cualquier IA entiende el proyecto.

### Motores recomendados para este proyecto
| Tarea | Motor |
|---|---|
| Código, scripts, infra, docs largas | Claude Sonnet 4.5 (actual) |
| Documentos enormes / logs muy largos | Gemini 2.5 Pro |
| Noticias, actualidad, respuestas rápidas | Grok 3 |
| Razonamiento / matemáticas | DeepSeek r1 |

---

## 🗓️ Estado de fases al cierre

| Fase | Estado | Pendiente crítico |
|---|---|---|
| Fase 1 — Seguridad Madre | 🟡 90% | SSH hardening (manual desde Acer) |
| Fase 2 — GitHub profesional | 🟡 70% | Labels CLI + Profile README |
| Fase 3 — Governance repo | 🔴 30% | HOME.md, ECOSISTEMA.md, ESTADO-SISTEMA.md |
| Fase 4 — Stack Madre | 🔴 0% | `start-batcueva.sh` (requiere estar en casa) |
| Fase 5 — Mobile | 🔴 0% | Tailscale + Termius iPhone |
| Fase 6 — THDORA + observabilidad | 🔴 0% | httpx fix + alertas Telegram |
| Fase 7 — GitHub Actions docs | 🔴 0% | Workflow + script Python |

---

## 🔜 Commits de esta sesión

| SHA | Contenido |
|---|---|
| `71283be` | Inbox masivo: 6 docs + 22 ficheros a procesado |
| `afe1b54` | docs/herramientas/perplexity.md creado |
| `ad6ecc7` | Fase 2: templates + labels + MASTER-PENDIENTES |

---

## ⏭️ Primera acción próxima sesión

```bash
cd ~/yggdrasil-dew && git pull --rebase
```

Luego:
1. Crear labels GitHub con script de `docs/github/labels.md`
2. Profile README profesional
3. SSH hardening Madre (cuando estés en casa)
4. Levantar stack: `sudo bash scripts/start-batcueva.sh`

---
_Cerrado: 02-jul-2026 19:54 CEST — Perplexity vía MCP_
