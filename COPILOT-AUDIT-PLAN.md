# COPILOT-AUDIT-PLAN.md — Plan maestro de auditoría del ecosistema

> **Generado:** 2026-07-04 por Perplexity  
> **Para:** GitHub Copilot / Gemini — cualquier IA con acceso al repo  
> **Objetivo:** Leer este archivo PRIMERO. Contiene el mapa completo del ecosistema,
> qué necesita auditoría, qué hay que mejorar y en qué orden hacerlo.

---

## INSTRUCCIONES PARA EL AGENTE IA

Eres un agente con acceso completo a este repositorio. Tu misión es:

1. **Leer este archivo completo antes de tocar nada**
2. **Auditar cada capa en el orden indicado** (de abajo a arriba: scripts → agentes → MCP → Actions → estructura)
3. **Para cada archivo auditado:** actualizar su contenido si está desactualizado, añadir encabezado de auditoría, y registrar el cambio en `CHANGELOG.md`
4. **No borrar nada** sin moverlo primero a `scripts/archive/` o `inbox/_meta/`
5. **Respetar las convenciones** definidas en `CONVENCIONES.md`

---

## MAPA COMPLETO DEL REPO (raíz)

```
yggdrasil-dew/
├── .github/workflows/         ← GitHub Actions (CAPA 4)
├── agentes/                   ← Agentes de terminal (CAPA 2)
├── cli-tools/                 ← Herramientas CLI propias
├── core/                      ← Lógica central del ecosistema
├── diarios/                   ← Cierres de sesión archivados (destino final)
├── docker/                    ← Configuración Docker/compose
├── docs/                      ← Documentación técnica
├── formacion/                 ← Recursos de aprendizaje
├── hardware/                  ← Config hardware (driver WiFi, etc.)
├── inbox/                     ← Zona de trabajo viva
│   ├── drop/                  ← Zona de aterrizaje (copias aquí primero)
│   ├── sesiones/              ← Logs y cierres de sesión
│   └── _meta/                 ← Reportes de auditoría
├── infra/                     ← Infraestructura (nginx, systemd, etc.)
├── investigacion/             ← Research / OSINT
├── islas/                     ← Proyectos satélite del ecosistema
├── logs/                      ← Logs del sistema
├── mcp/                       ← Servidores y config MCP
├── mocs/                      ← Maps of Content (Obsidian)
├── ollama/                    ← Config modelos Ollama
├── osint-stack/               ← Stack OSINT
├── proyectos/                 ← Proyectos activos
├── reports/                   ← Reportes generados
├── scripts/                   ← Scripts operacionales (CAPA 1) ← AUDITAR PRIMERO
├── sesiones/                  ← ⚠️ DUPLICADO de inbox/sesiones? Verificar
├── setup/                     ← Scripts de setup inicial
├── templates/                 ← Plantillas reutilizables
├── tests/                     ← Tests y smoke tests
├── thdora/                    ← Bot Thdora
├── tools/                     ← Herramientas varias
├── yo/                        ← Perfil personal / contexto del owner
├── AGENT.md                   ← Instrucciones para agentes IA
├── CHANGELOG.md               ← Registro de cambios
├── CONTEXT.md                 ← Contexto del proyecto
├── CONVENCIONES.md            ← Convenciones del repo (LEER OBLIGATORIO)
├── COPILOT-CONTEXT.md         ← Contexto específico para Copilot
├── ECOSISTEMA.md              ← Descripción del ecosistema
├── ECOSYSTEM-ARCHITECTURE.md ← Arquitectura técnica
├── ESTADO-SISTEMA.md          ← Estado actual del sistema
├── HERRAMIENTAS-ECOSISTEMA.md← Catálogo de herramientas
├── HOME.md                    ← Home page del vault
├── MAPA-ISLAS.md              ← Mapa de islas/proyectos
├── MASTER-PENDIENTES.md       ← Lista maestra de pendientes
├── PLAN-SEGURIDAD-Y-DESPLIEGUE.md
├── README.md                  ← Entrada principal
├── ROADMAP.md                 ← Roadmap general
├── ROADMAP-MASTER.md          ← Roadmap maestro
├── mcp-config.json            ← Configuración MCP
├── package.json               ← Dependencias Node
├── server.js                  ← Servidor principal
└── yggdrasil-dew              ← ⚠️ SYMLINK — verificar si es necesario
```

---

## CAPA 1 — SCRIPTS (auditar primero)

### Problemas conocidos a corregir

1. **4 archivos .md dentro de `scripts/`** que deben moverse:
   - `scripts/2026-07-03-23-05-struct-auditor-output.md` → `inbox/_meta/`
   - `scripts/2026-07-03-cierre-sesion-completo.md` → `diarios/`
   - `scripts/2026-07-03-inbox-audit-consolidado.md` → `inbox/_meta/`
   - `scripts/2026-07-03-reality-check.md` → `diarios/`

