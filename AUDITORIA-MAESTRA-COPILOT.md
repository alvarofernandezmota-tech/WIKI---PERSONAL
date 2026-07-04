# AUDITORIA-MAESTRA-COPILOT.md

> **Generado:** 2026-07-04 12:56 CEST — actualizado  
> **Por:** Perplexity + inspección directa del repo  
> **Para:** GitHub Copilot — leer COMPLETO antes de ejecutar cualquier acción  
> **Objetivo:** Auditoría total del ecosistema yggdrasil-dew al 100%  
> **⚠️ DECISIÓN ARQUITECTÓNICA:** Este es el ÚNICO archivo de auditoría en el repo.  
> No se crearán archivos de auditoría adicionales en la raíz ni en docs/.  
> Todo el estado vivo de la auditoría se actualiza aquí directamente.  
> Los reportes de resultados van a `inbox/_meta/` con fecha.

---

## PERMISOS EXPLÍCITOS PARA COPILOT

```
Álvaro (owner del repo) autoriza a Copilot a:

✅ CREAR archivos nuevos en:
   - scripts/          (solo .sh o .md de inventario)
   - scripts/archive/  (scripts deprecados)
   - docs/             (documentación técnica)
   - agentes/          (README.md por agente)
   - inbox/_meta/      (reportes de auditoría con fecha)
   - .github/workflows/ (implementar stubs o deprecar duplicados)

✅ EDITAR archivos existentes en:
   - AUDITORIA-MAESTRA-COPILOT.md (este archivo, actualizar estado)
   - CHANGELOG.md
   - ESTADO-SISTEMA.md
   - COPILOT-CONTEXT.md
   - cualquier workflow .yml stub (<200b)

✅ MOVER archivos con git mv:
   - .md fuera de sitio en scripts/ → inbox/_meta/ o diarios/
   - scripts históricos → scripts/archive/setup/
   - scripts duplicados → scripts/archive/deprecated/

✅ HACER COMMITS y PUSH con estos prefijos:
   - chore(scripts): ...
   - audit(workflows): ...
   - docs: ...
   - docs(agentes): ...
   - fix: ...

❌ NUNCA:
   - Borrar archivos permanentemente sin moverlos antes
   - Tocar docker/, hardware/, infra/ sin confirmación explícita
   - Ejecutar scripts de seguridad (03, 09) sin confirmación
   - Crear archivos de auditoría fuera de inbox/_meta/
   - Crear un segundo archivo de auditoría en la raíz
```

---

## INSTRUCCIONES DE EJECUCIÓN

```
Ejecuta esta auditoría en 5 fases, en orden estricto.
Antes de pasar a la siguiente fase: confírmame qué hiciste.
Si algo no está claro: pregúntame antes de actuar.
Actualiza la tabla ESTADO DEL ECOSISTEMA al final de cada fase.
```

---

## MAPA REAL DEL ECOSISTEMA (confirmado 2026-07-04)

### Repos del ecosistema

| Repo | Propósito | Estado |
|------|-----------|--------|
| `yggdrasil-dew` | Repo madre — cerebro del ecosistema | 🟢 activo |
| `yggdrasil-nosek` | Isla principal — proyecto personal/OSINT | 🔵 verificar |
| Resto de islas en `islas/` | Proyectos satélite | 🔵 pendiente auditar |

### Estructura de carpetas (raíz confirmada)

```
yggdrasil-dew/
├── .github/workflows/    47 workflows (VER SECCIÓN 3)
├── agentes/              Agentes de terminal
├── cli-tools/            Herramientas CLI propias
├── core/                 Lógica central
├── diarios/              Cierres de sesión archivados
├── docker/               Docker/compose
├── docs/                 Documentación técnica
├── formacion/            Recursos aprendizaje
├── hardware/             Config hardware
├── inbox/                Zona de trabajo viva
│   ├── drop/             Zona de aterrizaje
│   ├── sesiones/         Logs y cierres
│   └── _meta/            Reportes de auditoría
├── infra/                Infraestructura
├── investigacion/        Research/OSINT
├── islas/                Proyectos satélite
├── logs/                 Logs del sistema
├── mcp/                  Servidores MCP
├── mocs/                 Maps of Content (Obsidian)
├── ollama/               Config Ollama
├── osint-stack/          Stack OSINT
├── proyectos/            Proyectos activos
├── reports/              Reportes generados
├── scripts/              Scripts operacionales
├── sesiones/             ⚠️ POSIBLE DUPLICADO de inbox/sesiones/ — CONSOLIDAR
├── setup/                Scripts setup inicial
├── templates/            Plantillas
├── tests/                Tests
├── thdora/               Bot Thdora
├── tools/                Herramientas varias
├── yo/                   Perfil personal
└── [ARCHIVOS RAÍZ]       Solo archivos canónicos del ecosistema
```

