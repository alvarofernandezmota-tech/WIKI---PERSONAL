#!/usr/bin/env bash
# TEST-TEMPLATE.sh — Plantilla de test para agente {{AGENT_NAME}}
# USO: bash scripts/agentes/agent-templates/TEST-TEMPLATE.sh
set -euo pipefail

AGENT="{{AGENT_NAME}}"
PASS=0
FAIL=0

ok()  { echo "  [PASS] $1"; ((PASS++)) || true; }
fail(){ echo "  [FAIL] $1"; ((FAIL++)) || true; }

echo "=== Tests: $AGENT ==="

# Test 1: el script existe y es ejecutable
SCRIPT="scripts/agentes/${AGENT}.sh"
if [ -x "$SCRIPT" ]; then ok "Script ejecutable: $SCRIPT"; else fail "Script no encontrado o no ejecutable: $SCRIPT"; fi

# Test 2: dry-run no produce error
if bash "$SCRIPT" --dry-run > /dev/null 2>&1; then ok "dry-run sin error"; else fail "dry-run falló"; fi

# Test 3: genera algún artefacto de salida
REPORT_DIR="reports/${AGENT}"
if [ -d "$REPORT_DIR" ] || bash "$SCRIPT" --dry-run 2>&1 | grep -q 'report\|informe\|OUTDIR'; then
  ok "genera artefacto de salida"
else
  fail "no genera artefacto detectable"
fi

echo ""
echo "Resultado: $PASS PASS, $FAIL FAIL"
[ $FAIL -eq 0 ] && exit 0 || exit 1
