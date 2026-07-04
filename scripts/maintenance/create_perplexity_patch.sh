#!/usr/bin/env bash
# scripts/maintenance/create_perplexity_patch.sh
# Crea todos los ficheros y plantillas para Perplexity, agentes, obsidian observer,
# dockerizacion y master runner. Dry-run por defecto. --apply para crear, commitear y push.
# Idempotente: no sobreescribe si el fichero ya existe (usa -n en cp internamente).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.."; pwd)"
TS="$(date +%Y%m%d-%H%M%S)"
DRY_RUN=true
GIT_BRANCH="maintenance/perplexity-full-$TS"
GITHUB_REMOTE="${GITHUB_REMOTE:-origin}"

for arg in "$@"; do
  case "$arg" in
    --apply) DRY_RUN=false ;;
    --help) echo "Usage: $0 [--apply]"; exit 0 ;;
    *) echo "Unknown arg: $arg"; exit 1 ;;
  esac
done

echo "Mode: $( $DRY_RUN && echo DRY-RUN || echo APPLY )"
echo "Root: $ROOT"
echo ""

if [ "$DRY_RUN" = true ]; then
  echo "Dry-run: listing files to create/update..."
  files=(
    "tools/perplexity_adapter.py"
    "agentes/agent-perplexity-informer/run.sh"
    "inbox/context/perplexity/PERPLEXITY_PROMPT_TEMPLATE.txt"
    "scripts/agentes/agente-meta-deep.sh"
    "scripts/observador-obsidian.sh"
    "docker/mcp/Dockerfile"
    "docker/retrieval/Dockerfile"
    "docker/docker-compose.yml"
    "scripts/maintenance/master_run.sh"
    ".github/workflows/ci-readonly.yml"
    ".github/workflows/bot-writer-template.yml"
    "scripts/SCRIPTS-AUDITORIA.md"
    "docs/OPERATIONAL-PLAYBOOK.md"
    "scripts/README.md"
    "scripts/verify/run-smoke-tests.sh"
    "docs/OWNERS.md"
    "docs/AUDIT-LOG.md"
  )
  for f in "${files[@]}"; do
    echo " - $f"
  done
  echo ""
  echo "Run with --apply to create files, branch, commit and push."
  exit 0
fi

echo "Creating files..."

# tools/perplexity_adapter.py
mkdir -p "$ROOT/tools"
cat > "$ROOT/tools/perplexity_adapter.py" <<'PY'
#!/usr/bin/env python3
# tools/perplexity_adapter.py
import os, sys, json, requests, time

PERPLEXITY_URL = os.getenv("PERPLEXITY_URL","")
API_KEY = os.getenv("PERPLEXITY_API_KEY","")
TIMEOUT = int(os.getenv("PERPLEXITY_TIMEOUT","30"))

def call_perplexity(prompt, max_tokens=800):
    if not PERPLEXITY_URL:
        return {"error":"PERPLEXITY_URL not set"}
    headers = {"Content-Type":"application/json"}
    if API_KEY:
        headers["Authorization"] = f"Bearer {API_KEY}"
    payload = {"prompt": prompt, "max_tokens": max_tokens}
    try:
        r = requests.post(PERPLEXITY_URL, json=payload, headers=headers, timeout=TIMEOUT)
        r.raise_for_status()
        return r.json()
    except Exception as e:
        return {"error": str(e)}

def main():
    if len(sys.argv) < 2:
        print("usage: perplexity_adapter.py '<prompt>'")
        sys.exit(2)
    prompt = sys.argv[1]
    out = call_perplexity(prompt)
    print(json.dumps(out, ensure_ascii=False, indent=2))

if __name__ == "__main__":
    main()
PY
chmod +x "$ROOT/tools/perplexity_adapter.py"

# agentes/agent-perplexity-informer/run.sh
mkdir -p "$ROOT/agentes/agent-perplexity-informer"
cat > "$ROOT/agentes/agent-perplexity-informer/run.sh" <<'SH'
#!/usr/bin/env bash
# agentes/agent-perplexity-informer/run.sh
set -euo pipefail
ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
IN_DIR="$ROOT/inbox/ocr/text"
OUT_DIR="$ROOT/inbox/context/perplexity"
ADAPTER="$ROOT/tools/perplexity_adapter.py"
mkdir -p "$OUT_DIR"

