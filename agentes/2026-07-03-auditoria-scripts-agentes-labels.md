# AUDITORÍA COMPLETA — Scripts, Agentes, Labels y Fase Actual

**Fecha:** 2026-07-03 23:49 CEST  
**Estado:** 🔵 EN PROCESO  
**Tipo:** Auditoría + Hoja de ruta  
**Generado por:** Perplexity MCP Session  

---

## 📍 FASE ACTUAL: FASE 3 — ESTANDARIZACIÓN Y ACTIVACIÓN

```
FASE 1 ✅ COMPLETADA — Estructura base + scripts core creados
FASE 2 ✅ COMPLETADA — Auditoría y detección de gaps (reality-check, struct-auditor, ghost-file-detector)
FASE 3 🔵 EN PROCESO — Estandarizar plantilla única + activar scripts + labels
FASE 4 ⬜ PENDIENTE  — MCP server operativo (socket activo) + agentes autónomos GitHub
FASE 5 ⬜ PENDIENTE  — Propagación a islas (MAPA-ISLAS auto-sync)
```

---

## 🗂 INVENTARIO COMPLETO DE SCRIPTS — Estado real

### Scripts raíz (`scripts/*.sh`)

| Script | Función única | Plantilla OK | Doc inbox | Abre issue | Estado |
|--------|--------------|:---:|:---:|:---:|--------|
| `apertura-sesion.sh` | Abre sesión de trabajo + contexto | ⚠️ | ⚠️ | ❌ | 🟡 REVISAR |
| `inicio-sesion.sh` | Chequeo inicial del sistema | ⚠️ | ⚠️ | ❌ | 🟡 REVISAR |
| `cierre-sesion.sh` | Cierre completo + documentación | ⚠️ | ⚠️ | ❌ | 🟡 REVISAR |
| `between-sessions.sh` | Mantiene estado entre sesiones | ⚠️ | ❌ | ❌ | 🔴 ACTUALIZAR |
| `orquestador-supremo.sh` | Orquesta todos los agentes | ⚠️ | ❌ | ❌ | 🔴 ACTUALIZAR |
| `orquestador-total.sh` | Orquestación total del ecosistema | ⚠️ | ❌ | ❌ | 🔴 ACTUALIZAR |
| `agent-monitor.sh` | Monitor de estado de agentes | ⚠️ | ❌ | ❌ | 🔴 ACTUALIZAR |
| `struct-auditor.sh` | Detecta carpetas duplicadas/fantasma | ⚠️ | ✅ | ❌ | 🟡 REVISAR |
| `ghost-file-detector.sh` | Detecta archivos vacíos/huérfanos | ⚠️ | ❌ | ❌ | 🔴 ACTUALIZAR |
| `tool-inventory-auditor.sh` | Audita que todos los scripts tengan FUNCIÓN declarada | ⚠️ | ❌ | ❌ | 🔴 ACTUALIZAR |
| `cross-ref-checker.sh` | Verifica links internos en docs | ⚠️ | ❌ | ❌ | 🔴 ACTUALIZAR |
| `isla-sync-validator.sh` | Valida MAPA-ISLAS vs repo real | ⚠️ | ❌ | ❌ | 🔴 ACTUALIZAR |
| `issue-creator.sh` | Crea issues en GitHub vía gh CLI | ✅ | ✅ | — | ✅ OK |
| `create-issues.sh` | Batch de issues iniciales | ✅ | ✅ | — | ✅ OK |
| `setup-labels.sh` | Configura labels en GitHub | ✅ | ❌ | — | 🟡 REVISAR |
| `gestor-estados-inbox.sh` | Gestiona estados de archivos inbox | ✅ | ✅ | — | ✅ OK |
| `clasificador-maestro.sh` | Clasifica archivos a islas correctas | ✅ | ❌ | ❌ | 🟡 REVISAR |
| `audit-and-migrate.sh` | Audita + migra archivos viejos | ✅ | ✅ | — | ✅ OK |
| `inbox-cleanup-jun2026.sh` | Limpieza masiva inbox jun2026 | ✅ | ✅ | — | ✅ OK |
| `inbox-migrate.sh` | Migra archivos entre islas | ✅ | ❌ | ❌ | 🟡 REVISAR |
| `inbox-watcher.sh` | Vigila inbox en tiempo real | ✅ | ❌ | ❌ | 🟡 REVISAR |
| `procesar-inbox-masivo.sh` | Procesado masivo de inbox | ✅ | ❌ | ❌ | 🟡 REVISAR |
| `deploy-madre.sh` | Deploy completo en Madre | ✅ | ❌ | ❌ | 🟡 REVISAR |
| `deploy.sh` | Deploy genérico | ✅ | ❌ | ❌ | 🟡 REVISAR |
| `ecosystem-snapshot.sh` | Snapshot del ecosistema completo | ✅ | ❌ | ❌ | 🟡 REVISAR |
| `code-drift-detector.sh` | Detecta desviación de código vs docs | ✅ | ❌ | ❌ | 🔴 ACTUALIZAR |
| `repo-research.sh` | Investiga estructura del repo | ✅ | ✅ | — | ✅ OK |
| `task-analyzer.sh` | Analiza tareas pendientes | ✅ | ❌ | ❌ | 🟡 REVISAR |
| `watchdog-monitor.sh` | Watchdog del sistema | ✅ | ❌ | ❌ | 🟡 REVISAR |
| `batcueva-control.sh` | Control del entorno BatCueva | ✅ | ❌ | ❌ | 🟡 REVISAR |
| `galatea-fabrica-agentes.sh` | Fábrica de agentes Galatea | ✅ | ❌ | ❌ | 🟡 REVISAR |
| `galatea-islas-bots.sh` | Bots de islas Galatea | ✅ | ❌ | ❌ | 🟡 REVISAR |
| `galatea-scan.sh` | Escaneo Galatea | ✅ | ❌ | ❌ | 🟡 REVISAR |
| `copilot-fases.sh` | Fases para Copilot (existente) | ⚠️ | ❌ | ❌ | 🔴 REEMPLAZAR con nuevo |
| `template-insure.sh` | Asegura plantilla en scripts | ✅ | ❌ | ❌ | 🟡 REVISAR |
| `fix-permisos.sh` | Fix de permisos de archivos | ✅ | ❌ | — | 🟡 REVISAR |
| `hardening-ufw.sh` | Hardening firewall UFW | ✅ | ❌ | — | 🟡 REVISAR |
| `entrypoint.sh` | Entrypoint Docker | ✅ | ❌ | — | 🟡 REVISAR |

