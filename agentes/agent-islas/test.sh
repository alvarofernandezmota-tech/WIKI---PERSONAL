#!/usr/bin/env bash
set -euo pipefail
ROOT="${YGGDRASIL_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || echo '.')}"
REPORT_DIR="$ROOT/reports/agent-islas"
mkdir -p "$REPORT_DIR"
TS=$(date +"%Y%m%d-%H%M%S")
OUT="$REPORT_DIR/test-$TS.md"

echo "# test agent-islas run $TS" > "$OUT"
if [ -d "$ROOT/islas" ]; then
  echo "- islas folder exists" >> "$OUT"
else
  echo "- WARN: islas folder missing (no es error en fase inicial)" >> "$OUT"
fi

bad=0
for f in "$ROOT"/islas/*.md 2>/dev/null; do
  [ -f "$f" ] || continue
  if ! grep -q "Siguiente-paso" "$f"; then
    echo "- WARN: $(basename "$f") missing Siguiente-paso" >> "$OUT"
    bad=1
  fi
done

if [ "$bad" -eq 0 ]; then
  echo "RESULT: OK" >> "$OUT"
else
  echo "RESULT: WARN" >> "$OUT"
fi

echo "$OUT"
