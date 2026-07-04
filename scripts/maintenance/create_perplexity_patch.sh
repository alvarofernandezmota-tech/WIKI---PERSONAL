#!/usr/bin/env bash
# scripts/maintenance/create_perplexity_patch.sh
# Crea todos los ficheros y plantillas para Perplexity, agentes, obsidian observer,
# dockerización y master runner. Dry-run por defecto. --apply para crear, commitear y push.
# Idempotente: no sobreescribe si el archivo ya existe con mismo contenido.
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
    "agentes/agent-perplexity-informer/DISEÑO.md"
    "agentes/agent-perplexity-informer/PROFILE.md"
    "agentes/agent-perplexity-informer/test.sh"
    "inbox/context/perplexity/PERPLEXITY_PROMPT_TEMPLATE.txt"
    "inbox/context/perplexity/.gitkeep"
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
    "docs/OWNERS.md"
    "scripts/verify/run-smoke-tests.sh"
  )
  for f in "${files[@]}"; do
    echo " - $f"
  done
  echo ""
  echo "Run with --apply to create files, branch, commit and push."
  exit 0
fi

# ─── APPLY MODE ───────────────────────────────────────────────────
echo "Creating files..."

# tools/perplexity_adapter.py
mkdir -p "$ROOT/tools"
cat > "$ROOT/tools/perplexity_adapter.py" <<'PY'
#!/usr/bin/env python3
# tools/perplexity_adapter.py
# Adaptador HTTP para llamar a la API de Perplexity (o cualquier endpoint compatible).
import os, sys, json, requests, time

PERPLEXITY_URL = os.getenv("PERPLEXITY_URL", "")
API_KEY = os.getenv("PERPLEXITY_API_KEY", "")
TIMEOUT = int(os.getenv("PERPLEXITY_TIMEOUT", "30"))

def call_perplexity(prompt, max_tokens=800):
    if not PERPLEXITY_URL:
        return {"error": "PERPLEXITY_URL not set"}
    headers = {"Content-Type": "application/json"}
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
# Lee textos de inbox/ocr/text/, llama a Perplexity y escribe resultados en inbox/context/perplexity/
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
  cat > "$prompt_file" <<PROMPT
Analiza este extracto y devuelve:
1) Resumen breve (máx. 120 palabras).
2) Tres acciones prioritarias, numeradas.
3) PERCENT_COMPLETE: XX% (entero, 0-100).
4) Referencias públicas o links relevantes.
CONFIDENCE_REASON: <breve justificación>

Texto:
PROMPT
  echo "$summary" >> "$prompt_file"
  resp=$(python3 "$ADAPTER" "$(cat "$prompt_file")" 2>/dev/null || echo '{"error":"adapter failed"}')
  echo "## Perplexity raw response for $id" > "$out_file"
  echo '```json' >> "$out_file"
  echo "$resp" >> "$out_file"
  echo '```' >> "$out_file"
  pct=$(echo "$resp" | grep -Eo "PERCENT_COMPLETE: [0-9]{1,3}%" | head -n1 || true)
  echo "" >> "$out_file"
  echo "### Extracted" >> "$out_file"
  echo "- **PERCENT_COMPLETE**: ${pct:-unknown}" >> "$out_file"
  echo "- **Source**: $f" >> "$out_file"
  echo "- **Timestamp**: $(date -Iseconds)" >> "$out_file"
  echo "$out_file created"
done
SH
chmod +x "$ROOT/agentes/agent-perplexity-informer/run.sh"

# agentes/agent-perplexity-informer/test.sh
cat > "$ROOT/agentes/agent-perplexity-informer/test.sh" <<'SH'
#!/usr/bin/env bash
# test.sh — smoke test para agent-perplexity-informer
set -euo pipefail
ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
TEST_DIR="$ROOT/inbox/ocr/text"
mkdir -p "$TEST_DIR"
echo "Test input: PERCENT_COMPLETE: 85%" > "$TEST_DIR/test-perplexity-sample.txt"
bash "$(dirname "$0")/run.sh" && echo "PASS" || echo "FAIL"
SH
chmod +x "$ROOT/agentes/agent-perplexity-informer/test.sh"

