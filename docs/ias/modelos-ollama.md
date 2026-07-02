---
tags: [ia, ollama, modelos, madre]
fecha-creacion: 2026-06-30
ultima-actualizacion: 2026-07-01
estado: completo
---

# 🤖 Modelos Ollama — madre

## Estado: ✅ 5 modelos (confirmado 01-jul-2026)

| Modelo | Tamaño | Uso principal | Estado |
|---|---|---|---|
| `qwen2.5-coder:7b` | 4.7GB | Código — usado por thdora | ✅ |
| `qwen2.5:3b` | 1.9GB | Chat rápido | ✅ |
| `llama3.1:8b` | 4.7GB | Chat general | ✅ |
| `bge-m3` | 1.2GB | Embeddings RAG | ✅ |
| `nomic-embed-text` | 274MB | Embeddings rápidos | ✅ |
| **Total** | **~12.8GB** | | |

## Acceso

```bash
docker exec ollama ollama list
docker exec -it ollama ollama run qwen2.5:3b
curl http://100.91.112.32:11434/api/tags
```

## ⚠️ Pendiente — Seguridad
- [ ] Proteger Ollama API (`:11434`) — actualmente sin autenticación
- [ ] Proteger Qdrant (`:6333`) — actualmente sin autenticación

## Integración con THDORA

THDORA usa `qwen2.5-coder:7b` como modelo principal.
Conexión: `http://ollama:11434` (red Docker interna).

---
_Creado desde inbox 2026-06-30 / actualizado 2026-07-01 — Perplexity vía MCP_
