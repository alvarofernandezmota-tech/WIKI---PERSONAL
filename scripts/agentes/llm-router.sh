#!/usr/bin/env bash
# ============================================================
# NOMBRE:   scripts/agentes/llm-router.sh
# VERSION:  1.0.0
# FUNCIÓN:  Enruta prompts al LLM adecuado: Ollama (local)
#           u OpenAI/Anthropic (remoto). Auto-detección.
# TIPO:     gestor
# REPO:     alvarofernandezmota-tech/yggdrasil-dew
# USO:      bash scripts/agentes/llm-router.sh <prompt> [proveedor] [modelo]
# PROVEEDORES: auto | ollama | openai | anthropic
# ============================================================
set -euo pipefail

PROMPT="${1:-}"
PROVEEDOR="${2:-auto}"
MODELO="${3:-}"

if [ -z "$PROMPT" ]; then
  echo "USO: $0 <prompt> [proveedor] [modelo]"
  exit 1
fi

# ── AUTO-DETECCIÓN ────────────────────────────────────────
if [ "$PROVEEDOR" = "auto" ]; then
  if command -v ollama &>/dev/null && ollama list &>/dev/null 2>&1; then
    PROVEEDOR="ollama"
  elif [ -n "${OPENAI_API_KEY:-}" ]; then
    PROVEEDOR="openai"
  elif [ -n "${ANTHROPIC_API_KEY:-}" ]; then
    PROVEEDOR="anthropic"
  else
    echo "[ERROR] No hay LLM disponible. Instala Ollama o configura API keys."
    exit 1
  fi
fi

# ── OLLAMA ────────────────────────────────────────────────
if [ "$PROVEEDOR" = "ollama" ]; then
  MODELO="${MODELO:-llama3}"
  echo "[llm-router] Usando Ollama ($MODELO)" >&2
  ollama run "$MODELO" "$PROMPT"

# ── OPENAI ────────────────────────────────────────────────
elif [ "$PROVEEDOR" = "openai" ]; then
  [ -z "${OPENAI_API_KEY:-}" ] && { echo "[ERROR] OPENAI_API_KEY no configurada"; exit 1; }
  MODELO="${MODELO:-gpt-4o-mini}"
  echo "[llm-router] Usando OpenAI ($MODELO)" >&2
  BODY=$(printf '{"model":"%s","messages":[{"role":"user","content":"%s"}],"temperature":0.3}' "$MODELO" "$(echo "$PROMPT" | sed 's/"/\\"/g')")
  curl -s -X POST https://api.openai.com/v1/chat/completions \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -H "Content-Type: application/json" \
    -d "$BODY" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['choices'][0]['message']['content'])"

# ── ANTHROPIC ─────────────────────────────────────────────
elif [ "$PROVEEDOR" = "anthropic" ]; then
  [ -z "${ANTHROPIC_API_KEY:-}" ] && { echo "[ERROR] ANTHROPIC_API_KEY no configurada"; exit 1; }
  MODELO="${MODELO:-claude-3-haiku-20240307}"
  echo "[llm-router] Usando Anthropic ($MODELO)" >&2
  BODY=$(printf '{"model":"%s","max_tokens":2048,"messages":[{"role":"user","content":"%s"}]}' "$MODELO" "$(echo "$PROMPT" | sed 's/"/\\"/g')")
  curl -s -X POST https://api.anthropic.com/v1/messages \
    -H "x-api-key: $ANTHROPIC_API_KEY" \
    -H "anthropic-version: 2023-06-01" \
    -H "Content-Type: application/json" \
    -d "$BODY" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['content'][0]['text'])"
else
  echo "[ERROR] Proveedor desconocido: $PROVEEDOR"
  exit 1
fi
