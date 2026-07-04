#!/usr/bin/env python3
# tools/perplexity_adapter.py
# Adaptador HTTP para llamar a la API de Perplexity (o cualquier endpoint compatible).
# Variables de entorno:
#   PERPLEXITY_URL  — URL del endpoint (requerida)
#   PERPLEXITY_API_KEY — Bearer token (opcional)
#   PERPLEXITY_TIMEOUT — timeout en segundos (default 30)
import os
import sys
import json
import requests

PERPLEXITY_URL = os.getenv("PERPLEXITY_URL", "")
API_KEY = os.getenv("PERPLEXITY_API_KEY", "")
TIMEOUT = int(os.getenv("PERPLEXITY_TIMEOUT", "30"))


def call_perplexity(prompt: str, max_tokens: int = 800) -> dict:
    if not PERPLEXITY_URL:
        return {"error": "PERPLEXITY_URL not set. Export PERPLEXITY_URL before running."}
    headers = {"Content-Type": "application/json"}
    if API_KEY:
        headers["Authorization"] = f"Bearer {API_KEY}"
    payload = {"prompt": prompt, "max_tokens": max_tokens}
    try:
        r = requests.post(PERPLEXITY_URL, json=payload, headers=headers, timeout=TIMEOUT)
        r.raise_for_status()
        return r.json()
    except requests.exceptions.Timeout:
        return {"error": f"Request timed out after {TIMEOUT}s"}
    except requests.exceptions.HTTPError as e:
        return {"error": f"HTTP {e.response.status_code}: {e.response.text[:200]}"}
    except Exception as e:
        return {"error": str(e)}


def main():
    if len(sys.argv) < 2:
        print("Usage: perplexity_adapter.py '<prompt>'")
        print("       echo 'prompt' | perplexity_adapter.py -")
        sys.exit(2)
    if sys.argv[1] == "-":
        prompt = sys.stdin.read().strip()
    else:
        prompt = sys.argv[1]
    out = call_perplexity(prompt)
    print(json.dumps(out, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
