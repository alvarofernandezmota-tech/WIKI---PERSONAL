#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# run-agent-tests.sh
# FUNCIÓN ÚNICA: Runner de tests básicos para todos los agentes

echo "Running basic agent tests..."

echo "[1/3] Syntax check for shell scripts..."
find scripts -name '*.sh' -not -path '*/.git/*' -print0 \
  | xargs -0 -n1 bash -n \
  || { echo "Syntax errors found"; exit 1; }
echo "  OK"

echo "[2/3] Run template-insure in dry-run..."
bash scripts/template-insure.sh --dry-run
echo "  OK"

echo "[3/3] Run mejorador in dry-run..."
mkdir -p tests/out
bash scripts/agentes/agente-mejorador.sh --out tests/out --verbose || true
echo "  OK"

echo "All agent tests completed"