2. **Scripts duplicados a consolidar:**
   - `apertura-sesion.sh` vs `apertura-maestra.sh` → decidir canónico
   - `cierre-sesion.sh` vs `cierre-maestro.sh` → decidir canónico
   - `deploy.sh` vs `deploy-madre.sh` → decidir canónico
   - `copilot-fases.sh` vs `copilot-2fases.sh` → decidir cuál es actual
   - `auditoria-maestra.sh` vs `orquestador-unico.sh` → orquestador-unico es el nuevo canónico
   - `clasificador-maestro.sh` vs `inbox-clasificador.sh` → inbox-clasificador es el nuevo canónico

3. **Scripts a archivar** (mover a `scripts/archive/`):
   - Los duplicados que se deprecen
   - Scripts de setup único que ya se ejecutaron

### Diccionario de scripts (estado actual)

| Script | Propósito | Estado | Acción |
|--------|-----------|--------|--------|
| `01-fix-driver-rtl8188ftu.sh` | Instala driver WiFi USB RTL8188 | 🟡 setup puntual | Archivar tras verificar |
| `02-git-pull-rebase.sh` | Git pull con rebase en todos los repos | 🟢 activo | OK |
| `03-fase1-seguridad.sh` | Setup inicial de seguridad | 🟡 histórico | Archivar si ya se ejecutó |
| `04-fase2-start-batcueva.sh` | Arranca stack Batcueva | 🟢 activo | OK |
| `05-fase7-ollama-pull.sh` | Descarga modelos Ollama | 🟢 activo | OK |
| `06-verificacion-post-reboot.sh` | Verifica servicios tras reboot | 🟢 activo | OK |
| `07-fase3-restic-backup.sh` | Backup con Restic | 🟢 activo | OK |
| `08-fase6-thdora-handlers.sh` | Setup handlers Thdora | 🟡 histórico | Archivar si ya se ejecutó |
| `09-fase8-seguridad-acer.sh` | Hardening Acer | 🟡 histórico | Archivar si ya se ejecutó |
| `10-fase9-osint-stack.sh` | Instala stack OSINT | 🟡 histórico | Archivar si ya se ejecutó |
| `agent-monitor.sh` | Monitoriza agentes | 🟢 activo | OK |
| `apertura-maestra.sh` | Apertura completa del ecosistema | 🟡 duplicado | ¿Consolidar con apertura-sesion? |
| `apertura-sesion.sh` | Apertura de sesión de trabajo | 🟢 canónico | OK |
| `audit-and-migrate.sh` | Audita y migra archivos | 🟡 solapamiento | ¿Reemplazar por orquestador-unico? |
| `auditoria-maestra.sh` | Auditoría general | 🟡 solapamiento | ¿Reemplazar por orquestador-unico? |
| `batcueva-control.sh` | Control del stack | 🟢 activo | OK |
| `between-sessions.sh` | Tareas entre sesiones | 🟡 poco documentado | Auditar contenido |
| `cierre-maestro.sh` | Cierre completo | 🟡 duplicado | ¿Consolidar con cierre-sesion? |
| `cierre-sesion.sh` | Cierre de sesión | 🟢 canónico | OK |
| `clasificador-maestro.sh` | Clasificación archivos | 🟡 solapamiento | Reemplazar por inbox-clasificador |
| `code-drift-detector.sh` | Detecta drift de código | 🔴 sin auditar | Auditar: ¿qué baseline usa? |
| `copilot-2fases.sh` | Copilot 2 fases | 🔴 sin auditar | ¿Cuál es la versión actual? |
| `copilot-fases.sh` | Copilot fases | 🔴 sin auditar | ¿Cuál es la versión actual? |
| `copilot-mission-briefing.sh` | Genera briefing para Copilot | 🟢 activo | OK |
| `create-issues.sh` | Crea issues en GitHub | 🟢 activo | OK |
| `cross-ref-checker.sh` | Verifica referencias cruzadas | 🔴 sin auditar | Auditar: ¿qué cruza? |
| `deploy-madre.sh` | Deploy ecosistema madre | 🟡 duplicado | ¿Consolidar con deploy.sh? |
| `deploy.sh` | Deploy general | 🟡 duplicado | ¿Consolidar con deploy-madre? |
| `file-arrival-guardian.sh` | Valida estructura de archivos | 🟢 activo | OK |
| `inbox-clasificador.sh` | Clasifica inbox/drop/ | 🟢 nuevo canónico | OK |
| `inbox-commit.sh` | Commit rápido al inbox | 🟢 uso diario | OK |
| `orquestador-unico.sh` | Orquestador único del ecosistema | 🟢 nuevo canónico | OK |
| `session-logger.sh` | Logger de sesión terminal | 🟢 activo | OK |
| `session-terminal-doc.sh` | Doc de cierre de sesión | 🟢 activo | OK |

