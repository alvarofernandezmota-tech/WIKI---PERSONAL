# SCRIPTS-AUDITORIA.md — Inventario completo de scripts

> **Generado:** 2026-07-04 por Perplexity  
> **Última auditoría anterior:** 2026-07-03  
> **Total scripts `.sh`:** ~45 (raíz de `scripts/`) + subdirectorios  
> **Propósito:** Auditoría de qué hace cada script, si sigue siendo útil, y si es candidato a MCP tool

---

## Leyenda

| Símbolo | Significado |
|---------|-------------|
| 🟢 | Activo, se usa regularmente |
| 🟡 | Activo pero necesita revisión / deprecar si hay duplicado |
| 🔴 | Probablemente obsoleto o sin uso |
| 🚨 | **FUERA DE SITIO** — archivo mal colocado, requiere acción |
| 🆕 | Nuevo desde auditoría 2026-07-03 |
| 🤖 | Candidato a MCP tool (el agente puede llamarlo) |
| 👤 | Solo uso humano manual |

---

## ⚠️ PROBLEMA DETECTADO — Archivos .md dentro de scripts/

Estos archivos NO deben estar en `scripts/`. Solo deben existir `.sh`, `.py` y subdirectorios.

| Archivo | Dónde debería estar | Acción |
|---------|---------------------|--------|
| `scripts/2026-07-03-23-05-struct-auditor-output.md` 🚨 | `inbox/_meta/` | Mover manualmente o via `inbox-clasificador.sh` |
| `scripts/2026-07-03-cierre-sesion-completo.md` 🚨 | `diarios/` | Mover manualmente |
| `scripts/2026-07-03-inbox-audit-consolidado.md` 🚨 | `inbox/_meta/` | Mover manualmente |
| `scripts/2026-07-03-reality-check.md` 🚨 | `diarios/` o `inbox/_meta/` | Mover manualmente |
| `scripts/README.md` | `scripts/` ✅ | Permitido (documentación raíz) |
| `scripts/SCRIPTS-AUDITORIA.md` | `scripts/` ✅ | Permitido (este archivo) |
| `scripts/SCRIPTS.md` | `scripts/` ✅ | Permitido (documentación raíz) |

**Comandos para limpiarlos desde terminal:**
```bash
# Mover reportes de auditoría
mv scripts/2026-07-03-23-05-struct-auditor-output.md inbox/_meta/
mv scripts/2026-07-03-inbox-audit-consolidado.md inbox/_meta/

# Mover cierres de sesión
mv scripts/2026-07-03-cierre-sesion-completo.md diarios/
mv scripts/2026-07-03-reality-check.md diarios/

# Commitear la limpieza
git add -A && git commit -m "fix(estructura): mover .md fuera de scripts/ a sus destinos correctos" && git push
```

---

## Grupo 0 — Scripts de flujo (NUEVOS 2026-07-04) 🆕

Scripts añadidos esta madrugada para el flujo terminal → inbox → diarios.

| Script | Qué hace | Estado | MCP? |
|--------|----------|--------|------|
| `inbox-commit.sh` 🆕 | **UN comando**: copia archivo a `inbox/drop/`, git add + commit + push | 🟢 uso diario | 🤖 `commit_to_inbox` |
| `inbox-clasificador.sh` 🆕 | Mueve archivos de `inbox/drop/` al destino correcto según nombre/extensión | 🟢 | 🤖 `classify_inbox` (dry-run) |
| `session-logger.sh` 🆕 | Captura todo lo que ocurre en terminal y genera log en `inbox/sesiones/` | 🟢 | 👤 source manual |
| `session-terminal-doc.sh` 🆕 | Genera documento de cierre de sesión con estado del repo | 🟢 | 🤖 `generate_session_doc` |
| `orquestador-unico.sh` 🆕 | Punto de entrada único para ejecutar todos los agentes en orden | 🟢 | 🤖 `orchestrate` |