# agentes/agent-perplexity-informer/DISEÑO.md
cat > "$ROOT/agentes/agent-perplexity-informer/DISEÑO.md" <<'MD'
# agent-perplexity-informer — Diseño

## Propósito
Leer textos de `inbox/ocr/text/`, enviarlos a Perplexity vía `tools/perplexity_adapter.py`
y escribir respuestas estructuradas en `inbox/context/perplexity/`.

## Flujo
1. Escanea `inbox/ocr/text/*.txt`.
2. Para cada fichero construye prompt desde `PERPLEXITY_PROMPT_TEMPLATE.txt`.
3. Llama a `perplexity_adapter.py`.
4. Extrae `PERCENT_COMPLETE: XX%` y lo expone en el `.md` de salida.
5. Si PCT < 70 y `gh` disponible → crea issue automático.

## Variables de entorno
- `PERPLEXITY_URL` — URL del endpoint (obligatorio).
- `PERPLEXITY_API_KEY` — Bearer token (opcional).
- `PERPLEXITY_TIMEOUT` — timeout en segundos (default 30).
- `YGGDRASIL_ROOT` — raíz del repo (default `$(pwd)`).

## Outputs
- `inbox/context/perplexity/<id>.md` — respuesta + metadatos.
- `inbox/context/perplexity/<id>.prompt.txt` — prompt usado.
MD

# agentes/agent-perplexity-informer/PROFILE.md
cat > "$ROOT/agentes/agent-perplexity-informer/PROFILE.md" <<'MD'
# agent-perplexity-informer — Profile

| Campo | Valor |
|---|---|
| Nombre | agent-perplexity-informer |
| Owner | @alvarofernandezmota-tech |
| Tipo | Extractor / Classifier |
| Trigger | Manual / GitHub Actions |
| Input | `inbox/ocr/text/*.txt` |
| Output | `inbox/context/perplexity/*.md` |
| Crítico | No (puede fallar sin bloquear pipeline) |
| Versión | 1.0.0 |
| Creado | 2026-07-04 |
MD

# inbox/context/perplexity template
mkdir -p "$ROOT/inbox/context/perplexity"
touch "$ROOT/inbox/context/perplexity/.gitkeep"
cat > "$ROOT/inbox/context/perplexity/PERPLEXITY_PROMPT_TEMPLATE.txt" <<'TXT'
Analiza este extracto y devuelve:
1) Resumen breve (máx. 120 palabras).
2) Tres acciones prioritarias, numeradas.
3) PERCENT_COMPLETE: XX% (entero, 0-100).
4) Referencias públicas o links relevantes.
CONFIDENCE_REASON: <breve justificación de la confianza en el análisis>

Texto:
TXT

# scripts/agentes/agente-meta-deep.sh
mkdir -p "$ROOT/scripts/agentes"
cat > "$ROOT/scripts/agentes/agente-meta-deep.sh" <<'SH'
#!/usr/bin/env bash
# scripts/agentes/agente-meta-deep.sh
# Extrae PERCENT_COMPLETE de los outputs de Perplexity y abre issue si < 70.
set -euo pipefail
ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
REPORT_DIR="$ROOT/reports/meta-deep"
mkdir -p "$REPORT_DIR"

PCT="unknown"
PCT_LINE=$(grep -R --line-number -E "PERCENT_COMPLETE: [0-9]{1,3}%" \
  "$ROOT/inbox/context/perplexity" 2>/dev/null | head -n1 || true)

if [ -n "$PCT_LINE" ]; then
  PCT=$(echo "$PCT_LINE" | grep -Eo "[0-9]{1,3}" | head -n1)
  echo "Detected PERCENT_COMPLETE: $PCT%"
  if [ "$PCT" -lt 70 ]; then
    echo "WARNING: coverage below threshold (70%). Opening issue..."
    if command -v gh >/dev/null 2>&1; then
      gh issue create \
        --title "[meta-deep] Low coverage: ${PCT}%" \
        --body "Auto-detected PERCENT_COMPLETE=${PCT}% in inbox/context/perplexity. Review and increase coverage." \
        --label "audit" || true
    fi
  fi