---

## CAPA 2 — AGENTES DE TERMINAL (`agentes/`)

### Qué hay en `agentes/` (auditar)

Cada agente debe tener:
- Un archivo `.sh` o `.py` con la lógica
- Un `README.md` propio que explique: qué hace, cómo se lanza, qué genera
- Una entrada en `scripts/SCRIPTS-AUDITORIA.md`

### Integración con IAs (Copilot / Gemini)

Para que Copilot pueda **llamar** a los scripts desde la terminal:

```bash
# Copilot puede ejecutar comandos de terminal via su extensión de VS Code
# o via GitHub Actions con workflow_dispatch

# Ejemplo: Copilot lanza auditoría completa
bash scripts/orquestador-unico.sh all

# Copilot genera briefing antes de revisar código
bash scripts/copilot-mission-briefing.sh

# Copilot clasifica archivos nuevos en inbox
bash scripts/inbox-clasificador.sh --dry-run
```

Para que **Gemini** pueda acceder via MCP:
- Ver CAPA 3 (MCP)
- El servidor MCP en `mcp/` expone los scripts como herramientas

---

## CAPA 3 — MCP (Model Context Protocol)

### Archivos a auditar

- `mcp-config.json` — configuración de servidores MCP
- `mcp/` — implementación de los servidores

### Cómo conectar Copilot al MCP

Copilot en VS Code soporta MCP desde la versión 1.99+. Para activarlo:

```json
// .vscode/settings.json
{
  "github.copilot.chat.experimental.mcpServers": {
    "yggdrasil": {
      "command": "node",
      "args": ["mcp/server.js"],
      "env": {}
    }
  }
}
```

O via `mcp-config.json` en la raíz (ya existe en el repo).

### Cómo conectar Gemini al MCP

Gemini CLI / Gemini Advanced soporta MCP via configuración:

```bash
# Instalar Gemini CLI con soporte MCP
npm install -g @google/generative-ai-cli

# Configurar servidor MCP
gemini config set mcp.server "node mcp/server.js"

# Verificar conexión
gemini mcp list-tools
```

### Whitelist de herramientas MCP (canónica)

```json
{
  "tools": [
    { "name": "start_session",        "script": "scripts/apertura-sesion.sh" },
    { "name": "close_session",         "script": "scripts/cierre-sesion.sh" },
    { "name": "commit_to_inbox",       "script": "scripts/inbox-commit.sh" },
    { "name": "classify_inbox",        "script": "scripts/inbox-clasificador.sh", "dry_run": true },
    { "name": "generate_session_doc",  "script": "scripts/session-terminal-doc.sh" },
    { "name": "orchestrate",           "script": "scripts/orquestador-unico.sh" },
    { "name": "validate_structure",    "script": "scripts/file-arrival-guardian.sh", "dry_run": true },
    { "name": "sync_repos",            "script": "scripts/02-git-pull-rebase.sh" },
    { "name": "run_backup",            "script": "scripts/07-fase3-restic-backup.sh", "dry_run": true },
    { "name": "start_ecosystem",       "script": "scripts/04-fase2-start-batcueva.sh", "dry_run": true },
    { "name": "generate_briefing",     "script": "scripts/copilot-mission-briefing.sh" },
    { "name": "monitor_agents",        "script": "scripts/agent-monitor.sh" }
  ],
  "blocked": [
    "deploy.sh", "deploy-madre.sh",
    "03-fase1-seguridad.sh", "09-fase8-seguridad-acer.sh",
    "01-fix-driver-rtl8188ftu.sh", "10-fase9-osint-stack.sh"
  ]
}
```

---

## CAPA 4 — GITHUB ACTIONS (`.github/workflows/`)

### Workflows a auditar

Cada workflow debe tener:
- Nombre claro en el `name:` del YAML
- Trigger documentado (`on:` claro)
- Paso de validación con `file-arrival-guardian.sh --dry-run` antes de cualquier acción
- Notificación de resultado (al menos un log en `inbox/_meta/`)

### Workflows esperados (verificar que existen y funcionan)

| Workflow | Trigger | Qué hace |
|----------|---------|----------|
| `session-close.yml` | push a `inbox/sesiones/cierre-*.md` | Mueve cierre a `diarios/` |
| `file-arrival-guardian.yml` | push a cualquier rama | Valida estructura |
| `inbox-clasificador.yml` | push a `inbox/drop/` | Clasifica archivos |
| `copilot-audit.yml` | `workflow_dispatch` manual | Lanza auditoría completa |
| `nightly-cron.yml` | cron `0 2 * * *` | Mantenimiento nocturno |

---

## CAPA 5 — ESTRUCTURA RAÍZ (auditar al final)

