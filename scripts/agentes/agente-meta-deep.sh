#!/usr/bin/env bash
# scripts/agentes/agente-meta-deep.sh
# Extrae PERCENT_COMPLETE de los outputs de Perplexity.
# Si PCT < 70 y gh CLI disponible → abre issue automático.
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
REPORT_DIR="$ROOT/reports/meta-deep"
CONTEXT_DIR="$ROOT/inbox/context/perplexity"
THRESHOLD=70

mkdir -p "$REPORT_DIR"

PCT="unknown"
PCT_FILE=""

if [ -d "$CONTEXT_DIR" ]; then
  PCT_LINE=$(grep -R --line-number -E "PERCENT_COMPLETE: [0-9]{1,3}%" \
    "$CONTEXT_DIR" 2>/dev/null | head -n1 || true)

  if [ -n "$PCT_LINE" ]; then
    PCT=$(echo "$PCT_LINE" | grep -Eo "[0-9]{1,3}%" | head -n1 | tr -d '%')
    PCT_FILE=$(echo "$PCT_LINE" | cut -d: -f1)
    echo "Detected PERCENT_COMPLETE: ${PCT}% in $PCT_FILE"

    if [ "$PCT" -lt "$THRESHOLD" ]; then
      echo "WARNING: coverage ${PCT}% below threshold ${THRESHOLD}%"
      if command -v gh >/dev/null 2>&1; then
        gh issue create \
          --title "[meta-deep] Low coverage: ${PCT}%" \
          --body "Auto-detected PERCENT_COMPLETE=${PCT}% (threshold=${THRESHOLD}%) in:\n\n\`$PCT_FILE\`\n\nReview and increase coverage." \
          --label "audit" 2>/dev/null || echo "  (gh issue create skipped — no labels or permissions)"
      else
        echo "  gh CLI not available — skipping issue creation"
      fi
    else
      echo "Coverage OK: ${PCT}% >= ${THRESHOLD}%"
    fi
  else
    echo "No PERCENT_COMPLETE found in $CONTEXT_DIR"
  fi
else
  echo "WARN: context dir not found at $CONTEXT_DIR"
fi

TS=$(date +"%Y%m%d-%H%M%S")
OUT="$REPORT_DIR/meta-deep-$TS.md"
STATUS="NO_DATA"
[ "$PCT" != "unknown" ] && [ "$PCT" -ge "$THRESHOLD" ] && STATUS="OK"
[ "$PCT" != "unknown" ] && [ "$PCT" -lt "$THRESHOLD" ] && STATUS="BELOW_THRESHOLD"

cat > "$OUT" <<REPORT
# META DEEP — $TS

| Campo | Valor |
|---|---|
| PERCENT_COMPLETE | ${PCT}% |
| Threshold | ${THRESHOLD}% |
| Status | $STATUS |
| Source | ${PCT_FILE:-N/A} |
| Scan timestamp | $(date -Iseconds) |
REPORT

echo "Report: $OUT"