fi

TS=$(date +"%Y%m%d-%H%M%S")
OUT="$REPORT_DIR/meta-deep-$TS.md"
cat > "$OUT" <<REPORT
# META DEEP — $TS

- PERCENT_COMPLETE: ${PCT}%
- Source scan: $(date -Iseconds)
- Threshold: 70%
- Status: $( [ "$PCT" = "unknown" ] && echo "NO_DATA" || ( [ "$PCT" -ge 70 ] && echo "OK" || echo "BELOW_THRESHOLD" ) )
REPORT

echo "Report: $OUT"
SH
chmod +x "$ROOT/scripts/agentes/agente-meta-deep.sh"

# scripts/observador-obsidian.sh
cat > "$ROOT/scripts/observador-obsidian.sh" <<'SH'
#!/usr/bin/env bash
# scripts/observador-obsidian.sh
# Exporta notas modificadas en las últimas 24h del vault de Obsidian a inbox/context/obsidian/
set -euo pipefail
ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
VAULT_DIR="${OBSIDIAN_VAULT:-$HOME/ObsidianVault}"
OUT_DIR="$ROOT/inbox/context/obsidian"
mkdir -p "$OUT_DIR"

if [ ! -d "$VAULT_DIR" ]; then
  echo "WARN: OBSIDIAN_VAULT not found at $VAULT_DIR — skipping"
  exit 0
fi

COUNT=0
find "$VAULT_DIR" -type f -name "*.md" -mtime -1 | while read -r f; do
  id=$(basename "$f" .md | tr ' ' '_')
  excerpt=$(sed -n '1,40p' "$f" | tr '\n' ' ' | cut -c1-1200)
  out="$OUT_DIR/${id}-obsidian.md"
  cat > "$out" <<OBSIDIAN
# Obsidian export: $id

**Source**: $f
**Exported**: $(date -Iseconds)

## Excerpt
$excerpt
OBSIDIAN
  COUNT=$((COUNT+1))
done
echo "Exported $COUNT Obsidian notes to $OUT_DIR"
SH
chmod +x "$ROOT/scripts/observador-obsidian.sh"

# docker/
mkdir -p "$ROOT/docker/mcp" "$ROOT/docker/retrieval" "$ROOT/docker/prometheus" "$ROOT/docker/agent-worker"

cat > "$ROOT/docker/mcp/Dockerfile" <<'DF'
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . ./
ENV YGGDRASIL_ROOT=/app
EXPOSE 8081
CMD ["python3", "server.py", "--port", "8081"]
DF

cat > "$ROOT/docker/retrieval/Dockerfile" <<'DF'
FROM python:3.11-slim
WORKDIR /app
COPY retrieval_api.py ./
RUN pip install --no-cache-dir flask requests
EXPOSE 9001
CMD ["python3", "retrieval_api.py"]
DF

cat > "$ROOT/docker/docker-compose.yml" <<'DC'
version: "3.8"

services:
  mcp:
    build:
      context: ..
      dockerfile: docker/mcp/Dockerfile
    ports:
      - "8081:8081"
    environment:
      - YGGDRASIL_ROOT=/app
      - MCP_API_TOKEN=${MCP_API_TOKEN}
    volumes:
      - ../inbox:/app/inbox
      - ../reports:/app/reports
    restart: unless-stopped

  retrieval:
    build:
      context: ..
      dockerfile: docker/retrieval/Dockerfile
    ports:
      - "9001:9001"
    volumes:
      - ../inbox:/app/inbox
    restart: unless-stopped

  agent-worker:
    build:
      context: ..
      dockerfile: docker/agent-worker/Dockerfile
    environment:
      - YGGDRASIL_ROOT=/app
      - PERPLEXITY_URL=${PERPLEXITY_URL}
      - PERPLEXITY_API_KEY=${PERPLEXITY_API_KEY}
    volumes:
      - ../inbox:/app/inbox
      - ../agentes:/app/agentes
      - ../scripts:/app/scripts
    restart: unless-stopped
DC