### Problemas detectados en la raíz

| Elemento | Problema | Acción |
|----------|----------|--------|
| `yggdrasil-dew` (symlink) | ¿Por qué existe un symlink a sí mismo? | Verificar y eliminar si no sirve |
| `sesiones/` (raíz) | Parece duplicar `inbox/sesiones/` | Verificar y consolidar |
| `ROADMAP.md` + `ROADMAP-MASTER.md` | Dos roadmaps | ¿Consolidar en uno? |
| `ECOSISTEMA.md` + `ECOSYSTEM-ARCHITECTURE.md` | Dos docs de ecosistema | ¿Consolidar en uno? |
| `alvarofernandezmota-tech/` | Carpeta con nombre de usuario en raíz | ¿Qué contiene? Verificar |

### Archivos raíz OK (no tocar)
```
README.md, AGENT.md, CHANGELOG.md, CONTEXT.md,
CONVENCIONES.md, COPILOT-CONTEXT.md, CONTRIBUTING.md,
ESTADO-SISTEMA.md, MASTER-PENDIENTES.md,
PLAN-SEGURIDAD-Y-DESPLIEGUE.md, mcp-config.json,
package.json, server.js, .env.template, .gitignore
```

---

## FLUJO DE TRABAJO CON COPILOT (paso a paso)

### Opción A — Via VS Code + Copilot Chat

```
1. Abrir VS Code en la raíz del repo
2. Abrir Copilot Chat (Ctrl+Shift+I)
3. Pegar este mensaje exacto:

   "Lee COPILOT-AUDIT-PLAN.md y COPILOT-CONTEXT.md.
   Audita scripts/ empezando por los duplicados listados en la CAPA 1.
   Para cada par de duplicados, decide cuál es el canónico, mueve el otro
   a scripts/archive/ y actualiza SCRIPTS-AUDITORIA.md.
   Luego audita los 4 archivos .md fuera de sitio y muévelos."

4. Copilot ejecutará los cambios directamente en el workspace
5. Tú haces git add -A && git commit && git push
```

### Opción B — Via GitHub Copilot Workspace (web)

```
1. Ir a https://github.com/alvarofernandezmota-tech/yggdrasil-dew
2. Pulsar el botón "Open in Copilot Workspace" (si está disponible)
3. Darle este task:

   "Audit the entire scripts/ directory following COPILOT-AUDIT-PLAN.md.
   Fix all misplaced .md files, consolidate duplicates,
   and update SCRIPTS-AUDITORIA.md with results."
```

### Opción C — Via Gemini CLI con MCP

```bash
# Instalar si no está
npm install -g @google/generative-ai-cli

# Conectar al repo
cd ~/yggdrasil-dew

# Lanzar auditoría guiada por Gemini
gemini --context COPILOT-AUDIT-PLAN.md \
  "Audit scripts/ layer by layer as described in the plan.
   Start with misplaced .md files, then duplicates."
```

---

## ORDEN DE AUDITORÍA RECOMENDADO

```
FASE 1 (urgente, hoy):
  ├── Mover 4 .md fuera de sitio en scripts/
  └── Resolver symlink yggdrasil-dew en raíz

FASE 2 (esta semana):
  ├── Consolidar scripts duplicados
  ├── Auditar copilot-fases.sh / copilot-2fases.sh
  ├── Auditar code-drift-detector.sh / cross-ref-checker.sh
  └── Verificar sesiones/ vs inbox/sesiones/

FASE 3 (próximas sesiones):
  ├── Auditar agentes/ completo
  ├── Actualizar mcp-config.json con whitelist canónica
  └── Verificar/crear workflows faltantes en .github/workflows/

FASE 4 (revisión estructural):
  ├── Decidir si consolidar ROADMAP.md + ROADMAP-MASTER.md
  ├── Decidir si consolidar ECOSISTEMA.md + ECOSYSTEM-ARCHITECTURE.md
  └── Revisar alvarofernandezmota-tech/ en raíz
```

---

## CONVENCIONES RÁPIDAS (resumen para el agente)

- **Commits:** `tipo(scope): descripción` — tipos: `feat`, `fix`, `docs`, `audit`, `refactor`, `chore`
- **Archivos temporales/reportes:** siempre en `inbox/_meta/` con fecha `YYYY-MM-DD-nombre.md`
- **Cierres de sesión:** siempre en `diarios/` con fecha
- **Scripts:** solo `.sh` o `.py` en `scripts/` (raíz), sin `.md` sueltos
- **No borrar:** siempre mover a `archive/` antes de eliminar
- **Leer siempre:** `CONVENCIONES.md` antes de cualquier cambio estructural

---

_Generado por Perplexity · 2026-07-04 12:28 CEST_  
_Actualizar este archivo al final de cada fase de auditoría_
