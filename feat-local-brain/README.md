# feat/local-brain — Proyecto Local Brain RAG

## Objetivo

Sistema RAG local: indexar el contenido de yggdrasil-dew para poder consultarlo via LLM sin salir a internet.

## Scope

- [ ] `proyectos/local-brain/docker-compose.yml` — ChromaDB + Ollama
- [ ] `proyectos/local-brain/ingest.py` — indexar markdown del repo
- [ ] `proyectos/local-brain/query.py` — consulta RAG
- [ ] `proyectos/local-brain/README.md` — documentación completa
- [ ] Modelo embeddings: `bge-m3` via Ollama

## Stack

```
Markdown del repo → ingest.py → ChromaDB
                                      ↓
                   query.py → Ollama (bge-m3 embeddings + qwen2.5 chat)
```

## Bitacora relacionada

- `inbox/2026-06-23-proyecto-local-brain.md`
- `inbox/2026-06-23-local-brain-setup.md`
- `inbox/2026-06-23-ollama-rag-investigacion.md`

---
*Rama creada: 2026-06-25 | Perplexity MCP*
