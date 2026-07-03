---
date: 2026-07-03
hora-inicio: 22:54
tipo: sesion-trabajo
fase: blindaje-ecosistema
---

# Sesión Blindaje Ecosistema — 2026-07-03 22:54

## Hito crítico: MCP server OPERATIVO en Madre

```bash
cd /srv/yggdrasil-dew/mcp
npm install
export YGGDRASIL_ROOT="/srv/yggdrasil-dew"
node server.js
# Output confirmado:
# added 93 packages, and audited 94 packages in 6s
# 31 packages are looking for funding
# found 0 vulnerabilities
# [MCP] yggdrasil-ecosistema server arrancado ✅
```

**Estado MCP:** `node server.js` arranca correctamente. Socket operativo.

---

## Plan de ejecución auditoria completa — Fase 1 Diagnóstico

Orden exacto de ejecución en terminal en Madre. No toca nada, solo lee y detecta.

```bash
# PASO 1 — Detectar duplicados de orquestadores/clasificadores
cd /srv/yggdrasil-dew
bash scripts/struct-auditor.sh

# PASO 2 — Detectar archivos fantasma (vacíos, huérfanos, sin cabecera)
bash scripts/ghost-file-detector.sh

# PASO 3 — Inventario de tools (cuáles tienen cabecera Galatea, cuáles no)
bash scripts/tool-inventory-auditor.sh

# PASO 4 — Referencias rotas entre docs y archivos reales
bash scripts/cross-ref-checker.sh

# PASO 5 — Auditar y migrar estructuras duplicadas
bash scripts/audit-and-migrate.sh
```

---

## Inventario real del ecosistema (levantado hoy)

### Workflows activos: 35 en `.github/workflows/`

| Categoría | Workflows |
|---|---|
| Orquestación | orquestador-maestro.yml, orquestador-supremo.yml, orquestador-total.yml |
| Auditoría | audit-on-push.yml, meta-deep-audit.yml, ghost-file-detector.yml, cross-ref-checker.yml, struct-auditor.yml |
| Inbox/clasificación | inbox-cleanup.yml, inbox-dispatcher.yml, inbox-health.yml, inbox-processor.yml, gestor-estados-inbox.yml, clasificador.yml, clasificador-maestro.yml |
| Islas/sincronía | isla-context-sync.yml, isla-sync-validator.yml, islas-health.yml, mapa-islas-sync.yml |
| Salud/watchdog | health-check.yml, agent-monitor.yml, ecosystem-guardian.yml, watchdog.yml |
| Sesiones | diary-writer.yml, between-sessions.yml, context-reminder.yml |
| Galatea/Fábrica | galatea.yml, new-file-bootstrap.yml |
| Deuda/CI | deuda-tecnica.yml, code-drift.yml, lint-commits.yml, issue-creator.yml, auto-investigacion.yml, autonomous-cron.yml |

### Scripts raíz en `scripts/`

Scripts de sesión: apertura-sesion.sh, inicio-sesion.sh, cierre-sesion.sh
Scripts de auditoría: struct-auditor.sh, ghost-file-detector.sh, tool-inventory-auditor.sh, cross-ref-checker.sh, audit-and-migrate.sh
Scripts de orquestación: orquestador-total.sh, orquestador-supremo.sh (⚠️ duplicados — ver deuda)
Scripts de inbox: gestor-estados-inbox.sh, inbox-cleanup-jun2026.sh, inbox-migrate.sh, inbox-watcher.sh, procesar-inbox-masivo.sh
Scripts de agentes: galatea-fabrica-agentes.sh, galatea-scan.sh, galatea-islas-bots.sh, agent-monitor.sh
Scripts de deploy/infra: deploy.sh, deploy-madre.sh, batcueva-control.sh
Scripts de seguridad: hardening-ufw.sh, 03-fase1-seguridad.sh, 09-fase8-seguridad-acer.sh
Scripts de islas: isla-sync-validator.sh, ecosystem-snapshot.sh
Scripts de issues: issue-creator.sh, create-issues.sh (⚠️ posible duplicado — revisar)
Subcarpetas: agentes/, archive/, backup/, ci/, infra/, lib/, maintenance/, osint/, seguridad/, setup/, tests/, thdora/, thdora-dev/

---

## Deuda técnica detectada en esta sesión

### ⚠️ CRÍTICO — Triplicación de orquestadores
- `orquestador-maestro.yml` + `orquestador-supremo.yml` + `orquestador-total.yml`
- `clasificador.yml` + `clasificador-maestro.yml`
- Acción: consolidar en orquestador-maestro como único punto de entrada.
  Supremo y total → mover a scripts/archive/ tras fusionar lógica diferencial.

