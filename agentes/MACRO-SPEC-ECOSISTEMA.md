# 🧠 MACRO-SPEC DEL ECOSISTEMA YGGDRASIL

**Versión:** 2026-07-03 — Integrado con COPILOT-CONTEXT.md  
**Repo destino:** `yggdrasil-dew/agentes/MACRO-SPEC-ECOSISTEMA.md`

---

## 0. 📌 Propósito del documento

Este documento define:
- La filosofía del ecosistema Yggdrasil.
- La estructura real por repos.
- La arquitectura de agentes.
- El MCP server de última generación.
- El lenguaje correcto para IA.
- El laboratorio de agentes (LAB-AGENTES).
- El clon operativo Álvaro-agent.
- El agente Obsidian.
- El roadmap de 4 semanas.
- Las fuentes internas que gobiernan el sistema.

Es la biblia del ecosistema, y Copilot debe leerla antes de actuar.

---

## 1. 🧩 Filosofía del ecosistema

### 1.1. Principios fundamentales

- **Autonomía con límites**: Los agentes actúan solos, pero solo en tareas `[AUTO]`. Nunca tocan producción, nunca hacen merge, nunca borran.
- **Transparencia radical**: Todo se documenta — Markdown (diarios, informes, sesiones), Audit log en MCP, RAG sobre el historial (Qdrant + bge-m3).
- **Responsabilidad humana**: Tareas `[HUMAN]` y `[RISKY]` requieren tu decisión. `CRITICAL` → pausa + Telegram.
- **Memoria responsable**: El sistema recuerda lo necesario para operar y aprender. Evita acumular datos sensibles sin propósito claro.
- **Experimentación controlada (LAB-AGENTES)**: Agentes nuevos se prueban en entorno de laboratorio. No tocan producción hasta estar validados.

---

## 2. 🧠 Lenguaje correcto con la IA

### 2.1. Reglas de lenguaje

- **Etiquetas**: `[AUTO]`, `[HUMAN]`, `[RISKY]`, `CRITICAL`
- **Instrucciones**: "NUNCA tocar producción.", "SIEMPRE dry_run.", "SIEMPRE documentar."
- **Estructura**: Contexto → Objetivo → Reglas → Acción → Documentación
- **Estilo**: Directo. Técnico. Sin relleno. Con rutas reales del repo.

### 2.2. Documentos que definen tu lenguaje

- `REGLAS-AGENTES.md`
- `AI-CONTEXT.md`
- `COPILOT-CONTEXT.md`
- `Tesis-y-Metodo-Sistema-de-Alineacion-Cognitiva.md`
- `Arquitectura-de-Inteligencia-Artificial-Soberana-y-Open-Source.md`

---

## 3. 📁 Estructura real del ecosistema (por repos)

### 3.1. `yggdrasil-dew` → Cerebro operativo

```
yggdrasil-dew/
├── agentes/
│   ├── MACRO-SPEC-ECOSISTEMA.md   ← este documento
│   ├── REGLAS-AGENTES.md
│   ├── COPILOT-CONTEXT.md
│   ├── AI-CONTEXT.md
│   ├── PLAN-ESTADO-ACTUAL.md
│   ├── mcp-server/
│   │   ├── DISEÑO.md
│   │   ├── mcp_server.py
│   │   └── tools/
│   ├── alvaro-agent/
│   │   ├── PERFIL-ALVARO.md
│   │   ├── DISEÑO.md
│   │   └── alvaro_agent.py
│   ├── docs-agent/
│   ├── roadmap-agent/
│   └── obsidian-agent/
│       ├── DISEÑO.md
│       ├── ingest.py
│       ├── api.py
│       └── tools/
├── scripts/
│   ├── issue-creator.sh
│   ├── task-analyzer.sh
│   ├── cierre-sesion.sh
│   ├── apertura-sesion.sh
│   └── maintenance/
├── .github/workflows/
├── inbox/
├── diary/
├── reports/
├── ROADMAP-MASTER.md
└── REGISTRO-AGENTES.md
```