---

## SECCIÓN 1 — SCRIPTS (CAPA 1, AUDITAR PRIMERO)

### Paso 0 — Archivos .md fuera de sitio en scripts/ — MOVER URGENTE

```bash
git mv scripts/2026-07-03-23-05-struct-auditor-output.md inbox/_meta/
git mv scripts/2026-07-03-cierre-sesion-completo.md diarios/
git mv scripts/2026-07-03-inbox-audit-consolidado.md inbox/_meta/
git mv scripts/2026-07-03-reality-check.md diarios/
git commit -m "chore(scripts): mover .md fuera de sitio a destinos correctos"
git push
```

### Diccionario completo de scripts + estado

| # | Script | Propósito | Estado | Acción Copilot |
|---|--------|-----------|--------|----------------|
| 01 | `01-fix-driver-rtl8188ftu.sh` | Driver WiFi USB RTL8188 | 🟡 puntual | → `scripts/archive/setup/` |
| 02 | `02-git-pull-rebase.sh` | Git pull rebase todos repos | 🟢 activo | OK |
| 03 | `03-fase1-seguridad.sh` | Setup seguridad inicial | 🟡 histórico | → `scripts/archive/setup/` |
| 04 | `04-fase2-start-batcueva.sh` | Arranca stack Batcueva | 🟢 activo | OK |
| 05 | `05-fase7-ollama-pull.sh` | Descarga modelos Ollama | 🟢 activo | OK |
| 06 | `06-verificacion-post-reboot.sh` | Verifica servicios tras reboot | 🟢 activo | OK |
| 07 | `07-fase3-restic-backup.sh` | Backup Restic | 🟢 activo | OK |
| 08 | `08-fase6-thdora-handlers.sh` | Setup handlers Thdora | 🟡 histórico | → `scripts/archive/setup/` |
| 09 | `09-fase8-seguridad-acer.sh` | Hardening Acer | 🟡 histórico | → `scripts/archive/setup/` |
| 10 | `10-fase9-osint-stack.sh` | Instala stack OSINT | 🟡 histórico | → `scripts/archive/setup/` |
| 11 | `agent-monitor.sh` | Monitoriza agentes | 🟢 activo | OK |
| 12 | `apertura-maestra.sh` | Apertura completa | 🟡 DUPLICADO | → `scripts/archive/deprecated/` |
| 13 | `apertura-sesion.sh` | Apertura sesión | 🟢 CANÓNICO | OK |
| 14 | `audit-and-migrate.sh` | Audita y migra | 🟡 solapamiento | Revisar vs orquestador-unico |
| 15 | `auditoria-maestra.sh` | Auditoría general | 🟡 DUPLICADO | → `scripts/archive/deprecated/` |
| 16 | `batcueva-control.sh` | Control stack | 🟢 activo | OK |
| 17 | `between-sessions.sh` | Tareas entre sesiones | 🔴 poco doc | AUDITAR contenido |
| 18 | `cierre-maestro.sh` | Cierre completo | 🟡 DUPLICADO | → `scripts/archive/deprecated/` |
| 19 | `cierre-sesion.sh` | Cierre sesión | 🟢 CANÓNICO | OK |
| 20 | `clasificador-maestro.sh` | Clasificación archivos | 🟡 DUPLICADO | → `scripts/archive/deprecated/` |
| 21 | `code-drift-detector.sh` | Detecta drift código | 🔴 sin auditar | Documentar qué baseline usa |
| 22 | `copilot-2fases.sh` | Copilot 2 fases | 🔴 sin auditar | Verificar si duplicado |
| 23 | `copilot-fases.sh` | Copilot fases | 🔴 sin auditar | Comparar con copilot-2fases |
| 24 | `copilot-mission-briefing.sh` | Genera briefing | 🟢 activo | OK |
| 25 | `create-issues.sh` | Crea issues GitHub | 🟢 activo | OK |
| 26 | `cross-ref-checker.sh` | Verifica referencias cruzadas | 🔴 sin auditar | Documentar qué cruza |
| 27 | `deploy-madre.sh` | Deploy ecosistema madre | 🟡 DUPLICADO | Comparar con deploy.sh |
| 28 | `deploy.sh` | Deploy general | 🟡 DUPLICADO | Comparar con deploy-madre.sh |
| 29 | `file-arrival-guardian.sh` | Valida estructura carpetas | 🟢 CANÓNICO | OK |
| 30 | `inbox-clasificador.sh` | Clasifica inbox/drop/ | 🟢 NUEVO CANÓNICO | OK |
| 31 | `inbox-commit.sh` | Commit rápido inbox | 🟢 uso diario | OK |
| 32 | `orquestador-unico.sh` | Orquestador del ecosistema | 🟢 NUEVO CANÓNICO | OK |
| 33 | `session-logger.sh` | Logger sesión terminal | 🟢 activo | OK |
| 34 | `session-terminal-doc.sh` | Doc cierre sesión | 🟢 activo | OK |

