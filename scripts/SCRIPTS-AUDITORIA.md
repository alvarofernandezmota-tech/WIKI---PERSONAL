# SCRIPTS-AUDITORIA.md — Inventario completo de scripts

> **Generado:** 2026-07-03 por Perplexity  
> **Total scripts:** 34 (ficheros .sh + .py + subdirectorios)  
> **Propósito:** Auditoría de qué hace cada script, si sigue siendo útil, y si es candidato a MCP tool

---

## Leyenda

| Símbolo | Significado |
|---------|-------------|
| 🟢 | Activo, se usa regularmente |
| 🟡 | Activo pero necesita revisión / deprecar si hay duplicado |
| 🔴 | Probablemente obsoleto o sin uso |
| 🤖 | Candidato a MCP tool (el agente puede llamarlo) |
| 👤 | Solo uso humano manual |

---

## Grupo 1 — Sesión (inicio / cierre)

Son los scripts que lanzas tú al arrancar y cerrar el día.

| Script | Qué hace | Estado | MCP? |
|--------|----------|--------|------|
| `inicio-sesion.sh` | Git pull, verifica servicios, muestra estado del ecosistema | 🟢 | 🤖 `start_session` |
| `cierre-sesion.sh` | Guarda estado, git commit/push, genera resumen de sesión | 🟢 | 🤖 `close_session` |

**Acción:** Estos dos se lanzan siempre desde terminal. El MCP puede llamarlos para generar snapshots automáticos.

---

## Grupo 2 — Mantenimiento / Cron

Scripts que corren en background o con cron.

| Script | Qué hace | Estado | MCP? |
|--------|----------|--------|------|
| `maintenance/night-cron.sh` | Limpieza nocturna, backups, actualizaciones | 🟢 | 🤖 `run_night_cron` (dry-run) |
| `06-verificacion-post-reboot.sh` | Verifica que todo arranca bien tras reboot | 🟢 | 🤖 `verify_post_reboot` |
| `fix-permisos.sh` | Corrige permisos de ficheros críticos | 🟢 | 🤖 `fix_permissions` (dry-run) |
| `watchdog_adb.sh` | Watchdog ADB para dispositivos Android | 🟡 | 👤 manual |

---

## Grupo 3 — Inbox

Scripts de procesado del inbox (el "cerebro de entrada").

| Script | Qué hace | Estado | MCP? |
|--------|----------|--------|------|
| `inbox-cleanup-jun2026.sh` | Limpieza masiva del inbox (junio 2026) | 🟡 one-shot | 👤 manual |
| `inbox-cleanup-jun2024.sh` | Limpieza antigua (2024) | 🔴 obsoleto | ❌ archivar |
| `inbox-migrate.sh` | Migra entradas antiguas al nuevo formato | 🟡 migración | 👤 manual |
| `migrar-inbox.sh` | Versión anterior de inbox-migrate | 🔴 duplicado | ❌ archivar |
| `procesar-inbox-masivo.sh` | Procesa lote de entradas del inbox | 🟢 | 🤖 `process_inbox` |

**Acción:** Archivar `inbox-cleanup-jun2024.sh` y `migrar-inbox.sh`. Consolidar en `procesar-inbox-masivo.sh`.

---

## Grupo 4 — Seguridad

| Script | Qué hace | Estado | MCP? |
|--------|----------|--------|------|
| `03-fase1-seguridad.sh` | Setup inicial de seguridad (fase 1) | 🟡 setup histórico | 👤 manual |
| `09-fase8-seguridad-acer.sh` | Hardening específico Acer | 🟡 setup histórico | 👤 manual |
| `hardening-ufw.sh` | Reglas UFW, firewall | 🟢 | 🤖 `check_ufw_status` (read-only) |
| `scripts/seguridad/` | Subdirectorio con scripts de auditoría | 🟢 | 🤖 varios |

---

## Grupo 5 — Infraestructura / Setup

