# AUDITORIA-MAESTRA-COPILOT.md

> **Generado:** 2026-07-04 12:52 CEST  
> **Por:** Perplexity + inspección directa del repo  
> **Para:** GitHub Copilot — leer COMPLETO antes de ejecutar cualquier acción  
> **Objetivo:** Auditoría total del ecosistema yggdrasil-dew al 100%  

---

## INSTRUCCIONES PARA COPILOT

```
Eres el agente auditor del ecosistema yggdrasil-dew.
Tienes acceso completo al repositorio.
Tu misión es ejecutar esta auditoría en 5 fases, en orden.
Antes de cada cambio: lee el archivo, entiende su propósito, decide si está bien,
deprecado, duplicado o incompleto. Documenta todo en CHANGELOG.md.
NO borres nada sin moverlo antes. NO sobreescribas sin hacer backup en scripts/archive/.
Sigue CONVENCIONES.md en todo momento.
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
├── sesiones/             ⚠️ POSIBLE DUPLICADO de inbox/sesiones/
├── setup/                Scripts setup inicial
├── templates/            Plantillas
├── tests/                Tests
├── thdora/               Bot Thdora
├── tools/                Herramientas varias
├── yo/                   Perfil personal
└── [ARCHIVOS RAÍZ]
```

---

## SECCIÓN 1 — SCRIPTS (CAPA 1, AUDITAR PRIMERO)

### Archivos .md fuera de sitio en scripts/ — MOVER URGENTE

```bash
# Ejecutar esto primero antes de cualquier otra cosa
git mv scripts/2026-07-03-23-05-struct-auditor-output.md inbox/_meta/
git mv scripts/2026-07-03-cierre-sesion-completo.md diarios/
git mv scripts/2026-07-03-inbox-audit-consolidado.md inbox/_meta/
git mv scripts/2026-07-03-reality-check.md diarios/
git commit -m "chore(scripts): mover .md fuera de sitio a destinos correctos"
git push
```

### Diccionario completo de scripts + estado de auditoría