### Estructura canónica de scripts/ tras auditoría

```
scripts/
├── [14 scripts activos canónicos]
├── archive/
│   ├── setup/      ← scripts históricos (01, 03, 08, 09, 10)
│   └── deprecated/ ← duplicados (12, 15, 18, 20)
└── SCRIPTS-AUDITORIA.md  ← inventario actualizado (crear aquí)
```

---

## SECCIÓN 2 — AGENTES (`agentes/`)

### Estructura mínima por agente

```
agentes/
└── nombre-agente/
    ├── agent.sh (o agent.py)
    ├── README.md          ← qué hace, cómo se lanza, qué genera
    └── config.json        ← parámetros configurables (si aplica)
```

### Tarea Copilot para agentes

```
1. Lista todos los directorios/archivos en agentes/
2. Para cada agente sin README.md: créalo con estructura mínima
3. Verifica que cada agente tiene su workflow en .github/workflows/
4. Si no tiene workflow: crea uno básico con on: workflow_dispatch
5. Actualiza docs/agentes-manual.md con el inventario completo
```

---

## SECCIÓN 3 — GITHUB ACTIONS (47 WORKFLOWS CONFIRMADOS)

### Inventario real con estado

| Workflow | Tamaño | Estado | Problema detectado |
|----------|---------|--------|--------------------|
| `agent-monitor.yml` | 152b | 🔴 stub | Casi vacío |
| `audit-on-push.yml` | 152b | 🔴 stub | Casi vacío |
| `auditoria-auto.yml` | 193b | 🔴 stub | Muy pequeño |
| `auto-investigacion.yml` | 157b | 🔴 stub | Casi vacío |
| `auto-pr.yml` | 146b | 🔴 stub | Casi vacío |
| `autonomous-cron.yml` | 154b | 🔴 stub | Casi vacío |
| `between-sessions.yml` | 155b | 🔴 stub | Casi vacío |
| `ci-agentes.yml` | 599b | 🟡 parcial | Verificar |
| `clasificador-maestro.yml` | 159b | 🔴 stub | Duplicado de clasificador.yml |
| `clasificador.yml` | 151b | 🔴 stub | Casi vacío |
| `code-drift.yml` | 149b | 🔴 stub | Casi vacío |
| `context-reminder.yml` | 155b | 🔴 stub | Casi vacío |
| `cross-ref-checker.yml` | 156b | 🔴 stub | Casi vacío |
| `deuda-tecnica.yml` | 152b | 🔴 stub | Casi vacío |
| `diary-writer.yml` | 151b | 🔴 stub | Casi vacío |
| `e2e-full-flow.yml` | 1232b | 🟡 parcial | Verificar |
| `ecosystem-guardian.yml` | 157b | 🔴 stub | Casi vacío |
| `file-arrival-guardian.yml` | 2411b | 🟢 OK | Funcional |
| `galatea.yml` | 5839b | 🟢 OK | El más grande |
| `gestor-estados-inbox.yml` | 2904b | 🟢 OK | Funcional |
| `ghost-file-detector.yml` | 158b | 🔴 stub | Casi vacío |
| `health-check.yml` | 2928b | 🟢 OK | Funcional |
| `inbox-clasificador.yml` | 2262b | 🟢 OK | Funcional |
| `inbox-cleanup.yml` | 1680b | 🟡 parcial | Verificar |
| `inbox-dispatcher.yml` | 3322b | 🟢 OK | Funcional |
| `inbox-health.yml` | 1438b | 🟡 parcial | Verificar |
| `inbox-processor.yml` | 2436b | 🟢 OK | Funcional |
| `isla-context-sync.yml` | 156b | 🔴 stub | Casi vacío |
| `isla-sync-validator.yml` | 158b | 🔴 stub | Casi vacío |
| `islas-health.yml` | 151b | 🔴 stub | Casi vacío |
| `issue-creator.yml` | 1969b | 🟡 parcial | Verificar |
| `lint-commits.yml` | 1346b | 🟡 parcial | Verificar |
| `mapa-islas-sync.yml` | 1698b | 🟡 parcial | Verificar |
| `meta-deep-audit.yml` | 1845b | 🟡 parcial | Verificar |
| `meta-deep-draft-pr.yml` | 526b | 🔴 stub | Pequeño |
| `new-file-bootstrap.yml` | 1283b | 🟡 parcial | Verificar |
| `orquestador-maestro.yml` | 4221b | 🟢 OK | Funcional — CANÓNICO |
| `orquestador-supremo.yml` | 1021b | 🟡 parcial | DUPLICADO → deprecar |
| `orquestador-total.yml` | 1475b | 🟡 parcial | DUPLICADO → deprecar |
| `reality-check.yml` | 1288b | 🟡 parcial | Verificar |
| `repo-audit.yml` | 4622b | 🟢 OK | Funcional |
| `repo-health-check.yml` | 2013b | 🟡 parcial | DUPLICADO → comparar con repo-health.yml |
| `repo-health.yml` | 4365b | 🟢 OK | Funcional — CANÓNICO |
| `repo-research-on-push.yml` | 1244b | 🟡 parcial | Verificar |
| `resumen-diario.yml` | 1508b | 🟡 parcial | Verificar |
| `secret-scan.yml` | 1565b | 🟡 parcial | Verificar |
| `session-close.yml` | 995b | 🟡 parcial | Verificar flujo completo |
| `struct-auditor.yml` | 963b | 🟡 parcial | Verificar |
| `sync-drive.yml` | 949b | 🟡 parcial | Verificar |
| `sync-estado.yml` | 1771b | 🟡 parcial | Verificar |
| `test-scripts.yml` | 1901b | 🟡 parcial | Verificar |
| `tool-inventory-auditor.yml` | 1021b | 🟡 parcial | Verificar |
| `tripwire-repo.yml` | 2826b | 🟢 OK | Funcional |
| `watchdog-monitor.yml` | 998b | 🟡 parcial | DUPLICADO → comparar con watchdog.yml |
| `watchdog.yml` | 920b | 🟡 parcial | DUPLICADO → comparar con watchdog-monitor.yml |
| `yamllint.yml` | 943b | 🟡 parcial | Verificar |

