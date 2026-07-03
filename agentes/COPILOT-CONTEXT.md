---
tipo: copilot-context
version: 1.0
fecha: 2026-07-03
destino: GitHub Copilot (Cursor, VS Code, GitHub.com)
---

# Contexto para GitHub Copilot

> Este fichero es el briefing para Copilot.
> Leelo entero antes de sugerir cualquier cambio.

---

## Para qué sirve este repo

`yggdrasil-dew` es el **cerebro operativo** del ecosistema personal de Álvaro.
No es un proyecto de software convencional.
Es un sistema vivo: se monitoriza solo, documenta solo, crea sus propios issues.

---

## Reglas absolutas para Copilot

1. **No generes código de producción en main directamente.**
2. Propuestas de código → en branch `copilot/` o `agent/`.
3. **No borres ficheros existentes.** Solo archiva.
4. Respeta el esquema de etiquetas: `[AUTO]`, `[HUMAN]`, `[RISKY]`.
5. Scripts en `scripts/` son herramientas/sensores, NO generan lógica de negocio.
6. Si no estás seguro → crea un issue `[HUMAN]` en vez de actuar.

---

## Mapa del repo para Copilot

```
yggdrasil-dew/
├── agentes/                   ← todo sobre agentes AI
│   ├── MACRO-SPEC-ECOSISTEMA.md  ← la biblia del ecosistema
│   ├── REGLAS-AGENTES.md         ← reglas obligatorias
│   ├── COPILOT-CONTEXT.md        ← este fichero
│   ├── AI-CONTEXT.md             ← contexto para todas las IAs
│   ├── PLAN-ESTADO-ACTUAL.md     ← qué está hecho y qué falta
│   ├── mcp-server/               ← MCP server (en construcción)
│   └── ecosystem-snapshot/       ← n8n workflow del health-agent
├── scripts/
│   ├── issue-creator.sh          ← crea issues auto analizando el repo
│   ├── task-analyzer.sh          ← detecta tareas repetidas
│   ├── cierre-sesion.sh
│   ├── apertura-sesion.sh
│   └── maintenance/              ← 23+ scripts de mantenimiento
├── .github/workflows/          ← 28 Actions (ahora con issue-creator)
├── inbox/                      ← entrada de información
├── diary/                      ← registro de sesiones
├── reports/                    ← informes automáticos
├── ROADMAP-MASTER.md           ← fuente de verdad del plan
└── REGISTRO-AGENTES.md         ← todos los agentes
```

---

## Cómo ayudar en este repo (tareas válidas para Copilot)

### ✅ Puedes hacer esto:
- Documentar scripts existentes (añadir cabeceras, ejemplos de uso)
- Completar el MCP server: `agentes/mcp-server/mcp_server.py`
- Añadir tools al MCP server (check_docker, write_inbox, read_roadmap)
- Crear docker-compose para health-agent
- Crear specs de agentes en `agentes/[nombre]/SPEC.md`
- Proponer mejoras en branches `copilot/`
- Mejorar el `issue-creator.sh` añadiendo nuevos analizadores
- Escribir tests (pytest) para los scripts Python

### ❌ Nunca hagas esto:
- Merge a main sin PR aprobado
- Modificar ROADMAP-MASTER.md directamente
- Borrar ficheros de diary/ o inbox/archive/
- Cambiar etiquetas del sistema de issues
- Tocar la configuración de seguridad (UFW, fail2ban, SSH)

---

## Siguiente tarea prioritaria para Copilot

**Tarea 1:** Completar `agentes/mcp-server/mcp_server.py`
- Añadir tool `write_inbox(content: str, filename: str)`
- Añadir tool `read_roadmap() -> str`
- Añadir tool `list_issues(label: str) -> list`
- Añadir `docker-compose.yml` en `agentes/mcp-server/`

**Tarea 2:** Documentar los 5 scripts de maintenance más grandes
- `ecosystem-reality-check.sh` (12KB)
- `repo-analyzer.sh` (7.9KB)
- `macro-noche.sh` (5.7KB)
- `morning-check.sh` (5.7KB)
- `new-session.sh` (5.6KB)

**Tarea 3:** Crear `scripts/lib/common.sh` con funciones reutilizables
- `log()`, `error()`, `create_issue()`, `check_dependency()`

---

## Estilo de código del repo

- Bash: `set -euo pipefail` obligatorio. Funciones en snake_case. Log con timestamp.
- Python: type hints, dataclasses, no globals. FastAPI para servicios.
- YAML: 2 espacios, comentarios en cabecera describiendo el workflow.
- Markdown: frontmatter YAML, headers con `##`, listas con `-`.
- Commits: `feat|fix|docs|chore|refactor(scope): mensaje [AUTO|HUMAN]`

---

*Última actualización: 2026-07-03 [AUTO]*