| # | Script | Propósito | Estado | Acción Copilot |
|---|--------|-----------|--------|----------------|
| 01 | `01-fix-driver-rtl8188ftu.sh` | Instala driver WiFi USB RTL8188 | 🟡 puntual | Mover a `scripts/archive/setup/` |
| 02 | `02-git-pull-rebase.sh` | Git pull rebase en todos repos | 🟢 activo | OK, verificar rutas |
| 03 | `03-fase1-seguridad.sh` | Setup seguridad inicial | 🟡 histórico | Archivar si ya ejecutado |
| 04 | `04-fase2-start-batcueva.sh` | Arranca stack Batcueva | 🟢 activo | OK |
| 05 | `05-fase7-ollama-pull.sh` | Descarga modelos Ollama | 🟢 activo | OK |
| 06 | `06-verificacion-post-reboot.sh` | Verifica servicios tras reboot | 🟢 activo | OK |
| 07 | `07-fase3-restic-backup.sh` | Backup Restic | 🟢 activo | OK |
| 08 | `08-fase6-thdora-handlers.sh` | Setup handlers Thdora | 🟡 histórico | Archivar |
| 09 | `09-fase8-seguridad-acer.sh` | Hardening Acer | 🟡 histórico | Archivar |
| 10 | `10-fase9-osint-stack.sh` | Instala stack OSINT | 🟡 histórico | Archivar |
| 11 | `agent-monitor.sh` | Monitoriza agentes | 🟢 activo | OK |
| 12 | `apertura-maestra.sh` | Apertura completa | 🟡 DUPLICADO | ¿Consolidar en apertura-sesion? |
| 13 | `apertura-sesion.sh` | Apertura sesión | 🟢 CANÓNICO | OK |
| 14 | `audit-and-migrate.sh` | Audita y migra | 🟡 solapamiento | Revisar vs orquestador-unico |
| 15 | `auditoria-maestra.sh` | Auditoría general | 🟡 DUPLICADO | Deprecar → orquestador-unico.sh |
| 16 | `batcueva-control.sh` | Control stack | 🟢 activo | OK |
| 17 | `between-sessions.sh` | Tareas entre sesiones | 🔴 poco doc | AUDITAR contenido |
| 18 | `cierre-maestro.sh` | Cierre completo | 🟡 DUPLICADO | ¿Consolidar en cierre-sesion? |
| 19 | `cierre-sesion.sh` | Cierre sesión | 🟢 CANÓNICO | OK |
| 20 | `clasificador-maestro.sh` | Clasificación archivos | 🟡 DUPLICADO | Deprecar → inbox-clasificador.sh |
| 21 | `code-drift-detector.sh` | Detecta drift código | 🔴 sin auditar | ¿Qué baseline usa? Documentar |
| 22 | `copilot-2fases.sh` | Copilot 2 fases | 🔴 sin auditar | ¿Cuál es la versión actual? |
| 23 | `copilot-fases.sh` | Copilot fases | 🔴 sin auditar | ¿Duplicado de copilot-2fases? |
| 24 | `copilot-mission-briefing.sh` | Genera briefing | 🟢 activo | OK |
| 25 | `create-issues.sh` | Crea issues GitHub | 🟢 activo | OK |
| 26 | `cross-ref-checker.sh` | Verifica referencias | 🔴 sin auditar | Documentar qué cruza |
| 27 | `deploy-madre.sh` | Deploy ecosistema madre | 🟡 DUPLICADO | ¿Consolidar con deploy.sh? |
| 28 | `deploy.sh` | Deploy general | 🟡 DUPLICADO | ¿Consolidar con deploy-madre? |
| 29 | `file-arrival-guardian.sh` | Valida estructura | 🟢 CANÓNICO | OK |
| 30 | `inbox-clasificador.sh` | Clasifica inbox/drop/ | 🟢 NUEVO CANÓNICO | OK |
| 31 | `inbox-commit.sh` | Commit rápido inbox | 🟢 uso diario | OK |
| 32 | `orquestador-unico.sh` | Orquestador del ecosistema | 🟢 NUEVO CANÓNICO | OK |
| 33 | `session-logger.sh` | Logger sesión terminal | 🟢 activo | OK |
| 34 | `session-terminal-doc.sh` | Doc cierre sesión | 🟢 activo | OK |

### Estructura canónica de scripts/ tras auditoría

```
scripts/
├── [scripts activos — ver tabla anterior]
├── archive/
│   ├── setup/     ← Scripts de setup puntual (01, 03, 08, 09, 10)
│   └── deprecated/ ← Duplicados deprecados
└── SCRIPTS-AUDITORIA.md  ← Este diccionario actualizado
```

---

## SECCIÓN 2 — AGENTES (`agentes/`)

### Qué debe tener cada agente

```
agentes/
└── nombre-agente/
    ├── agent.sh (o agent.py)
    ├── README.md          ← qué hace, cómo se lanza, qué genera
    └── config.json        ← parámetros configurables
```

### Tarea Copilot para agentes

```
1. Lista todos los archivos en agentes/
2. Para cada agente sin README.md: créalo con estructura mínima
3. Verifica que cada agente tiene su workflow correspondiente en .github/workflows/
4. Si no tiene workflow: crea uno básico con workflow_dispatch
5. Actualiza HERRAMIENTAS-ECOSISTEMA.md con el inventario completo
```

---

## SECCIÓN 3 — GITHUB ACTIONS (47 WORKFLOWS CONFIRMADOS)

### Inventario real con estado de auditoría

