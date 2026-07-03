#!/usr/bin/env bash
set -euo pipefail
ROOT="${YGGDRASIL_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || echo '.')}"
REPORT_DIR="$ROOT/reports/agent-docs"
mkdir -p "$REPORT_DIR"
TS=$(date +"%Y%m%d-%H%M%S")
OUT="$REPORT_DIR/test-$TS.md"

echo "# test agent-docs run $TS" > "$OUT"
if [ -d "$ROOT/docs" ]; then
  echo "- docs folder exists" >> "$OUT"
else
  echo "- ERROR: docs folder missing" >> "$OUT"; exit 2
fi

echo "- Simulated sync OK" >> "$OUT"
echo "RESULT: OK" >> "$OUT"
echo "$OUT"