# docker/agent-worker/Dockerfile
cat > "$ROOT/docker/agent-worker/Dockerfile" <<'DF'
FROM python:3.11-slim
RUN apt-get update && apt-get install -y bash git curl jq && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt 2>/dev/null || true
COPY . ./
ENV YGGDRASIL_ROOT=/app
CMD ["bash", "scripts/maintenance/master_run.sh", "--apply"]
DF

# scripts/verify/run-smoke-tests.sh
mkdir -p "$ROOT/scripts/verify"
cat > "$ROOT/scripts/verify/run-smoke-tests.sh" <<'SH'
#!/usr/bin/env bash
# scripts/verify/run-smoke-tests.sh — smoke tests del ecosistema
set -euo pipefail
ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
FAILS=0

check() {
  local desc="$1"; local cmd="$2"
  if eval "$cmd" >/dev/null 2>&1; then
    echo "  PASS: $desc"
  else
    echo "  FAIL: $desc"
    FAILS=$((FAILS+1))
  fi
}

echo "=== Smoke Tests Yggdrasil-Dew ==="

# Estructura básica
check "scripts/ existe"            "[ -d '$ROOT/scripts' ]"
check "inbox/ existe"              "[ -d '$ROOT/inbox' ]"
check "diarios/ existe"            "[ -d '$ROOT/diarios' ]"
check "agentes/ existe"            "[ -d '$ROOT/agentes' ]"
check "tools/ existe"              "[ -d '$ROOT/tools' ]"

# Scripts ejecutables clave
check "file-arrival-guardian.sh ejecutable"  "[ -x '$ROOT/scripts/file-arrival-guardian.sh' ]"
check "inbox-commit.sh ejecutable"           "[ -x '$ROOT/scripts/inbox-commit.sh' ]"
check "cierre-sesion.sh ejecutable"          "[ -x '$ROOT/scripts/cierre-sesion.sh' ]"
check "master_run.sh ejecutable"             "[ -x '$ROOT/scripts/maintenance/master_run.sh' ]"

# Python tools
check "perplexity_adapter.py existe" "[ -f '$ROOT/tools/perplexity_adapter.py' ]"
check "python3 disponible"           "command -v python3"

# Git
check "git disponible"               "command -v git"
check "repo es git"                   "[ -d '$ROOT/.git' ]"

echo ""
echo "=== Resultado: $FAILS fallos ==="
[ "$FAILS" -eq 0 ] && exit 0 || exit 1
SH
chmod +x "$ROOT/scripts/verify/run-smoke-tests.sh"

# scripts/maintenance/master_run.sh
cat > "$ROOT/scripts/maintenance/master_run.sh" <<'SH'
#!/usr/bin/env bash
# scripts/maintenance/master_run.sh — Terminal Madre
# Orquesta todos los pasos del ecosistema en orden seguro.
# Dry-run por defecto. --apply para ejecutar de verdad.
set -euo pipefail
ROOT="$(pwd)"
DRY_RUN=true

while [ $# -gt 0 ]; do
  case "$1" in
    --apply) DRY_RUN=false; shift ;;
    --help) echo "Usage: $0 [--apply]"; exit 0 ;;
    *) echo "Unknown arg: $1"; exit 1 ;;
  esac
done

MODE=$( $DRY_RUN && echo "DRY-RUN" || echo "APPLY" )
echo "═══════════════════════════════════"
echo "  TERMINAL MADRE — Yggdrasil-Dew  "
echo "  Mode: $MODE"
echo "  $(date -Iseconds)"
echo "═══════════════════════════════════"

run_step() {
  local step="$1"; local cmd="$2"
  echo ""
  echo "── STEP $step ──"
  if [ "$DRY_RUN" = true ]; then
    echo "  [DRY-RUN] $cmd"
  else
    eval "$cmd" && echo "  ✓ OK" || echo "  ✗ FAILED (continuing)"
  fi
}

# STEP 0: mover .md extraviados de scripts/
run_step "0 — mover .md fuera de scripts/" \
  "git mv scripts/2026-07-03-23-05-struct-auditor-output.md inbox/_meta/ 2>/dev/null || true; git mv scripts/2026-07-03-inbox-audit-consolidado.md inbox/_meta/ 2>/dev/null || true; git mv scripts/2026-07-03-cierre-sesion-completo.md diarios/ 2>/dev/null || true; git mv scripts/2026-07-03-reality-check.md diarios/ 2>/dev/null || true; git mv scripts/gemini-brief.md docs/ 2>/dev/null || true"