### Resumen workflows
- 🟢 **11 funcionales** (>2000b, cuerpo real)
- 🟡 **22 parciales** (contenido pero sin auditar)
- 🔴 **22 stubs** (150-200b, casi vacíos)

### Plan Copilot para workflows

```
FASE A — 22 stubs urgentes (<200b):
  Para cada uno → leer nombre → implementar cuerpo real O deprecar
  Si es duplicado: añadir comentario # DEPRECATED → usar [canónico]

FASE B — Duplicados de orquestadores:
  orquestador-supremo.yml + orquestador-total.yml
  → Comparar con orquestador-maestro.yml
  → Consolidar en maestro → deprecar los otros dos

FASE C — Duplicados de health:
  repo-health-check.yml vs repo-health.yml
  → Consolidar en el más completo

FASE D — Duplicados de watchdog:
  watchdog.yml vs watchdog-monitor.yml
  → Consolidar en uno
```

---

## SECCIÓN 4 — INBOX Y DOCS

### Inbox — verificar

```
1. ¿Existe inbox/drop/.gitkeep? Si no → crear
2. ¿Archivos sin clasificar en inbox/drop/? → lanzar inbox-clasificador.sh
3. ¿Carpeta sesiones/ en raíz Y en inbox/? → consolidar en inbox/sesiones/
4. ¿inbox/_meta/ tiene reportes anteriores? → listarlos
```

### Docs — archivos a crear

