#!/usr/bin/env bash
# test.sh
# Doc: docs/  <- COMPLETAR ruta al doc relacionado
# Fase: <- COMPLETAR fase
# Descripción: <- COMPLETAR
set -euo pipefail
ROOT="${YGGDRASIL_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || echo '.')}"
REPORT_DIR="$ROOT/reports/agent-tareas"
mkdir -p "$REPORT_DIR"
TS=$(date +"%Y%m%d-%H%M%S")
OUT="$REPORT_DIR/test-$TS.md"

echo "# test agent-tareas run $TS" > "$OUT"
if [ -d "$ROOT/docs/tareas" ]; then
  echo "- docs/tareas exists" >> "$OUT"
else
  echo "- WARN: docs/tareas missing" >> "$OUT"
fi

empty=0
for f in "$ROOT"/docs/tareas/*.md 2>/dev/null; do
  [ -f "$f" ] || continue
  if [ ! -s "$f" ]; then
    echo "- ERROR: empty task file $(basename "$f")" >> "$OUT"
    empty=1
  fi
done

if [ "$empty" -eq 0 ]; then
  echo "RESULT: OK" >> "$OUT"
else
  echo "RESULT: FAIL" >> "$OUT"; exit 2
fi

echo "$OUT"