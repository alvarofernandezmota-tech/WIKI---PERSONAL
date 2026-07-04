---
type: audit
date: 2026-07-04
hora: 00:22
source: ecosystem-reality-check.sh
priority: high
status: pending
processed_by: pending
title: Reality Check 2026-07-04 00:22
---

# 🔍 Ecosystem Reality Check — 2026-07-04 00:22

> Auditoría automática del estado real vs documentado.
> Generado por 


## 1. Scripts — Inventario y estado

| Métrica | Valor |
|---------|-------|
| Total scripts | 132 |
| Ejecutables (chmod +x) | 69 |
| Sin permisos ejecución | 63 |
| En raíz scripts/ (sin organizar) | 70 |
| En subdirectorios | 62 |

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
- `apertura-maestra.sh`
- `apertura-sesion.sh`
- `audit-and-migrate.sh`
- `auditoria-maestra.sh`
- `batcueva-control.sh`
- `between-sessions.sh`
- `cierre-maestro.sh`
- `cierre-sesion.sh`
- `clasificador-maestro.sh`
- `code-drift-detector.sh`
- `copilot-2fases.sh`
- `copilot-fases.sh`
- `copilot-mission-briefing.sh`
- `create-issues.sh`
- `cross-ref-checker.sh`
- `deploy-madre.sh`
- `deploy.sh`
- `ecosystem-snapshot.sh`
- `entrypoint.sh`
- `file-arrival-guardian.sh`
- `fix-permisos.sh`
- `galatea-fabrica-agentes.sh`
- `galatea-islas-bots.sh`
- `galatea-scan.sh`
- `gestor-estados-inbox.sh`
- `ghost-file-detector.sh`
- `guardian-maestro.sh`
- `hardening-ufw.sh`
- `inbox-clasificador.sh`
- `inbox-cleanup-jun2026.sh`
- `inbox-commit.sh`
- `inbox-migrate.sh`
- `inbox-watcher.sh`
- `inicio-sesion.sh`
- `isla-sync-validator.sh`
- `issue-creator.sh`
- `meta-orquestador.sh`
- `observador-diarios.sh`
- `observador-inbox.sh`
- `observador-islas.sh`
- `observador-mcp.sh`
- `observador-scripts.sh`
- `observador-workflows.sh`
- `orquestador-supremo.sh`
- `orquestador-total.sh`
- `orquestador-unico.sh`
- `procesar-inbox-masivo.sh`
- `repo-research.sh`
- `session-logger.sh`
- `session-terminal-doc.sh`
- `setup-labels.sh`
- `struct-auditor.sh`
- `task-analyzer.sh`
- `template-insure.sh`
- `thdora-handlers.py`
- `tool-inventory-auditor.sh`
- `uptime-kuma-webhook.py`
- `watchdog-monitor.sh`
- `watchdog_adb.sh`

### Scripts potencialmente duplicados
- ⚠ `galatea-fabrica-agentes.sh`

## 2. GitHub Actions — Inventario

