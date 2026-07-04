# COPILOT MASTER TASKLIST — yggdrasil-dew
> Generado: 2026-07-04 | Estado: PENDIENTE DE EJECUCIÓN
> Copilot: ejecuta este documento en orden. Cada tarea tiene rama, commit, PR y rollback.

---

## CONTEXTO DEL ECOSISTEMA

Este repo es el cerebro operativo de yggdrasil-dew. Tiene scripts de sesión, agentes, workflows de GitHub Actions, infra Docker/MCP, y un sistema de inbox→diarios. El objetivo es que TODO el flujo sea trazable: archivo entra por `inbox/drop/` → clasificador lo mueve → workflows lo procesan → termina documentado en `diarios/` o `docs/`.

### Reglas de estructura (NO violar nunca)
- `scripts/` → solo `.sh`, `.py`, `.js`. NUNCA `.md` sueltos.
- `inbox/drop/` → zona de aterrizaje única para archivos nuevos.
- `inbox/_meta/` → reportes de auditoría y orquestación.
- `inbox/sesiones/` → logs y cierres de sesión temporales.
- `diarios/` → destino final de cierres de sesión, con formato `YYYY-MM-DD-tema.md`.
- `docs/` → documentación permanente del ecosistema.
- `scripts/archive/` → scripts obsoletos/reemplazados (no borrar, preservar historial).
- `scripts/templates/` → plantillas reutilizables para nuevos scripts.

---

## PASO 0 — Urgente: mover 4 `.md` fuera de `scripts/`

**Estado:** PENDIENTE — confirmado que siguen en `scripts/` a fecha 2026-07-04.

```bash
git checkout main && git pull origin main

git mv scripts/2026-07-03-23-05-struct-auditor-output.md inbox/_meta/
git mv scripts/2026-07-03-inbox-audit-consolidado.md inbox/_meta/
git mv scripts/2026-07-03-cierre-sesion-completo.md diarios/
git mv scripts/2026-07-03-reality-check.md diarios/

git add -A
git commit -m "fix(estructura): mover .md fuera de scripts/ a sus destinos correctos"
git push origin main
```

**Verificación:**
```bash
ls scripts/*.md 2>/dev/null && echo "ERROR: quedan .md en scripts/" || echo "OK: scripts/ limpio"
ls inbox/_meta/ | grep 2026-07-03
ls diarios/ | grep 2026-07-03
```

**Rollback:** `git revert HEAD`

---

## PRIORIDAD 1 — Consolidar orquestadores

**Objetivo:** `scripts/orquestador-unico.sh` es el ÚNICO canónico. Los demás van a `scripts/archive/`.

**Archivos a archivar:**
- `scripts/orquestador-supremo.sh`
- `scripts/orquestador-total.sh`
- `scripts/meta-orquestador.sh`
- `scripts/clasificador-maestro.sh`
- `scripts/guardian-maestro.sh`

**Rama:** `maintenance/priority-1-consolidacion`

```bash
git checkout -b maintenance/priority-1-consolidacion
mkdir -p scripts/archive

git mv scripts/orquestador-supremo.sh scripts/archive/ 2>/dev/null || true
git mv scripts/orquestador-total.sh scripts/archive/ 2>/dev/null || true
git mv scripts/meta-orquestador.sh scripts/archive/ 2>/dev/null || true
git mv scripts/clasificador-maestro.sh scripts/archive/ 2>/dev/null || true
git mv scripts/guardian-maestro.sh scripts/archive/ 2>/dev/null || true
```

**Añadir encabezado CANONICAL a `orquestador-unico.sh`** (insertar tras shebang si no existe):
```bash
if ! grep -q 'CANONICAL ORQUESTADOR' scripts/orquestador-unico.sh; then
  sed -i '1a\# CANONICAL ORQUESTADOR — única entrada canónica. Redundantes archivados en scripts/archive/' scripts/orquestador-unico.sh
fi
```

```bash
git add -A
git commit -m "chore(consolidation): archive redundant orchestrators; mark orquestador-unico as canonical"
git push origin HEAD
gh pr create --title "P1: consolidar orquestadores" \
  --body "Archiva orquestadores redundantes en scripts/archive/. Mantiene orquestador-unico.sh como canónico. Reversible con git mv desde archive/." \
  --draft --base main
```

**Verificación:**
```bash
ls scripts/archive/ | grep orquestador
bash scripts/orquestador-unico.sh --help 2>/dev/null || bash scripts/orquestador-unico.sh audit
```

**Rollback:** `git mv scripts/archive/<file> scripts/<file> && git commit -m "revert: restore <file>"`

---

## PRIORIDAD 2 — Auto-commit en `cierre-sesion.sh`

