---
type: rule
date: 2026-07-03
hora: 16:37
source: perplexity-session
priority: high
status: pending
processed_by: pending
title: Plan de fases — ecosistema autónomo completo
---

# Plan de fases — ecosistema autónomo

> Este documento es la spec para Gemini/Copilot.
> Perplexity documenta. Gemini/Copilot construyen.
> Actualizar cuando una fase esté completa.

---

## Estado actual (2026-07-03)

| Componente | Estado | Notas |
|---|---|---|
| Scripts base | ✅ Existen | 25 scripts sueltos sin isla |
| GitHub Actions | ✅ Pusheadas hoy | inbox-dispatcher, health-check, repo-research-on-push |
| Reglas orquestación | ✅ Documentadas | inbox/2026-07-03-reglas-orquestacion.md |
| gh CLI autenticado | ✅ Hoy | gh auth login completado |
| git pull local | ❌ Pendiente | Ejecutar: git fetch origin && git reset --hard origin/main |
| health-agent-core | ❌ Esqueleto | FastAPI existe, no desplegado |
| inbox-watcher | ❌ Pendiente | systemd service para auto-push |
| MCP server Madre | ❌ Pendiente | La pieza más estratégica |
| Ollama modelos | ⚠️ Parcial | Instalado, modelos por definir |
| Qdrant RAG | ❌ Pendiente | Vector store no levantado |

---

## FASE 1 — Sincronización local (HOY)

**Responsable**: tú en Madre
**Código**: Copilot/Gemini

### Tareas

```bash
# 1. Forzar sync con remoto
cd /srv/yggdrasil-dew
git fetch origin && git reset --hard origin/main

# 2. Verificar que repo-research.sh funciona
bash scripts/repo-research.sh

# 3. Verificar gh autenticado
gh auth status
```

### Entregable
`inbox/2026-07-03-repo-research.md` generado sin errores.

---

## FASE 2 — inbox-watcher systemd (Esta semana)

**Responsable**: Copilot construye, tú instalas
**Código a generar**: `/etc/systemd/system/inbox-watcher.service`

### Spec para Copilot

Crea un servicio systemd que:
- Use `inotifywait` para vigilar `/srv/yggdrasil-dew/inbox/`
- Cuando detecte un fichero `.md` nuevo:
  1. `cd /srv/yggdrasil-dew`
  2. `git add inbox/`
  3. `git commit -m "auto(inbox): nuevo fichero detectado [AUTO]"`
  4. `git push`
- Se reinicie automáticamente si falla
- Log en `/var/log/inbox-watcher.log`

### Entregable
```
/etc/systemd/system/inbox-watcher.service
/usr/local/bin/inbox-watcher.sh
```

---

## FASE 3 — Migración scripts a islas (Esta semana)

**Responsable**: audit-and-migrate.sh + revisión manual
**Código a generar**: Copilot actualiza audit-and-migrate.sh

### Mapa de migración

```
scripts/01-fix-driver-rtl8188ftu.sh   → scripts/setup/
scripts/02-git-pull-rebase.sh         → scripts/maintenance/
scripts/03-fase1-seguridad.sh         → scripts/seguridad/
scripts/04-fase2-start-batcueva.sh    → scripts/infra/
scripts/05-fase7-ollama-pull.sh       → scripts/infra/
scripts/06-verificacion-post-reboot.sh → scripts/maintenance/
scripts/07-fase3-restic-backup.sh     → scripts/backup/
scripts/08-fase6-thdora-handlers.sh   → scripts/thdora/
scripts/09-fase8-seguridad-acer.sh    → scripts/seguridad/
scripts/10-fase9-osint-stack.sh       → scripts/osint/
scripts/audit-and-migrate.sh         → scripts/maintenance/
scripts/batcueva-control.sh          → scripts/infra/
scripts/cierre-sesion.sh             → scripts/sesion/ (crear)
scripts/inicio-sesion.sh             → scripts/sesion/ (crear)
scripts/create-issues.sh             → scripts/ci/
scripts/fix-permisos.sh              → scripts/maintenance/
scripts/hardening-ufw.sh             → scripts/seguridad/
scripts/inbox-cleanup-jun2026.sh     → scripts/archive/
scripts/inbox-migrate.sh             → scripts/archive/
scripts/procesar-inbox-masivo.sh     → scripts/maintenance/
scripts/repo-research.sh             → scripts/agents/ (crear)
scripts/setup-labels.sh              → scripts/ci/
scripts/thdora-handlers.py           → scripts/thdora/
scripts/uptime-kuma-webhook.py       → scripts/infra/
scripts/watchdog_adb.sh              → scripts/maintenance/
```

### READMEs a crear (Copilot genera, uno por directorio)
`archive/`, `backup/`, `ci/`, `infra/`, `maintenance/`, `osint/`, `seguridad/`, `setup/`, `tests/`, `thdora/`, `sesion/` (nuevo), `agents/` (nuevo)

---

## FASE 4 — health-agent-core desplegado (Próxima semana)

**Responsable**: Copilot construye docker-compose, tú despliegas
**Código a generar**: docker-compose para health-agent-core

### Spec para Copilot

```yaml
# docker-compose.health-agent.yml
servicios necesarios:
  - health-agent-core (FastAPI, puerto 8010)
  - ollama (ya existe en Madre, reusar)
  - qdrant (puerto 6333, volumen persistente)

endpoints a implementar:
  POST /health/evaluate   # recibe EcosystemSnapshot, devuelve análisis
  GET  /health/status     # estado del agente
  GET  /health/history    # últimos N logs
```

### El código base ya existe en:
`agents/health-agent-core/main.py` (esqueleto de sesión anterior)

---

## FASE 5 — MCP server Madre (Próxima semana)

**Responsable**: Copilot construye, es la pieza más estratégica
**Código a generar**: MCP server Python en Madre

### Spec para Copilot

```python
# /srv/mcp-madre/server.py
# pip install mcp fastapi uvicorn docker

tools a exponer:
  check_docker()           # lista contenedores y estado
  query_rag(pregunta)      # consulta Qdrant con bge-m3
  read_roadmap()           # lee ROADMAP-MASTER.md
  list_inbox()             # lista ficheros pendientes en inbox/
  create_issue(titulo, body, labels)  # crea issue en GitHub
  run_safe_script(nombre)  # ejecuta script marcado safe:true
  get_ecosystem_snapshot() # snapshot completo del ecosistema
```

Cuando esté listo, Cursor + Claude Desktop + Open WebUI ven el ecosistema completo.

---

## FASE 6 — Multi-agent gatekeeper (Mes siguiente)

Un agente jefe que delega en:
- `agente-salud` → health-agent-core
- `agente-roadmap` → lee issues + ROADMAP, genera PRs
- `agente-investigacion` → scraping + síntesis + inbox
- `agente-rag` → responde preguntas sobre el historial

---

## Issues a crear en GitHub (para tracking)

1. `[FASE 1]` Fix: git reset --hard en Madre + verificar repo-research
2. `[FASE 2]` Feat: inbox-watcher systemd service
3. `[FASE 3]` Refactor: migrar 25 scripts sueltos a sus islas
4. `[FASE 3]` Docs: READMEs para 12 subdirectorios de scripts/
5. `[FASE 4]` Feat: desplegar health-agent-core con docker-compose
6. `[FASE 5]` Feat: MCP server Madre — 7 tools expuestas
7. `[FASE 6]` Arch: diseño multi-agent gatekeeper

*Generado por Perplexity en sesión 2026-07-03 16:37 [AUTO]*
