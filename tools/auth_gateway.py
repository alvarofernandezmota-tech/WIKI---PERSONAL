# tools/auth_gateway.py — Gateway de autenticación para MCP HTTP
import os
import hashlib
import hmac
import time
from functools import wraps

API_TOKEN = os.getenv("MCP_API_TOKEN", "")
RATE_LIMIT_PER_MIN = int(os.getenv("MCP_RATE_LIMIT", "60"))

# Almacén en memoria de rate limiting (reseteado al reiniciar proceso)
_request_log: dict = {}

def verify_token(token: str) -> bool:
    """Verifica el token Bearer de forma segura (timing-safe)."""
    if not API_TOKEN:
        return True  # sin token configurado = modo desarrollo
    expected = f"Bearer {API_TOKEN}"
    return hmac.compare_digest(token or "", expected)

def check_rate_limit(client_ip: str) -> bool:
    """Devuelve True si el cliente está dentro del límite."""
    now = time.time()
    window_start = now - 60
    log = _request_log.get(client_ip, [])
    log = [t for t in log if t > window_start]
    if len(log) >= RATE_LIMIT_PER_MIN:
        return False
    log.append(now)
    _request_log[client_ip] = log
    return True

def sanitize_input(data: dict) -> dict:
    """Elimina campos potencialmente peligrosos del input."""
    BLOCKED = ['__proto__', 'constructor', 'prototype']
    return {k: v for k, v in data.items() if k not in BLOCKED}

SCOPES = {
    "orquestador_total":      ["admin", "operator"],
    "agent_meta_deep":        ["admin", "operator", "readonly"],
    "llm_router":             ["admin", "operator"],
    "galatea_fabrica_agente": ["admin"],
    "galatea_create_pr":      ["admin"]
}

def can_access(tool: str, scope: str) -> bool:
    """Verifica si el scope tiene acceso a la herramienta."""
    return scope in SCOPES.get(tool, [])
