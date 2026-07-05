# AUDITORIA-MAESTRA-COPILOT.md

> **Generado:** 2026-07-04 12:56 CEST  
> **Última actualización:** 2026-07-04 22:02 CEST — revisión nocturna + anti-desviación  
> **Por:** Perplexity + inspección directa del repo  
> **Para:** GitHub Copilot — leer COMPLETO antes de ejecutar cualquier acción  
> **Objetivo:** Auditoría total del ecosistema yggdrasil-dew al 100%  
> **⚠️ DECISIÓN ARQUITECTÓNICA:** Este es el ÚNICO archivo de auditoría en el repo.  
> No se crearán archivos de auditoría adicionales en la raíz ni en docs/.  
> Todo el estado vivo de la auditoría se actualiza aquí directamente.  
> Los reportes de resultados van a `inbox/_meta/` con fecha.

---

## ⛔ FILOSOFÍA DEL ECOSISTEMA — LEER ANTES DE ACTUAR

```
Este ecosistema es LOCAL y MINIMALISTA.
No conecta con APIs externas.
No usa Perplexity como servicio.
No añade nuevas capas de complejidad sin confirmación del owner.

Antes de proponer cualquier cosa, hazte estas preguntas:
  1. ¿Existe ya algo que haga esto en el repo?
  2. ¿Es imprescindible o es "nice to have"?
  3. ¿Lo ha pedido Álvaro explícitamente?

Si la respuesta a (1) es sí o a (3) es no → NO LO HAGAS.

Prohibido añadir:
  - Integraciones con APIs externas (Perplexity, OpenAI, etc.)
  - Dockerización nueva sin confirmación
  - Archivos de auditoría adicionales
  - Scripts duplicados
  - Workflows sin propósito real definido
```

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
   - audit: ...

❌ NUNCA:
   - Borrar archivos permanentemente sin moverlos antes
   - Tocar docker/, hardware/, infra/ sin confirmación explícita
   - Ejecutar scripts de seguridad (03, 09) sin confirmación
   - Crear archivos de auditoría fuera de inbox/_meta/
   - Crear un segundo archivo de auditoría en la raíz
   - Añadir integraciones con APIs externas (Perplexity, OpenAI, etc.)
   - Proponer dockerización nueva sin confirmación del owner
   - Crear scripts sin propósito operativo real y concreto
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

## PROGRESO DE LA AUDITORÍA (actualizar aquí)

| Fase | Descripción | Estado | Fecha | Observaciones |
|------|-------------|--------|-------|---------------|
| 0 | Crear archivo maestro + permisos + mapa | ✅ COMPLETO | 2026-07-04 12:56 | Perplexity |
| 0b | Scripts nuevos: inbox-commit.sh, inbox-clasificador.sh, orquestador-unico.sh, session-logger.sh, session-terminal-doc.sh | ✅ COMPLETO | 2026-07-04 ~01:00 | Perplexity |
| 0c | Revisión bloque Copilot externo — rechazado por desviación API | ✅ DOCUMENTADO | 2026-07-04 22:02 | Ver sección RECHAZADO |
| 1 | Limpieza scripts/ + archivado duplicados | 🔴 PENDIENTE | — | Próximo bloque |
| 2 | Workflows: stubs + duplicados | 🔴 PENDIENTE | — | — |
| 3 | Docs faltantes | 🔴 PENDIENTE | — | — |
| 4 | Agentes: README + workflows | 🔴 PENDIENTE | — | — |
| 5 | Informe final + ESTADO-SISTEMA | 🔴 PENDIENTE | — | — |
| 6 | Módulos siguientes: inbox, mcp, islas | 🔵 PLANIFICADO | — | Tras fase 5 |

---

## ⛔ BLOQUE RECHAZADO — 2026-07-04 noche