| Archivo | Estado | Acción |
|---------|--------|--------|
| `docs/inbox-flujo.md` | Existe | Actualizar con estado real |
| `docs/scripts-diccionario.md` | Falta | Crear desde Sección 1 |
| `docs/workflows-inventario.md` | Falta | Crear desde Sección 3 |
| `docs/agentes-manual.md` | Falta | Crear inventario agentes |
| `docs/mcp-config-guide.md` | Falta | Config Copilot + Gemini al MCP |
| `docs/islas-mapa.md` | Verificar | Actualizar estado real de islas |
| `docs/ecosistema-flujo-completo.md` | Falta | Diagrama terminal→inbox→diarios |

---

## SECCIÓN 5 — MCP

### Config Copilot (VS Code .vscode/settings.json)

```json
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

### Whitelist MCP canónica

```json
{
  "tools": [
    { "name": "start_session",     "script": "scripts/apertura-sesion.sh" },
    { "name": "close_session",     "script": "scripts/cierre-sesion.sh" },
    { "name": "commit_inbox",      "script": "scripts/inbox-commit.sh" },
    { "name": "classify_inbox",    "script": "scripts/inbox-clasificador.sh" },
    { "name": "gen_session_doc",   "script": "scripts/session-terminal-doc.sh" },
    { "name": "orchestrate",       "script": "scripts/orquestador-unico.sh" },
    { "name": "validate_structure","script": "scripts/file-arrival-guardian.sh" },
    { "name": "sync_repos",        "script": "scripts/02-git-pull-rebase.sh" },
    { "name": "backup",            "script": "scripts/07-fase3-restic-backup.sh" },
    { "name": "start_ecosystem",   "script": "scripts/04-fase2-start-batcueva.sh" },
    { "name": "briefing",          "script": "scripts/copilot-mission-briefing.sh" },
    { "name": "monitor_agents",    "script": "scripts/agent-monitor.sh" }
  ],
  "blocked": [
    "deploy.sh", "deploy-madre.sh",
    "03-fase1-seguridad.sh", "09-fase8-seguridad-acer.sh"
  ]
}
```

---

## SECCIÓN 6 — PROMPT RAW COMPLETO PARA COPILOT

> Copia este bloque COMPLETO y pégalo en Copilot Chat en VS Code

```
Lee los archivos AUDITORIA-MAESTRA-COPILOT.md, COPILOT-CONTEXT.md y CONVENCIONES.md
antes de hacer nada. Lee también AGENT.md si existe.

PERMISOS: El owner (Álvaro) te autoriza a crear, editar, mover y hacer commit/push
según la sección PERMISOS EXPLÍCITOS PARA COPILOT de AUDITORIA-MAESTRA-COPILOT.md.

REGLA CRÍTICA: Este es el ÚNICO archivo de auditoría del repo.
No crees archivos de auditoría adicionales en la raíz ni en docs/.
Los reportes de resultados van ÚNICAMENTE a inbox/_meta/ con fecha.

Ejecuta la auditoría en 5 fases. Una fase por respuesta.
Confírmame qué hiciste antes de pasar a la siguiente.

────────────────────────────────────────
FASE 1 — LIMPIEZA scripts/
────────────────────────────────────────
- Crea scripts/archive/setup/ y scripts/archive/deprecated/
- Mueve los 4 archivos .md de scripts/ a inbox/_meta/ o diarios/ (Sección 1)
- Mueve scripts históricos (01, 03, 08, 09, 10) → scripts/archive/setup/
- Mueve scripts duplicados (12, 15, 18, 20) → scripts/archive/deprecated/
- Crea scripts/SCRIPTS-AUDITORIA.md con el diccionario final
- Commit: "chore(scripts): limpieza fase 1 — .md fuera de sitio + archivado"
- Push

────────────────────────────────────────
FASE 2 — WORKFLOWS STUB (22 workflows <200b)
────────────────────────────────────────
- Para cada stub: leer nombre → implementar cuerpo real O marcar DEPRECATED
- Duplicados (orquestador-supremo, orquestador-total): deprecar → canónico = orquestador-maestro
- Duplicados (repo-health-check): deprecar → canónico = repo-health
- Duplicados (watchdog-monitor): comparar → consolidar
- Commit: "audit(workflows): implementar stubs + deprecar duplicados"
- Push

