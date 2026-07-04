# COPILOT-MASTER-TASKS.md
> Estado: ACTIVO — generado 2026-07-04  
> Scope: **TODA LA REPO** — scripts, agentes, workflows, docs, plantillas, infra  
> Patrón invariable: `dry-run por defecto → branch → apply → PR draft → revisión humana`

---

## ÍNDICE

1. [PASO 0 — Limpieza urgente `.md` en `scripts/`](#paso-0)
2. [CAPA 1 — Scripts (P1→P4)](#capa-1)
3. [CAPA 2 — Agentes y MCP](#capa-2)
4. [CAPA 3 — Workflows GitHub Actions](#capa-3)
5. [CAPA 4 — Plantillas de toda la repo](#capa-4)
6. [CAPA 5 — Infra / Docker / Islas](#capa-5)
7. [Política anti-ruido](#politica)
8. [Checklist de verificación final](#checklist)

---

## PASO 0 — Limpieza urgente `.md` en `scripts/` {#paso-0}

> **Acción urgente.** Estos 4 archivos no pertenecen a `scripts/`.

```bash
git checkout main && git pull origin main

git mv scripts/2026-07-03-23-05-struct-auditor-output.md inbox/_meta/
git mv scripts/2026-07-03-inbox-audit-consolidado.md    inbox/_meta/
git mv scripts/2026-07-03-cierre-sesion-completo.md     diarios/
git mv scripts/2026-07-03-reality-check.md              diarios/

git add -A
git commit -m "fix(estructura): mover .md fuera de scripts/ a sus destinos correctos"
git push origin main
```

**Verificación:**
```bash
ls -l inbox/_meta | grep 2026-07-03
ls -l diarios    | grep 2026-07-03
git status --porcelain
```

---

## CAPA 1 — Scripts {#capa-1}

### P1 — Consolidación de orquestadores

**Mantener:** `scripts/orquestador-unico.sh`  
**Archivar en `scripts/archive/`:**
- `scripts/orquestador-supremo.sh`
- `scripts/orquestador-total.sh`
- `scripts/meta-orquestador.sh`
- `scripts/clasificador-maestro.sh`
- `scripts/guardian-maestro.sh`

```bash
# DRY-RUN
for f in orquestador-supremo.sh orquestador-total.sh meta-orquestador.sh clasificador-maestro.sh guardian-maestro.sh; do
  [ -f "scripts/$f" ] && echo "[DRY-RUN] would move scripts/$f -> scripts/archive/$f" || echo "[MISSING] $f"
done

# APPLY
git checkout -b maintenance/priority-1-consolidacion-$(date +%Y%m%d%H%M%S)
mkdir -p scripts/archive
for f in orquestador-supremo.sh orquestador-total.sh meta-orquestador.sh clasificador-maestro.sh guardian-maestro.sh; do
  git mv "scripts/$f" scripts/archive/ 2>/dev/null || true
done

# Añadir cabecera CANONICAL a orquestador-unico.sh
python3 - <<'PY'
p='scripts/orquestador-unico.sh'
hdr="# CANONICAL ORQUESTADOR\n# Entrada canónica de orquestación. Redundantes archivados en scripts/archive/.\n"
s=open(p).read()
if 'CANONICAL ORQUESTADOR' not in s:
    open(p,'w').write(hdr + '\n' + s)
PY

git add -A
git commit -m "chore(P1): archive redundant orchestrators; orquestador-unico as canonical"
git push origin HEAD
gh pr create --title "P1: archive redundant orchestrators" \
  --body "Archiva orquestadores redundantes en scripts/archive/. orquestador-unico.sh = CANONICAL. Reversible via git mv." \
  --draft
```

**Rollback:** `git mv scripts/archive/<file> scripts/<file>`

---

### P2 — Auto-commit en `cierre-sesion.sh`

Snippet exacto a añadir al final del script:

```bash
# Auto-upload session closure (added by maintenance script)
if [ -x "$(dirname "$0")/inbox-commit.sh" ]; then
  if [ "${DRY_RUN:-true}" = "false" ]; then
    "$(dirname "$0")/inbox-commit.sh" || true
  else
    echo "[DRY-RUN] would call $(dirname \"$0\")/inbox-commit.sh to commit closure"
  fi
fi
```

```bash
# DRY-RUN
grep -q 'Auto-upload session closure' scripts/cierre-sesion.sh && echo 'already present' || echo '[DRY-RUN] would append snippet'

# APPLY
git checkout -b maintenance/priority-2-auto-commit-$(date +%Y%m%d%H%M%S)
if ! grep -q 'Auto-upload session closure' scripts/cierre-sesion.sh 2>/dev/null; then
  cat >> scripts/cierre-sesion.sh <<'SH'

# Auto-upload session closure (added by maintenance script)
if [ -x "$(dirname "$0")/inbox-commit.sh" ]; then
  if [ "${DRY_RUN:-true}" = "false" ]; then
    "$(dirname "$0")/inbox-commit.sh" || true
  else
    echo "[DRY-RUN] would call inbox-commit.sh to commit closure"
  fi
fi
SH
  chmod +x scripts/cierre-sesion.sh
  git add scripts/cierre-sesion.sh
  git commit -m "feat(P2): auto-commit session closure in cierre-sesion.sh"
  git push origin HEAD
  gh pr create --title "P2: auto-commit session closure" --body "Añade llamada a inbox-commit.sh al final de cierre-sesion.sh (respeta DRY_RUN)." --draft
fi
```

**Verificación:**
```bash
DRY_RUN=true  bash scripts/cierre-sesion.sh
DRY_RUN=false bash scripts/cierre-sesion.sh  # en staging
```

---

### P3 — `migrar-sesiones-diarios.sh` (nuevo script)

Crea `scripts/migrar-sesiones-diarios.sh` con:

```bash
#!/usr/bin/env bash
# scripts/migrar-sesiones-diarios.sh
# Mueve inbox/sesiones/cierre-*.md -> diarios/YYYY-MM-DD-tema.md
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
INBOX="$ROOT/inbox/sesiones"
OUTDIR="$ROOT/diarios"
DRY_RUN="${DRY_RUN:-true}"
mkdir -p "$OUTDIR"

for f in "$INBOX"/cierre-*.md; do
  [ -f "$f" ] || continue
  base=$(basename "$f")
  if [[ "$base" =~ ([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
    datepart="${BASH_REMATCH[1]}"
  elif [[ "$base" =~ ([0-9]{8}) ]]; then
    d="${BASH_REMATCH[1]}"; datepart="${d:0:4}-${d:4:2}-${d:6:2}"
  else
    datepart=$(grep -Eo '[0-9]{4}-[0-9]{2}-[0-9]{2}' "$f" | head -n1 || date -r "$f" +%F)
  fi
  topic=$(grep -m1 '^#' "$f" | sed 's/^#\s*//; s/[^a-zA-Z0-9_-]/-/g' | tr '[:upper:]' '[:lower:]' | cut -c1-40 || true)
  [ -z "$topic" ] && topic=$(echo "$base" | sed 's/^cierre-//; s/\.md$//; s/[^a-zA-Z0-9_-]/-/g' | cut -c1-40)
  out="$OUTDIR/${datepart}-${topic}.md"
  if [ -f "$out" ]; then
    suffix=1
    while [ -f "${out%.md}-$suffix.md" ]; do suffix=$((suffix+1)); done
    out="${out%.md}-$suffix.md"
  fi
  if [ "$DRY_RUN" = "true" ]; then
    echo "[DRY-RUN] Would move: $f -> $out"
  else
    mv "$f" "$out" && git add "$out" && git rm --quiet "$f" || true
    echo "Moved $f -> $out"
  fi
done

[ "$DRY_RUN" = "false" ] && git commit -m "chore(P3): migrate sessions to diarios" && git push origin HEAD
```

```bash
# APPLY
git checkout -b maintenance/priority-3-migrar-sesiones-$(date +%Y%m%d%H%M%S)
chmod +x scripts/migrar-sesiones-diarios.sh
git add scripts/migrar-sesiones-diarios.sh
git commit -m "feat(P3): add migrar-sesiones-diarios.sh"
git push origin HEAD
gh pr create --title "P3: migrar sesiones a diarios" --body "Añade script para mover inbox/sesiones/cierre-*.md a diarios/." --draft

# Ejecutar migración (tras merge del PR)
DRY_RUN=true  bash scripts/migrar-sesiones-diarios.sh  # revisar
DRY_RUN=false bash scripts/migrar-sesiones-diarios.sh  # aplicar
```

---

### P4 — Auditoría pre-sesión en `apertura-sesion.sh`

Snippet a insertar justo después del shebang:

```bash
# Pre-session quick audit (added by maintenance script)
if [ -x "$(dirname "$0")/struct-auditor.sh" ]; then
  "$(dirname "$0")/struct-auditor.sh" --quick || { echo "Critical issues detected. Aborting."; exit 1; }
else
  echo "struct-auditor not found; skipping pre-session audit."
fi
```

```bash
# APPLY
git checkout -b maintenance/priority-4-pre-audit-$(date +%Y%m%d%H%M%S)
awk 'NR==1 && /^#!/{print; print "\n# Pre-session quick audit (added by maintenance script)\nif [ -x \"$(dirname \"$0\")/struct-auditor.sh\" ]; then\n  \"$(dirname \"$0\")/struct-auditor.sh\" --quick || { echo \"Critical issues. Aborting.\"; exit 1; }\nelse\n  echo \"struct-auditor not found; skipping.\";\nfi\n"; next} {print}' \
  scripts/apertura-sesion.sh > scripts/apertura-sesion.sh.tmp \
  && mv scripts/apertura-sesion.sh.tmp scripts/apertura-sesion.sh
chmod +x scripts/apertura-sesion.sh
git add scripts/apertura-sesion.sh
git commit -m "feat(P4): pre-session quick audit in apertura-sesion.sh"
git push origin HEAD
gh pr create --title "P4: pre-session quick audit" --body "Inserta struct-auditor.sh --quick al inicio de apertura-sesion.sh." --draft
```

---

## CAPA 2 — Agentes y MCP {#capa-2}

> Mismo patrón: dry-run → branch → apply → PR draft.

### Tareas para Copilot — CAPA 2

1. **Auditar `scripts/agentes/`** — listar todos los agentes, verificar que cada uno tiene:
   - Shebang correcto
   - Cabecera con `AGENT:`, `VERSION:`, `OWNER:`, `DESCRIPTION:`
   - Modo `--dry-run` implementado
   - Log estructurado (timestamp + nivel)

2. **Plantilla de agente** — crear `templates/agent-template.sh` con la estructura estándar mínima.

3. **Auditar `scripts/observador-*.sh`** — verificar que ninguno escribe directamente en `main` sin pasar por `inbox/`.

4. **MCP config** — si existe `mcp/` o `.mcp/`, verificar que los endpoints apuntan a staging antes de producción.

5. **Crear `docs/AGENTES-INVENTARIO.md`** — tabla con: nombre, ruta, descripción, owner, estado (activo/archivado), última ejecución conocida.

```bash
# Branch para CAPA 2
git checkout -b maintenance/capa2-agentes-mcp-$(date +%Y%m%d%H%M%S)
```

---

## CAPA 3 — Workflows GitHub Actions {#capa-3}

### Tareas para Copilot — CAPA 3

1. **Inventariar `.github/workflows/`** — lista completa con: nombre, trigger, escribe-en-repo (sí/no), estado (habilitado/deshabilitado).

2. **Política de workflows escritores** — cualquier workflow que haga `git push` o cree archivos DEBE:
   - Tener `workflow_dispatch` como trigger (no solo `push`/`schedule`).
   - Crear rama `bot/<workflow>-<ts>` y abrir PR draft.
   - Nunca mergear automáticamente sin aprobación humana.

3. **Desactivar workflows escritores activos** que no cumplan la política anterior.

4. **Crear `.github/workflows/file-arrival-guardian.yml`** que llame a `scripts/file-arrival-guardian.sh --dry-run` en cada PR.

5. **Crear `.github/workflows/struct-audit.yml`** que ejecute `scripts/struct-auditor.sh --quick` en cada push a `main`.

```bash
git checkout -b maintenance/capa3-workflows-$(date +%Y%m%d%H%M%S)
```

---

## CAPA 4 — Plantillas de toda la repo {#capa-4}

### Tareas para Copilot — CAPA 4

Crear o actualizar en `templates/`:

| Archivo | Descripción |
|---|---|
| `templates/script-template.sh` | Plantilla estándar para scripts: shebang, cabecera, dry-run, log, cleanup |
| `templates/agent-template.sh` | Plantilla para agentes autónomos |
| `templates/session-close-template.md` | Plantilla para documentos de cierre de sesión |
| `templates/diario-template.md` | Plantilla para entradas en `diarios/` |
| `templates/workflow-template.yml` | Plantilla para workflows de GitHub Actions |
| `templates/pr-body-template.md` | Plantilla para cuerpo de PRs |
| `templates/issue-template.md` | Plantilla para issues (si no existe en `.github/ISSUE_TEMPLATE/`) |

Todas las plantillas deben incluir:
- Cabecera con metadatos (propósito, owner, versión, fecha de creación)
- Sección `## USO` con ejemplo de uso mínimo
- Sección `## PARÁMETROS` (si aplica)
- Sección `## ROLLBACK` (si aplica)

```bash
git checkout -b maintenance/capa4-plantillas-$(date +%Y%m%d%H%M%S)
mkdir -p templates
```

---

## CAPA 5 — Infra / Docker / Islas {#capa-5}

### Tareas para Copilot — CAPA 5

1. **Inventariar `scripts/infra/`** — listar todos los scripts de infra y verificar que tienen dry-run.

2. **Auditar `scripts/galatea-*.sh`** (islas/bots) — verificar que cada isla tiene:
   - Script de inicio y parada limpios
   - No escribe fuera de su directorio asignado
   - Logs van a `inbox/` o `logs/`

3. **Docker** — si existe `docker-compose.yml` o `Dockerfile`, verificar:
   - Variables de entorno no hardcodeadas
   - `.env.example` presente
   - `DOCKER-README.md` con instrucciones de arranque

4. **`scripts/deploy.sh` y `scripts/deploy-madre.sh`** — verificar que ambos tienen modo `--dry-run` antes de cualquier acción destructiva.

5. **Crear `docs/ISLAS-INVENTARIO.md`** — tabla: nombre isla, docker/nativo, puertos, estado, script de control.

```bash
git checkout -b maintenance/capa5-infra-islas-$(date +%Y%m%d%H%M%S)
```

---

## Política anti-ruido y anti-loops {#politica}

Pega esto en `docs/OPERATIONAL-PLAYBOOK.md`:

```markdown
## Prevención de ruido y loops de bots (política operativa)

- Todos los workflows que escriben en el repo se ejecutan SOLO en modo `workflow_dispatch`.
- Cualquier workflow escritor DEBE:
  1. Crear rama `bot/<workflow>-<ts>`.
  2. Abrir PR draft hacia `main`.
  3. Nunca auto-mergear sin revisión humana.
- Antes de activar un workflow escritor: pruebas en staging 48-72h.
- Backups en `maintenance/backups/<ts>/` para restauración rápida.
- Ningún script llama a otro orquestador: solo `orquestador-unico.sh` coordina.
```

---

## Checklist de verificación final {#checklist}

Ejecuta tras completar cada capa:

```bash
# 1. Ramas creadas
git branch --list 'maintenance/*'

# 2. PRs draft visibles
gh pr list --state open

# 3. scripts/archive/ con los orquestadores movidos
ls -1 scripts/archive/

# 4. cierre-sesion.sh tiene el snippet
grep 'Auto-upload session closure' scripts/cierre-sesion.sh

# 5. migrar-sesiones-diarios.sh ejecuta en dry-run
DRY_RUN=true bash scripts/migrar-sesiones-diarios.sh

# 6. apertura-sesion.sh aborta si struct-auditor falla
bash scripts/apertura-sesion.sh

# 7. Smoke tests
bash scripts/verify/run-smoke-tests.sh 2>/dev/null || echo 'smoke tests: check manually'

# 8. Auditor de estructura
bash scripts/struct-auditor.sh --quick
```

---

## Estado de ejecución (actualizar por Copilot tras cada PR)

| Tarea | Estado | Branch | PR | Merge |
|---|---|---|---|---|
| PASO 0 — mover .md | ⏳ pendiente | — | — | — |
| P1 — consolidar orquestadores | ⏳ pendiente | — | — | — |
| P2 — auto-commit cierre | ⏳ pendiente | — | — | — |
| P3 — migrar-sesiones-diarios | ⏳ pendiente | — | — | — |
| P4 — pre-audit apertura | ⏳ pendiente | — | — | — |
| CAPA 2 — agentes/MCP | ⏳ pendiente | — | — | — |
| CAPA 3 — workflows | ⏳ pendiente | — | — | — |
| CAPA 4 — plantillas | ⏳ pendiente | — | — | — |
| CAPA 5 — infra/islas | ⏳ pendiente | — | — | — |

> Copilot: actualiza la columna **Estado** con ✅/❌ y rellena **Branch** y **PR** con los valores reales tras cada ejecución.
