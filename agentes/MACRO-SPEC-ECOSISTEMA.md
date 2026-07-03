# 🧠 MACRO-SPEC DEL ECOSISTEMA YGGDRASIL

> Versión: 2026-07-03 | Biblia del ecosistema. Copilot debe leer esto antes de actuar.

---

## 0. Propósito

Este documento define la filosofía, estructura, agentes, MCP server, lenguaje correcto y roadmap del ecosistema Yggdrasil.
Es la fuente de verdad para cualquier IA que opere en este ecosistema.

---

## 1. Filosofía

- **Autonomía con límites** — Agentes actúan solos en tareas `[AUTO]`. NUNCA tocan producción, NUNCA hacen merge, NUNCA borran.
- **Transparencia radical** — Todo se documenta: Markdown, audit log MCP, RAG (Qdrant + bge-m3).
- **Responsabilidad humana** — Tareas `[HUMAN]` y `[RISKY]` requieren decisión humana. `CRITICAL` → pausa + Telegram.
- **Memoria responsable** — El sistema recuerda lo necesario para operar. Sin datos sensibles sin propósito.
- **Experimentación controlada** — Agentes nuevos se validan en LAB-AGENTES antes de producción.

---

## 2. Lenguaje correcto con la IA

### Etiquetas obligatorias

| Etiqueta | Significado |
|----------|-------------|
| `[AUTO]` | El agente puede ejecutarlo sin supervisión |
| `[HUMAN]` | Requiere decisión humana |
| `[RISKY]` | Acción con riesgo — dry_run primero |
| `CRITICAL` | Pausa + notificación Telegram |
| `[DRIFT]` | Código desviado del estándar |

### Estructura de instrucción

```
Contexto → Objetivo → Reglas → Acción → Documentación
```

### Reglas absolutas

- NUNCA tocar producción sin `dry_run` previo
- SIEMPRE `set -euo pipefail` en Bash
- SIEMPRE `source scripts/lib/common.sh`
- SIEMPRE loguear con `log()` de common.sh
- NUNCA `git add -A` — solo el fichero exacto

### Documentos que definen el lenguaje

- `agentes/REGLAS-AGENTES.md`
- `agentes/AI-CONTEXT.md`
- `agentes/COPILOT-CONTEXT.md`
- `docs/SCRIPT-REGISTRY.md`

---

## 3. Estructura del ecosistema

### 3.1 `yggdrasil-dew` — Cerebro operativo

```
yggdrasil-dew/
├── agentes/
│   ├── MACRO-SPEC-ECOSISTEMA.md   ← este documento
│   ├── REGLAS-AGENTES.md
│   ├── COPILOT-CONTEXT.md
│   ├── AI-CONTEXT.md
│   ├── PLAN-ESTADO-ACTUAL.md
│   ├── mcp-server/
│   │   ├── mcp_server.py          ← FastAPI + 5 tools
│   │   ├── docker-compose.yml     ← puerto 8002
│   │   └── requirements.txt
│   ├── health-agent/
│   │   ├── health_agent.py        ← FastAPI + Ollama
│   │   └── docker-compose.yml     ← puerto 8001
│   ├── alvaro-agent/
│   ├── docs-agent/
│   ├── roadmap-agent/
│   └── obsidian-agent/
├── scripts/
│   ├── lib/common.sh              ← librería compartida
│   ├── inbox-watcher.sh           ← daemon inotify
│   ├── ecosystem-snapshot.sh      ← genera JSON estado
│   ├── issue-creator.sh
│   ├── task-analyzer.sh
│   └── ...
├── .github/workflows/             ← 29 workflows activos
├── inbox/                         ← buzón de entrada
├── diary/
├── reports/
├── ROADMAP-MASTER.md
└── REGISTRO-AGENTES.md
```

### 3.2 `yggdrasil-secops` — Seguridad y watchdogs

```
yggdrasil-secops/
├── health-agent/
├── security-agent/
├── optimize-agent/
└── watchdogs/
    ├── yggdrasilwatchdog
    ├── networkradar
    ├── tailscalemonitor
    └── logguardianbot
```

