---
tags: [osint, ivre, qdrant, vector-db, rag-pipeline, gemini]
fecha: 2026-06-23
estado: referencia
ruta-obsidian: osint/expansion-osint-gemini.md
---

# Expansión OSINT — Gemini Research 23/06/2026

> Movido desde inbox/ · Auditoría Grok 23/06/2026

Investigación Gemini sobre expansión del stack OSINT con pipeline RAG vectorial.

## Pipeline diseñado
```
IVRE escanea → MongoDB → embedding nomic-embed-text
    → Qdrant búsqueda histórico → Ollama análisis
    → Nota Markdown → inbox/ yggdrasil-dew
```

Ver [[tools/rag_osint_engine.py]] para implementación.
Ver [[setup/servidor/batcueva-osint.yml]] para compose.