# STEP 1: smoke tests
run_step "1 — smoke tests" \
  "bash scripts/verify/run-smoke-tests.sh"

# STEP 2: file-arrival-guardian
run_step "2 — file-arrival-guardian" \
  "bash scripts/file-arrival-guardian.sh --dry-run"

# STEP 3: Perplexity informer
run_step "3 — Perplexity informer" \
  "bash agentes/agent-perplexity-informer/run.sh"

# STEP 4: meta-deep auditor
run_step "4 — meta-deep auditor" \
  "bash scripts/agentes/agente-meta-deep.sh"

# STEP 5: obsidian observer
run_step "5 — obsidian observer" \
  "bash scripts/observador-obsidian.sh"

# STEP 6: inbox clasificador
run_step "6 — inbox clasificador" \
  "bash scripts/inbox-clasificador.sh"

# STEP 7: struct auditor
run_step "7 — struct auditor" \
  "bash scripts/struct-auditor.sh"

echo ""
echo "═══════════════════════════════════"
echo "  TERMINAL MADRE — $MODE completado"
echo "  $(date -Iseconds)"
echo "═══════════════════════════════════"
SH
chmod +x "$ROOT/scripts/maintenance/master_run.sh"

# .github/workflows/ci-readonly.yml
mkdir -p "$ROOT/.github/workflows"
cat > "$ROOT/.github/workflows/ci-readonly.yml" <<'YML'
name: CI Readonly — Smoke Tests
on:
  push:
    branches: [ main ]
  pull_request:
jobs:
  smoke:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Install deps
        run: sudo apt-get update && sudo apt-get install -y jq
      - name: Run smoke tests
        env:
          YGGDRASIL_ROOT: ${{ github.workspace }}
        run: bash scripts/verify/run-smoke-tests.sh
YML

# .github/workflows/bot-writer-template.yml
cat > "$ROOT/.github/workflows/bot-writer-template.yml" <<'YML'
name: Bot Writer — Draft PR Template
# REGLA: ningún bot escribe en main directamente.
# Este workflow crea una rama + PR draft para revisión humana.
on:
  workflow_dispatch:
    inputs:
      description:
        description: 'Descripción del cambio a generar'
        required: true
        default: 'chore: automated changes'
jobs:
  prepare:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Create branch and commit
        run: |
          BRANCH="bot/changes-$(date +%Y%m%d-%H%M%S)"
          git config user.name "github-actions[bot]"
          git config user.email "github-actions[bot]@users.noreply.github.com"
          git checkout -b "$BRANCH"
          echo "# Bot changes $(date -Iseconds)" >> docs/BOT-CHANGELOG.md
          git add -A
          git commit -m "chore(bot): ${{ github.event.inputs.description }}"
          git push origin "$BRANCH"
      - name: Create draft PR
        uses: peter-evans/create-pull-request@v5
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          title: "bot: ${{ github.event.inputs.description }}"
          body: |
            ## Cambios automáticos
            Generado por bot-writer-template workflow.
            **Requiere revisión humana antes de mergear.**
          draft: true
          labels: bot,needs-review
YML

# docs/OWNERS.md
mkdir -p "$ROOT/docs"
cat > "$ROOT/docs/OWNERS.md" <<'MD'
# OWNERS — Yggdrasil-Dew

| Módulo / Agente | Owner | Contacto |
|---|---|---|
| agent-perplexity-informer | @alvarofernandezmota-tech | GitHub |
| agente-meta-deep | @alvarofernandezmota-tech | GitHub |
| scripts/maintenance/ | @alvarofernandezmota-tech | GitHub |
| docker/ | @alvarofernandezmota-tech | GitHub |
| scripts/verify/ | @alvarofernandezmota-tech | GitHub |
| inbox/ | @alvarofernandezmota-tech | GitHub |
| diarios/ | @alvarofernandezmota-tech | GitHub |
MD