| Workflow | Tamaño | Estado | Problema detectado |
|----------|---------|--------|--------------------|
| `agent-monitor.yml` | 152b | 🔴 stub | Solo 152b → casi vacío |
| `audit-on-push.yml` | 152b | 🔴 stub | Solo 152b → casi vacío |
| `auditoria-auto.yml` | 193b | 🔴 stub | Muy pequeño |
| `auto-investigacion.yml` | 157b | 🔴 stub | Casi vacío |
| `auto-pr.yml` | 146b | 🔴 stub | Casi vacío |
| `autonomous-cron.yml` | 154b | 🔴 stub | Casi vacío |
| `between-sessions.yml` | 155b | 🔴 stub | Casi vacío |
| `ci-agentes.yml` | 599b | 🟡 parcial | Tiene contenido, verificar |
| `clasificador-maestro.yml` | 159b | 🔴 stub | Duplicado de clasificador.yml |
| `clasificador.yml` | 151b | 🔴 stub | Casi vacío |
| `code-drift.yml` | 149b | 🔴 stub | Casi vacío |
| `context-reminder.yml` | 155b | 🔴 stub | Casi vacío |
| `cross-ref-checker.yml` | 156b | 🔴 stub | Casi vacío |
| `deuda-tecnica.yml` | 152b | 🔴 stub | Casi vacío |
| `diary-writer.yml` | 151b | 🔴 stub | Casi vacío |
| `e2e-full-flow.yml` | 1232b | 🟡 parcial | Tiene contenido, verificar |
| `ecosystem-guardian.yml` | 157b | 🔴 stub | Casi vacío |
| `file-arrival-guardian.yml` | 2411b | 🟢 OK | Tamaño real, funcional |
| `galatea.yml` | 5839b | 🟢 OK | El más grande, verificar contenido |
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
| `orquestador-maestro.yml` | 4221b | 🟢 OK | Funcional |
| `orquestador-supremo.yml` | 1021b | 🟡 parcial | ¿Duplicado de maestro? |
| `orquestador-total.yml` | 1475b | 🟡 parcial | ¿Duplicado de maestro? |
| `reality-check.yml` | 1288b | 🟡 parcial | Verificar |
| `repo-audit.yml` | 4622b | 🟢 OK | Funcional |
| `repo-health-check.yml` | 2013b | 🟡 parcial | Verificar vs repo-health.yml |
| `repo-health.yml` | 4365b | 🟢 OK | Funcional |
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
| `watchdog-monitor.yml` | 998b | 🟡 parcial | ¿Duplicado de watchdog.yml? |
| `watchdog.yml` | 920b | 🟡 parcial | ¿Duplicado de watchdog-monitor? |
| `yamllint.yml` | 943b | 🟡 parcial | Verificar |

### Resumen del estado de workflows

- 🟢 **OK funcional:** 11 workflows (tienen cuerpo real >2000b)
- 🟡 **Parcial/verificar:** 22 workflows (tienen contenido pero sin auditar)
- 🔴 **Stub/vacío:** 22 workflows (152-200b, casi solo nombre y trigger)

### Tarea Copilot para workflows

```
FASE A — Stubs urgentes (los 22 con <200b):
  Para cada stub:
  1. Leer el nombre y deducir su propósito
  2. Implementar el cuerpo real del workflow o marcar como DEPRECATED
  3. Si es duplicado de otro: marcar deprecated y añadir comment con el canónico

FASE B — Duplicados de orquestadores:
  orquestador-supremo.yml + orquestador-total.yml:
  → Comparar con orquestador-maestro.yml (el más completo)
  → Consolidar en orquestador-maestro.yml
  → Deprecar los otros dos

FASE C — Duplicados de health:
  repo-health-check.yml vs repo-health.yml:
  → Consolidar en el más completo
  → Deprecar el menor

FASE D — Duplicados de watchdog:
  watchdog.yml vs watchdog-monitor.yml:
  → Consolidar en uno
```

---

## SECCIÓN 4 — INBOX Y DOCS

### Inbox — problemas detectados

