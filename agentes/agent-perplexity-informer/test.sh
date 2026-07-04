#!/usr/bin/env bash
# agentes/agent-perplexity-informer/test.sh
# Test basico: crea un txt de prueba y verifica que el agente genera output.
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
TEST_IN="$ROOT/inbox/ocr/text/test-agent-informer.txt"
TEST_OUT="$ROOT/inbox/context/perplexity/test-agent-informer.md"

# Crear input de prueba
mkdir -p "$ROOT/inbox/ocr/text"
echo "Texto de prueba para verificar el agente informer. PERCENT_COMPLETE: 85%" > "$TEST_IN"

# Ejecutar agente (sin API real, el adapter devolvera error JSON que es valido)
export PERPLEXITY_URL=""
bash "$ROOT/agentes/agent-perplexity-informer/run.sh" || true

# Verificar que se genero el output
if [ -f "$TEST_OUT" ]; then
  echo "[PASS] Output generado: $TEST_OUT"
  rm -f "$TEST_IN" "$TEST_OUT" "$ROOT/inbox/context/perplexity/test-agent-informer.prompt.txt"
  exit 0
else
  echo "[FAIL] Output no encontrado: $TEST_OUT"
  exit 1
fi
