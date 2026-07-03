#!/usr/bin/env bash
# scripts/agentes/agente-meta-deep.sh — Auditor LLM con propuestas y PR draft
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
REPORT_DIR="$ROOT/reports/meta-deep"
mkdir -p "$REPORT_DIR"

TS=$(date +"%Y%m%d-%H%M%S")
OUT="$REPORT_DIR/meta-deep-$TS.md"

echo "# META DEEP AUDIT — $TS" > "$OUT"
echo "" >> "$OUT"

# Inventario de scripts
echo "## Inventario de scripts" >> "$OUT"
ls -1 "$ROOT/scripts/" 2>/dev/null | while read -r f; do echo "- scripts/$f"; done >> "$OUT"
ls -1 "$ROOT/scripts/agentes/" 2>/dev/null | while read -r f; do echo "- scripts/agentes/$f"; done >> "$OUT"
ls -1 "$ROOT/scripts/ingest/" 2>/dev/null | while read -r f; do echo "- scripts/ingest/$f"; done >> "$OUT" 2>/dev/null || true

# Inventario de agentes
echo "" >> "$OUT"
echo "## Inventario de agentes" >> "$OUT"
for d in "$ROOT/agentes/"/*/; do
  name=$(basename "$d")
  has_diseño=$([ -f "$d/DISEÑO.md" ] && echo "✅" || echo "❌")
  has_profile=$([ -f "$d/PROFILE.md" ] && echo "✅" || echo "❌")
  has_test=$([ -f "$d/test.sh" ] && echo "✅" || echo "❌")
  echo "- **$name** | DISEÑO: $has_diseño | PROFILE: $has_profile | test: $has_test" >> "$OUT"
done

# Detección de huérfanos
echo "" >> "$OUT"
echo "## Huérfanos detectados" >> "$OUT"
grep -rh "agent-" "$ROOT/scripts/" "$ROOT/agentes/" 2>/dev/null \
  | grep -oE 'agent-[a-zA-Z0-9_-]+' | sort -u \
  | while read -r ref; do
      if ! ls "$ROOT/agentes/$ref"* >/dev/null 2>&1 && ! ls "$ROOT/scripts/agentes/$ref"* >/dev/null 2>&1; then
        echo "- ⚠️  $ref (referenciado pero sin directorio/script)"
      fi
    done >> "$OUT" || echo "(ninguno)" >> "$OUT"

# Análisis LLM (opcional — usa llm-router si está disponible)
echo "" >> "$OUT"
echo "## Propuestas LLM" >> "$OUT"
PROMPT="Revisa el ecosistema yggdrasil-dew: MCP server, router LLM, Galatea, agentes y OCR pipeline. Sugiere 5 mejoras priorizadas con diffs de ejemplo."
if command -v bash >/dev/null 2>&1 && [ -f "$ROOT/scripts/agentes/llm-router.sh" ]; then
  SUG=$(bash "$ROOT/scripts/agentes/llm-router.sh" "$PROMPT" auto 2>/dev/null || echo "LLM no disponible en este entorno.")
  echo "$SUG" >> "$OUT"
else
  echo "_(llm-router no disponible — ejecutar manualmente)_" >> "$OUT"
fi

# Si hay propuestas críticas, crear draft PR con Galatea
if grep -q "CRÍTICO\|CRITICAL\|⚠️" "$OUT" 2>/dev/null; then
  echo "" >> "$OUT"
  echo "## Acción automática" >> "$OUT"
  if [ -f "$ROOT/scripts/agentes/galatea-create-pr.sh" ]; then
    PR_OUT=$(bash "$ROOT/scripts/agentes/galatea-create-pr.sh" \
      "meta-deep/propuestas-$TS" \
      "[meta-deep] Propuestas automatizadas $TS" \
      "draft" 2>/dev/null || echo "galatea-create-pr no pudo crear PR")
    echo "PR draft: $PR_OUT" >> "$OUT"
  fi
fi

echo "Reporte generado: $OUT"
cat "$OUT"
