# MACRO-SPEC DEL ECOSISTEMA YGGDRASIL

> **Versión:** 2026-07-03 — Integrado con COPILOT-CONTEXT.md  
> **Estado:** PENDIENTE MOVER A `agentes/MACRO-SPEC-ECOSISTEMA.md` cuando carpeta exista  
> **Prioridad:** 🔴 ALTA — es la biblia del ecosistema

---

## 0. Propósito

Este documento define:
- La filosofía del ecosistema Yggdrasil
- La estructura real por repos
- La arquitectura de agentes
- El MCP server de última generación
- El lenguaje correcto para IA
- El laboratorio de agentes (LAB-AGENTES)
- El clon operativo Álvaro-agent
- El agente Obsidian
- El roadmap de 4 semanas
- Las fuentes internas que gobiernan el sistema

Es la biblia del ecosistema. Copilot debe leerla antes de actuar.

---

## 1. Filosofía del ecosistema

### Principios fundamentales

**Autonomía con límites**  
Los agentes actúan solos, pero solo en tareas [AUTO].  
Nunca tocan producción, nunca hacen merge, nunca borran.

**Transparencia radical**  
Todo se documenta: Markdown (diarios, informes, sesiones), audit log en MCP, RAG sobre el historial (Qdrant + bge-m3).

**Responsabilidad humana**  
Tareas [HUMAN] y [RISKY] requieren decisión humana.  
CRITICAL → pausa + Telegram.

**Memoria responsable**  
El sistema recuerda lo necesario para operar y aprender.  
Evita acumular datos sensibles sin propósito claro.

**Experimentación controlada (LAB-AGENTES)**  
Agentes nuevos se prueban en entorno de laboratorio.  
No tocan producción hasta estar validados.

---

## 2. Lenguaje correcto con la IA

### Reglas de lenguaje

- Usa etiquetas: `[AUTO]`, `[HUMAN]`, `[RISKY]`, `CRITICAL`
- Usa instrucciones claras: "NUNCA tocar producción", "SIEMPRE dry_run", "SIEMPRE documentar"
- Usa estructura: Contexto → Objetivo → Reglas → Acción → Documentación
- Usa estilo: directo, técnico, sin relleno, con rutas reales del repo

### Documentos que definen el lenguaje

- `REGLAS-AGENTES.md`
- `AI-CONTEXT.md`
- `COPILOT-CONTEXT.md`
- `Tesis-y-Metodo-Sistema-de-Alineacion-Cognitiva.md`
- `Arquitectura-de-Inteligencia-Artificial-Soberana-y-Open-Source.md`

---

## 3. Estructura real del ecosistema

### `yggdrasil-dew` → Cerebro operativo

```
yggdrasil-dew/
├── agentes/
│   ├── MACRO-SPEC-ECOSISTEMA.md   ← este documento (destino final)
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

### `yggdrasil-secops` → Salud, seguridad, watchdogs

```
yggdrasil-secops/
├── health-agent/
├── security-agent/
├── optimize-agent/
└── watchdogs/
```

### Otros repos

- `local-brain` → RAG general + embeddings
- `osint-stack` → OSINT + Spiderfoot
- `thdora-personal` → Interfaz humana (Telegram)

---

## 4. Arquitectura de agentes

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

## 5. MCP server — tools completas

### Tools actuales (MVP)

```python
# tools existentes
check_docker()           # estado contenedores
get_ecosystem_state()    # snapshot completo
read_roadmap()           # lee ROADMAP-MASTER.md
list_services()          # servicios activos
```

### Tools nuevas (próxima iteración)

```python
write_inbox(content, filename)   # escribe en inbox/
list_issues(label)               # issues GitHub por label
get_logs(service, lines)         # logs de servicio
run_safe_script(name)            # ejecuta script de whitelist
query_rag(question)              # pregunta al RAG
```

### Buenas prácticas

- Tools pequeñas, un solo propósito
- Scopes explícitos
- Audit log obligatorio en cada llamada
- `dry_run=True` por defecto
- Compatible con Cursor, Claude, agentes locales

---

## 6. Health-agent + n8n — bucle

```
n8n (cron 5min)
  → construye EcosystemSnapshot
  → POST /health/evaluate
  → health-agent clasifica: OK / WARN / CRITICAL
  → OK     → log Markdown → ingest Qdrant
  → WARN   → issue GitHub auto
  → CRITICAL → Telegram → espera humano
