---
tags: [inbox, ollama, embeddings, bge-m3, multilingue, rag, madre, pendiente-migrar]
fecha: 2026-06-23
estado: pendiente-migrar
destino: ollama/bge-m3.md
relacionado-anterior: [[inbox/2026-06-23-ollama-rag-investigacion]]
ruta-obsidian: inbox/2026-06-23-ollama-bge-m3.md
---

# bge-m3 — Embedding Multilingüe Híbrido

Modelo de embeddings de BAAI. El más potente para búsqueda híbrida multilingüe.
Alternativa a nomic-embed-text cuando el español falla.

## Hardware

| Modelo | VRAM | Idiomas | Híbrido nativo |
|---|---|---|---|
| nomic-embed-text (actual) | ~270 MB | Pobre ES | No |
| **bge-m3** (alternativa) | ~570 MB | 100+ idiomas | Sí (dense+sparse) |

## Ventaja clave

Genera vectores **densos Y dispersos** en una sola pasada.
Ideal para stack híbrido BM25 + ChromaDB — soluciona el fallback a nivel de modelo.

## Cálculo VRAM con qwen2.5:3b

```
qwen2.5:3b   = 2.00 GB
bge-m3       = 0.57 GB
OS Hyprland  = 1.50 GB
─────────────────
             = 4.07 GB  ✅ caben en GTX 1060 6GB
Libre        = 1.93 GB
```

## Cuándo migrar de nomic a bge-m3

- Si la búsqueda falla en notas en español
- Si los resultados RAG son irrelevantes en consultas en español
- Requiere reindexar todo el vault (borrar chroma_db/ y re-ejecutar /index)

```bash
ollama pull bge-m3
# Actualizar .env:
EMBED_MODEL=bge-m3
# Reindexar:
curl -X POST http://127.0.0.1:8001/index
```

## Ver también
- [[ollama/nomic-embed-text]] — modelo actual
- [[tools/local-brain/]] — donde se usa