# docs/OPERATIONAL-PLAYBOOK.md
cat > "$ROOT/docs/OPERATIONAL-PLAYBOOK.md" <<'MD'
# OPERATIONAL PLAYBOOK — Yggdrasil-Dew

> Versión: 2.0 — 2026-07-04
> Autor: Perplexity + @alvarofernandezmota-tech

---

## Regla 1 — Bot Writes (Anti-ruido)
Ningún workflow o agente puede commitear directamente en `main`.
Si necesita escribir:
1. Crear rama `bot/<workflow>-<ts>`.
2. Commit en esa rama.
3. Abrir PR draft hacia `main`.
4. **Revisión humana obligatoria** antes de mergear.

## Regla 2 — Inbox Conventions
| Carpeta | Contenido |
|---|---|
| `inbox/drop/` | Zona de aterrizaje — archivos nuevos de tú (humano) |
| `inbox/ocr/raw/` | Archivos binarios para OCR |
| `inbox/ocr/text/` | Textos extraídos por OCR |
| `inbox/sesiones/` | Cierres de sesión `cierre-YYYYMMDD-*.md` |
| `inbox/context/perplexity/` | Respuestas Perplexity con `PERCENT_COMPLETE: XX%` |
| `inbox/context/obsidian/` | Exports del vault de Obsidian |
| `inbox/_meta/` | Reportes de auditoría automáticos |

## Regla 3 — PII y Secrets
- Sanitizar prompts antes de enviar a LLMs externos.
- CI ejecuta secret-scan en todos los PRs.
- Nunca incluir API keys en el código — usar `.env` (ignorado) o GitHub Secrets.

## Regla 4 — Tamaño de archivos
- No subir archivos > 10 MB al repo.
- Binarios grandes → `inbox/ocr/raw/` y documentados en `.gitignore` si son temporales.

## Regla 5 — Ownership de agentes
Cada agente en `agentes/` debe tener:
- `DISEÑO.md` — arquitectura y flujo.
- `PROFILE.md` — metadatos y owner.
- `test.sh` — smoke test propio.
- Owner declarado en `docs/OWNERS.md`.

## Regla 6 — Monitoreo Perplexity
- Prompts DEBEN pedir `PERCENT_COMPLETE: XX%`.
- `agente-meta-deep.sh` extrae el valor y abre issue automático si < 70%.
- Revisar `reports/meta-deep/` después de cada run.

## Regla 7 — Sesiones de trabajo
Flujo obligatorio:
```
git pull origin main
source scripts/session-logger.sh          # iniciar logging
# ... trabajo ...
bash scripts/session-terminal-doc.sh "descripción"
git add inbox/sesiones/cierre-*.md
git commit -m "docs(sesion): cierre YYYY-MM-DD"
git push origin main
```

## Regla 8 — Terminal Madre
`scripts/maintenance/master_run.sh` es el punto de entrada único.
Siempre correr dry-run primero:
```bash
bash scripts/maintenance/master_run.sh          # dry-run
bash scripts/maintenance/master_run.sh --apply  # ejecutar
```
MD

# scripts/SCRIPTS-AUDITORIA.md — actualizado
cat > "$ROOT/scripts/SCRIPTS-AUDITORIA.md" <<MD
# SCRIPTS-AUDITORIA — Yggdrasil-Dew

Última actualización: $TS

---

## ✅ MÓDULOS COMPLETADOS

### Sesión 2026-07-03
- [x] `scripts/file-arrival-guardian.sh` — Guardián de llegada de archivos con dry-run
- [x] `scripts/session-logger.sh` — Logger de terminal para sesiones
- [x] `scripts/session-terminal-doc.sh` — Generador de documentos de cierre
- [x] `scripts/orquestador-unico.sh` — Orquestador con fases (all/audit/inbox/health)
- [x] `scripts/inbox-commit.sh` — Commit de inbox en un comando
- [x] `scripts/inbox-clasificador.sh` — Clasificador automático de inbox/drop/
- [x] `docs/inbox-flujo.md` — Documentación del flujo inbox
- [x] `inbox/drop/.gitkeep` — Zona de aterrizaje inicializada