**Objetivo:** Al cerrar sesión, `cierre-sesion.sh` debe llamar automáticamente a `inbox-commit.sh`. Dry-run por defecto (`DRY_RUN=true`).

**Rama:** `maintenance/priority-2-auto-commit`

**Snippet a añadir al final de `scripts/cierre-sesion.sh`:**
```bash
# Auto-upload session closure (added by maintenance script — DO NOT REMOVE)
if [ -x "$(dirname "$0")/inbox-commit.sh" ]; then
  if [ "${DRY_RUN:-true}" = "false" ]; then
    "$(dirname "$0")/inbox-commit.sh" || true
  else
    echo "[DRY-RUN] would call $(dirname "$0")/inbox-commit.sh to commit closure"
  fi
fi
```

**Comandos:**
```bash
git checkout -b maintenance/priority-2-auto-commit

if ! grep -q 'Auto-upload session closure' scripts/cierre-sesion.sh 2>/dev/null; then
  cat >> scripts/cierre-sesion.sh <<'SH'

# Auto-upload session closure (added by maintenance script — DO NOT REMOVE)
if [ -x "$(dirname "$0")/inbox-commit.sh" ]; then
  if [ "${DRY_RUN:-true}" = "false" ]; then
    "$(dirname "$0")/inbox-commit.sh" || true
  else
    echo "[DRY-RUN] would call $(dirname "$0")/inbox-commit.sh to commit closure"
  fi
fi
SH
  chmod +x scripts/cierre-sesion.sh
  git add scripts/cierre-sesion.sh
  git commit -m "feat: auto-commit session closure in cierre-sesion.sh (DRY_RUN=true default)"
  git push origin HEAD
  gh pr create --title "P2: auto-commit al cerrar sesión" \
    --body "cierre-sesion.sh ahora llama a inbox-commit.sh al final. DRY_RUN=true por defecto." \
    --draft --base main
else
  echo "Snippet ya existe — OK"
fi
```

**Verificación:**
```bash
DRY_RUN=true bash scripts/cierre-sesion.sh
# Debe mostrar: [DRY-RUN] would call .../inbox-commit.sh
```

**Para activar en producción:**
```bash
DRY_RUN=false bash scripts/cierre-sesion.sh
```

---

## PRIORIDAD 3 — Script `migrar-sesiones-diarios.sh`

**Objetivo:** Crear `scripts/migrar-sesiones-diarios.sh` que mueva `inbox/sesiones/cierre-*.md` → `diarios/YYYY-MM-DD-tema.md` y commitee el movimiento.

**Rama:** `maintenance/priority-3-migrar-sesiones`

**Contenido del script** (crear como `scripts/migrar-sesiones-diarios.sh`):

```bash
#!/usr/bin/env bash
# scripts/migrar-sesiones-diarios.sh
# Mueve inbox/sesiones/cierre-*.md -> diarios/YYYY-MM-DD-tema.md
# Uso: DRY_RUN=true bash scripts/migrar-sesiones-diarios.sh (por defecto)
#      DRY_RUN=false bash scripts/migrar-sesiones-diarios.sh (aplica cambios)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
INBOX="$ROOT/inbox/sesiones"
OUTDIR="$ROOT/diarios"
DRY_RUN="${DRY_RUN:-true}"

mkdir -p "$OUTDIR"

for f in "$INBOX"/cierre-*.md; do
  [ -f "$f" ] || continue
  base=$(basename "$f")
  # Extraer fecha del nombre
  if [[ "$base" =~ ([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
    datepart="${BASH_REMATCH[1]}"
  elif [[ "$base" =~ ([0-9]{8}T[0-9]{6}) ]]; then
    d="${BASH_REMATCH[1]:0:8}"
    datepart="${d:0:4}-${d:4:2}-${d:6:2}"
  else
    datepart=$(grep -Eo '[0-9]{4}-[0-9]{2}-[0-9]{2}' "$f" | head -n1 || date +%F)
  fi
  # Extraer tema del primer H1
  topic=$(grep -m1 '^# ' "$f" | sed 's/^# //; s/[^a-zA-Z0-9_-]/-/g' | tr '[:upper:]' '[:lower:]' | cut -c1-40 || true)
  [ -z "$topic" ] && topic=$(echo "$base" | sed 's/^cierre-//; s/\.md$//; s/[^a-zA-Z0-9_-]/-/g' | cut -c1-40)
  out="$OUTDIR/${datepart}-${topic}.md"
  # Evitar colisiones
  if [ -f "$out" ]; then
    i=1
    while [ -f "${out%.md}-$i.md" ]; do i=$((i+1)); done
    out="${out%.md}-$i.md"
  fi
  if [ "$DRY_RUN" = "true" ]; then
    echo "[DRY-RUN] $f -> $out"
  else
    mv "$f" "$out"
    git add "$out"
    git rm --quiet "$f" 2>/dev/null || true
    echo "Movido: $f -> $out"
  fi
done

if [ "$DRY_RUN" = "false" ]; then
  git diff --cached --quiet || git commit -m "chore: migrate inbox/sesiones -> diarios (migrar-sesiones-diarios.sh)"
  git push origin HEAD
fi
```