### Scripts de fases numeradas (`01-` a `10-`)

| Script | Descripción | Estado |
|--------|-------------|--------|
| `01-fix-driver-rtl8188ftu.sh` | Fix driver WiFi RTL | ✅ OK |
| `02-git-pull-rebase.sh` | Git pull con rebase | ✅ OK |
| `03-fase1-seguridad.sh` | Fase 1 seguridad | ✅ OK |
| `04-fase2-start-batcueva.sh` | Fase 2 arranque BatCueva | ✅ OK |
| `05-fase7-ollama-pull.sh` | Fase 7 pull modelos Ollama | ✅ OK |
| `06-verificacion-post-reboot.sh` | Verificación post-reboot | ✅ OK |
| `07-fase3-restic-backup.sh` | Fase 3 backup Restic | ✅ OK |
| `08-fase6-thdora-handlers.sh` | Fase 6 handlers Thdora | ✅ OK |
| `09-fase8-seguridad-acer.sh` | Fase 8 seguridad Acer | ✅ OK |
| `10-fase9-osint-stack.sh` | Fase 9 stack OSINT | ✅ OK |

---

## 🤖 INVENTARIO AGENTES — `scripts/agentes/`

> ⚠️ PENDIENTE: Necesita listado manual de `scripts/agentes/` — se procesará en Fase 3

**Agentes confirmados por conversación:**
- `thdora-guardian[bot]` — audita pushes → mueve a inbox ✅
- `inbox-cleanup` Action — limpia inbox ✅
- `reality-check` Action — compara doc vs realidad ✅
- `health-check` Action — pulso del sistema ✅
- `diary-writer` Action — escribe diario automáticamente ✅
- `mcp_server.py` — expone tools a agentes vía socket ⚠️ (socket NO activo)

**Agentes pendientes de crear:**
- `conversation-logger` — guarda resumen sesión en inbox/diary ❌
- `label-manager` — gestiona labels automáticamente ❌
- `completion-tracker` — mueve etiquetas completado/en proceso/pendiente ❌

---

## 🏷 LABELS — Revisión y propuesta nueva

### Labels actuales (confirmar con `gh label list`)

### Labels propuestas nuevas normas:

