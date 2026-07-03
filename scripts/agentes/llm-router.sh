#!/usr/bin/env bash
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-/srv/yggdrasil-dew}"
PROMPT_RAW="${1:-}"
MODE="${2:-auto}"
LOGDIR="$ROOT/logs/llm-router"
mkdir -p "$LOGDIR"
TS=$(date +"%Y%m%d-%H%M%S")
LOG="$LOGDIR/llm-router-$TS.log"

sanitize() {
  local p="$1"
  p=$(echo "$p" | sed -E 's/[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}/[REDACTED_EMAIL]/g')
  p=$(echo "$p" | sed -E 's/(sk-[A-Za-z0-9_-]{20,})/[REDACTED_KEY]/g')
  p=$(echo "$p" | sed -E 's/[0-9]{12,}/[REDACTED_NUMBER]/g')
  echo "$p"
}

PROMPT="$(sanitize "$PROMPT_RAW")"
echo "{\"ts\":\"$TS\",\"mode\":\"$MODE\",\"prompt\":\"$(echo "$PROMPT" | sed 's/"/\\"/g')\"}" >> "$LOG"

call_ollama() {
  if command -v ollama >/dev/null 2>&1; then
    timeout 30s ollama run "$1" --prompt "$PROMPT"
    return $?
  fi
  return 2
}

call_openai() {
  if [ -z "${OPENAI_API_KEY:-}" ]; then
    echo "OPENAI_API_KEY not set" >&2
    return 2
  fi
  payload=$(jq -nc --arg m "$1" --arg p "$PROMPT" '{model:$m,messages:[{role:"user",content:$p}],max_tokens:800}')
  curl -sS -X POST "https://api.openai.com/v1/chat/completions" \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -H "Content-Type: application/json" \
    -d "$payload" | jq -r '.choices[0].message.content'
}

call_anthropic() {
  if [ -z "${ANTHROPIC_API_KEY:-}" ]; then
    echo "ANTHROPIC_API_KEY not set" >&2
    return 2
  fi
  payload=$(jq -nc --arg m "$1" --arg p "$PROMPT" '{model:$m,prompt:$p,max_tokens_to_sample:800}')
  curl -sS -X POST "https://api.anthropic.com/v1/complete" \
    -H "x-api-key: $ANTHROPIC_API_KEY" \
    -H "Content-Type: application/json" \
    -d "$payload" | jq -r '.completion'
}

if [ "$MODE" = "auto" ] || [ "$MODE" = "ollama" ]; then
  out=$(call_ollama "llama3" 2>/dev/null || true)
  if [ -n "$out" ]; then
    echo "$out"
    exit 0
  fi
fi

if [ "$MODE" = "auto" ] || [ "$MODE" = "openai" ]; then
  out=$(call_openai "gpt-4o" 2>/dev/null || true)
  if [ -n "$out" ]; then
    echo "$out"
    exit 0
  fi
fi

if [ "$MODE" = "auto" ] || [ "$MODE" = "anthropic" ]; then
  out=$(call_anthropic "claude-3" 2>/dev/null || true)
  if [ -n "$out" ]; then
    echo "$out"
    exit 0
  fi
fi

echo "LLM_ROUTER_ERROR: no model available" >&2
exit 1
