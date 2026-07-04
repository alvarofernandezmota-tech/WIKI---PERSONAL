#!/usr/bin/env bash
# scripts/maintenance/repo_audit_full.sh
# Auditoría completa del repo: workflows, agentes, islas, ingest, vector index, secrets, CI, E2E.
# Ejecutar desde la raíz del repo.
# USO: bash scripts/maintenance/repo_audit_full.sh
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
TS="$(date +%Y%m%d-%H%M%S)"
OUTDIR="$ROOT/reports/audit"
mkdir -p "$OUTDIR"
OUT="$OUTDIR/full-audit-$TS.md"

echo "# Full repo audit - $TS" > "$OUT"
echo "" >> "$OUT"

exists(){ [ -f "$1" ] || [ -d "$1" ]; }
report_ok(){ echo "- [OK] $1 : $2" >> "$OUT"; }
report_missing(){ echo "- [MISSING] $1 : $2" >> "$OUT"; MISSING+=("$2|$1"); }

MISSING=()

# -----------------------------------------------------------------------
echo "## 1. Estructura básica y artefactos clave" >> "$OUT"
check(){
  if exists "$ROOT/$2"; then report_ok "$1" "$2"; else report_missing "$1" "$2"; fi
}
check "MCP server"             "mcp/server.py"
check "LLM adapters"           "mcp/llm_adapters.py"
check "MCP requirements"       "mcp/requirements.txt"
check "Cliente C MCP"          "mcp/mcp_client.c"
check "Orquestador"            "scripts/orquestador-total.sh"
check "OCR ingest"             "scripts/ingest/ocr-ingest.sh"
check "OCR worker loop"        "scripts/ingest/ocr-worker-loop.sh"
check "Inbox raw OCR"          "inbox/ocr/raw"
check "Inbox OCR text"         "inbox/ocr/text"
check "Perplexity context"     "inbox/context/perplexity"
check "Vector adapter local"   "tools/vector_adapter.py"
check "Weaviate adapter"       "tools/weaviate_adapter.py"
check "Retrieval API"          "tools/retrieval_api.py"
check "Prometheus exporter"    "tools/prometheus_exporter.py"
check "Auth gateway"           "tools/auth_gateway.py"
check "E2E workflow"           ".github/workflows/e2e-full-flow.yml"
check "CI agentes workflow"    ".github/workflows/ci-agentes.yml"
check "Secret scan workflow"   ".github/workflows/secret-scan.yml"
check "Meta-deep auditor"      "scripts/agentes/agente-meta-deep.sh"
check "LLM router"             "scripts/agentes/llm-router.sh"
check "Galatea factory"        "scripts/agentes/galatea-fabrica-agentes.sh"
check "Galatea create PR"      "scripts/agentes/galatea-create-pr.sh"
check "Smoke tests"            "scripts/verify/run-smoke-tests.sh"
check "Copilot context doc"    "docs/COPILOT-CONTEXT.md"
check "Operational playbook"   "docs/OPERATIONAL-PLAYBOOK.md"
check "PROFILE template"       "scripts/agentes/agent-templates/PROFILE-TEMPLATE.md"
check "TEST template"          "scripts/agentes/agent-templates/TEST-TEMPLATE.sh"

# -----------------------------------------------------------------------
echo "" >> "$OUT"
echo "## 2. Workflows que escriben (heurística)" >> "$OUT"
grep -R --line-number -E "git push|git commit|git add|actions/checkout" "$ROOT/.github/workflows" 2>/dev/null \
  | sed -n '1,200p' >> "$OUT" || echo "- none found by heuristic" >> "$OUT"

# -----------------------------------------------------------------------
echo "" >> "$OUT"
echo "## 3. Islas y contenido (Siguiente-paso check)" >> "$OUT"
if [ -d "$ROOT/islas" ]; then
  for d in "$ROOT/islas/"*/; do
    [ -d "$d" ] || continue
    name=$(basename "$d")
    if grep -q "Siguiente-paso" "$d"*.md 2>/dev/null; then
      echo "- [OK] isla $name tiene Siguiente-paso" >> "$OUT"
    else
      echo "- [MISSING] isla $name sin Siguiente-paso" >> "$OUT"
      MISSING+=("islas/$name|isla-$name")
    fi
  done
else
  echo "- [MISSING] carpeta islas" >> "$OUT"
  MISSING+=("islas|islas")
fi

# -----------------------------------------------------------------------
echo "" >> "$OUT"
echo "## 4. Agentes: PROFILE.md y test.sh por agente" >> "$OUT"
if [ -d "$ROOT/agentes" ]; then
  for a in "$ROOT/agentes/"*/; do
    [ -d "$a" ] || continue
    name=$(basename "$a")
    if [ -f "$a/PROFILE.md" ]; then
      echo "- [OK] $name PROFILE.md" >> "$OUT"
    else
      echo "- [MISSING] $name PROFILE.md" >> "$OUT"
      MISSING+=("$a/PROFILE.md|profile-$name")
    fi
    if [ -f "$a/test.sh" ] || [ -f "$a/tests.sh" ]; then
      echo "- [OK] $name test present" >> "$OUT"
    else
      echo "- [MISSING] $name test.sh" >> "$OUT"
      MISSING+=("$a/test.sh|test-$name")
    fi
  done
