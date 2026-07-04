#!/usr/bin/env bash
# scripts/agentes/llm-router.sh
# Sanitiza PII del PROMPT y lo envía al MCP LLM router
# Uso: PROMPT="texto" bash scripts/agentes/llm-router.sh
# o:   bash scripts/agentes/llm-router.sh "mi prompt aquí"
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
MCP_URL="${MCP_URL:-http://localhost:3000}"
PROMPT="${1:-${PROMPT:-}}"

if [ -z "$PROMPT" ]; then
  echo "ERROR: PROMPT vacío. Uso: bash llm-router.sh \"mi prompt\"" >&2
  exit 1
fi

# === SANITIZACIÓN PII ===
# DNI/NIE español
PROMPT=$(echo "$PROMPT" | sed -E 's/[0-9]{8}[A-Z]/[REDACTED_ID]/g')
PROMPT=$(echo "$PROMPT" | sed -E 's/[XYZ][0-9]{7}[A-Z]/[REDACTED_NIE]/g')
# SSN americano
PROMPT=$(echo "$PROMPT" | sed -E 's/[0-9]{3}-[0-9]{2}-[0-9]{4}/[REDACTED_SSN]/g')
# Emails
PROMPT=$(echo "$PROMPT" | sed -E 's/[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/[REDACTED_EMAIL]/g')
# Teléfonos (ES y formato internacional)
PROMPT=$(echo "$PROMPT" | sed -E 's/(\+34|0034)?[ -]?[6789][0-9]{2}[ -]?[0-9]{3}[ -]?[0-9]{3}/[REDACTED_PHONE]/g')
# Tarjetas (Luhn-like pattern)
PROMPT=$(echo "$PROMPT" | sed -E 's/[0-9]{4}[ -]?[0-9]{4}[ -]?[0-9]{4}[ -]?[0-9]{4}/[REDACTED_CARD]/g')
# IBANs
PROMPT=$(echo "$PROMPT" | sed -E 's/[A-Z]{2}[0-9]{2}[ ]?([0-9]{4}[ ]?){4,6}/[REDACTED_IBAN]/g')

# === ENVÍO AL ROUTER ===
RESPONSE=$(curl -sf -X POST "$MCP_URL/route" \
  -H "Content-Type: application/json" \
  -d "{\"prompt\": $(echo "$PROMPT" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read().strip()))')}" \
  2>/dev/null) || {
    echo "ERROR: MCP router no disponible en $MCP_URL" >&2
    exit 1
  }

echo "$RESPONSE"
