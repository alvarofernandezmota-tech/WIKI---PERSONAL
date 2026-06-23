---
tags: [ollama, cpu, setup, optimizacion, i5-8400]
fecha: 2026-06-24
maquina: madre
---

# Ollama CPU Setup — Madre (i5-8400)

## Hardware objetivo
- CPU: Intel i5-8400 (6 núcleos físicos, sin HT)
- RAM: 16GB DDR4
- GPU: ninguna (CPU only)

---

## Variables de entorno optimizadas

| Variable | Valor | Motivo |
|---|---|---|
| OLLAMA_NUM_THREADS | 6 | = cores físicos exactos |
| OLLAMA_NUM_PARALLEL | 1 | CPU-only, más causa swap |
| OLLAMA_MAX_LOADED_MODELS | 2 | qwen3b + embeddings |
| OLLAMA_KEEP_ALIVE | 24h | no descargar entre chats |

---

## Modelfile — qwen2.5:3b CPU puro

Guarda como `Modelfile` y ejecuta:

```dockerfile
FROM qwen2.5:3b
PARAMETER num_thread 6
PARAMETER num_gpu 0
PARAMETER num_ctx 4096
```

```bash
ollama create qwen2.5:3b-cpu -f Modelfile
```

---

## Modelos — orden de descarga

```bash
ollama pull qwen2.5:3b        # LLM principal (español + RAG)
ollama pull nomic-embed-text  # embeddings RAG
ollama pull gemma2:2b         # fallback rápido (opcional)
```

---

## Verificación

```bash
curl http://localhost:11434/api/tags
docker compose ps
docker compose logs ollama --tail=20
```