**Qué propuso Copilot externo:**  
Un script `scripts/maintenance/create_perplexity_patch.sh` que añadía:
- `tools/perplexity_adapter.py` (integración API externa)
- `agentes/agent-perplexity-informer/` (agente dependiente de API)
- `inbox/context/perplexity/` (carpeta nueva no acordada)
- `docker/mcp/`, `docker/retrieval/` (dockerización nueva)
- `scripts/agentes/agente-meta-deep.sh` (extracción PERCENT_COMPLETE vía API)
- `scripts/observador-obsidian.sh` (no solicitado)
- Workflows nuevos no alineados con el plan de auditoría

**Por qué se rechaza:**
1. Añade dependencia de API externa (Perplexity) — el ecosistema es LOCAL
2. Propone dockerización nueva sin confirmación del owner
3. Crea carpetas y scripts no acordados
4. Desvía a Copilot de la auditoría en curso
5. Contradice la filosofía minimalista del repo

**Qué sí se acepta del bloque:**
- El concepto de `master_run.sh` como punto de entrada único (ya cubierto por `orquestador-unico.sh`)
- El concepto de PR draft para cambios bot (ya en los permisos)
- El `OPERATIONAL-PLAYBOOK.md` → incorporar reglas útiles en `docs/` sin referencias a API

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
├── docker/               Docker/compose (NO TOCAR sin confirmación)
├── docs/                 Documentación técnica
├── formacion/            Recursos aprendizaje
├── hardware/             Config hardware (NO TOCAR sin confirmación)
├── inbox/                Zona de trabajo viva
│   ├── drop/             Zona de aterrizaje
│   ├── sesiones/         Logs y cierres
│   └── _meta/            Reportes de auditoría
├── infra/                Infraestructura (NO TOCAR sin confirmación)
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

### Scripts canónicos activos (los que SIEMPRE se mantienen)

```
apertura-sesion.sh         ← inicio de sesión
cierre-sesion.sh           ← cierre de sesión
orquestador-unico.sh       ← punto de entrada único del ecosistema
file-arrival-guardian.sh   ← guardián de estructura
inbox-commit.sh            ← commit rápido al ecosistema
inbox-clasificador.sh      ← clasificación de inbox/drop/
session-logger.sh          ← logger de terminal
session-terminal-doc.sh    ← documentación de cierre
copilot-mission-briefing.sh ← briefing para sesiones IA
agent-monitor.sh           ← monitorización de agentes
```

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
|----------|---------|--------|---------------------|
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
| `docs/mcp-config-guide.md` | Falta | Config Copilot + Gemini al MCP local |
| `docs/islas-mapa.md` | Verificar | Actualizar estado real de islas |
| `docs/ecosistema-flujo-completo.md` | Falta | Diagrama terminal→inbox→diarios |
| `docs/OPERATIONAL-PLAYBOOK.md` | Falta | Reglas operativas locales (sin APIs externas) |

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
    { "name": "start_session",      "script": "scripts/apertura-sesion.sh" },
    { "name": "close_session",      "script": "scripts/cierre-sesion.sh" },
    { "name": "commit_inbox",       "script": "scripts/inbox-commit.sh" },
    { "name": "classify_inbox",     "script": "scripts/inbox-clasificador.sh" },
    { "name": "gen_session_doc",    "script": "scripts/session-terminal-doc.sh" },
    { "name": "orchestrate",        "script": "scripts/orquestador-unico.sh" },
    { "name": "validate_structure", "script": "scripts/file-arrival-guardian.sh" },
    { "name": "sync_repos",         "script": "scripts/02-git-pull-rebase.sh" },
    { "name": "backup",             "script": "scripts/07-fase3-restic-backup.sh" },
    { "name": "start_ecosystem",    "script": "scripts/04-fase2-start-batcueva.sh" },
    { "name": "briefing",           "script": "scripts/copilot-mission-briefing.sh" },
    { "name": "monitor_agents",     "script": "scripts/agent-monitor.sh" }
  ],
  "blocked": [
    "deploy.sh", "deploy-madre.sh",
    "03-fase1-seguridad.sh", "09-fase8-seguridad-acer.sh"
  ]
}
```

---

## SECCIÓN 6 — PROMPT COMPLETO ANTI-DESVIACIÓN PARA COPILOT

> ⚠️ Usa este bloque cuando Copilot se desvíe o proponga cosas fuera del ecosistema local

```
LEE ESTO COMPLETO ANTES DE ACTUAR.
Archivos a leer en orden: AUDITORIA-MAESTRA-COPILOT.md, COPILOT-CONTEXT.md, CONVENCIONES.md

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
FILOSOFÍA DEL ECOSISTEMA (no negociable)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Este repo es LOCAL y MINIMALISTA.
NO conecta con APIs externas.
NO usa Perplexity como servicio externo.
NO añade complejidad nueva sin confirmación del owner.
Si propones algo que no está en AUDITORIA-MAESTRA-COPILOT.md → pregunta antes.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
BLOQUE 1 — LIMPIEZA scripts/
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. Crea scripts/archive/setup/ y scripts/archive/deprecated/
2. Mueve los 4 .md de scripts/ a inbox/_meta/ o diarios/ (ver Sección 1)
3. Mueve históricos (01, 03, 08, 09, 10) → scripts/archive/setup/
4. Mueve duplicados (12, 15, 18, 20) → scripts/archive/deprecated/
5. Audita scripts sin auditar: between-sessions.sh, code-drift-detector.sh,
   copilot-2fases.sh, copilot-fases.sh, cross-ref-checker.sh, deploy.sh, deploy-madre.sh
   → para cada uno: abre el fichero, lee qué hace, documenta en SCRIPTS-AUDITORIA.md
