---
type: audit
date: 2026-07-03
hora: 20:39
source: ecosystem-reality-check.sh
priority: high
status: pending
processed_by: pending
title: Reality Check 2026-07-03 20:39
---

# 🔍 Ecosystem Reality Check — 2026-07-03 20:39

> Auditoría automática del estado real vs documentado.
> Generado por 


## 1. Scripts — Inventario y estado

| Métrica | Valor |
|---------|-------|
| Total scripts | 93 |
| Ejecutables (chmod +x) | 52 |
| Sin permisos ejecución | 41 |
| En raíz scripts/ (sin organizar) | 48 |
| En subdirectorios | 45 |

### Scripts en raíz (candidatos a migrar a subdirs)
- `01-fix-driver-rtl8188ftu.sh`
- `02-git-pull-rebase.sh`
- `03-fase1-seguridad.sh`
- `04-fase2-start-batcueva.sh`
- `05-fase7-ollama-pull.sh`
- `06-verificacion-post-reboot.sh`
- `07-fase3-restic-backup.sh`
- `08-fase6-thdora-handlers.sh`
- `09-fase8-seguridad-acer.sh`
- `10-fase9-osint-stack.sh`
- `agent-monitor.sh`
- `apertura-sesion.sh`
- `audit-and-migrate.sh`
- `batcueva-control.sh`
- `between-sessions.sh`
- `cierre-sesion.sh`
- `clasificador-maestro.sh`
- `code-drift-detector.sh`
- `create-issues.sh`
- `cross-ref-checker.sh`
- `deploy-madre.sh`
- `deploy.sh`
- `ecosystem-snapshot.sh`
- `fix-permisos.sh`
- `galatea-fabrica-agentes.sh`
- `galatea-islas-bots.sh`
- `galatea-scan.sh`
- `gestor-estados-inbox.sh`
- `ghost-file-detector.sh`
- `hardening-ufw.sh`
- `inbox-cleanup-jun2026.sh`
- `inbox-migrate.sh`
- `inbox-watcher.sh`
- `inicio-sesion.sh`
- `isla-sync-validator.sh`
- `issue-creator.sh`
- `orquestador-supremo.sh`
- `orquestador-total.sh`
- `procesar-inbox-masivo.sh`
- `repo-research.sh`
- `setup-labels.sh`
- `struct-auditor.sh`
- `task-analyzer.sh`
- `thdora-handlers.py`
- `tool-inventory-auditor.sh`
- `uptime-kuma-webhook.py`
- `watchdog-monitor.sh`
- `watchdog_adb.sh`

### Scripts potencialmente duplicados
_Ninguno detectado_

## 2. GitHub Actions — Inventario

| Workflow | Trigger | Estado |
|----------|---------|--------|
| `agent-monitor.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `audit-on-push.yml` | push | 🟢 ACTIVO |
| `auto-investigacion.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `autonomous-cron.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `between-sessions.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `clasificador-maestro.yml` | push workflow_dispatch | 🟢 ACTIVO |
| `clasificador.yml` | push | 🟢 ACTIVO |
| `code-drift.yml` | push schedule workflow_dispatch | 🟢 ACTIVO |
| `context-reminder.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `cross-ref-checker.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `deuda-tecnica.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `diary-writer.yml` | push workflow_dispatch | 🟢 ACTIVO |
| `ecosystem-guardian.yml` | push schedule workflow_dispatch # manual desde Telegram via API | 🟢 ACTIVO |
| `galatea.yml` | workflow_dispatch schedule | 🟢 ACTIVO |
| `gestor-estados-inbox.yml` | push schedule workflow_dispatch | 🟢 ACTIVO |
| `ghost-file-detector.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `health-check.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `inbox-cleanup.yml` | schedule push workflow_dispatch | 🟢 ACTIVO |
| `inbox-dispatcher.yml` | push workflow_dispatch | 🟢 ACTIVO |
| `inbox-health.yml` | push schedule workflow_dispatch | 🟢 ACTIVO |
| `inbox-processor.yml` | push schedule workflow_dispatch | 🟢 ACTIVO |
| `isla-context-sync.yml` | push schedule | 🟢 ACTIVO |
| `isla-sync-validator.yml` | push workflow_dispatch | 🟢 ACTIVO |
| `islas-health.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `issue-creator.yml` | schedule push workflow_dispatch | 🟢 ACTIVO |
| `lint-commits.yml` | push pull_request | 🟢 ACTIVO |
| `mapa-islas-sync.yml` | pull_request push | 🟢 ACTIVO |
| `new-file-bootstrap.yml` | push | 🟢 ACTIVO |
| `orquestador-maestro.yml` | push pull_request schedule | 🟢 ACTIVO |
| `orquestador-supremo.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `reality-check.yml` | schedule push workflow_dispatch | 🟢 ACTIVO |
| `repo-audit.yml` | push | 🟢 ACTIVO |
| `repo-health-check.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `repo-health.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `repo-research-on-push.yml` | push workflow_dispatch | 🟢 ACTIVO |
| `resumen-diario.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `session-close.yml` | workflow_dispatch push | 🟢 ACTIVO |
| `struct-auditor.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `sync-drive.yml` | schedule workflow_dispatch # permite ejecución manual desde GitHub Actions | 🟢 ACTIVO |
| `sync-estado.yml` | schedule workflow_dispatch # También manual desde GitHub | 🟢 ACTIVO |
| `test-scripts.yml` | push pull_request | 🟢 ACTIVO |
| `tool-inventory-auditor.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `tripwire-repo.yml` | push pull_request | 🟢 ACTIVO |
| `watchdog-monitor.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `yamllint.yml` | push pull_request | 🟢 ACTIVO |

## 3. Servicios Docker (Madre)

| Contenedores corriendo | 0 |
| Contenedores parados | 0 |

### Contenedores activos
```
NAMES     STATUS    IMAGE
```

## 4. Servicios HTTP — Estado

| Servicio | URL | Estado |
|----------|-----|--------|
| n8n | `http://localhost:5678` | ❌ DOWN |
| Portainer | `http://localhost:9000` | ❌ DOWN |
| Uptime-Kuma | `http://localhost:3001` | ❌ DOWN |
| Ollama | `http://localhost:11434` | ❌ DOWN |
| Gitea | `http://localhost:3002` | ❌ DOWN |
| health-agent | `http://localhost:8000` | ❌ DOWN |
| Qdrant | `http://localhost:6333` | ❌ DOWN |
| Grafana | `http://localhost:3000` | ❌ DOWN |
| Open-WebUI | `http://localhost:8080` | ❌ DOWN |