────────────────────────────────────────
FASE 3 — DOCS FALTANTES
────────────────────────────────────────
- Crea: docs/scripts-diccionario.md (desde Sección 1)
- Crea: docs/workflows-inventario.md (desde Sección 3)
- Crea: docs/agentes-manual.md (lista agentes/ + estado)
- Crea: docs/mcp-config-guide.md (config Copilot + Gemini CLI)
- Crea: docs/ecosistema-flujo-completo.md (diagrama terminal→inbox→diarios)
- Actualiza: docs/inbox-flujo.md con estado real
- Commit: "docs: crear inventarios faltantes (scripts, workflows, agentes, mcp, flujo)"
- Push

────────────────────────────────────────
FASE 4 — AGENTES
────────────────────────────────────────
- Lista todo agentes/
- Para cada agente sin README.md: créalo con estructura mínima
- Para cada agente sin workflow: crea uno básico con workflow_dispatch
- Actualiza docs/agentes-manual.md
- Commit: "docs(agentes): README.md para todos los agentes"
- Push

────────────────────────────────────────
FASE 5 — INFORME FINAL
────────────────────────────────────────
- Crea: inbox/_meta/auditoria-completa-2026-07-04.md (resumen de todo)
- Actualiza: CHANGELOG.md (todas las fases)
- Actualiza: ESTADO-SISTEMA.md (estado post-auditoría)
- Actualiza: AUDITORIA-MAESTRA-COPILOT.md → tabla ESTADO DEL ECOSISTEMA
- Commit: "audit: informe final + ESTADO-SISTEMA actualizado"
- Push

────────────────────────────────────────
REGLAS ABSOLUTAS:
- No borres nada sin moverlo antes
- Sigue CONVENCIONES.md en todo momento
- NO crees archivos de auditoría fuera de inbox/_meta/
- Confírmame qué hiciste antes de pasar a la siguiente fase
- Si algo no está claro: pregúntame
────────────────────────────────────────
```

---

## SECCIÓN 7 — ISLAS

### Orden de auditoría

```
Fase A: yggdrasil-dew (este repo) — EN MARCHA
Fase B: yggdrasil-nosek — SEGUNDO (mismo proceso)
Fase C: resto de islas en islas/ — una por una
```

### Estructura mínima de cada isla tras auditoría

```
yggdrasil-[nombre]/
├── COPILOT-CONTEXT.md    ← contexto específico de la isla
├── AGENT.md              ← instrucciones para el agente IA
├── ESTADO.md             ← estado actual
├── README.md             ← descripción pública
├── inbox/                ← zona de trabajo viva
└── scripts/              ← scripts propios (si los tiene)
```

---

## SECCIÓN 8 — COMANDOS DIARIOS DEFINITIVOS

### Inicio de sesión
```bash
cd ~/yggdrasil-dew
git pull origin main
source scripts/session-logger.sh
bash scripts/orquestador-unico.sh audit
```

### Meter archivo al ecosistema
```bash
cp /ruta/de/tu/archivo.md ~/yggdrasil-dew/inbox/drop/
bash scripts/inbox-commit.sh "descripción de qué entra"
```

### Cierre de sesión
```bash
bash scripts/orquestador-unico.sh audit
bash scripts/session-terminal-doc.sh "resumen de la sesión"
git add inbox/sesiones/cierre-*.md
git commit -m "docs(sesion): cierre $(date +%Y-%m-%d) — descripción"
git push origin main
```

### Auditoría manual completa
```bash
bash scripts/orquestador-unico.sh all
# O via GitHub Actions → orquestador-maestro.yml → Run workflow
```

---

## ESTADO DEL ECOSISTEMA (actualizar en cada fase)

| Área | Estado | Bloqueante | Fase que lo resuelve |
|------|--------|------------|----------------------|
| Scripts: .md fuera de sitio | 🔴 pendiente | Sí | Fase 1 |
| Scripts: duplicados | 🔴 pendiente | Sí | Fase 1 |
| Workflows: 22 stubs | 🔴 pendiente | Sí | Fase 2 |
| Workflows: duplicados | 🔴 pendiente | No | Fase 2 |
| Docs: 5 archivos faltantes | 🔴 pendiente | Sí | Fase 3 |
| Agentes: sin README | 🔵 sin auditar | No | Fase 4 |
| inbox/sesiones/ vs sesiones/ | 🟡 verificar | No | Fase 1 |
| MCP config | 🔵 pendiente | No | Post-auditoría |
| Islas | 🔵 pendiente tras ygg | No | Post-auditoría |

---

_Generado por Perplexity · 2026-07-04 12:56 CEST_  
_Actualizar tras completar cada fase — NO crear archivos de auditoría adicionales_
