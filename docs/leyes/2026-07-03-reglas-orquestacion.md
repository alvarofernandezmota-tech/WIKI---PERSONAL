---
type: rule
date: 2026-07-03
hora: 16:23
source: perplexity-session
priority: high
status: pending
title: Reglas de orquestación Actions + Scripts + Agentes
processed_by: pending
---

# Reglas de orquestación del ecosistema

> Documento generado en sesión 2026-07-03 a partir de la discusión con Perplexity.
> Estas son las reglas arquitectónicas fundamentales del ecosistema autónomo.

---

## Regla 1 — El flujo de datos siempre es unidireccional

```
EVENTO (push, cron, webhook, fichero nuevo en inbox/)
    ↓
GitHub Action (trigger / orquestador)
    ↓
Script en Madre (músculo — ejecuta, observa, genera)
    ↓
Fichero .md en inbox/ (dato estructurado con frontmatter YAML)
    ↓
Agente (cerebro — decide, clasifica, actua)
    ↓
Acciones safe: issue, notificación Telegram, workflow, reinicio
```

**Nunca al revés.** Los agentes no escriben directamente en producción sin pasar por inbox.

---

## Regla 2 — Los scripts son reglas ejecutables, no solo automatización

Cada script del ecosistema tiene un rol de agente futuro:

| Script actual | Rol | Agente futuro |
|---|---|---|
| `inicio-sesion.sh` | Observa estado al arrancar | `agente-sesion.open()` |
| `cierre-sesion.sh` | Consolida y sincroniza al cerrar | `agente-sesion.close()` |
| `repo-research.sh` | Analiza gaps del repo | `agente-investigacion.observe_repo()` |
| `audit-and-migrate.sh` | Audita y reorganiza | `agente-auditoria.run()` |
| `[deuda-tecnica.sh]` | Clasifica deuda técnica | `agente-roadmap.triage()` |

**Los scripts de hoy son las tools de los agentes de mañana.**

---

## Regla 3 — El inbox es el bus de comunicación del ecosistema

Todo lo que entra al ecosistema pasa por `inbox/`:

- Formato: `YYYY-MM-DD-nombre-descriptivo.md`
- Frontmatter obligatorio:
  ```yaml
  ---
  type: report | rule | task | alert | research
  date: YYYY-MM-DD
  source: nombre-del-script-o-agente
  priority: low | medium | high | critical
  status: pending | in-progress | done
  processed_by: pending | agente-X | human
  ---
  ```
- El gatekeeper lee el `type` y el `priority` para decidir quién procesa
- `processed_by: pending` = nadie lo ha tocado aún
- `processed_by: human` = requiere decisión humana [HUMAN]

---

## Regla 4 — GitHub Actions son el sistema nervioso

Cada Action conecta un evento con un script o agente:

| Trigger | Action | Script/Agente | Resultado |
|---|---|---|---|
| `push` a `main` | `ecosystem-audit.yml` | `repo-research.sh` | `inbox/DATE-auto-research.md` |
| Nuevo fichero en `inbox/` | `inbox-dispatcher.yml` | `agente-gatekeeper` | Clasifica y delega |
| `cron` cada 15min | `health-check.yml` | `health-agent-core` | `inbox/DATE-health.md` o alerta |
| Issue cerrado | `roadmap-sync.yml` | `agente-roadmap` | Actualiza `ROADMAP-MASTER.md` |
| `workflow_dispatch` | `manual-audit.yml` | `audit-and-migrate.sh` | Log + issue |

---

## Regla 5 — Los agentes solo ejecutan acciones `safe: true`

Acciones autorizadas sin supervision humana:
- Crear issues en GitHub
- Escribir ficheros en `inbox/`, `logs/`, `sesiones/`
- Notificar por Telegram (solo informativo)
- Reiniciar contenedores marcados como `auto-restart: true`
- Actualizar docs y README

Acciones que requieren `[HUMAN]`:
- Merge a `main`
- Borrar ficheros
- Cambios en configuración de seguridad
- Ejecución de cualquier script marcado `safe: false`

---

## Regla 6 — El repo ES la memoria del ecosistema

Los agentes no necesitan contexto de conversación porque:
- El estado actual → `git status` + `docker ps` + servicios
- El historial → `git log` + `logs/` + `sesiones/`
- Las tareas → issues GitHub + `ROADMAP-MASTER.md`
- Las reglas → este fichero + `docs/`

**Un agente nuevo puede arrancar desde cero leyendo solo el repo.**

---

## Deuda técnica detectada hoy (2026-07-03)

### Scripts sueltos sin isla (prioridad media)
- `scripts/audit-and-migrate.sh` → mover a `scripts/maintenance/`
- `scripts/batcueva-control.sh` → mover a `scripts/infra/`
- `scripts/cierre-sesion.sh` → mover a `scripts/sesion/`
- `scripts/create-issues.sh` → mover a `scripts/ci/`
- `scripts/fix-permisos.sh` → mover a `scripts/maintenance/`
- `scripts/hardening-ufw.sh` → mover a `scripts/seguridad/`
- `scripts/inbox-*.sh` → mover a `scripts/maintenance/`
- `scripts/inicio-sesion.sh` → mover a `scripts/sesion/`
- `scripts/repo-research.sh` → mover a `scripts/agents/` (proto-agente)
- `scripts/setup-labels.sh` → mover a `scripts/ci/`
- `scripts/thdora-handlers.py` → mover a `scripts/thdora/`
- `scripts/uptime-kuma-webhook.py` → mover a `scripts/infra/`
- `scripts/watchdog_adb.sh` → mover a `scripts/maintenance/`

### Subdirectorios sin README (prioridad baja — bloquea agente-investigacion)
`archive/`, `backup/`, `ci/`, `infra/`, `maintenance/`, `osint/`, `seguridad/`, `setup/`, `tests/`, `thdora/`

### gh CLI no autenticado en Madre
- Ejecutar: `gh auth login --with-token <<< "$GH_TOKEN"`
- O: `export GH_TOKEN=ghp_xxx` en `~/.bashrc`

---

*Generado en sesión [AUTO] · 2026-07-03 16:23 · varopc@Madre*