```
## ESTADO DE PROGRESO
✅ completado        — verde       #28a745  — Tarea finalizada y verificada
🔵 en-proceso        — azul        #0075ca  — Actualmente en ejecución
⬜ pendiente         — gris        #e4e669  — Por hacer, sin empezar
🔴 bloqueado         — rojo        #d73a4a  — No puede avanzar sin acción previa
🟡 revisar           — amarillo    #fbca04  — Necesita revisión antes de continuar
📦 aplazado          — púrpura     #8250df  — Decidido aplazar, no urgente
🔄 en-revision       — naranja     #e99695  — En revisión activa por agente/humano

## TIPO DE TRABAJO
auto:script          — #bfd4f2  — Generado/ejecutado por script
auto:action          — #bfd4f2  — Generado/ejecutado por GitHub Action
auto:agente          — #bfd4f2  — Generado/ejecutado por agente
doc:inbox            — #f9d0c4  — Documentación pendiente en inbox
doc:diary            — #f9d0c4  — Registrado en diary
bug:ghost-file       — #ee0701  — Archivo fantasma detectado
bug:duplicado        — #ee0701  — Duplicación de carpeta/archivo
bug:struct           — #ee0701  — Error estructural del repo
infra:madre          — #0e8a16  — Relacionado con Madre
infra:isla           — #0e8a16  — Relacionado con una isla
agente:thdora        — #cfd3d7  — Acción de Thdora
agente:copilot       — #cfd3d7  — Acción de Copilot
prioridad:alta       — #b60205  — Alta prioridad
prioridad:media      — #e4e669  — Media prioridad
prioridad:baja       — #0075ca  — Baja prioridad
```

---

## 📋 PLANTILLA ÚNICA OBLIGATORIA — Todos los scripts

Cada script debe tener esta cabecera EXACTA:

```bash
#!/usr/bin/env bash
# =============================================================================
# SCRIPT: nombre-del-script.sh
# VERSIÓN: 1.0.0
# FUNCIÓN ÚNICA: [descripción en UNA línea de qué hace y solo qué hace]
# AUTOR: alvaro@yggdrasil-dew
# REPO: alvarofernandezmota-tech/yggdrasil-dew
# CREADO: YYYY-MM-DD
# ACTUALIZADO: YYYY-MM-DD
# USO: ./nombre-del-script.sh [args]
# DEPENDENCIAS: gh, git, jq (lista exacta)
# DOCUMENTA EN: inbox/[isla]/YYYY-MM-DD-nombre.md
# ABRE ISSUE SI: [condición — ej: estructura duplicada detectada]
# =============================================================================
set -euo pipefail
```

Y siempre terminar con bloque de documentación:

```bash
# --- DOCUMENTAR EN INBOX ---
FECHA=$(date +%Y-%m-%d-%H-%M)
cat >> "inbox/YYYY-MM-DD-${SCRIPT_NAME}-output.md" << EOF
## ${SCRIPT_NAME} — ${FECHA}
- Estado: COMPLETADO / ERROR
- Resultado: ...
EOF
```

---

## 🚦 RESUMEN DE ESTADO — Semáforo

| Categoría | OK ✅ | Revisar 🟡 | Actualizar 🔴 |
|-----------|:---:|:---:|:---:|
| Scripts core sesión | 3 | 0 | 1 |
| Scripts auditoría | 4 | 2 | 3 |
| Scripts inbox | 3 | 4 | 0 |
| Scripts deploy/infra | 2 | 4 | 0 |
| Scripts agentes | 2 | 3 | 2 |
| Labels sistema | 0 | 1 | 1 |
| MCP server | 0 | 0 | 1 |

**Total scripts:** 48+ en `scripts/`  
**Con plantilla OK:** ~30%  
**Con doc inbox:** ~40%  
**Con apertura issue automático:** ~10%  

---

## ⏭ SIGUIENTE ACCIÓN INMEDIATA

1. **Ejecutar `setup-labels.sh`** con el nuevo listado de labels (actualizar primero el script)
2. **Actualizar `copilot-fases.sh`** → usar el nuevo `copilot-2fases.sh`
3. **Añadir plantilla única** a los 🔴 scripts críticos: `orquestador-*.sh`, `cierre-sesion.sh`, `struct-auditor.sh`
4. **Activar MCP socket** en Madre para autonomía GitHub
5. **Crear agente `completion-tracker`** que gestione labels automáticamente

---

*Documento generado automáticamente por Perplexity MCP Session — 2026-07-03 23:49 CEST*  
*Estado: 🔵 EN PROCESO — actualizar a ✅ cuando labels y plantillas estén aplicados*
