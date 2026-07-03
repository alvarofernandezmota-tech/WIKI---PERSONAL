# mcp/llm_adapters.py
import os
import subprocess
import requests

TIMEOUT = int(os.getenv("LLM_TIMEOUT", "30"))

def run_ollama(model: str, prompt: str) -> str:
    cmd = ["ollama", "run", model, "--prompt", prompt]
    try:
        out = subprocess.run(cmd, capture_output=True, text=True, timeout=TIMEOUT)
        return out.stdout.strip() or out.stderr.strip()
    except Exception as e:
        return f"OLLAMA_ERROR: {e}"

def run_openai(model: str, prompt: str) -> str:
    key = os.getenv("OPENAI_API_KEY")
    if not key:
        return "OPENAI_ERROR: OPENAI_API_KEY not set"
    url = "https://api.openai.com/v1/chat/completions"
    headers = {"Authorization": f"Bearer {key}", "Content-Type": "application/json"}
    payload = {"model": model, "messages": [{"role": "user", "content": prompt}], "max_tokens": 1500}
    try:
        r = requests.post(url, headers=headers, json=payload, timeout=TIMEOUT)
        r.raise_for_status()
        j = r.json()
        return j["choices"][0]["message"]["content"]
    except Exception as e:
        return f"OPENAI_ERROR: {e}"

def run_anthropic(model: str, prompt: str) -> str:
    key = os.getenv("ANTHROPIC_API_KEY")
    if not key:
        return "ANTHROPIC_ERROR: ANTHROPIC_API_KEY not set"
    url = "https://api.anthropic.com/v1/complete"
    headers = {"x-api-key": key, "Content-Type": "application/json"}
    payload = {"model": model, "prompt": prompt, "max_tokens_to_sample": 1000}
    try:
        r = requests.post(url, headers=headers, json=payload, timeout=TIMEOUT)
        r.raise_for_status()
        j = r.json()
        return j.get("completion", "")
    except Exception as e:
        return f"ANTHROPIC_ERROR: {e}"

def llm_router(model: str, prompt: str) -> str:
    if model.startswith("ollama:"):
        return run_ollama(model.split(":",1)[1], prompt)
    if model.startswith("openai:"):
        return run_openai(model.split(":",1)[1], prompt)
    if model.startswith("anthropic:"):
        return run_anthropic(model.split(":",1)[1], prompt)
    try:
        return run_ollama("llama2", prompt)
    except Exception:
        return "LLM_ROUTER_ERROR: no adapter matched"
