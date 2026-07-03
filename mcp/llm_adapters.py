#!/usr/bin/env python3
"""
llm_adapters.py — Adaptadores LLM para Ollama / OpenAI / Anthropic
Uso desde llm-router.sh o directamente:
    python3 mcp/llm_adapters.py --provider ollama --prompt "hola"
"""

from __future__ import annotations
import argparse
import json
import os
import sys
import time
import re
from typing import Optional

# ── Constantes ──────────────────────────────────────────────────────────
DEFAULT_TIMEOUT   = int(os.getenv("LLM_TIMEOUT", "60"))      # segundos
DEFAULT_MAX_TOK   = int(os.getenv("LLM_MAX_TOKENS", "2048"))
OLLAMA_HOST       = os.getenv("OLLAMA_HOST", "http://localhost:11434")
OLLAMA_MODEL      = os.getenv("OLLAMA_MODEL", "llama3")
OPENAI_MODEL      = os.getenv("OPENAI_MODEL", "gpt-4o-mini")
ANTHROPIC_MODEL   = os.getenv("ANTHROPIC_MODEL", "claude-3-haiku-20240307")

# PII: patrones que se enmascaran antes de enviar al modelo
_PII_PATTERNS = [
    (re.compile(r"\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b"), "[EMAIL]"),
    (re.compile(r"\b(?:\+34|0034)?[6789]\d{8}\b"),                         "[PHONE]"),
    (re.compile(r"\b[0-9]{4}[\s-]?[0-9]{4}[\s-]?[0-9]{4}[\s-]?[0-9]{4}\b"), "[CARD]"),
    (re.compile(r"Bearer\s+[A-Za-z0-9\-._~+/]+=*"),                        "Bearer [TOKEN]"),
    (re.compile(r"sk-[A-Za-z0-9]{20,}"),                                    "[API_KEY]"),
]


def sanitize_prompt(prompt: str) -> str:
    """Enmascara PII y trunca el prompt si supera el límite."""
    for pattern, replacement in _PII_PATTERNS:
        prompt = pattern.sub(replacement, prompt)
    max_chars = DEFAULT_MAX_TOK * 4  # aprox 4 chars/token
    if len(prompt) > max_chars:
        prompt = prompt[:max_chars] + "\n[... prompt truncado por límite de tokens]"
    return prompt


# ── Adaptador Ollama ─────────────────────────────────────────────────────
def call_ollama(prompt: str, model: str = OLLAMA_MODEL,
                timeout: int = DEFAULT_TIMEOUT) -> str:
    import urllib.request
    import urllib.error

    payload = json.dumps({
        "model":  model,
        "prompt": prompt,
        "stream": False,
        "options": {"num_predict": DEFAULT_MAX_TOK},
    }).encode()

    req = urllib.request.Request(
        f"{OLLAMA_HOST}/api/generate",
        data=payload,
        headers={"Content-Type": "application/json"},
        method="POST",
    )
    try:
        with urllib.request.urlopen(req, timeout=timeout) as resp:
            data = json.loads(resp.read())
            return data.get("response", "")
    except urllib.error.URLError as e:
        raise RuntimeError(f"Ollama no disponible en {OLLAMA_HOST}: {e}") from e


# ── Adaptador OpenAI ─────────────────────────────────────────────────────
def call_openai(prompt: str, model: str = OPENAI_MODEL,
                timeout: int = DEFAULT_TIMEOUT) -> str:
    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        raise RuntimeError("OPENAI_API_KEY no definida")

    import urllib.request
    payload = json.dumps({
        "model": model,
        "messages": [{"role": "user", "content": prompt}],
        "max_tokens": DEFAULT_MAX_TOK,
    }).encode()

    req = urllib.request.Request(
        "https://api.openai.com/v1/chat/completions",
        data=payload,
        headers={
            "Content-Type":  "application/json",
            "Authorization": f"Bearer {api_key}",
        },
        method="POST",
    )
    import urllib.error
    try:
        with urllib.request.urlopen(req, timeout=timeout) as resp:
            data = json.loads(resp.read())
            return data["choices"][0]["message"]["content"]
    except urllib.error.HTTPError as e:
        raise RuntimeError(f"OpenAI HTTP {e.code}: {e.read().decode()}") from e


# ── Adaptador Anthropic ──────────────────────────────────────────────────
def call_anthropic(prompt: str, model: str = ANTHROPIC_MODEL,
                   timeout: int = DEFAULT_TIMEOUT) -> str:
    api_key = os.getenv("ANTHROPIC_API_KEY")
    if not api_key:
        raise RuntimeError("ANTHROPIC_API_KEY no definida")

    import urllib.request
    payload = json.dumps({
        "model":      model,
        "max_tokens": DEFAULT_MAX_TOK,
        "messages":   [{"role": "user", "content": prompt}],
    }).encode()

    req = urllib.request.Request(
        "https://api.anthropic.com/v1/messages",
        data=payload,
        headers={
            "Content-Type":      "application/json",
            "x-api-key":         api_key,
            "anthropic-version": "2023-06-01",
        },
        method="POST",
    )
    import urllib.error
    try:
        with urllib.request.urlopen(req, timeout=timeout) as resp:
            data = json.loads(resp.read())
            return data["content"][0]["text"]
    except urllib.error.HTTPError as e:
        raise RuntimeError(f"Anthropic HTTP {e.code}: {e.read().decode()}") from e


# ── Router con fallback ──────────────────────────────────────────────────
def route(prompt: str, provider: str = "auto",
          timeout: int = DEFAULT_TIMEOUT) -> dict:
    """
    provider: 'ollama' | 'openai' | 'anthropic' | 'auto'
    'auto' intenta Ollama → OpenAI → Anthropic.
    Devuelve dict con keys: provider, response, latency_ms, error
    """
    prompt_clean = sanitize_prompt(prompt)
    order = {
        "ollama":    [call_ollama],
        "openai":    [call_openai],
        "anthropic": [call_anthropic],
        "auto":      [call_ollama, call_openai, call_anthropic],
    }.get(provider, [call_ollama])

    last_err: Optional[str] = None
    for fn in order:
        t0 = time.time()
        try:
            resp = fn(prompt_clean, timeout=timeout)
            return {
                "provider":    fn.__name__.replace("call_", ""),
                "response":    resp,
                "latency_ms":  int((time.time() - t0) * 1000),
                "error":       None,
            }
        except Exception as e:
            last_err = str(e)
            sys.stderr.write(f"[llm_adapters] {fn.__name__} falló: {e}\n")

    return {
        "provider":   "none",
        "response":   "",
        "latency_ms": 0,
        "error":      last_err,
    }


# ── CLI ──────────────────────────────────────────────────────────────────
if __name__ == "__main__":
    ap = argparse.ArgumentParser(description="Llama a un LLM con fallback")
    ap.add_argument("--provider", default="auto",
                    choices=["auto", "ollama", "openai", "anthropic"])
    ap.add_argument("--prompt",   required=True)
    ap.add_argument("--timeout",  type=int, default=DEFAULT_TIMEOUT)
    ap.add_argument("--json",     action="store_true",
                    help="Devolver resultado completo en JSON")
    args = ap.parse_args()

    result = route(args.prompt, provider=args.provider, timeout=args.timeout)

    if args.json:
        print(json.dumps(result, ensure_ascii=False, indent=2))
    else:
        if result["error"]:
            sys.stderr.write(f"ERROR: {result['error']}\n")
            sys.exit(1)
        print(result["response"])