```

---

## 7. Obsidian-agent

**Funciones:**
- Ingesta de notas `.md` de Obsidian vault
- RAG sobre Obsidian (Qdrant + bge-m3)
- API `/ask` para consultas

**Tools MCP:**
- `search_obsidian_notes(query)`
- `get_obsidian_note(filename)`
- `create_obsidian_note(title, content)`

---

## 8. Álvaro-agent (clon operativo)

**Componentes:**
- `PERFIL-ALVARO.md` — personalidad, estilo, decisiones pasadas
- RAG sobre: yggdrasil-dew + Obsidian + Tesis de alineación cognitiva
- Tools MCP: ecosistema + roadmap + Obsidian
- Integración con n8n y Telegram

**Objetivo:** responder "qué haría Álvaro" cuando no estás disponible.

---

## 9. Roadmap de 4 semanas

### Semana 1 — Base operativa
- [ ] MCP server completo (5 tools MVP)
- [ ] Health-agent en Docker (docker-compose)
- [ ] Workflow n8n ecosystem-snapshot importado y activo

### Semana 2 — Automatización docs
- [ ] Roadmap-agent (lee ROADMAP-MASTER, ejecuta [AUTO])
- [ ] Docs-agent (actualiza README, diarios, reportes)

### Semana 3 — Seguridad + OSINT
- [ ] OSINT-agent (Spiderfoot + síntesis)
- [ ] Security-agent (alertas + audit)

### Semana 4 — Memoria + Identidad
- [ ] Obsidian-agent (RAG sobre vault)
- [ ] Álvaro-agent (clon operativo)
- [ ] Optimization-agent (recursos Madre)

---

## 10. Fuentes internas del ecosistema

- `agentes/REGLAS-AGENTES.md`
- `agentes/AI-CONTEXT.md`
- `agentes/COPILOT-CONTEXT.md`
- `Tesis-y-Metodo-Sistema-de-Alineacion-Cognitiva.md`
- `Arquitectura-de-Inteligencia-Artificial-Soberana-y-Open-Source.md`
- `PLAN-ESTADO-ACTUAL.md`
- `REGISTRO-AGENTES.md`

---

## 11. Quién se encarga del código real

### Flujo de implementación

```
Tu (dirección + decisión)
    ↓
Perplexity (diseño, spec, docs, inbox)
    ↓
Cursor + Copilot (código real con contexto del repo)
    ↓
Scripts (organización + escalado)
    ↓
Agentes (automatización progresiva)
```

### Reparto de roles

| Quién | Hace | No hace |
|---|---|---|
| **Tú** | Decisión, dirección, validación | Código manual repetitivo |
| **Perplexity** | Spec, diseño, docs, inbox, plan | Acceso directo a Madre |
| **Cursor** | Código real, refactor, tests | Decisiones de arquitectura |
| **Copilot** | Sugerencias inline, review | Arquitectura |
| **Scripts** | Organización, escalado, CI | Lógica compleja |
| **Agentes** | Tareas [AUTO] repetitivas | Tareas [HUMAN] o [RISKY] |

### Workflow concreto para el MCP server

1. **Perplexity** → genera el spec completo + estructura de archivos → pushea a inbox
2. **Tú** → abres Cursor en `yggdrasil-dew/agentes/mcp-server/`
3. **Cursor** → lee `DISEÑO.md` + `MACRO-SPEC` → genera `mcp_server.py` + `tools/`
4. **Tú** → `docker-compose up` en Madre → test con `mcp inspect`
5. **Scripts** → `apertura-sesion.sh` actualiza el estado → inbox recibe log

---

*Generado: 2026-07-03 17:22 CEST | Destino final: `agentes/MACRO-SPEC-ECOSISTEMA.md`*
