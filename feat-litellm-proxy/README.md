# feat/litellm-proxy — LiteLLM como proxy central

## Objetivo

Configurar LiteLLM como capa intermedia entre todos los clientes (n8n, agentes, CLI) y los LLMs (Ollama local + APIs externas).

## Scope

- [ ] `agentes/litellm/docker-compose.yml`
- [ ] `agentes/litellm/config.yaml` — routing de modelos
- [ ] `agentes/litellm/secrets.sops.yaml` — API keys cifradas con SOPS
- [ ] `docs/setup/litellm-setup.md`
- [ ] ADR documentando la decisión de usar LiteLLM como proxy

## Arquitectura objetivo

```
n8n / agentes / CLI
       ↓
    LiteLLM (proxy)
    ├── Ollama (local: qwen2.5, bge-m3)
    ├── Gemini API
    ├── Perplexity API
    └── OpenAI API (opcional)
```

---
*Rama creada: 2026-06-25 | Perplexity MCP*