**Comandos para crear la rama y el script:**
```bash
git checkout -b maintenance/priority-3-migrar-sesiones
# (crear el archivo con el contenido de arriba)
chmod +x scripts/migrar-sesiones-diarios.sh
git add scripts/migrar-sesiones-diarios.sh
git commit -m "feat: add migrar-sesiones-diarios.sh"
git push origin HEAD
gh pr create --title "P3: migrar sesiones a diarios" \
  --body "Añade script que mueve inbox/sesiones/cierre-*.md a diarios/YYYY-MM-DD-tema.md con dry-run por defecto." \
  --draft --base main

# Probar en dry-run:
DRY_RUN=true bash scripts/migrar-sesiones-diarios.sh
# Aplicar:
DRY_RUN=false bash scripts/migrar-sesiones-diarios.sh
```

---

## PRIORIDAD 4 — Auditoría pre-sesión en `apertura-sesion.sh`

**Objetivo:** Al abrir sesión, ejecutar `struct-auditor.sh --quick` y abortar si hay errores críticos.

**Rama:** `maintenance/priority-4-pre-audit`

**Snippet a insertar justo después del shebang en `scripts/apertura-sesion.sh`:**
```bash
# Pre-session quick audit (added by maintenance — DO NOT REMOVE)
if [ -x "$(dirname "$0")/struct-auditor.sh" ]; then
  "$(dirname "$0")/struct-auditor.sh" --quick || {
    echo "CRITICAL: struct-auditor.sh --quick detectó errores. Sesión abortada."
    exit 1
  }
else
  echo "WARN: struct-auditor.sh no encontrado — saltando auditoría pre-sesión"
fi
```

**Comandos:**
```bash
git checkout -b maintenance/priority-4-pre-audit

if ! grep -q 'Pre-session quick audit' scripts/apertura-sesion.sh 2>/dev/null; then
  # Insertar snippet después de la línea 1 (shebang)
  awk 'NR==1 && /^#!/{print; print "# Pre-session quick audit (added by maintenance — DO NOT REMOVE)"; print "if [ -x \"$(dirname \"$0\")/struct-auditor.sh\" ]; then"; print "  \"$(dirname \"$0\")/struct-auditor.sh\" --quick || { echo \"CRITICAL: struct-auditor.sh --quick detectó errores. Sesión abortada.\"; exit 1; }"; print "else"; print "  echo \"WARN: struct-auditor.sh no encontrado — saltando auditoría pre-sesión\""; print "fi"; next} {print}' scripts/apertura-sesion.sh > /tmp/apertura-sesion.sh.tmp && mv /tmp/apertura-sesion.sh.tmp scripts/apertura-sesion.sh
  chmod +x scripts/apertura-sesion.sh
  git add scripts/apertura-sesion.sh
  git commit -m "feat: pre-session quick audit in apertura-sesion.sh"
  git push origin HEAD
  gh pr create --title "P4: auditoría pre-sesión" \
    --body "apertura-sesion.sh ahora ejecuta struct-auditor.sh --quick al inicio. Aborta si hay errores críticos." \
    --draft --base main
fi
```

**Verificación:**
```bash
bash scripts/struct-auditor.sh --quick && echo "struct-auditor OK"
bash scripts/apertura-sesion.sh
```

---

## PRIORIDAD 5 — Plantillas para todos los scripts

**Objetivo:** Crear `scripts/templates/` con plantillas base para `.sh`, `.py` y `.md` de diario/cierre. Todos los scripts nuevos deben partir de estas plantillas.

**Rama:** `maintenance/priority-5-templates`

### Plantilla `scripts/templates/template-script.sh`
```bash
#!/usr/bin/env bash
# scripts/<nombre-script>.sh
# Descripción: <qué hace este script>
# Uso: DRY_RUN=true bash scripts/<nombre>.sh [opciones]
# Autor: yggdrasil-dew ecosystem
# Creado: YYYY-MM-DD
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DRY_RUN="${DRY_RUN:-true}"

log() { echo "[$(date +%H:%M:%S)] $*"; }
log_dry() { [ "$DRY_RUN" = "true" ] && echo "[DRY-RUN] $*" || true; }

main() {
  log "Iniciando <nombre-script>"
  # TODO: implementar lógica
  log "Completado"
}

main "$@"
```