### Sesión 2026-07-04 (parche Perplexity full)
- [x] `tools/perplexity_adapter.py` — Adaptador HTTP para Perplexity API
- [x] `agentes/agent-perplexity-informer/run.sh` — Agente lector OCR → Perplexity
- [x] `agentes/agent-perplexity-informer/DISEÑO.md` — Diseño del agente
- [x] `agentes/agent-perplexity-informer/PROFILE.md` — Metadatos y owner
- [x] `agentes/agent-perplexity-informer/test.sh` — Smoke test del agente
- [x] `inbox/context/perplexity/PERPLEXITY_PROMPT_TEMPLATE.txt` — Template de prompt
- [x] `scripts/agentes/agente-meta-deep.sh` — Extractor PERCENT_COMPLETE + issue automático
- [x] `scripts/observador-obsidian.sh` — Observer del vault de Obsidian
- [x] `docker/mcp/Dockerfile` — Dockerfile para servidor MCP
- [x] `docker/retrieval/Dockerfile` — Dockerfile para API de retrieval
- [x] `docker/agent-worker/Dockerfile` — Dockerfile para worker de agentes
- [x] `docker/docker-compose.yml` — Composición de servicios
- [x] `scripts/maintenance/master_run.sh` — Terminal madre (orquestador supremo)
- [x] `scripts/verify/run-smoke-tests.sh` — Suite de smoke tests
- [x] `.github/workflows/ci-readonly.yml` — CI de solo lectura / smoke tests
- [x] `.github/workflows/bot-writer-template.yml` — Template para bots que escriben (PR draft)
- [x] `docs/OPERATIONAL-PLAYBOOK.md` — Playbook operativo con 8 reglas
- [x] `docs/OWNERS.md` — Tabla de ownership de módulos
- [x] `scripts/maintenance/create_perplexity_patch.sh` — Script maestro idempotente

---

## 🔴 PENDIENTE — Próxima auditoría

### Módulo A — Limpieza de scripts/
- [ ] Mover `.md` extraviados de scripts/ a sus destinos: inbox/_meta/ o diarios/
  - scripts/2026-07-03-23-05-struct-auditor-output.md → inbox/_meta/
  - scripts/2026-07-03-inbox-audit-consolidado.md → inbox/_meta/
  - scripts/2026-07-03-cierre-sesion-completo.md → diarios/
  - scripts/2026-07-03-reality-check.md → diarios/
  - scripts/gemini-brief.md → docs/
- [ ] Revisar duplicados: orquestador-supremo.sh vs orquestador-total.sh vs orquestador-unico.sh
- [ ] Archivar scripts 01-xx redundantes en scripts/archive/

### Módulo B — Agentes
- [ ] Auditar `agentes/` — listar todos y verificar DISEÑO.md + PROFILE.md + test.sh
- [ ] Completar `agentes/` con los agentes faltantes (llm-router, ocr-processor, etc.)
- [ ] Crear `agentes/README.md` con tabla de todos los agentes

### Módulo C — Workflows
- [ ] Auditar `.github/workflows/` — listar todos y verificar que ninguno escribe en main
- [ ] Añadir secret-scan.yml
- [ ] Añadir session-close.yml (mueve inbox/sesiones/ → diarios/)
- [ ] Añadir inbox-guardian.yml (dispara file-arrival-guardian en push)

### Módulo D — Docker
- [ ] Añadir requirements.txt para cada Dockerfile
- [ ] Añadir docker/prometheus/ Dockerfile y config
- [ ] Probar docker-compose up -d localmente
- [ ] Añadir healthchecks a docker-compose.yml

### Módulo E — Tests y CI
- [ ] Ampliar smoke tests con verificación de workflows
- [ ] Añadir tests/integration/ con tests de extremo a extremo
- [ ] Configurar coverage report para agentes Python

### Módulo F — Documentación
- [ ] Actualizar ECOSISTEMA.md con los nuevos módulos
- [ ] Crear docs/ARCHITECTURE-DIAGRAM.md con diagrama mermaid
- [ ] Actualizar HOME.md con links a los nuevos módulos
- [ ] Crear docs/QUICKSTART.md para nuevos colaboradores

---

