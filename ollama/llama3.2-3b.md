---
tags: [ollama, llm-local, llama, madre, rag]
fecha: 2026-06-23
---

# llama3.2:3b — LLM Principal del RAG en Madre

Modelo principal usado en `tools/ollama-rag/` para generación de respuestas.

## Hardware
- **VRAM mínima:** 3-4 GB ✔️ Funciona en GTX 1060 6GB de Madre
- **Velocidad Madre:** ~15-25 tokens/s

## Uso en el RAG
```bash
ollama pull llama3.2:3b
ollama run llama3.2:3b
```

## Cuándo usarlo
- Motor del RAG local (`:8001`)
- Consultas rápidas sin conexión
- Privacidad absoluta