### ⚠️ IMPORTANTE — Scripts sin plantilla Galatea uniforme
- Scripts numerados (01- al 10-) usan formato diferente al resto.
- `bc` (sin extensión .sh) — archivo fantasma potencial.
- `inbox-cleanup-jun2026.sh` — específico de fecha, candidato a archivado.
- `watchdog_adb.sh` — naming inconsistente (guión bajo vs guión medio).

### ⚠️ IMPORTANTE — Posible duplicado de creadores de issues
- `issue-creator.sh` (7051 bytes) vs `create-issues.sh` (8298 bytes)
- Revisar si tienen funciones solapadas o complementarias.

### ℹ️ MENOR — Subcarpetas con contenido no inventariado
- scripts/agentes/, scripts/thdora/, scripts/thdora-dev/ — pendiente listar contenido.

---

## Pieza faltante identificada: `guardian-maestro.sh`

Agente que orquesta la limpieza completa en secuencia con logging. Diseño:

```
guardian-maestro.sh
  1. → struct-auditor.sh         (detecta duplicados)
  2. → ghost-file-detector.sh    (detecta fantasmas)
  3. → tool-inventory-auditor.sh (verifica cabeceras)
  4. → cross-ref-checker.sh      (verifica refs rotas)
  5. → galatea-scan.sh           (detecta scripts sin plantilla)
  6. → issue-creator.sh          (abre issues de todo lo encontrado)
  7. → ecosystem-snapshot.sh     (documenta el estado final)
  8. → isla-sync-validator.sh    (sincroniza MAPA-ISLAS.md)
```

Pendiente de crear. Es la pieza que cierra el ciclo de auditoría autónoma.

---

## Plantilla Galatea estándar (cabecera universal acordada)

Todos los scripts, agentes y Actions del ecosistema deben usar esta cabecera:

```bash
#!/usr/bin/env bash
# ============================================================
# NOMBRE    : nombre-exacto-del-script.sh
# VERSIÓN   : 1.0.0
# FUNCIÓN   : [UNA sola frase — acción concreta y única]
# CATEGORÍA : [auditoria|orquestacion|sesion|inbox|galatea|seguridad|osint]
# TRIGGER   : [manual|on-push|cron|llamado-por:otro-script.sh]
# OUTPUT    : [qué produce: issue/log en inbox/diary/ninguno]
# AUTOR     : thdora-guardian[bot] / Álvaro
# REPO      : alvarofernandezmota-tech/yggdrasil-dew
# ACTUALIZ  : YYYY-MM-DD
# ============================================================
# DEPENDENCIAS: gh cli, git, jq
# ABRE ISSUE  : sí/no — [condición que lo dispara]
# ============================================================
set -euo pipefail
```

---

## Prompt Copilot (añadir a docs/COPILOT-CONTEXT.md)

```
Eres el agente de ingeniería del ecosistema Yggdrasil-Dew.

REPO: alvarofernandezmota-tech/yggdrasil-dew
ÁRBOL CORE:
  scripts/          → scripts bash con cabecera Galatea
  scripts/agentes/  → agentes especializados (función única)
  .github/workflows/→ GitHub Actions (35 workflows activos)
  mcp/              → MCP server Node.js (OPERATIVO desde 2026-07-03)
  docs/             → COPILOT-CONTEXT.md, MAPA-ISLAS.md
  inbox/            → entrada de datos sin clasificar
  diary/            → log de sesiones

REGLAS ABSOLUTAS:
1. Cada script/agente/workflow tiene UNA sola función declarada en cabecera.
2. Todo script usa la plantilla Galatea (set -euo pipefail + cabecera estándar).
3. Nada puede vivir en inbox/ más de 24h sin procesarse.
4. Cualquier estado inconsistente se documenta como issue en GitHub.
5. Los orquestadores tienen un único punto de entrada (orquestador-maestro).
6. MAPA-ISLAS.md debe reflejar la estructura real en cada push.
7. Archivos duplicados van a scripts/archive/ antes de borrarse.
8. Copilot solo propone cambios compatibles con este ecosistema.

CUANDO GENERES CÓDIGO:
- Usa siempre la cabecera Galatea completa.
- Llama a issue-creator.sh si detectas inconsistencia.
- Documenta en inbox/ si el script produce output relevante.
- No crees scripts nuevos si ya existe uno con la misma función.
- Primero busca en scripts/ y scripts/agentes/ antes de proponer algo nuevo.
```

---

## Próximos pasos inmediatos

- [ ] Ejecutar Fase 1 diagnóstico completa (5 scripts arriba)
- [ ] Crear guardian-maestro.sh
- [ ] Consolidar orquestadores (maestro + supremo + total → uno solo)
- [ ] Aplicar plantilla Galatea a scripts sin cabecera
- [ ] Añadir prompt Copilot a docs/COPILOT-CONTEXT.md
- [ ] Crear FASE 2 workflows: isla-sync nightly, ghost-detector on-push reforzado

*Documentado automáticamente — sesión activa Álvaro + Perplexity 2026-07-03*