| Script | Qué hace | Estado | MCP? |
|--------|----------|--------|------|
| `04-fase2-start-batcueva.sh` | Arranca el stack completo (Batcueva) | 🟢 | 🤖 `start_ecosystem` (dry-run) |
| `batcueva-control.sh` | Control del stack: start/stop/restart | 🟢 | 🤖 `control_ecosystem` |
| `05-fase7-ollama-pull.sh` | Descarga modelos Ollama | 🟢 | 🤖 `pull_ollama_model` |
| `02-git-pull-rebase.sh` | Git pull con rebase en todos los repos | 🟢 | 🤖 `sync_repos` |
| `01-fix-driver-rtl8188ftu.sh` | Instala driver WiFi USB | 🟡 setup puntual | 👤 manual |
| `scripts/setup/` | Subdirectorio setup general | 🟡 | 👤 manual |
| `scripts/infra/` | Subdirectorio infra | 🟢 | 🤖 varios |
| `scripts/ci/` | Scripts de CI/CD | 🟢 | 🤖 `run_ci` |

---

## Grupo 6 — Backup

| Script | Qué hace | Estado | MCP? |
|--------|----------|--------|------|
| `07-fase3-restic-backup.sh` | Backup con Restic | 🟢 | 🤖 `run_backup` (dry-run obligatorio) |
| `scripts/backup/` | Subdirectorio con variantes de backup | 🟢 | 🤖 `check_backup_status` |

---

## Grupo 7 — Thdora (bot / asistente)

| Script | Qué hace | Estado | MCP? |
|--------|----------|--------|------|
| `08-fase6-thdora-handlers.sh` | Setup handlers de Thdora | 🟡 setup histórico | 👤 manual |
| `thdora-handlers.py` | Lógica de handlers del bot Thdora | 🟢 | 🤖 integrado en bot |
| `scripts/thdora/thdora-scaffold.sh` | Crea estructura de nuevo proyecto Thdora | 🟢 | 👤 manual |
| `scripts/thdora/bot-session-report.sh` | Genera reporte de sesión del bot | 🟢 | 🤖 `generate_bot_report` |
| `scripts/thdora-dev/` | Entorno de desarrollo de Thdora | 🟢 | 👤 manual |

---

## Grupo 8 — OSINT

| Script | Qué hace | Estado | MCP? |
|--------|----------|--------|------|
| `10-fase9-osint-stack.sh` | Instala/configura stack OSINT (Spiderfoot) | 🟡 setup histórico | 👤 manual |
| `scripts/osint/` | Scripts de escaneo OSINT | 🟢 | 🤖 `run_osint_scan` |

---

## Grupo 9 — Integraciones externas

| Script | Qué hace | Estado | MCP? |
|--------|----------|--------|------|
| `uptime-kuma-webhook.py` | Webhook para Uptime Kuma → Telegram | 🟢 | 🤖 `get_uptime_status` |
| `setup-labels.sh` | Crea labels en GitHub repos | 🟢 | 🤖 `setup_github_labels` |
| `scripts/bc` | Batcueva CLI shortcut | 🟢 | 👤 manual |

---

## Grupo 10 — Tests / Smoke

| Script | Qué hace | Estado | MCP? |
|--------|----------|--------|------|
| `scripts/tests/smoke-test-scripts.sh` | Smoke test de todos los scripts | 🟢 | 🤖 `run_smoke_tests` |

---

## Resumen de acciones

### Archivar (mover a `scripts/archive/`)
- `inbox-cleanup-jun2024.sh` — obsoleto (2024)
- `migrar-inbox.sh` — duplicado de `inbox-migrate.sh`

### Candidatos MCP tools (whitelist inicial)
```
start_session        → inicio-sesion.sh
close_session        → cierre-sesion.sh
process_inbox        → procesar-inbox-masivo.sh
check_ufw_status     → hardening-ufw.sh (read-only)
sync_repos           → 02-git-pull-rebase.sh
check_backup_status  → scripts/backup/ (read-only)
run_smoke_tests      → scripts/tests/smoke-test-scripts.sh
get_uptime_status    → uptime-kuma-webhook.py
generate_bot_report  → scripts/thdora/bot-session-report.sh
```

### Con dry-run obligatorio
```
run_night_cron       → maintenance/night-cron.sh
run_backup           → 07-fase3-restic-backup.sh
start_ecosystem      → 04-fase2-start-batcueva.sh
fix_permissions      → fix-permisos.sh
```

### BLOQUEADAS para agentes (solo humano)
```
merge_branch, deploy_production, install_drivers,
setup_security_hardening, osint_active_scan
```

---

_Auditado por Perplexity · 2026-07-03_