6. Define canónico para: deploy.sh vs deploy-madre.sh; copilot-2fases vs copilot-fases
7. Crea scripts/SCRIPTS-AUDITORIA.md con tabla: activos / archivados / deprecados / pendientes
8. Commit: "chore(scripts): limpieza fase 1 — archivado + inventario"
9. Push a main

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
BLOQUE 2 — WORKFLOWS (nivel DevOps real)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. Para cada uno de los 22 stubs (<200b):
   - Abre el fichero
   - Lee el nombre
   - Decide: ¿implementar con cuerpo mínimo real? ¿o deprecar?
   - Si deprecar: añade comentario en la primera línea: # DEPRECATED: usar [canónico alternativo]
   - Si implementar: añade trigger real + un step mínimo funcional
2. Consolida duplicados:
   - orquestador-supremo.yml → deprecar, canónico: orquestador-maestro.yml
   - orquestador-total.yml → deprecar, canónico: orquestador-maestro.yml
   - repo-health-check.yml → comparar con repo-health.yml → conservar el más completo
   - watchdog-monitor.yml vs watchdog.yml → consolidar en uno solo
3. Para cada workflow funcional (🟢): verifica que los scripts que llama existen en scripts/
4. Crea docs/workflows-inventario.md con tabla:
   - nombre | trigger | scripts que llama | estado | criticidad (crítico/importante/auxiliar/deprecado)
5. Commit: "audit(workflows): stubs implementados + duplicados deprecados + inventario"
6. Push a main

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
BLOQUE 3 — DOCS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Crea estos archivos. Sin inventar componentes. Sin APIs externas.
1. docs/scripts-diccionario.md
   → tabla con todos los scripts: nombre | propósito | estado | notas | canónico
2. docs/workflows-inventario.md
   → tabla: workflow | trigger | scripts | estado | criticidad
3. docs/agentes-manual.md
   → inventario de agentes/, qué hace cada uno, cómo se lanza
4. docs/mcp-config-guide.md
   → cómo conectar Copilot y Gemini CLI al MCP local del repo
5. docs/ecosistema-flujo-completo.md
   → diagrama textual: terminal → inbox/drop/ → inbox-clasificador → destino → workflow → diarios/
6. docs/OPERATIONAL-PLAYBOOK.md
   → reglas operativas del ecosistema (sin APIs externas, sin dockerización no acordada)