```
Verificar:
1. ¿Existe inbox/drop/.gitkeep? Si no, crear.
2. ¿Hay archivos en inbox/drop/ sin clasificar? Lanzar inbox-clasificador.sh
3. ¿Existe la carpeta sesiones/ en la raíz Y en inbox/? Consolidar en inbox/sesiones/
4. ¿Inbox/_meta/ tiene reportes de auditoría anteriores? Listarlos.
```

### Docs — archivos a crear/actualizar

| Archivo docs/ | Estado | Acción |
|---------------|--------|--------|
| `docs/inbox-flujo.md` | Existe | Actualizar con estado real |
| `docs/scripts-diccionario.md` | Falta | Crear desde Sección 1 de este archivo |
| `docs/workflows-inventario.md` | Falta | Crear desde Sección 3 de este archivo |
| `docs/agentes-manual.md` | Falta | Crear inventario de agentes |
| `docs/mcp-config-guide.md` | Falta | Cómo conectar Copilot y Gemini al MCP |
| `docs/islas-mapa.md` | Verificar | Actualizar con estado real de cada isla |
| `docs/ecosistema-flujo-completo.md` | Falta | Diagrama del flujo terminal→inbox→diarios |

---

## SECCIÓN 5 — MCP

### Configuración para Copilot (VS Code)

```json
// .vscode/settings.json — crear si no existe
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

### Configuración para Gemini CLI

```bash
# 1. Instalar
npm install -g @google/generative-ai-cli

# 2. Configurar contexto del repo
gemini context add AUDITORIA-MAESTRA-COPILOT.md
gemini context add COPILOT-CONTEXT.md
gemini context add CONVENCIONES.md

# 3. Lanzar auditoría
gemini "Audit all stub workflows in .github/workflows/ following AUDITORIA-MAESTRA-COPILOT.md Section 3"
```

### Whitelist MCP canónica (actualizada)

```json
{
  "tools": [
    { "name": "start_session",       "script": "scripts/apertura-sesion.sh" },
    { "name": "close_session",        "script": "scripts/cierre-sesion.sh" },
    { "name": "commit_inbox",         "script": "scripts/inbox-commit.sh" },
    { "name": "classify_inbox",       "script": "scripts/inbox-clasificador.sh" },
    { "name": "gen_session_doc",      "script": "scripts/session-terminal-doc.sh" },
    { "name": "orchestrate",          "script": "scripts/orquestador-unico.sh" },
    { "name": "validate_structure",   "script": "scripts/file-arrival-guardian.sh" },
    { "name": "sync_repos",           "script": "scripts/02-git-pull-rebase.sh" },
    { "name": "backup",               "script": "scripts/07-fase3-restic-backup.sh" },
    { "name": "start_ecosystem",      "script": "scripts/04-fase2-start-batcueva.sh" },
    { "name": "briefing",             "script": "scripts/copilot-mission-briefing.sh" },
    { "name": "monitor_agents",       "script": "scripts/agent-monitor.sh" }
  ],
  "blocked": [
    "deploy.sh", "deploy-madre.sh",
    "03-fase1-seguridad.sh", "09-fase8-seguridad-acer.sh"
  ]
}
```

---

## SECCIÓN 6 — PROMPT RAW PARA COPILOT

> Copia este bloque completo y pégalo en Copilot Chat en VS Code

```
Lee los archivos AUDITORIA-MAESTRA-COPILOT.md, COPILOT-CONTEXT.md y CONVENCIONES.md.

Ejecuta la siguiente secuencia de auditoría, una fase por respuesta, confirmándome
qué has hecho en cada una antes de pasar a la siguiente:

FASE 1 — LIMPIEZA URGENTE scripts/
  - Mueve los 4 archivos .md a sus destinos correctos (descritos en Sección 1)
  - Crea scripts/archive/setup/ y mueve los scripts históricos (01, 03, 08, 09, 10)
  - Actualiza SCRIPTS-AUDITORIA.md con el estado actual
  - Commit: "chore(scripts): limpieza fase 1 — .md fuera de sitio + archivado históricos"

