#!/usr/bin/env bash
# scripts/verify/run-smoke-tests.sh
# Ejecuta todos los agentes/*/test.sh y reporta resultados
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
TS="$(date +%Y%m%d-%H%M%S)"
OUT="$ROOT/reports/verify/smoke-$TS.md"
mkdir -p "$ROOT/reports/verify"

echo "# Smoke Tests — $TS" > "$OUT"
echo "" >> "$OUT"

PASS=0; FAIL=0; SKIP=0

for dir in "$ROOT/agentes"/*/; do
  name=$(basename "$dir")
  test_sh=""
  [ -f "$dir/test.sh" ] && test_sh="$dir/test.sh"
  [ -f "$dir/tests.sh" ] && test_sh="$dir/tests.sh"

  if [ -z "$test_sh" ]; then
    echo "- [SKIP] $name: sin test.sh" >> "$OUT"
    SKIP=$((SKIP+1))
    continue
  fi

  if bash "$test_sh" >> "$OUT" 2>&1; then
    echo "- [PASS] $name" >> "$OUT"
    PASS=$((PASS+1))
  else
    echo "- [FAIL] $name" >> "$OUT"
    FAIL=$((FAIL+1))
  fi
done

echo "" >> "$OUT"
echo "## Resumen: PASS=$PASS FAIL=$FAIL SKIP=$SKIP" >> "$OUT"
echo "Smoke tests guardados en: $OUT"
echo "PASS=$PASS FAIL=$FAIL SKIP=$SKIP"

[ "$FAIL" -eq 0 ] && exit 0 || exit 1