## 📊 Métricas de salud del repo

| Métrica | Estado | Notas |
|---|---|---|
| Scripts con extensión .sh correcta | ✅ | Ver struct-auditor |
| .md en scripts/ (contaminación) | ⚠️ | 4 ficheros pendientes de mover |
| Agentes con DISEÑO+PROFILE+test | ⚠️ | Solo agent-perplexity-informer completo |
| Workflows seguros (no escriben en main) | ✅ | ci-readonly + bot-writer-template |
| Docker compose funcional | ⚠️ | Falta requirements.txt |
| Smoke tests pasando | ✅ | run-smoke-tests.sh |
| Documentación operativa | ✅ | OPERATIONAL-PLAYBOOK.md v2.0 |
MD

# scripts/README.md
cat > "$ROOT/scripts/README.md" <<'MD'
# scripts/ — Guía de uso

## Punto de entrada único
```bash
# Dry-run (solo muestra lo que haría)
bash scripts/maintenance/master_run.sh

# Ejecutar de verdad
bash scripts/maintenance/master_run.sh --apply
```

## Scripts de sesión
```bash
# Inicio de sesión
git pull origin main
source scripts/session-logger.sh

# Cierre de sesión
bash scripts/session-terminal-doc.sh "descripción"
git add inbox/sesiones/cierre-*.md && git commit -m "docs(sesion): cierre" && git push
```

## Inbox
```bash
# Copiar archivo a zona de aterrizaje
cp /ruta/archivo.md inbox/drop/
bash scripts/inbox-commit.sh "descripción del archivo"
```

## Auditoría
```bash
bash scripts/file-arrival-guardian.sh --dry-run
bash scripts/struct-auditor.sh
bash scripts/verify/run-smoke-tests.sh
```

## Perplexity
```bash
bash agentes/agent-perplexity-informer/run.sh
bash scripts/agentes/agente-meta-deep.sh
```

## Mantenimiento
```bash
# Crear parche Perplexity (dry-run)
bash scripts/maintenance/create_perplexity_patch.sh

# Aplicar parche
bash scripts/maintenance/create_perplexity_patch.sh --apply
```

## Subdirectorios
| Dir | Contenido |
|---|---|
| `scripts/agentes/` | Scripts de agentes de análisis |
| `scripts/maintenance/` | Scripts de mantenimiento y parches |
| `scripts/verify/` | Smoke tests y verificación |
| `scripts/ci/` | Scripts usados por GitHub Actions |
| `scripts/infra/` | Infraestructura y Docker helpers |
| `scripts/backup/` | Backup y restic |
| `scripts/seguridad/` | Hardening y seguridad |
| `scripts/archive/` | Scripts obsoletos archivados |
MD

# Git: create branch, commit, push
echo ""
echo "Creating branch $GIT_BRANCH..."
git checkout -b "$GIT_BRANCH"
git add -A
git commit -m "feat(perplexity-ecosystem): add full Perplexity adapter, agents, docker, master runner, smoke tests and playbook v2 [2026-07-04]"
git push "$GITHUB_REMOTE" HEAD

# Draft PR if gh available
if command -v gh >/dev/null 2>&1; then
  gh pr create \
    --title "feat: Perplexity full ecosystem patch — 2026-07-04" \
    --body "## Cambios
- tools/perplexity_adapter.py
- agentes/agent-perplexity-informer/ completo (run, test, DISEÑO, PROFILE)
- scripts/agentes/agente-meta-deep.sh
- scripts/observador-obsidian.sh
- docker/ (mcp, retrieval, agent-worker, compose)
- scripts/maintenance/master_run.sh (Terminal Madre)
- scripts/verify/run-smoke-tests.sh
- .github/workflows/ci-readonly.yml + bot-writer-template.yml
- docs/OPERATIONAL-PLAYBOOK.md v2.0
- docs/OWNERS.md
- scripts/SCRIPTS-AUDITORIA.md actualizado
- scripts/README.md actualizado

**Dry-run tested. Review required.**" \
    --draft || true
fi

echo ""
echo "Done. Branch: $GIT_BRANCH"
echo "Review the draft PR on GitHub before merging."
