#!/usr/bin/env bash
# llm-router.sh — Router LLM con sanitización, timeouts, circuit breaker y logs JSON
# Uso: bash scripts/agentes/llm-router.sh "<prompt>" [provider]
# Provider: auto | ollama | openai | anthropic (defecto: auto)
# Vars de entorno: LLM_TIMEOUT, LLM_MAX_TOKENS, OLLAMA_HOST, OLLAMA_MODEL
# Logs JSON en: inbox/_meta/llm-router-YYYYMMDD.jsonl

set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(git -C "$(dirname "$0")" rev-parse --show-toplevel 2>/dev/null || echo ".")}"
LOG_DIR="$ROOT/inbox/_meta"
LOG_FILE="$LOG_DIR/llm-router-$(date +%Y%m%d).jsonl"
CB_FILE="/tmp/yggdrasil-llm-cb"  # circuit breaker state
CB_THRESHOLD=5                    # fallos consecutivos antes de abrir CB
CB_RESET_SECS=300                 # segundos hasta intentar de nuevo

mkdir -p "$LOG_DIR"

# ── Ayuda ──────────────────────────────────────────────────────────────
if [[ "${1:-}" == "--help" || -z "${1:-}" ]]; then
  cat <<EOF
Uso: bash $0 "<prompt>" [provider]
  provider: auto | ollama | openai | anthropic  (defecto: auto)
Vars: LLM_TIMEOUT (seg), LLM_MAX_TOKENS, OLLAMA_HOST, OLLAMA_MODEL
Ejemplo:
  bash $0 "Resume el último reporte maestro" auto
EOF
  exit 0
fi

PROMPT="${1}"
PROVIDER="${2:-auto}"
TIMESTAMP="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
T_START=$(date +%s%3N)

# ── Circuit breaker ────────────────────────────────────────────────────
_cb_check() {
  if [[ -f "$CB_FILE" ]]; then
    local fails ts_fail elapsed
    fails=$(cut -d: -f1 "$CB_FILE")
    ts_fail=$(cut -d: -f2 "$CB_FILE")
    elapsed=$(( $(date +%s) - ts_fail ))
    if (( fails >= CB_THRESHOLD && elapsed < CB_RESET_SECS )); then
      echo "{\"ts\":\"$TIMESTAMP\",\"event\":\"circuit_breaker_open\",\"fails\":$fails,\"retry_in\":$((CB_RESET_SECS-elapsed))}" >> "$LOG_FILE"
      echo "[llm-router] Circuit breaker ABIERTO ($fails fallos, retry en ${CB_RESET_SECS}s)" >&2
      exit 5
    fi
    if (( elapsed >= CB_RESET_SECS )); then
      rm -f "$CB_FILE"  # reset
    fi
  fi
}

_cb_fail() {
  local fails=1
  if [[ -f "$CB_FILE" ]]; then
    fails=$(( $(cut -d: -f1 "$CB_FILE") + 1 ))
  fi
  echo "${fails}:$(date +%s)" > "$CB_FILE"
}

_cb_success() {
  rm -f "$CB_FILE"
}

_cb_check

# ── Llamada al adaptador Python ────────────────────────────────────────
RESULT="$(python3 "$ROOT/mcp/llm_adapters.py" \
  --provider "$PROVIDER" \
  --prompt   "$PROMPT"   \
  --timeout  "${LLM_TIMEOUT:-60}" \
  --json 2>/tmp/llm-router-stderr)" || true

STATUS=$?
T_END=$(date +%s%3N)
LATENCY=$(( T_END - T_START ))

# ── Parsear resultado ──────────────────────────────────────────────────
ERROR_MSG="$(python3 -c "import json,sys; d=json.loads(sys.stdin.read() or '{}'); print(d.get('error',''))" <<< "$RESULT" 2>/dev/null || echo "parse_error")"
ACTUAL_PROVIDER="$(python3 -c "import json,sys; d=json.loads(sys.stdin.read() or '{}'); print(d.get('provider','unknown'))" <<< "$RESULT" 2>/dev/null || echo "unknown")"
RESPONSE="$(python3 -c "import json,sys; d=json.loads(sys.stdin.read() or '{}'); print(d.get('response',''))" <<< "$RESULT" 2>/dev/null || echo "")"

# ── Log estructurado JSON ─────────────────────────────────────────────
STDERR_OUT="$(cat /tmp/llm-router-stderr 2>/dev/null | head -c 500 | python3 -c "import sys,json; print(json.dumps(sys.stdin.read().strip()))" 2>/dev/null || echo '""')"

python3 - <<PYEOF >> "$LOG_FILE"
import json, datetime
log = {
    "ts":        "$TIMESTAMP",
    "provider":  "$ACTUAL_PROVIDER",
    "prompt_len": len("""$PROMPT"""),
    "latency_ms": $LATENCY,
    "success":   not bool("""$ERROR_MSG"""),
    "error":     """$ERROR_MSG""" or None,
    "stderr":    $STDERR_OUT,
}
print(json.dumps(log, ensure_ascii=False))
PYEOF

# ── Resultado y circuit breaker ────────────────────────────────────────
if [[ -n "$ERROR_MSG" ]]; then
  _cb_fail
  echo "[llm-router] ERROR: $ERROR_MSG" >&2
  exit 1
fi

_cb_success
echo "$RESPONSE"