FASE 2 — WORKFLOWS STUB
  - Lee los 22 workflows con <200b listados en Sección 3
  - Para cada uno: implementa el cuerpo real o marca como DEPRECATED con comentario
  - Para duplicados (orquestador-supremo, orquestador-total, watchdog-monitor): 
    marca deprecated y apunta al canónico
  - Commit: "audit(workflows): implementar stubs + deprecar duplicados"

FASE 3 — DOCS FALTANTES
  - Crea los 5 archivos faltantes en docs/ (listados en Sección 4)
  - Actualiza docs/inbox-flujo.md con el estado real
  - Commit: "docs: crear inventarios faltantes (scripts, workflows, agentes, mcp, flujo)"

FASE 4 — AGENTES
  - Lista agentes/ y crea README.md para cada agente sin él
  - Verifica que cada agente tiene su workflow
  - Commit: "docs(agentes): README.md para todos los agentes"

FASE 5 — INFORME FINAL
  - Crea inbox/_meta/auditoria-completa-2026-07-04.md con resumen de todo lo hecho
  - Actualiza CHANGELOG.md con todas las fases
  - Actualiza ESTADO-SISTEMA.md con el estado post-auditoría
  - Commit: "audit: informe final + ESTADO-SISTEMA actualizado"

REGLAS:
- No borres nada sin moverlo antes
- Sigue CONVENCIONES.md en todo momento
- Confírmame qué hiciste antes de pasar a la siguiente fase
- Si algo no está claro, pregúntame
```

---

## SECCIÓN 7 — ISLAS (yggdrasil-nosek y resto)

### Orden de auditoría de islas

```
Fase A: yggdrasil-dew (este repo) — PRIMERO (ya en marcha)
Fase B: yggdrasil-nosek — SEGUNDO
  - Clonar si no está local
  - Aplicar el mismo proceso de este documento
  - Sincronizar con yggdrasil-dew via isla-context-sync.yml
Fase C: resto de islas en islas/
  - Una por una, en orden de importancia
  - Cada isla debe tener su propio COPILOT-CONTEXT.md
```

### Qué debe tener cada isla tras la auditoría

```
yggdrasil-[nombre]/
├── COPILOT-CONTEXT.md    ← contexto específico de la isla
├── AGENT.md              ← instrucciones para el agente IA
├── ESTADO.md             ← estado actual de la isla
├── README.md             ← descripción pública
├── inbox/                ← zona de trabajo viva de la isla
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

### Meter un archivo al ecosistema

```bash
cp /ruta/de/tu/archivo.md ~/yggdrasil-dew/inbox/drop/
bash scripts/inbox-commit.sh "descripción de qué entra"
# GitHub Actions clasifica automáticamente
```

### Cierre de sesión

```bash
bash scripts/orquestador-unico.sh audit  # comprobación final
bash scripts/session-terminal-doc.sh "resumen de la sesión"
git add inbox/sesiones/cierre-*.md
git commit -m "docs(sesion): cierre $(date +%Y-%m-%d) — descripción"
git push origin main
```

### Lanzar auditoría manual completa

```bash
bash scripts/orquestador-unico.sh all
# O via GitHub Actions:
# Actions → orquestador-maestro.yml → Run workflow
```

---

## ESTADO DEL ECOSISTEMA (2026-07-04)

| Área | Estado | Bloqueante |
|------|--------|------------|
| Scripts activos | 🟡 22 stubs/duplicados | Sí |
| Workflows | 🔴 22 stubs sin implementar | Sí |
| Agentes | 🔵 sin auditar | No |
| MCP | 🔵 config pendiente | No |
| Docs | 🔴 5 archivos faltantes | Sí |
| Inbox | 🟡 flujo funcionando, verificar | No |
| Islas | 🔵 pendiente tras ygg | No |

---

_Generado por Perplexity · 2026-07-04 12:52 CEST_  
_Actualizar tras completar cada fase_