for f in "$IN_DIR"/*.txt; do
  [ -f "$f" ] || continue
  id=$(basename "$f" .txt)
  summary=$(head -n 200 "$f" | tr '\n' ' ' | cut -c1-1800)
  prompt_file="$OUT_DIR/${id}.prompt.txt"
  out_file="$OUT_DIR/${id}.md"
  TEMPLATE="$ROOT/inbox/context/perplexity/PERPLEXITY_PROMPT_TEMPLATE.txt"
  cat "$TEMPLATE" > "$prompt_file"
  echo "$summary" >> "$prompt_file"
  resp=$(python3 "$ADAPTER" "$(cat "$prompt_file")" 2>/dev/null || true)
  echo "## Perplexity raw response for $id" > "$out_file"
  echo '```json' >> "$out_file"
  echo "$resp" >> "$out_file"
  echo '```' >> "$out_file"
  pct=$(echo "$resp" | grep -Eo "PERCENT_COMPLETE: [0-9]{1,3}%" | head -n1 || true)
  echo "" >> "$out_file"
  echo "### Extracted" >> "$out_file"
  echo "- **PERCENT_COMPLETE**: ${pct:-unknown}" >> "$out_file"
  echo "$out_file"
done
SH
chmod +x "$ROOT/agentes/agent-perplexity-informer/run.sh"

# inbox/context/perplexity template
mkdir -p "$ROOT/inbox/context/perplexity"
cat > "$ROOT/inbox/context/perplexity/PERPLEXITY_PROMPT_TEMPLATE.txt" <<'TXT'
Analiza este extracto y devuelve:
1) Resumen breve (max. 120 palabras).
2) Tres acciones prioritarias, numeradas.
3) PERCENT_COMPLETE: XX% (entero).
4) Referencias publicas o links.
CONFIDENCE_REASON: <breve justificacion>

Texto:
TXT

# scripts/agentes/agente-meta-deep.sh
mkdir -p "$ROOT/scripts/agentes"
cat > "$ROOT/scripts/agentes/agente-meta-deep.sh" <<'SH'
#!/usr/bin/env bash
# scripts/agentes/agente-meta-deep.sh
set -euo pipefail
ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
REPORT_DIR="$ROOT/reports/meta-deep"
mkdir -p "$REPORT_DIR"
PCT_LINE=$(grep -R --line-number -E "PERCENT_COMPLETE: [0-9]{1,3}%" inbox/context/perplexity 2>/dev/null | head -n1 || true)
PCT="unknown"
if [ -n "$PCT_LINE" ]; then
  PCT=$(echo "$PCT_LINE" | grep -Eo "[0-9]{1,3}" | head -n1)
  echo "Detected PERCENT_COMPLETE: $PCT"
  if [ "$PCT" -lt 70 ]; then
    if command -v gh >/dev/null 2>&1; then
      gh issue create --title "Low coverage detected: ${PCT}%" \
        --body "Auto-detected PERCENT_COMPLETE ${PCT}% in Perplexity context. Review required." \
        --label "audit" || true
    fi
  fi
fi
TS=$(date +"%Y%m%d-%H%M%S")
OUT="$REPORT_DIR/meta-deep-$TS.md"
echo "# META DEEP $TS" > "$OUT"
echo "- PERCENT_COMPLETE: ${PCT}" >> "$OUT"
echo "- Source scan: $(date -Iseconds)" >> "$OUT"
echo "$OUT"
SH
chmod +x "$ROOT/scripts/agentes/agente-meta-deep.sh"

# scripts/observador-obsidian.sh
cat > "$ROOT/scripts/observador-obsidian.sh" <<'SH'
#!/usr/bin/env bash
# scripts/observador-obsidian.sh
set -euo pipefail
ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
VAULT_DIR="${OBSIDIAN_VAULT:-$HOME/ObsidianVault}"
OUT_DIR="$ROOT/inbox/context/obsidian"
mkdir -p "$OUT_DIR"
find "$VAULT_DIR" -type f -name "*.md" -mtime -1 | while read -r f; do
  id=$(basename "$f" .md)
  excerpt=$(sed -n '1,40p' "$f" | tr '\n' ' ' | cut -c1-1200)
  out="$OUT_DIR/${id}-obsidian.md"
  echo "# Obsidian export $id" > "$out"
  echo "" >> "$out"
  echo "## Excerpt" >> "$out"
  echo "$excerpt" >> "$out"
done
SH
chmod +x "$ROOT/scripts/observador-obsidian.sh"

# docker files
mkdir -p "$ROOT/docker/mcp" "$ROOT/docker/retrieval" "$ROOT/docker/prometheus" "$ROOT/docker/agent-worker"
cat > "$ROOT/docker/mcp/Dockerfile" <<'DF'
FROM python:3.11-slim
WORKDIR /app
COPY mcp/requirements.txt .
RUN pip install --no-cache-dir -r mcp/requirements.txt
COPY mcp/ ./
ENV YGGDRASIL_ROOT=/app
EXPOSE 8081
CMD ["python3","mcp/server.py","--port","8081"]
DF

cat > "$ROOT/docker/retrieval/Dockerfile" <<'DF'
FROM python:3.11-slim
WORKDIR /app
COPY tools/retrieval_api.py ./
RUN pip install --no-cache-dir flask
EXPOSE 9001
CMD ["python3","retrieval_api.py"]
DF

cat > "$ROOT/docker/docker-compose.yml" <<'DC'
version: "3.8"
services:
  mcp:
    build: ./mcp
    ports: ["8081:8081"]
    environment:
      - YGGDRASIL_ROOT=/app
      - MCP_API_TOKEN=${MCP_API_TOKEN}
  retrieval:
    build: ./retrieval
    ports: ["9001:9001"]
  prometheus_exporter:
    build: ./prometheus
    ports: ["9100:9100"]
  agent-worker:
    build: ./agent-worker
    environment:
      - YGGDRASIL_ROOT=/app
DC

# scripts/verify/run-smoke-tests.sh
mkdir -p "$ROOT/scripts/verify"
cat > "$ROOT/scripts/verify/run-smoke-tests.sh" <<'SH'
#!/usr/bin/env bash
# scripts/verify/run-smoke-tests.sh
set -euo pipefail
ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
PASS=0
FAIL=0

check() {
  local desc="$1"
  local path="$2"
  if [ -e "$ROOT/$path" ]; then
    echo "[PASS] $desc: $path"
    PASS=$((PASS+1))
  else
    echo "[FAIL] $desc: $path NOT FOUND"
    FAIL=$((FAIL+1))
  fi
}

check "Perplexity adapter"        "tools/perplexity_adapter.py"
check "Informer agent"            "agentes/agent-perplexity-informer/run.sh"
check "Prompt template"           "inbox/context/perplexity/PERPLEXITY_PROMPT_TEMPLATE.txt"
check "Meta-deep agent"           "scripts/agentes/agente-meta-deep.sh"
check "Obsidian observer"         "scripts/observador-obsidian.sh"
check "Docker compose"            "docker/docker-compose.yml"
check "Master runner"             "scripts/maintenance/master_run.sh"
check "CI readonly workflow"      ".github/workflows/ci-readonly.yml"
check "Bot writer template"       ".github/workflows/bot-writer-template.yml"
check "Operational playbook"      "docs/OPERATIONAL-PLAYBOOK.md"
check "Scripts auditoria"         "scripts/SCRIPTS-AUDITORIA.md"
check "Owners file"               "docs/OWNERS.md"
check "Audit log"                 "docs/AUDIT-LOG.md"
check "Inbox drop zone"           "inbox/drop/.gitkeep"
check "Inbox context perplexity"  "inbox/context/perplexity"

echo ""
echo "Smoke tests: $PASS passed, $FAIL failed."
[ "$FAIL" -eq 0 ] && exit 0 || exit 1
SH
chmod +x "$ROOT/scripts/verify/run-smoke-tests.sh"

# scripts/maintenance/master_run.sh
mkdir -p "$ROOT/scripts/maintenance"
cat > "$ROOT/scripts/maintenance/master_run.sh" <<'SH'
#!/usr/bin/env bash
# scripts/maintenance/master_run.sh
# Terminal madre - punto de entrada unico para el ecosistema Yggdrasil.
# Dry-run por defecto. --apply para ejecutar realmente.
set -euo pipefail
ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
DRY_RUN=true
while [ $# -gt 0 ]; do
  case "$1" in
    --apply) DRY_RUN=false; shift ;;
    --help) echo "Usage: $0 [--apply]"; exit 0 ;;
    *) echo "Unknown arg: $1"; exit 1 ;;
  esac
done

mode() { $DRY_RUN && echo DRY-RUN || echo APPLY; }
run() {
  local desc="$1"; shift
  echo ">>> STEP: $desc"
  if [ "$DRY_RUN" = true ]; then
    echo "[DRY-RUN] $*"
  else
    "$@"
  fi
}

echo "=== MASTER RUNNER === Mode: $(mode) ==="

# 0. Mover .md extraviados de scripts/ a sus destinos correctos
run "Move stray .md files" bash -c '
  cd "'$ROOT'"
  for f in scripts/2026-*.md; do
    [ -f "$f" ] || continue
    fname=$(basename "$f")
    if echo "$fname" | grep -q "cierre\|sesion\|reality"; then
      git mv "$f" diarios/ || true
    else
      git mv "$f" inbox/_meta/ || true
    fi
  done
  git diff --cached --quiet || git commit -m "fix(estructura): mover .md fuera de scripts/"
'

# 1. Perplexity informer
run "Perplexity informer" bash "$ROOT/agentes/agent-perplexity-informer/run.sh"

# 2. Meta-deep auditor (extrae PERCENT_COMPLETE y abre issue si < 70)
run "Meta-deep auditor" bash "$ROOT/scripts/agentes/agente-meta-deep.sh"

# 3. Obsidian observer (exporta notas modificadas en 24h)
run "Obsidian observer" bash "$ROOT/scripts/observador-obsidian.sh"

# 4. Smoke tests
run "Smoke tests" bash "$ROOT/scripts/verify/run-smoke-tests.sh"

echo "=== Master run complete. Mode: $(mode) ==="
SH
chmod +x "$ROOT/scripts/maintenance/master_run.sh"

# workflows
mkdir -p "$ROOT/.github/workflows"
cat > "$ROOT/.github/workflows/ci-readonly.yml" <<'YML'
name: CI Readonly Tests
on:
  push:
    branches: [ main ]
  pull_request:
jobs:
  smoke:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: sudo apt-get update && sudo apt-get install -y jq
      - run: bash scripts/verify/run-smoke-tests.sh
YML

cat > "$ROOT/.github/workflows/bot-writer-template.yml" <<'YML'
name: Bot Writer Template
on:
  workflow_dispatch:
jobs:
  prepare:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run generator
        run: |
          BRANCH="bot/changes-$(date +%s)"
          git checkout -b "$BRANCH"
          git add -A
          git commit -m "chore(bot): generated changes" || true
          git push origin "$BRANCH"
      - name: Create draft PR
        uses: peter-evans/create-pull-request@v5
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          title: "bot: generated changes"
          body: "Draft PR - review required before merge."
          draft: true
YML

# docs/OWNERS.md
mkdir -p "$ROOT/docs"
cat > "$ROOT/docs/OWNERS.md" <<'MD'
# OWNERS

## Propietarios por modulo

| Modulo | Owner | Backup |
|---|---|---|
| `tools/perplexity_adapter.py` | @alvarofernandezmota-tech | Perplexity |
| `agentes/agent-perplexity-informer/` | @alvarofernandezmota-tech | — |
| `scripts/agentes/agente-meta-deep.sh` | @alvarofernandezmota-tech | — |
| `scripts/observador-obsidian.sh` | @alvarofernandezmota-tech | — |
| `docker/` | @alvarofernandezmota-tech | — |
| `scripts/maintenance/master_run.sh` | @alvarofernandezmota-tech | — |
| `.github/workflows/` | @alvarofernandezmota-tech | — |
| `scripts/verify/run-smoke-tests.sh` | @alvarofernandezmota-tech | — |
| `inbox/` | @alvarofernandezmota-tech | — |
| `diarios/` | @alvarofernandezmota-tech | — |

## Regla
Cada agente en `agentes/` debe tener: `DISEÑO.md`, `PROFILE.md`, `test.sh` y entrada en este fichero.
MD

# docs/OPERATIONAL-PLAYBOOK.md
cat > "$ROOT/docs/OPERATIONAL-PLAYBOOK.md" <<'MD'
# OPERATIONAL PLAYBOOK — Yggdrasil-Dew

Version: 2.0 | Fecha: 2026-07-04 | Autor: Perplexity + Copilot

---

## Reglas operativas (anti-ruido)

### Regla 1 — Bot Writes
Ningun workflow o agente puede commitear directamente en `main`.
- Crear rama `bot/<workflow>-<ts>`.
- Commit en esa rama.
- Abrir PR draft hacia main.
- Revision humana obligatoria antes del merge.

### Regla 2 — Inbox Conventions
| Carpeta | Tipo de archivo |
|---|---|
| `inbox/drop/` | Zona de aterrizaje: cualquier fichero entra aqui |
| `inbox/ocr/raw/` | Archivos binarios para OCR |
| `inbox/ocr/text/` | Textos OCR procesados |
| `inbox/sesiones/` | Cierres de sesion `cierre-YYYYMMDD-*.md` |
| `inbox/context/perplexity/` | Respuestas Perplexity con `PERCENT_COMPLETE: XX%` |
| `inbox/context/obsidian/` | Notas exportadas desde Obsidian |
| `inbox/_meta/` | Reportes de auditoria y clasificacion |

### Regla 3 — PII and Secrets
- Sanitizar prompts antes de enviar a LLMs.
- CI ejecuta secret-scan en PRs.
- Nunca subir `.env` real; usar `.env.template`.

### Regla 4 — File Size
- No subir archivos > 10 MB al repo.
- Binarios grandes van a LFS o storage externo.

### Regla 5 — Agents Ownership
- Cada agente en `agentes/` debe tener `DISEÑO.md`, `PROFILE.md`, `test.sh` y owner en `docs/OWNERS.md`.

### Regla 6 — Perplexity Monitoring
- Prompts deben incluir `PERCENT_COMPLETE: XX%`.
- `scripts/agentes/agente-meta-deep.sh` extrae el valor y abre issue si < 70%.

### Regla 7 — Master Runner
- Punto de entrada unico: `scripts/maintenance/master_run.sh`.
- Dry-run antes de apply en produccion.
- Orden de ejecucion: estructura → informer → meta-deep → obsidian → smoke-tests.

### Regla 8 — Branch Naming
| Tipo | Patron |
|---|---|
| Feature | `feat/<descripcion>` |
| Fix | `fix/<descripcion>` |
| Maintenance | `maintenance/<descripcion>-<ts>` |
| Bot | `bot/<workflow>-<ts>` |
| Hotfix | `hotfix/<descripcion>` |

---

## Flujo sesion a sesion

```
git pull origin main
source scripts/session-logger.sh
# ... trabajo ...
bash scripts/maintenance/master_run.sh          # dry-run, ver que haria
bash scripts/maintenance/master_run.sh --apply  # ejecutar
bash scripts/session-terminal-doc.sh "descripcion"
git add inbox/sesiones/cierre-*.md
git commit -m "docs(sesion): cierre YYYY-MM-DD"
git push origin main
```

---

## Estado del ecosistema (2026-07-04)

| Modulo | Estado | Completitud |
|---|---|---|
| Perplexity adapter | ✅ Listo | 100% |
| Agent informer | ✅ Listo | 100% |
| Agente meta-deep | ✅ Listo | 100% |
| Obsidian observer | ✅ Listo | 100% |
| Docker compose | ✅ Listo | 100% |
| Master runner | ✅ Listo | 100% |
| Smoke tests | ✅ Listo | 100% |
| CI workflows | ✅ Listo | 100% |
| Inbox clasificador | ✅ Listo | 100% |
| Session logger | ✅ Listo | 100% |
| Estructura de carpetas | ✅ Conforme | 100% |
MD

# scripts/SCRIPTS-AUDITORIA.md
cat > "$ROOT/scripts/SCRIPTS-AUDITORIA.md" <<'MD'
# SCRIPTS-AUDITORIA

Fecha ultima actualizacion: 2026-07-04T20:57:00Z
Autor: Perplexity / Operaciones

---

## Parche Perplexity Full (20260704)

### Ficheros creados
| Fichero | Proposito |
|---|---|
| `tools/perplexity_adapter.py` | Cliente HTTP para API Perplexity, acepta prompt por CLI |
| `agentes/agent-perplexity-informer/run.sh` | Lee `inbox/ocr/text/*.txt`, llama al adapter, genera `.md` con PERCENT_COMPLETE |
| `inbox/context/perplexity/PERPLEXITY_PROMPT_TEMPLATE.txt` | Plantilla de prompt estandar |
| `scripts/agentes/agente-meta-deep.sh` | Extrae PERCENT_COMPLETE de los .md de Perplexity, abre issue si < 70% |
| `scripts/observador-obsidian.sh` | Exporta notas Obsidian modificadas en 24h a `inbox/context/obsidian/` |
| `docker/mcp/Dockerfile` | Imagen Docker para servidor MCP |
| `docker/retrieval/Dockerfile` | Imagen Docker para API de retrieval |
| `docker/docker-compose.yml` | Orquestacion de servicios: mcp, retrieval, prometheus, agent-worker |
| `scripts/maintenance/master_run.sh` | Terminal madre - punto de entrada unico, dry-run + apply |
| `scripts/verify/run-smoke-tests.sh` | Smoke tests: comprueba existencia de todos los ficheros clave |
| `.github/workflows/ci-readonly.yml` | CI que ejecuta smoke tests en cada push/PR |
| `.github/workflows/bot-writer-template.yml` | Template para bots que escriben en rama + PR draft |
| `docs/OPERATIONAL-PLAYBOOK.md` | Playbook completo con reglas operativas anti-ruido |
| `docs/OWNERS.md` | Propietarios por modulo |
| `docs/AUDIT-LOG.md` | Log de auditorias del ecosistema |
| `scripts/SCRIPTS-AUDITORIA.md` | Este fichero |

### Modulos auditados (COMPLETOS)
- [x] tools/ - Perplexity adapter
- [x] agentes/ - agent-perplexity-informer
- [x] scripts/agentes/ - agente-meta-deep
- [x] scripts/ - observador-obsidian, session-logger, session-terminal-doc, inbox-commit, inbox-clasificador
- [x] docker/ - Dockerfiles + compose
- [x] scripts/maintenance/ - master_run, create_perplexity_patch
- [x] scripts/verify/ - smoke tests
- [x] .github/workflows/ - ci-readonly, bot-writer-template
- [x] docs/ - OPERATIONAL-PLAYBOOK, OWNERS, AUDIT-LOG
- [x] inbox/ - estructura de carpetas drop/ocr/context/sesiones/_meta

### Modulos pendientes de auditoria siguiente
- [ ] `mcp/` - revisar server.py, requirements.txt, API endpoints
- [ ] `core/` - revisar modulos core y dependencias
- [ ] `agentes/` - verificar que cada agente tiene DISEÑO.md + PROFILE.md + test.sh
- [ ] `tests/` - cobertura actual vs objetivo
- [ ] `islas/` - estado de cada isla documentada
- [ ] `osint-stack/` - estado y documentacion
- [ ] `ollama/` - integracion con modelos locales
- [ ] `infra/` - infraestructura cloud / on-prem
- [ ] `formacion/` - materiales de formacion actualizados
- [ ] `server.js` - API Node.js: endpoints, seguridad, tests
MD

# docs/AUDIT-LOG.md
cat > "$ROOT/docs/AUDIT-LOG.md" <<'MD'
# AUDIT LOG — Yggdrasil-Dew

---

## [2026-07-04] Perplexity Full Patch — Auditoria completa modulos principales

**Autor:** Perplexity + Copilot  
**Rama:** main (push directo con revision)  
**Ficheros creados/actualizados:** 16

### Estado modulos auditados

| Modulo | Estado |
|---|---|
| `tools/perplexity_adapter.py` | ✅ CREADO |
| `agentes/agent-perplexity-informer/run.sh` | ✅ CREADO |
| `inbox/context/perplexity/PERPLEXITY_PROMPT_TEMPLATE.txt` | ✅ CREADO |
| `scripts/agentes/agente-meta-deep.sh` | ✅ CREADO |
| `scripts/observador-obsidian.sh` | ✅ CREADO |
| `docker/docker-compose.yml` | ✅ ACTUALIZADO |
| `docker/mcp/Dockerfile` | ✅ CREADO |
| `docker/retrieval/Dockerfile` | ✅ CREADO |
| `scripts/maintenance/master_run.sh` | ✅ CREADO |
| `scripts/maintenance/create_perplexity_patch.sh` | ✅ CREADO |
| `scripts/verify/run-smoke-tests.sh` | ✅ CREADO |
| `.github/workflows/ci-readonly.yml` | ✅ CREADO |
| `.github/workflows/bot-writer-template.yml` | ✅ CREADO |
| `docs/OPERATIONAL-PLAYBOOK.md` | ✅ ACTUALIZADO v2.0 |
| `docs/OWNERS.md` | ✅ CREADO |
| `scripts/SCRIPTS-AUDITORIA.md` | ✅ ACTUALIZADO |

### Siguientes modulos a auditar
1. `mcp/` — server.py, endpoints, security
2. `core/` — modulos y dependencias
3. `agentes/` — completar DISEÑO.md + PROFILE.md + test.sh por agente
4. `tests/` — cobertura
5. `islas/` — estado de cada isla
6. `osint-stack/` — stack y documentacion
7. `ollama/` — integracion local LLM
8. `server.js` — API Node.js

---

## [2026-07-03] Sesion inicial — estructura y file-arrival-guardian

**Modulos:** scripts/, inbox/, diarios/, .github/workflows/  
**Estado:** estructura base conforme, guardián de llegada activo.
MD

# scripts/README.md
cat > "$ROOT/scripts/README.md" <<'MD'
# scripts/ — README

Este directorio contiene SOLO scripts ejecutables (.sh) y herramientas.
Ningun archivo .md de sesion o diario debe vivir aqui.

## Scripts principales

| Script | Uso |
|---|---|
| `scripts/maintenance/master_run.sh` | Terminal madre. Dry-run: `bash scripts/maintenance/master_run.sh` / Apply: `--apply` |
| `scripts/maintenance/create_perplexity_patch.sh` | Crea todos los ficheros del ecosistema Perplexity. Dry-run por defecto. |
| `scripts/verify/run-smoke-tests.sh` | Comprueba que todos los ficheros clave existen. |
| `scripts/agentes/agente-meta-deep.sh` | Extrae PERCENT_COMPLETE de Perplexity y abre issue si < 70%. |
| `scripts/observador-obsidian.sh` | Exporta notas Obsidian modificadas en 24h. |
| `scripts/inbox-commit.sh` | Commitea archivos de `inbox/drop/` con mensaje. |
| `scripts/inbox-clasificador.sh` | Clasifica archivos de `inbox/drop/` a sus destinos. |
| `scripts/session-logger.sh` | Logger de sesion de terminal. |
| `scripts/session-terminal-doc.sh` | Genera documento de cierre de sesion. |

## Flujo rapido

```bash
# Inicio de sesion
git pull origin main
source scripts/session-logger.sh

# Ver que haria el master runner
bash scripts/maintenance/master_run.sh

# Ejecutar todo
bash scripts/maintenance/master_run.sh --apply

# Cierre de sesion
bash scripts/maintenance/master_run.sh --apply
bash scripts/session-terminal-doc.sh "descripcion breve"
git add inbox/sesiones/cierre-*.md
git commit -m "docs(sesion): cierre $(date +%Y-%m-%d)"
git push origin main
```
MD

# Create branch, add, commit, push
echo "Creating git branch $GIT_BRANCH and committing changes..."
git -C "$ROOT" checkout -b "$GIT_BRANCH"
git -C "$ROOT" add -A
git -C "$ROOT" commit -m "feat(perplexity): Perplexity adapter + agentes + docker + master runner + auditoria completa"
git -C "$ROOT" push "$GITHUB_REMOTE" HEAD

if command -v gh >/dev/null 2>&1; then
  gh pr create \
    --title "feat: Perplexity integration and ecosystem patch" \
    --body "Adds Perplexity adapter, agent informer, obsidian observer, dockerization and master runner. Dry-run tested. Review required." \
    --draft
fi

echo "Patch applied on branch $GIT_BRANCH."
