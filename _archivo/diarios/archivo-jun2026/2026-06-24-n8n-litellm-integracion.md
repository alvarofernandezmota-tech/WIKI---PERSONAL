# n8n + LiteLLM + Telegram — Workflow Maestro
**Fecha:** 2026-06-24  
**Objetivo:** Automatización completa: Telegram → n8n → LiteLLM → Ollama/Claude/Gemini

---

## Arquitectura del workflow

```
Telegram (tú)
  ↓ mensaje
n8n (orquestador)
  ↓ enruta según contexto
LiteLLM (proxy unificado)
  ├─ modelo local  → Ollama (qwen2.5:7b, erika)
  ├─ modelo rápido → Gemini Flash (gratis)
  └─ modelo potente → Claude Sonnet (pago)
  ↓ respuesta
n8n → responde en Telegram
```

---

## Configuración n8n → LiteLLM

En n8n, crear credential tipo **OpenAI**:
```
API Key: sk-batcueva    (tu LITELLM_MASTER_KEY)
Base URL: http://litellm:4000
```

Desde ese momento cualquier nodo OpenAI de n8n funciona con LiteLLM.

---

## Workflow Telegram TOKI v2 con LiteLLM

```json
{
  "nodes": [
    {
      "name": "Telegram Trigger",
      "type": "n8n-nodes-base.telegramTrigger",
      "parameters": { "updates": ["message"] }
    },
    {
      "name": "Enrutador",
      "type": "n8n-nodes-base.switch",
      "parameters": {
        "rules": [
          { "condition": "message contiene /osint", "output": 0 },
          { "condition": "message contiene /cerebro", "output": 1 },
          { "condition": "message contiene /foto", "output": 2 },
          { "condition": "default", "output": 3 }
        ]
      }
    },
    {
      "name": "OSINT Scan",
      "type": "n8n-nodes-base.httpRequest",
      "parameters": {
        "url": "http://spiderfoot:5001/api/v1/scan/new",
        "method": "POST"
      }
    },
    {
      "name": "RAG Cerebro",
      "type": "@n8n/n8n-nodes-langchain.chainRetrievalQa",
      "parameters": {
        "model": "qwen2.5:7b",
        "baseURL": "http://litellm:4000"
      }
    },
    {
      "name": "Chat General (Erika)",
      "type": "@n8n/n8n-nodes-langchain.openAi",
      "parameters": {
        "model": "erika",
        "baseURL": "http://litellm:4000"
      }
    },
    {
      "name": "Responder Telegram",
      "type": "n8n-nodes-base.telegram",
      "parameters": { "operation": "sendMessage" }
    }
  ]
}
```

---

## Comando de test LiteLLM

```bash
# Ver modelos disponibles
curl http://localhost:4000/v1/models \
  -H "Authorization: Bearer sk-batcueva"

# Test chat local (Ollama a través de LiteLLM)
curl http://localhost:4000/v1/chat/completions \
  -H "Authorization: Bearer sk-batcueva" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "qwen2.5:3b",
    "messages": [{"role": "user", "content": "Hola Erika"}]
  }'

# Test con Claude (si hay API key)
curl http://localhost:4000/v1/chat/completions \
  -H "Authorization: Bearer sk-batcueva" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "claude-sonnet",
    "messages": [{"role": "user", "content": "Test desde LiteLLM"}]
  }'
```

---

## Ventaja clave: fallback automático

LiteLLM puede hacer fallback si un modelo falla:

```yaml
# En config.yaml añadir:
router_settings:
  routing_strategy: least-busy
  fallbacks:
    - {"qwen2.5:7b": ["qwen2.5:3b", "gemini-flash"]}
    - {"claude-sonnet": ["gemini-flash", "qwen2.5:7b"]}
  num_retries: 3
  timeout: 30
```

Si Ollama está ocupado o el modelo es muy grande, usa Gemini Flash automáticamente.