### 3.3 Otras islas

| Repo | Rol |
|------|-----|
| `local-brain` | RAG general + embeddings + Qdrant |
| `osint-stack` | OSINT + Spiderfoot + osint-agent |
| `thdora-personal` | Interfaz Telegram (bot + API) |

---

## 4. Arquitectura de agentes

| Agente | Repo | Runtime | Rol | Estado |
|--------|------|---------|-----|--------|
| MCP server | dew | Docker :8002 | Tools + audit + reglas | 🟡 Listo para deploy |
| Health-agent | dew/secops | Docker :8001 | Salud del ecosistema | 🟡 Listo para deploy |
| Roadmap-agent | dew | Actions | Ejecuta tareas [AUTO] | 🟠 En desarrollo |
| Docs-agent | dew | Actions | Documentación automática | 🟠 En desarrollo |
| OSINT-agent | osint-stack | Docker | Radar externo | 🔴 Pendiente |
| Security-agent | secops | Docker | Seguridad | 🔴 Pendiente |
| Obsidian-agent | dew | Docker | RAG sobre Obsidian | 🔴 Pendiente |
| Álvaro-agent | dew | Docker | Clon operativo | 🔴 Pendiente |
| inbox-watcher | dew | systemd | Sensor buzón | 🟡 Listo para deploy |

---

## 5. MCP Server — Tools completas

| Tool | Endpoint | Descripción |
|------|----------|-------------|
| `write_inbox` | POST /tools/write_inbox | Escribe .md → dispara bucle |
| `read_roadmap` | GET /tools/read_roadmap | Lee ROADMAP-MASTER.md |
| `list_issues` | POST /tools/list_issues | Issues por label |
| `list_scripts` | GET /tools/list_scripts | Inventario scripts |
| `run_script` | POST /tools/run_script | Ejecuta script (dry_run default) |
| `ecosystem_health` | GET /tools/ecosystem_health | Estado rápido del sistema |

---

## 6. Flujo del bucle autónomo completo

```
Evento (push / cron / webhook / inotify / LLM)
         ↓
   Trigger (GitHub Actions / systemd / cron)
         ↓
   Script (sensor / análisis / acción) [set -euo pipefail + common.sh]
         ↓
   Agente (LLM Ollama + FastAPI) ← para decisiones
         ↓
   Acción safe [AUTO]: issue / push / telegram / docker restart
         ↓
   Log → Markdown → Qdrant RAG → memoria del sistema
         ↓
   GitHub Actions verifican drift + calidad [AUTO]
```

---

## 7. Roadmap de 4 semanas

### Semana 1 — Base operativa
- [ ] Deploy MCP server en Madre (`docker compose up -d`)
- [ ] Deploy inbox-watcher como systemd daemon
- [ ] `ecosystem-snapshot.sh` generando JSON
- [ ] Health-agent en Docker conectado a Ollama

### Semana 2 — Agentes GitOps
- [ ] Roadmap-agent ejecutando tareas [AUTO]
- [ ] Docs-agent actualizando documentación
- [ ] n8n workflow `ecosystem-snapshot` importado

### Semana 3 — Seguridad e investigación
- [ ] OSINT-agent con Spiderfoot
- [ ] Security-agent (Wazuh lite)
- [ ] RAG-second-brain-bot funcional

### Semana 4 — Agentes avanzados
- [ ] Obsidian-agent con ingestión automática
- [ ] Álvaro-agent (clon operativo)
- [ ] Optimization-agent (recursos Madre)

---

## 8. Fuentes internas del ecosistema

- `agentes/REGLAS-AGENTES.md` — Reglas absolutas de comportamiento
- `agentes/AI-CONTEXT.md` — Contexto para IAs externas
- `agentes/COPILOT-CONTEXT.md` — Constitución para GitHub Copilot
- `docs/SCRIPT-REGISTRY.md` — Mapa de todos los scripts
- `docs/INSTALACION-MADRE.md` — Guía de despliegue en varpc
- `ROADMAP-MASTER.md` — Fuente de verdad del plan
- `REGISTRO-AGENTES.md` — Estado de todos los agentes
