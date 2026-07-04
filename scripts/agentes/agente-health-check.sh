#!/usr/bin/env bash
# agente-health-check.sh
# Doc: docs/  <- COMPLETAR ruta al doc relacionado
# Fase: <- COMPLETAR fase
# Descripción: <- COMPLETAR
# scripts/agentes/agente-health-check.sh
# Comprueba que MCP server, retrieval API y Ollama responden
set -euo pipefail

MCP_URL="${MCP_URL:-http://localhost:3000}"
RETRIEVAL_URL="${RETRIEVAL_URL:-http://localhost:9001}"
OLLAMA_URL="${OLLAMA_URL:-http://localhost:11434}"

OK=0; FAIL=0
check(){
  local name="$1" url="$2"
  if curl -sf --max-time 3 "$url" &>/dev/null; then
    echo "[OK]   $name ($url)"
    OK=$((OK+1))
  else
    echo "[FAIL] $name ($url)"
    FAIL=$((FAIL+1))
  fi
}

echo "=== Health Check ==="
check "MCP Server"    "$MCP_URL/health"
check "Retrieval API" "$RETRIEVAL_URL"
check "Ollama"        "$OLLAMA_URL/api/tags"

echo ""
echo "Resultado: $OK OK, $FAIL FAIL"
[ "$FAIL" -eq 0 ] && exit 0 || exit 1