### Plantilla `scripts/templates/template-diario.md`
```markdown
# YYYY-MM-DD — Tema de la sesión

**Fecha:** YYYY-MM-DD HH:MM CEST
**Rama activa:** main / feature/xxx
**Estado:** ✅ Completado | 🔄 En progreso | ❌ Bloqueado

## Resumen

<!-- 2-3 líneas de qué se hizo -->

## Cambios realizados

- [ ] Cambio 1
- [ ] Cambio 2

## Estado del repo

```bash
# Pegar aquí git status --short
```

## Próximos pasos

1. Paso 1
2. Paso 2

## Notas

<!-- Observaciones, bloqueos, decisiones tomadas -->
```

### Plantilla `scripts/templates/template-cierre.md`
```markdown
# Cierre de sesión — YYYY-MM-DD HH:MM

**Duración:** Xh Ym
**Scripts ejecutados:** orquestador-unico.sh, struct-auditor.sh, ...
**Commits en esta sesión:** X commits

## Acciones completadas

- ✅ Acción 1
- ✅ Acción 2

## Pendiente para próxima sesión

- ⏳ Tarea 1
- ⏳ Tarea 2

## Hash último commit

```
git log --oneline -n 1
```
```

**Comandos:**
```bash
git checkout -b maintenance/priority-5-templates
mkdir -p scripts/templates
# (crear los 3 archivos de plantilla con los contenidos de arriba)
git add scripts/templates/
git commit -m "feat: add script and doc templates in scripts/templates/"
git push origin HEAD
gh pr create --title "P5: plantillas de scripts y documentos" \
  --body "Añade scripts/templates/ con template-script.sh, template-diario.md y template-cierre.md." \
  --draft --base main
```

---

## PRIORIDAD 6 — Política anti-ruido en `docs/OPERATIONAL-PLAYBOOK.md`

**Objetivo:** Documentar la política de workflows escritores para evitar loops de bots.

**Añadir esta sección a `docs/OPERATIONAL-PLAYBOOK.md`** (crear el archivo si no existe):

```markdown
## Prevención de ruido y loops de bots (política operativa)

- Todos los workflows que escriben en el repo deben ejecutarse en modo manual (`workflow_dispatch`) hasta revisión.
- Los workflows escritores deben:
  1. Crear una rama `bot/<workflow>-<timestamp>` y commitear allí.
  2. Abrir un PR draft hacia `main`.
  3. No mergear sin revisión humana explícita.
- Antes de activar cualquier workflow escritor, realizar pruebas en staging 48–72h.
- Mantener backups en `maintenance/backups/<timestamp>/` para restauración rápida.
- Ningún workflow puede escribir directamente en `main` sin PR aprobado.
```

**Rama:** `maintenance/priority-6-playbook`

---

## CHECKLIST FINAL (ejecutar tras completar P1→P6)

```bash
# 1. Verificar que scripts/ está limpio de .md sueltos
ls scripts/*.md 2>/dev/null | grep -v 'SCRIPTS' || echo "OK: no hay .md sueltos"

# 2. Verificar archive/
ls scripts/archive/ | head -20

# 3. Verificar plantillas
ls scripts/templates/

# 4. Test cierre-sesion en dry-run
DRY_RUN=true bash scripts/cierre-sesion.sh

# 5. Test apertura-sesion
bash scripts/apertura-sesion.sh

# 6. Test migración en dry-run
DRY_RUN=true bash scripts/migrar-sesiones-diarios.sh

# 7. PRs draft creados
gh pr list --state open

# 8. Actualizar SCRIPTS-AUDITORIA.md con entradas por prioridad
```

---

## SIGUIENTE CAPA (CAPA 2 — Agentes y MCP)

Una vez fusionados los PRs de P1→P4, proceder con:

- **Agentes:** revisar `scripts/agentes/` — inventariar, eliminar duplicados, documentar en `docs/AGENTES.md`
- **MCP:** revisar configuración MCP en `scripts/` — centralizar en `config/mcp/`
- **Islas:** revisar `scripts/galatea-*.sh` — documentar topología de islas en `docs/ISLAS.md`
- **Docker:** revisar `scripts/infra/` — documentar servicios en `docs/INFRA.md`
- **Workflows:** auditar `.github/workflows/` — desactivar escritores, dejar solo lectura activos

---

*Este documento es la referencia única para Copilot. Actualizar aquí cuando cambien prioridades.*
*Última actualización: 2026-07-04 por Perplexity/MCP*
