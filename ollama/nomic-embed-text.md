---
tags: [ollama, embeddings, rag, chromadb]
fecha: 2026-06-23
---

# nomic-embed-text — Embeddings Locales para el RAG

Modelo de embeddings usado por `tools/ollama-rag/` para vectorizar yggdrasil-dew.

## Características
- **Dimensiones:** 768
- **Contexto:** 8192 tokens
- **Tamaño:** ~274MB
- **Multilingüe:** Sí

## Uso
```bash
ollama pull nomic-embed-text
```

## Privacidad
Las notas NUNCA salen de Madre. Los embeddings se calculan 100% local.