## 5. Discordancias detectadas

### Scripts referenciados en README pero no encontrados

### TODOs/FIXMEs pendientes en scripts
_18 items encontrados:_
```
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/orquestador-total.sh:211:  echo "## TODO auto-generado" >> "$REPORT"
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/orquestador-total.sh:300:  echo "## TODO sugerido" >> "$REPORT"
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/ci/ecosystem_audit.py:10:- TODO/FIXME sin issue asociado
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/ci/ecosystem_audit.py:49:        ["grep", "-rn", "--include=*.py", "--include=*.sh", "-E", "TODO|FIXME", str(repo_path / "src")],
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/thdora/thdora-scaffold.sh:60:    # TODO: conectar con Ollama para clasificar y resumir
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/galatea-fabrica-agentes.sh:88:# TODO: lógica específica del agente
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/galatea-scan.sh:6:# Detecta islas y bots Galatea, genera reporte y TODO
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/galatea-scan.sh:39:echo "## TODO Galatea" >> "$REPORT"
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/clasificador-maestro.sh:75:  elif echo "$nombre $cabecera" | grep -qiE '(tarea|TAREA|PENDIENTE|pendiente|TODO|SIGUIENTE-PASO|PENDIENTES)'; then
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/maintenance/ecosystem-reality-check.sh:200:# TODOs y FIXMEs en scripts
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/maintenance/ecosystem-reality-check.sh:201:echo "### TODOs/FIXMEs pendientes en scripts" >> "$OUTPUT"
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/maintenance/ecosystem-reality-check.sh:202:TODOS=$(grep -rn 'TODO\|FIXME\|HACK\|XXX' "$REPO_DIR/scripts" --include='*.sh' --include='*.py' 2>/dev/null | wc -l | tr -d ' ')
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/maintenance/ecosystem-reality-check.sh:203:if [ "$TODOS" -gt 0 ]; then
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/maintenance/ecosystem-reality-check.sh:204:  log_warn "$TODOS TODOs/FIXMEs en scripts"
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/maintenance/ecosystem-reality-check.sh:205:  echo "_$TODOS items encontrados:_" >> "$OUTPUT"
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/maintenance/ecosystem-reality-check.sh:207:  grep -rn 'TODO\|FIXME' "$REPO_DIR/scripts" --include='*.sh' --include='*.py' 2>/dev/null | head -20 >> "$OUTPUT" || true
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/maintenance/ecosystem-reality-check.sh:210:  log_ok "Sin TODOs/FIXMEs en scripts"
```

## 6. Fase actual del ecosistema

| Fase | Componente | Estado |
|------|------------|--------|
| Fase 1 | Seguridad base (UFW, fail2ban, hardening) | ✅ |
| Fase 2 | Stack batcueva (Portainer, n8n, Ollama) | ✅ |
| Fase 3 | Backup Restic | ✅ |
| Fase 4 | health-agent-core (FastAPI + LLM) | 🔨 |
| Fase 5 | MCP server Madre | ✅ |
| Fase 6 | RAG + second-brain | ✅ |

---

## Resumen

| | |
|--|--|
| ✅ OK | 3 |
| ⚠ Warnings | 12 |
| Total checks | 15 |
| Scripts totales | 93 |
| Actions activas | 45 |

*Generado por ecosystem-reality-check.sh [AUTO] · 2026-07-03 20:39*
*Ejecutar en Madre para datos Docker/HTTP reales.*