**Uso desde terminal:**
```bash
# Inicio sesión
source scripts/session-logger.sh

# Meter archivo al ecosistema
bash scripts/inbox-commit.sh "descripción"

# Cierre sesión
bash scripts/session-terminal-doc.sh "descripción de la sesión"
git add inbox/sesiones/cierre-*.md && git commit -m "docs(sesion): cierre" && git push
```

---

## Grupo 1 — Sesión (inicio / cierre)

| Script | Qué hace | Estado | MCP? |
|--------|----------|--------|------|
| `apertura-sesion.sh` | Git pull, verifica servicios, muestra estado del ecosistema | 🟢 | 🤖 `start_session` |
| `apertura-maestra.sh` | Versión extendida de apertura — lanza todo el stack | 🟡 solapamiento con `apertura-sesion` | 👤 revisar si consolidar |
| `cierre-sesion.sh` | Guarda estado, git commit/push, genera resumen | 🟢 | 🤖 `close_session` |
| `cierre-maestro.sh` | Cierre completo del ecosistema (servicios + commit) | 🟡 solapamiento con `cierre-sesion` | 👤 revisar si consolidar |
| `between-sessions.sh` | Tareas entre sesiones (sync, limpieza ligera) | 🟡 poco documentado | 👤 revisar |

**Pendiente auditar:** `apertura-maestra.sh` vs `apertura-sesion.sh` — ¿son duplicados? Decidir cuál es el canónico.

---

## Grupo 2 — Orquestación / Auditoría

| Script | Qué hace | Estado | MCP? |
|--------|----------|--------|------|
| `orquestador-unico.sh` 🆕 | Punto de entrada único para todas las fases | 🟢 | 🤖 `orchestrate` |
| `auditoria-maestra.sh` | Auditoría general del ecosistema | 🟡 solapamiento con `orquestador-unico` | 👤 revisar |
| `audit-and-migrate.sh` | Audita estructura y migra archivos mal ubicados | 🟡 solapamiento | 👤 revisar |
| `clasificador-maestro.sh` | Clasificación masiva de archivos | 🟡 solapamiento con `inbox-clasificador` | 👤 revisar |
| `file-arrival-guardian.sh` | Valida que archivos lleguen al sitio correcto | 🟢 | 🤖 `validate_structure` (--dry-run) |
| `cross-ref-checker.sh` | Verifica referencias cruzadas entre archivos | 🟡 poco claro | 🔴 auditar |
| `code-drift-detector.sh` | Detecta derivaciones en el código | 🟡 poco claro | 🔴 auditar |

---

## Grupo 3 — Mantenimiento / Cron

| Script | Qué hace | Estado | MCP? |
|--------|----------|--------|------|
| `06-verificacion-post-reboot.sh` | Verifica que todo arranca bien tras reboot | 🟢 | 🤖 `verify_post_reboot` |
| `agent-monitor.sh` | Monitoriza agentes en ejecución | 🟢 | 🤖 `monitor_agents` |

---

## Grupo 4 — Inbox

| Script | Qué hace | Estado | MCP? |
|--------|----------|--------|------|
| `inbox-commit.sh` 🆕 | Commit al inbox (ver Grupo 0) | 🟢 | 🤖 |
| `inbox-clasificador.sh` 🆕 | Clasificador de inbox (ver Grupo 0) | 🟢 | 🤖 |

---

## Grupo 5 — Seguridad

| Script | Qué hace | Estado | MCP? |
|--------|----------|--------|------|
| `03-fase1-seguridad.sh` | Setup inicial de seguridad (fase 1) | 🟡 setup histórico | 👤 manual |
| `09-fase8-seguridad-acer.sh` | Hardening específico Acer | 🟡 setup histórico | 👤 manual |

---

## Grupo 6 — Infraestructura / Setup

