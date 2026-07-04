#!/usr/bin/env bash
# scripts/agentes/agente-meta-deep.sh
# Extrae PERCENT_COMPLETE de los .md generados por Perplexity.
# Si el valor es < 70, abre un issue en GitHub automaticamente.
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
REPORT_DIR="$ROOT/reports/meta-deep"
mkdir -p "$REPORT_DIR"

PCT="unknown"
PCT_LINE=$(grep -R --line-number -E "PERCENT_COMPLETE: [0-9]{1,3}%" \
  "$ROOT/inbox/context/perplexity" 2>/dev/null | head -n1 || true)

if [ -n "$PCT_LINE" ]; then
  PCT=$(echo "$PCT_LINE" | grep -Eo "[0-9]{1,3}" | head -n1)
  echo "[meta-deep] Detected PERCENT_COMPLETE: $PCT"
  if [ "$PCT" -lt 70 ]; then
    echo "[meta-deep] ALERT: Coverage below threshold (70%). Opening issue..."
    if command -v gh >/dev/null 2>&1; then
      gh issue create \
        --title "[ALERT] Low coverage detected: ${PCT}%" \
        --body "Auto-detected PERCENT_COMPLETE ${PCT}% in Perplexity context. Manual review required." \
        --label "audit" || echo "[meta-deep] gh issue create failed (no gh or no permissions)"
    fi
  fi
fi

TS=$(date +"%Y%m%d-%H%M%S")
OUT="$REPORT_DIR/meta-deep-$TS.md"
{
  echo "# META DEEP REPORT — $TS"
  echo ""
  echo "| Campo | Valor |"
  echo "|---|---|"
  echo "| PERCENT_COMPLETE | $PCT |"
  echo "| Source scan | $(date -Iseconds) |"
  echo "| Archivos escaneados | $(find "$ROOT/inbox/context/perplexity" -name '*.md' 2>/dev/null | wc -l) |"
} > "$OUT"

echo "[meta-deep] Report: $OUT"
