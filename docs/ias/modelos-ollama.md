---
tags: [ia, ollama, modelos, madre]
fecha-creacion: 2026-06-30
ultima-actualizacion: 2026-07-01
estado: completo
---

# 🤖 Modelos Ollama — madre

## Estado: ✅ 5 modelos descargados (confirmado 01-jul-2026)

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
# Listar modelos
docker exec ollama ollama list

# Chat directo (terminal)
docker exec -it ollama ollama run qwen2.5:3b

# API
curl http://100.91.112.32:11434/api/tags
```

## Puertos

| Servicio | Puerto | Auth |
|---|---|---|
| Ollama API | 11434 | ⚠️ sin auth — solo red local/Tailscale |
| Ollama Embeddings | 11435 | ⚠️ sin auth |

> ⚠️ **Pendiente**: Auditar y proteger Ollama API (`:11434`) — actualmente sin autenticación.

## Integración con THDORA

THDORA usa `qwen2.5-coder:7b` como modelo principal.
Conexión: `http://ollama:11434` (red Docker interna).

## Ver también
- [[proyectos/thdora/estado]]
- [[ESTADO-SISTEMA]]

---
_Creado desde inbox 2026-06-30 / actualizado 2026-07-01 — Perplexity vía MCP_
