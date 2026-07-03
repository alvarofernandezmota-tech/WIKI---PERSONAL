#!/usr/bin/env bash
# scripts/agentes/llm-router.sh — Router LLM con sanitización y circuit breaker
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
PROMPT_RAW="${1:-}"
MODE="${2:-auto}"

# Sanitización: elimina emails y API keys antes de enviar al LLM
sanitize() {
  local p="$1"
  p=$(echo "$p" | sed -E 's/[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}/[REDACTED_EMAIL]/g')
  p=$(echo "$p" | sed -E 's/(sk-[A-Za-z0-9_-]{20,})/[REDACTED_KEY]/g')
  p=$(echo "$p" | sed -E 's/(Bearer [A-Za-z0-9_-]{10,})/Bearer [REDACTED]/g')
  echo "$p"
}

PROMPT="$(sanitize "$PROMPT_RAW")"

LOGDIR="$ROOT/logs/llm-router"
mkdir -p "$LOGDIR"
TS=$(date +"%Y%m%d-%H%M%S")
echo "{\"ts\":\"$TS\",\"mode\":\"$MODE\",\"prompt_len\":${#PROMPT}}" >> "$LOGDIR/llm-router.log"

# Circuit breaker: máximo 3 intentos
ATTEMPTS=0
MAX=3

call_ollama() {
  command -v ollama >/dev/null 2>&1 || return 2
  timeout 30s ollama run "${OLLAMA_MODEL:-llama3}" --prompt "$PROMPT" 2>/dev/null
}

call_openai() {
  [ -z "${OPENAI_API_KEY:-}" ] && return 2
  local payload
  payload=$(printf '{"model":"%s","messages":[{"role":"user","content":"%s"}],"max_tokens":800}' \
    "${OPENAI_MODEL:-gpt-4o}" "$(echo "$PROMPT" | sed 's/"/\\"/g')")
  curl -sS -X POST "https://api.openai.com/v1/chat/completions" \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -H "Content-Type: application/json" \
    -d "$payload" | grep -o '"content":"[^"]*"' | head -1 | sed 's/"content":"//;s/"$//'
}

call_anthropic() {
  [ -z "${ANTHROPIC_API_KEY:-}" ] && return 2
  local payload
  payload=$(printf '{"model":"claude-3-haiku-20240307","max_tokens":800,"messages":[{"role":"user","content":"%s"}]}' \
    "$(echo "$PROMPT" | sed 's/"/\\"/g')")
  curl -sS -X POST "https://api.anthropic.com/v1/messages" \
    -H "x-api-key: $ANTHROPIC_API_KEY" \
    -H "anthropic-version: 2023-06-01" \
    -H "Content-Type: application/json" \
    -d "$payload" | grep -o '"text":"[^"]*"' | head -1 | sed 's/"text":"//;s/"$//'
}

for provider in ollama openai anthropic; do
  [ "$MODE" != "auto" ] && [ "$MODE" != "$provider" ] && continue
  [ "$ATTEMPTS" -ge "$MAX" ] && break
  ATTEMPTS=$((ATTEMPTS + 1))
  OUT=$(call_$provider 2>/dev/null || true)
  if [ -n "$OUT" ]; then
    echo "$OUT"
    exit 0
  fi
done

echo "LLM_ROUTER_ERROR: no model available (tried $ATTEMPTS providers)" >&2
exit 1