### 3.2. `yggdrasil-secops` → Salud, seguridad, watchdogs

```
yggdrasil-secops/
├── health-agent/
├── security-agent/
├── optimize-agent/
└── watchdogs/
```

### 3.3. `local-brain` → RAG general + embeddings

```
local-brain/
├── ingest/
├── rag/
└── models/
```

### 3.4. `osint-stack` → OSINT + Spiderfoot

```
osint-stack/
└── agentes/osint-agent/
```

### 3.5. `thdora-personal` → Interfaz humana (Telegram)

```
thdora-personal/
├── bot/
└── api/
```

---

## 4. 🧬 Arquitectura de agentes

| Agente | Repo | Runtime | Rol |
|---|---|---|---|
| MCP server | dew | Madre | Tools + audit + reglas |
| Health-agent | secops | Docker | Salud del ecosistema |
| Roadmap-agent | dew | Actions | Ejecuta tareas [AUTO] |
| Docs-agent | dew | Actions | Documentación automática |
| OSINT-agent | osint-stack | Docker | Radar externo |
| Security-agent | secops | Docker | Seguridad |
| Optimization-agent | secops | Docker | Recursos |
| Obsidian-agent | dew | Docker | RAG sobre Obsidian |
| Álvaro-agent | dew | Docker | Clon operativo |

---

## 5. 🧩 MCP server de última generación

### 5.1. Tools actuales
- `check_docker`
- `get_ecosystem_state`
- `read_roadmap`
- `list_services`

### 5.2. Tools nuevas
- `write_inbox(content, filename)`
- `list_issues(label)`
- `restart_container(name, dry_run=True)`

### 5.3. Buenas prácticas
- Tools pequeñas, scopes explícitos.
- Audit log obligatorio en `/srv/yggdrasil-dew/logs/mcp-audit.jsonl`.
- `dry_run=True` por defecto en todas las tools destructivas.
- Compatible con Cursor, Claude Desktop, agentes locales.

---

## 6. 🧠 Health-agent + n8n

```
1. n8n → snapshot (cron cada 5min)
2. health-agent → clasificación LLM (Ollama phi3:mini)
3. Acciones:
   OK       → log Markdown
   WARN     → issue GitHub
   CRITICAL → Telegram + pausa supervisión humana
4. Log → Qdrant → RAG
```

Endpoint: `POST http://localhost:8001/health/evaluate`

---

## 7. 📚 Obsidian-agent

- Ingesta de notas `.md` desde vault Obsidian
- RAG sobre Obsidian vault (Qdrant + bge-m3)
- API `/ask`
- Tools MCP: `search_obsidian_notes`, `get_obsidian_note`, `create_obsidian_note`

---

## 8. 🧬 Álvaro-agent (clon operativo)

- `PERFIL-ALVARO.md` como base de personalidad
- RAG sobre: yggdrasil-dew, Obsidian, Tesis de alineación cognitiva
- Tools MCP: Ecosistema + Roadmap + Obsidian
- Integración con n8n y Telegram

---

## 9. 🔧 Roadmap de 4 semanas

| Semana | Objetivos |
|---|---|
| 1 | MCP server completo · Health-agent Docker · Workflow n8n importado |
| 2 | Roadmap-agent · Docs-agent |
| 3 | OSINT-agent · Security-agent |
| 4 | Obsidian-agent · Álvaro-agent · Optimization-agent |

---

## 10. 📚 Fuentes internas del ecosistema

- `REGLAS-AGENTES.md`
- `AI-CONTEXT.md`
- `COPILOT-CONTEXT.md`
- `Tesis-y-Metodo-Sistema-de-Alineacion-Cognitiva.md`
- `Arquitectura-de-Inteligencia-Artificial-Soberana-y-Open-Source.md`
- `PLAN-ESTADO-ACTUAL.md`
- `REGISTRO-AGENTES.md`
