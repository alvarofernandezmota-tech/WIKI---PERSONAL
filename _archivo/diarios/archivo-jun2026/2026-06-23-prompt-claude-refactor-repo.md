---
tags: [prompt, claude, refactor, arquitectura, ingenieria-software, plan]
fecha: 2026-06-23
estado: listo-para-ejecutar
tipo: prompt-agente
agente: claude-sonnet
ruta-obsidian: inbox/2026-06-23-prompt-claude-refactor-repo.md
---

# Prompt para Claude — Refactor repo nivel ingeniero de software

> 📌 Guardar como chat en Claude con acceso MCP al repo `yggdrasil-dew`
> Usar para escalar cada parte de la repo por separado

---

## CONTEXTO DEL REPO

Este repo se llama `yggdrasil-dew` y es mi **cerebro digital** (second brain) como ingeniero de software. Está en proceso de escalarse al nivel profesional de un ingeniero de software bien organizado.

La referencia de calidad es `agentes/` — ese es el nivel al que hay que llevar todo.

### Estructura actual

```
yggdrasil-dew/
  .github/
  AGENT.md
  CHANGELOG.md
  CONTEXT.md
  ECOSISTEMA.md
  HOME.md
  README.md
  filosofia.md          ← v3.0 — 3 leyes + ingeniero software
  agentes/              ← ✅ REFERENCIA — NO tocar
  cli-tools/
  diarios/
  docs/
  formacion/
  inbox/                ← todo nuevo entra aquí primero
  ollama/
  osint/
  proyectos/
  setup/
  templates/
  tools/
  yo/
```

### Decisiones ADR ya tomadas (NO cambiar)

1. `agentes/` = IAs externas con API únicamente
2. `ollama/` = todo lo local (modelos, RAG, Qdrant, Open WebUI)
3. `setup/servidor/` = homelab Batcueva (Docker, Madre, scripts, systemd)
4. `proyectos/` = solo productos con repo GitHub propia
5. `osint/` = conocimiento en cerebro + repo `osint-stack` futura
6. Todo Docker → repo GitHub propia + entrada `proyectos/` + doc en cerebro

### Las 3 leyes (filosofia.md v3.0)

- **Ley 1**: Nunca duplicar — siempre enlazar con wikilinks
- **Ley 2**: Todo nuevo entra por `inbox/`
- **Ley 3**: Infraestructura ≠ Producto

### Auditorías ya en inbox

- `diarios/` → `inbox/2026-06-23-auditoria-diarios.md`
- `ollama/` → `inbox/2026-06-23-auditoria-ollama.md`
- `osint/` → `inbox/2026-06-23-auditoria-osint.md`
- `formacion/` → `inbox/2026-06-23-auditoria-formacion.md`
- `tools/` + `cli-tools/` → `inbox/2026-06-23-auditoria-tools.md`
- `docs/` → `inbox/2026-06-23-auditoria-docs.md`
- `yo/` → `inbox/2026-06-23-auditoria-yo.md`
- `setup/` → `inbox/2026-06-23-auditoria-setup.md`

### Pendiente auditar

- `templates/` — ¿conectada con Templater Obsidian?
- Archivos raíz: `HOME.md`, `ECOSISTEMA.md`, `CONTEXT.md`, `AGENT.md`
- `.obsidian/` workspace — NO existe aún → hay que crearlo

---

## TAREAS

### TAREA 1 — Auditar lo pendiente

Revisa el contenido actual de `templates/`, `HOME.md`, `ECOSISTEMA.md`,
`CONTEXT.md`, `AGENT.md`, `proyectos/`, `setup/`, `yo/`, `formacion/`,
`tools/`, `cli-tools/`.

Para cada uno: diagnóstico + plan de mejora al nivel de `agentes/`.
Guarda cada plan en `inbox/2026-06-23-auditoria-NOMBRE.md`.

### TAREA 2 — Crear `.obsidian/` workspace

Crea `.obsidian/` con configuración profesional:
- `app.json` — wikilinks activados, attachments, daily notes → `diarios/2026/MM/`
- `graph.json` — graph view con filtros por carpeta
- Plugins: Obsidian Git, Dataview, Templater, Calendar

El vault root = raíz del repo para que todos los `[[wikilinks]]` funcionen.

### TAREA 3 — Actualizar archivos raíz

Actualiza `HOME.md` y `ECOSISTEMA.md` con:
- Wikilinks a todas las carpetas con nueva arquitectura
- Estado homelab (Docker corriendo / pendiente)
- Proyectos activos con links repos GitHub
- Reflejo de decisiones ADR de hoy

### TAREA 4 — Plan maestro de ejecución

Genera `inbox/2026-06-23-plan-maestro-ejecucion.md` con:
- Lista ordenada por prioridad
- Estimación complejidad (fácil / medio / difícil)
- Orden lógico (qué depende de qué)
- Qué se puede hacer YA vs qué requiere instalar cosas

### TAREA 5 — Convenciones del sistema

Crea `docs/CONVENCIONES.md` con:
- Naming conventions (fecha-tema.md, MAYUSCULAS para docs maestros)
- Frontmatter YAML obligatorio por tipo
- Cómo usar wikilinks
- Flujo inbox: procesar y mover archivos
- Cómo crear nueva carpeta al nivel de `agentes/`

---

## RESTRICCIONES

- NO tocar `agentes/` — es la referencia perfecta
- NO mover archivos del inbox sin confirmación
- Todos los docs con frontmatter YAML completo
- Siempre wikilinks `[[ruta/archivo]]` nunca URLs relativas
- Respetar las 3 leyes de `filosofia.md`
- Commit message descriptivo por cada acción

---

## REPOS DEL ECOSISTEMA

| Repo | Estado | Tipo |
|---|---|---|
| `alvarofernandezmota-tech/yggdrasil-dew` | ✅ activo | cerebro |
| `alvarofernandezmota-tech/thdora` | ✅ activo | proyecto |
| `alvarofernandezmota-tech/ai-toolkit` | ✅ activo | proyecto |
| `alvarofernandezmota-tech/ollama-stack` | 🔴 pendiente crear | docker |
| `alvarofernandezmota-tech/osint-stack` | 🔴 pendiente crear | docker |
| `alvarofernandezmota-tech/local-brain` | 🔴 pendiente crear | proyecto |
| `alvarofernandezmota-tech/chatbot-control` | 🔴 pendiente crear | proyecto |
| `alvarofernandezmota-tech/terminal-ia` | 🔴 pendiente crear | proyecto |

---

_Generado por Perplexity · sesión 2026-06-23 · usar con Claude + acceso MCP a yggdrasil-dew_
