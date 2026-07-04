#!/usr/bin/env python3
# tools/perplexity_adapter.py
# Adaptador HTTP para la API de Perplexity.
# USO: python3 tools/perplexity_adapter.py '<prompt>'
# ENV: PERPLEXITY_URL, PERPLEXITY_API_KEY, PERPLEXITY_TIMEOUT
import os
import sys
import json
import requests

PERPLEXITY_URL = os.getenv("PERPLEXITY_URL", "")
API_KEY = os.getenv("PERPLEXITY_API_KEY", "")
TIMEOUT = int(os.getenv("PERPLEXITY_TIMEOUT", "30"))


def call_perplexity(prompt: str, max_tokens: int = 800) -> dict:
    if not PERPLEXITY_URL:
        return {"error": "PERPLEXITY_URL not set"}
    headers = {"Content-Type": "application/json"}
    if API_KEY:
        headers["Authorization"] = f"Bearer {API_KEY}"
    payload = {"prompt": prompt, "max_tokens": max_tokens}
    try:
        r = requests.post(PERPLEXITY_URL, json=payload, headers=headers, timeout=TIMEOUT)
        r.raise_for_status()
        return r.json()
    except Exception as e:
        return {"error": str(e)}


def main():
    if len(sys.argv) < 2:
        print("usage: perplexity_adapter.py '<prompt>'")
        sys.exit(2)
    prompt = " ".join(sys.argv[1:])
    out = call_perplexity(prompt)
    print(json.dumps(out, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