| Workflow | Trigger | Estado |
|----------|---------|--------|
| `agent-monitor.yml` | workflow_dispatch | 🟢 ACTIVO |
| `audit-on-push.yml` | workflow_dispatch | 🟢 ACTIVO |
| `auditoria-auto.yml` | workflow_dispatch | 🟢 ACTIVO |
| `auto-investigacion.yml` | workflow_dispatch | 🟢 ACTIVO |
| `auto-pr.yml` | workflow_dispatch | 🟢 ACTIVO |
| `autonomous-cron.yml` | workflow_dispatch | 🟢 ACTIVO |
| `between-sessions.yml` | workflow_dispatch | 🟢 ACTIVO |
| `ci-agentes.yml` | push pull_request | 🟢 ACTIVO |
| `clasificador-maestro.yml` | workflow_dispatch | 🟢 ACTIVO |
| `clasificador.yml` | workflow_dispatch | 🟢 ACTIVO |
| `code-drift.yml` | workflow_dispatch | 🟢 ACTIVO |
| `context-reminder.yml` | workflow_dispatch | 🟢 ACTIVO |
| `cross-ref-checker.yml` | workflow_dispatch | 🟢 ACTIVO |
| `deuda-tecnica.yml` | workflow_dispatch | 🟢 ACTIVO |
| `diary-writer.yml` | workflow_dispatch | 🟢 ACTIVO |
| `e2e-full-flow.yml` | workflow_dispatch | 🟢 ACTIVO |
| `ecosystem-guardian.yml` | workflow_dispatch | 🟢 ACTIVO |
| `file-arrival-guardian.yml` | push workflow_dispatch | 🟢 ACTIVO |
| `galatea.yml` | workflow_dispatch schedule | 🟢 ACTIVO |
| `gestor-estados-inbox.yml` | push schedule workflow_dispatch | 🟢 ACTIVO |
| `ghost-file-detector.yml` | workflow_dispatch | 🟢 ACTIVO |
| `health-check.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `inbox-clasificador.yml` | push | 🟢 ACTIVO |
| `inbox-cleanup.yml` | schedule push workflow_dispatch | 🟢 ACTIVO |
| `inbox-dispatcher.yml` | push workflow_dispatch | 🟢 ACTIVO |
| `inbox-health.yml` | push schedule workflow_dispatch | 🟢 ACTIVO |
| `inbox-processor.yml` | push schedule workflow_dispatch | 🟢 ACTIVO |
| `isla-context-sync.yml` | workflow_dispatch | 🟢 ACTIVO |
| `isla-sync-validator.yml` | workflow_dispatch | 🟢 ACTIVO |
| `islas-health.yml` | workflow_dispatch | 🟢 ACTIVO |
| `issue-creator.yml` | schedule push workflow_dispatch | 🟢 ACTIVO |
| `lint-commits.yml` | push pull_request | 🟢 ACTIVO |
| `mapa-islas-sync.yml` | pull_request push | 🟢 ACTIVO |
| `meta-deep-audit.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `meta-deep-draft-pr.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `new-file-bootstrap.yml` | push | 🟢 ACTIVO |
| `orquestador-maestro.yml` | push pull_request schedule | 🟢 ACTIVO |
| `orquestador-supremo.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
| `orquestador-total.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
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
| `watchdog.yml` | schedule workflow_dispatch | 🟢 ACTIVO |
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
_23 items encontrados:_
```
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/inbox-commit.sh:3:# inbox-commit.sh — Commitea TODO lo que haya en inbox/drop/ de una vez
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/ci/ecosystem_audit.py:10:- TODO/FIXME sin issue asociado
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/ci/ecosystem_audit.py:49:        ["grep", "-rn", "--include=*.py", "--include=*.sh", "-E", "TODO|FIXME", str(repo_path / "src")],
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/thdora/thdora-scaffold.sh:60:    # TODO: conectar con Ollama para clasificar y resumir
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/guardian-maestro.sh:56:  echo "**Estado final: ✅ TODOS LOS OBSERVADORES OK**" >> "${REPORT}"
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/galatea-fabrica-agentes.sh:88:# TODO: lógica específica del agente
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/galatea-scan.sh:6:# Detecta islas y bots Galatea, genera reporte y TODO
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/galatea-scan.sh:39:echo "## TODO Galatea" >> "$REPORT"
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/agentes/agente-deuda-detecta.sh:89:# --- 6. TODOs y FIXMEs ---
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/agentes/agente-deuda-detecta.sh:91:  count=$(grep -c 'TODO\|FIXME\|HACK\|XXX' "$f" 2>/dev/null || true)
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/agentes/agente-deuda-detecta.sh:93:    add_item "todos-fixmes" "$f" "${count} TODO/FIXME/HACK encontrados" "BAJA"
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/agentes/agente-mejorador.sh:47:    | xargs -0 -n1 bash -c 'f="$0"; grep -Iq . "$f" || exit 0; (head -n1 "$f" | grep -q "^#!/" || grep -q "TODO" "$f") && echo "$f"' || true
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/agentes/agente-mejorador.sh:62:  if grep -q "TODO" "$file"; then
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/clasificador-maestro.sh:75:  elif echo "$nombre $cabecera" | grep -qiE '(tarea|TAREA|PENDIENTE|pendiente|TODO|SIGUIENTE-PASO|PENDIENTES)'; then
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/maintenance/ecosystem-reality-check.sh:200:# TODOs y FIXMEs en scripts
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/maintenance/ecosystem-reality-check.sh:201:echo "### TODOs/FIXMEs pendientes en scripts" >> "$OUTPUT"
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/maintenance/ecosystem-reality-check.sh:202:TODOS=$(grep -rn 'TODO\|FIXME\|HACK\|XXX' "$REPO_DIR/scripts" --include='*.sh' --include='*.py' 2>/dev/null | wc -l | tr -d ' ')
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/maintenance/ecosystem-reality-check.sh:203:if [ "$TODOS" -gt 0 ]; then
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/maintenance/ecosystem-reality-check.sh:204:  log_warn "$TODOS TODOs/FIXMEs en scripts"
/home/runner/work/yggdrasil-dew/yggdrasil-dew/scripts/maintenance/ecosystem-reality-check.sh:205:  echo "_$TODOS items encontrados:_" >> "$OUTPUT"
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
| ✅ OK | 2 |
| ⚠ Warnings | 13 |
| Total checks | 15 |
| Scripts totales | 132 |
| Actions activas | 55 |

*Generado por ecosystem-reality-check.sh [AUTO] · 2026-07-04 00:22*
*Ejecutar en Madre para datos Docker/HTTP reales.*
