# 📋 Script Registry — Yggdrasil-DEW

> Fuente de verdad de todos los scripts del ecosistema.
> Actualizado: 2026-07-03 [AUTO]

## Mapa de roles: Script → Agente → Trigger

| Script | Rol | Agente que lo usa | Trigger | Capa |
|--------|-----|-------------------|---------|------|
| `inbox-watcher.sh` | Sensor de buzón | — (systemd daemon) | inotify kernel | SENSOR |
| `create-issues.sh` | Crea issues [AUTO] | agente-roadmap | cron / GitHub Actions | ACCIÓN |
| `issue-creator.sh` | Crea issues desde ROADMAP | agente-roadmap | cron 19:00 UTC | ACCIÓN |
| `code-drift-detector.sh` | Detecta desviación del estándar | agente-calidad | push a scripts/ | ANÁLISIS |
| `audit-and-migrate.sh` | Audita y migra estructura repos | agente-mantenimiento | cron semanal | ANÁLISIS |
| `task-analyzer.sh` | Analiza tareas pendientes | agente-roadmap | cron diario | ANÁLISIS |
| `repo-research.sh` | Investiga repos externos | agente-investigacion | cron semanal | INVESTIGACIÓN |
| `apertura-sesion.sh` | Prepara entorno al iniciar sesión | — (manual) | login | UTILIDAD |
| `cierre-sesion.sh` | Cierra sesión con log | — (manual) | logout | UTILIDAD |
| `inicio-sesion.sh` | Script de inicio Batcueva | — (manual) | manual | UTILIDAD |
| `batcueva-control.sh` | Control servicios Batcueva | agente-salud | on-demand | CONTROL |
| `04-fase2-start-batcueva.sh` | Levanta stack Batcueva | agente-salud | reboot / manual | DESPLIEGUE |
| `05-fase7-ollama-pull.sh` | Actualiza modelos Ollama | agente-mantenimiento | cron semanal | MANTENIMIENTO |
| `06-verificacion-post-reboot.sh` | Verifica sistema tras reboot | agente-salud | reboot | SALUD |
| `07-fase3-restic-backup.sh` | Backup restic cifrado | agente-mantenimiento | cron diario | BACKUP |
| `08-fase6-thdora-handlers.sh` | Handlers Thdora bot | agente-thdora | webhook Telegram | BOT |
| `09-fase8-seguridad-acer.sh` | Hardening Acer | — (manual) | manual | SEGURIDAD |
| `10-fase9-osint-stack.sh` | Stack OSINT | agente-osint | manual / cron | OSINT |
| `hardening-ufw.sh` | Configura UFW | — (manual) | post-install | SEGURIDAD |
| `fix-permisos.sh` | Corrige permisos repo | — (manual) | on-demand | UTILIDAD |
| `setup-labels.sh` | Crea labels GitHub | — (manual/CI) | post-init | SETUP |
| `inbox-cleanup-jun2026.sh` | Limpieza inbox | agente-mantenimiento | cron mensual | LIMPIEZA |
| `procesar-inbox-masivo.sh` | Procesa inbox en lote | agente-mantenimiento | on-demand | PROCESADO |
| `inbox-migrate.sh` | Migra inbox a nueva estructura | — (manual) | on-demand | MIGRACIÓN |
| `watchdog_adb.sh` | Watchdog ADB dispositivos | agente-salud | cron 5min | WATCHDOG |
| `thdora-handlers.py` | Handlers Python Thdora | agente-thdora | webhook | BOT |
| `uptime-kuma-webhook.py` | Webhook Uptime Kuma | agente-salud | alert trigger | SALUD |

## Librería común

| Archivo | Rol |
|---------|-----|
| `scripts/lib/common.sh` | Funciones compartidas: log(), create_issue(), dry_run_exec(), git_push_with_retry() |

## Scripts pendientes de crear

| Script | Descripción | Prioridad |
|--------|-------------|----------|
| `ecosystem-snapshot.sh` | Genera JSON de estado para health-agent | 🔴 ALTA |
| `qdrant-ingest.sh` | Ingesta logs en Qdrant para RAG | 🟡 MEDIA |
| `retry-failed-pushes.sh` | Reintenta pushes fallidos de inbox-watcher | 🟡 MEDIA |
| `agent-eval.sh` | Tests de comportamiento de agentes | 🟠 ALTA |
| `mcp-health-check.sh` | Verifica que el MCP server responde | 🟡 MEDIA |

## Flujo de activación completo

```
Evento (push/cron/webhook/inotify)
         ↓
   Trigger (GitHub Actions / systemd / cron)
         ↓
   Script (sensor/análisis/acción)
         ↓
   Agente (LLM + FastAPI) ← opcional para decisiones
         ↓
   Acción (issue / push / telegram / docker restart)
         ↓
   Log → Qdrant RAG → memoria del sistema
```
