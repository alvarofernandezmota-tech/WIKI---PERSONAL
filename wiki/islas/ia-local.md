---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-10
actualizado: 2026-07-10
ruta: wiki/islas/ia-local.md
tags: [isla, ia, ollama, llm, qdrant, rag, local]
status: borrador
repos: [ollama-stack, local-brain, ai-toolkit]
---

# Isla: IA Local

> Stack de inteligencia artificial local corriendo en Madre.
> GPU GTX 1060 — modelos Ollama, RAG, embeddings, Open WebUI.

---

## Stack completo

```
Open WebUI (interfaz)
    └── LiteLLM (router de modelos)
            └── Ollama (inferencia local — GPU 1060)
                    └── Modelos: llama3, mistral, qwen, phi...

Qdrant (vector DB)
    └── local-brain (RAG + embeddings)
            └── pgvector (PostgreSQL)

ai-toolkit (repo público — cuestión de recursos y herramientas)
```

---

## Repos

| Repo | Rol |
|------|-----|
| `ollama-stack` | Configuración Ollama + Open WebUI + Qdrant |
| `local-brain` | RAG, embeddings, pgvector |
| `ai-toolkit` | Stack AI open source (público) |

---

## Estado

🟡 Repos sin auditar — pendiente completar IaC en Madre.

Issues relacionados en DEW:
→ [#43 IaC Madre — versionar 16 servicios](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/43)

---

_Creado: 2026-07-10 · Perplexity-MCP_