else
  echo "- [INFO] carpeta agentes/ no existe" >> "$OUT"
fi

# -----------------------------------------------------------------------
echo "" >> "$OUT"
echo "## 5. Vector index / retrieval quick check" >> "$OUT"
if [ -d "$ROOT/tools/vector_index" ]; then
  cnt=$(find "$ROOT/tools/vector_index" -type f 2>/dev/null | wc -l)
  echo "- [OK] vector_index existe, archivos: $cnt" >> "$OUT"
else
  echo "- [MISSING] tools/vector_index" >> "$OUT"
  MISSING+=("tools/vector_index|vector_index")
fi

# -----------------------------------------------------------------------
echo "" >> "$OUT"
echo "## 6. Secrets & tokens heuristic scan" >> "$OUT"
echo "Buscando patrones: sk-, AKIA, PRIVATE KEY..." >> "$OUT"
grep -R --include='*.py' --include='*.sh' --include='*.yml' --include='*.yaml' --include='*.json' \
  --line-number -E "sk-[A-Za-z0-9_-]{20,}|AKIA[0-9A-Z]{16}|-----BEGIN PRIVATE KEY-----|ghp_[A-Za-z0-9]{36}" \
  "$ROOT" 2>/dev/null \
  | grep -v ".git" | sed -n '1,100p' >> "$OUT" || echo "- Ninguno encontrado por heurística" >> "$OUT"

# -----------------------------------------------------------------------
echo "" >> "$OUT"
echo "## 7. Large files (>5MB) check" >> "$OUT"
git -C "$ROOT" rev-list --objects --all 2>/dev/null \
  | git -C "$ROOT" cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' 2>/dev/null \
  | awk '$1=="blob" && $3>5242880 {print $0}' | head -n 50 >> "$OUT" \
  || echo "- git no disponible o sin objetos grandes" >> "$OUT"

# -----------------------------------------------------------------------
echo "" >> "$OUT"
echo "## 8. CI/E2E and smoke tests" >> "$OUT"
echo "- Ejecutar: bash scripts/verify/run-smoke-tests.sh" >> "$OUT"
echo "- E2E en CI: .github/workflows/e2e-full-flow.yml" >> "$OUT"
echo "- Secret scan: .github/workflows/secret-scan.yml" >> "$OUT"

# -----------------------------------------------------------------------
echo "" >> "$OUT"
echo "## 9. Corrección automática sugerida (priorizada)" >> "$OUT"
echo "1) Pausar workflows escritores: bash scripts/maintenance/pause_noisy_workflows.sh --dry-run" >> "$OUT"
echo "2) Crear carpetas inbox OCR: mkdir -p inbox/ocr/raw inbox/ocr/text inbox/ocr/processed inbox/context/perplexity" >> "$OUT"
echo "3) Aplicar PROFILE.md + test.sh a agentes faltantes (ver sección 4)" >> "$OUT"
echo "4) Implementar tools/retrieval_api.py si falta (placeholder en repo)" >> "$OUT"
echo "5) Harden llm-router.sh: añadir regex DNI/NIE/SSN" >> "$OUT"
echo "6) Verificar secret-scan.yml en CI" >> "$OUT"
echo "7) Draft PR flow: galatea-create-pr.sh con --draft" >> "$OUT"

# -----------------------------------------------------------------------
echo "" >> "$OUT"
echo "## 10. Items faltantes (colectados)" >> "$OUT"
if [ "${#MISSING[@]}" -eq 0 ]; then
  echo "- Ninguno (core items presentes)" >> "$OUT"
else
  for it in "${MISSING[@]}"; do
    path="${it%%|*}"; desc="${it##*|}"
    echo "- $desc -> $path" >> "$OUT"
  done
fi

# -----------------------------------------------------------------------
echo "" >> "$OUT"
echo "## 11. Siguientes pasos operativos" >> "$OUT"
echo "- Revisar este reporte y adjuntar al ticket de mantenimiento" >> "$OUT"
echo "- Ejecutar pause_noisy_workflows.sh en dry-run y revisar diffs" >> "$OUT"
echo "- Preparar parches para PROFILE/test y retrieval API" >> "$OUT"
echo "- Ejecutar CI E2E e inspeccionar artefactos" >> "$OUT"
echo "- Monitorizar PERCENT_COMPLETE en reports/meta-deep/*.md" >> "$OUT"

echo "" >> "$OUT"
echo "Audit completo. Archivo: $OUT"
echo "Guardado en: $OUT"