| Script | Qué hace | Estado | MCP? |
|--------|----------|--------|------|
| `04-fase2-start-batcueva.sh` | Arranca el stack completo (Batcueva) | 🟢 | 🤖 `start_ecosystem` (dry-run) |
| `batcueva-control.sh` | Control del stack: start/stop/restart | 🟢 | 🤖 `control_ecosystem` |
| `05-fase7-ollama-pull.sh` | Descarga modelos Ollama | 🟢 | 🤖 `pull_ollama_model` |
| `02-git-pull-rebase.sh` | Git pull con rebase | 🟢 | 🤖 `sync_repos` |
| `01-fix-driver-rtl8188ftu.sh` | Instala driver WiFi USB | 🟡 setup puntual | 👤 manual |
| `deploy.sh` | Deploy general | 🟢 | 👤 manual (riesgo) |
| `deploy-madre.sh` | Deploy completo del ecosistema madre | 🟡 solapamiento con `deploy.sh` | 👤 revisar |

---

## Grupo 7 — Backup

| Script | Qué hace | Estado | MCP? |
|--------|----------|--------|------|
| `07-fase3-restic-backup.sh` | Backup con Restic | 🟢 | 🤖 `run_backup` (dry-run obligatorio) |

---

## Grupo 8 — Thdora / Copilot

| Script | Qué hace | Estado | MCP? |
|--------|----------|--------|------|
| `08-fase6-thdora-handlers.sh` | Setup handlers de Thdora | 🟡 setup histórico | 👤 manual |
| `copilot-fases.sh` | Gestión de fases del copilot | 🟡 por auditar | 🔴 auditar |
| `copilot-2fases.sh` | Variante 2 fases del copilot | 🟡 solapamiento | 🔴 auditar |
| `copilot-mission-briefing.sh` | Genera briefing de misión para el copilot | 🟢 | 🤖 `generate_briefing` |
| `create-issues.sh` | Crea issues en GitHub | 🟢 | 🤖 `create_github_issues` |

---

## Grupo 9 — OSINT

| Script | Qué hace | Estado | MCP? |
|--------|----------|--------|------|
| `10-fase9-osint-stack.sh` | Instala/configura stack OSINT | 🟡 setup histórico | 👤 manual |

---

## Resumen de acciones pendientes

### 🚨 URGENTE — Mover archivos .md fuera de scripts/
Ver tabla al inicio del documento. Comandos incluidos arriba.

### 🔴 Pendiente auditar (sin uso claro)
- `cross-ref-checker.sh` — ¿qué referencias cruza exactamente?
- `code-drift-detector.sh` — ¿contra qué baseline detecta drift?
- `copilot-fases.sh` vs `copilot-2fases.sh` — ¿son versiones del mismo script? ¿cuál es el actual?
- `apertura-maestra.sh` vs `apertura-sesion.sh` — decidir cuál es el canónico
- `cierre-maestro.sh` vs `cierre-sesion.sh` — lo mismo
- `deploy.sh` vs `deploy-madre.sh` — consolidar en uno

### 🤖 Whitelist MCP tools confirmada
```
start_session          → apertura-sesion.sh
close_session          → cierre-sesion.sh
commit_to_inbox        → inbox-commit.sh
classify_inbox         → inbox-clasificador.sh (--dry-run primero)
generate_session_doc   → session-terminal-doc.sh
orchestrate            → orquestador-unico.sh
validate_structure     → file-arrival-guardian.sh (--dry-run)
sync_repos             → 02-git-pull-rebase.sh
run_backup             → 07-fase3-restic-backup.sh (dry-run obligatorio)
start_ecosystem        → 04-fase2-start-batcueva.sh (dry-run)
generate_briefing      → copilot-mission-briefing.sh
monitor_agents         → agent-monitor.sh
```

### 🚫 BLOQUEADAS para agentes (solo humano)
```
deploy.sh / deploy-madre.sh
03-fase1-seguridad.sh / 09-fase8-seguridad-acer.sh
01-fix-driver-rtl8188ftu.sh
10-fase9-osint-stack.sh
```

---

_Auditado por Perplexity · 2026-07-04 12:24 CEST_