7. Actualiza docs/inbox-flujo.md con el flujo real vigente
8. Commit: "docs: inventarios scripts/workflows/agentes + playbook operativo"
9. Push a main

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
BLOQUE 4 — AGENTES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. Lista TODO lo que hay en agentes/
2. Para cada agente:
   a. ¿Tiene README.md? Si no → crear con: misión, comando, input, output, workflow asociado
   b. ¿Tiene workflow en .github/workflows/? Si no → crear uno mínimo con workflow_dispatch
   c. ¿Tiene dependencia de API externa? Si sí → documentar como bloqueado hasta decisión owner
3. Cruza agentes con workflows: ¿algún agente sin workflow? ¿algún workflow que llama a un agente inexistente?
4. Actualiza docs/agentes-manual.md
5. Commit: "docs(agentes): README.md para todos los agentes + workflows mínimos"
6. Push a main

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
BLOQUE 5 — CIERRE DE AUDITORÍA + SIGUIENTES MÓDULOS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. Crea inbox/_meta/auditoria-completa-2026-07-04.md con:
   - resumen de cada bloque ejecutado
   - archivos creados, movidos, deprecados
   - scripts canónicos activos
   - workflows funcionales
   - bloqueantes que quedaron pendientes
2. Actualiza CHANGELOG.md con todas las fases
3. Actualiza ESTADO-SISTEMA.md post-auditoría
4. Actualiza AUDITORIA-MAESTRA-COPILOT.md:
   - tabla PROGRESO marcando las fases completadas
   - tabla ESTADO DEL ECOSISTEMA actualizada
5. Añade sección "SIGUIENTES MÓDULOS" al final del archivo maestro:
   - inbox/ (consolidar sesiones/, verificar drop/, limpiar _meta/)
   - mcp/ (verificar server, whitelist, conexión local)
   - islas/ (mapeo + estructura mínima de cada isla)
   - yggdrasil-nosek (mismo proceso de auditoría)
6. Commit: "audit: cierre fase 1-5 + plan módulos siguientes"
7. Push a main

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
REGLAS ABSOLUTAS:
- No borres nada sin moverlo antes
- Sigue CONVENCIONES.md en todo momento
- NO crees archivos de auditoría fuera de inbox/_meta/
- NO añadas integraciones con APIs externas
- Confírmame qué hiciste antes de pasar al siguiente bloque
- Si algo no está claro: pregúntame
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## SECCIÓN 7 — ISLAS (módulo siguiente tras cerrar yggdrasil-dew)

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

## ESTADO DEL ECOSISTEMA (actualizar al final de cada fase)

| Área | Estado | Bloqueante | Fase que lo resuelve |
|------|--------|------------|----------------------|
| Scripts: .md fuera de sitio | 🔴 pendiente | Sí | Bloque 1 |
| Scripts: duplicados | 🔴 pendiente | Sí | Bloque 1 |
| Scripts: sin auditar (between-sessions, code-drift, etc.) | 🔴 pendiente | Sí | Bloque 1 |
| Workflows: 22 stubs | 🔴 pendiente | Sí | Bloque 2 |
| Workflows: duplicados orquestadores | 🔴 pendiente | No | Bloque 2 |
| Workflows: cruces con scripts | 🔴 pendiente | Sí | Bloque 2 |
| Docs: 6 archivos faltantes | 🔴 pendiente | Sí | Bloque 3 |
| Agentes: sin README | 🔵 sin auditar | No | Bloque 4 |
| inbox/sesiones/ vs sesiones/ duplicado | 🟡 verificar | No | Bloque 1 |
| MCP config local | 🔵 pendiente | No | Post-auditoría |
| Islas | 🔵 pendiente tras ygg | No | Post-auditoría |
| Bloque externo Copilot (Perplexity/API) | ⛔ rechazado | — | No aplica |

---

_Generado por Perplexity · 2026-07-04 12:56 CEST_  
_Actualizado 2026-07-04 22:02 CEST — anti-desviación + bloque completo 5 fases_  
_Actualizar tras completar cada bloque — NO crear archivos de auditoría adicionales_
