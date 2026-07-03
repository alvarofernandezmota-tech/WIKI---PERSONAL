---
tags: [ia/llm, infra/docker, estado/draft]
fecha: 2026-06-30
hora: 21:29
---

# 📥 INBOX — Pull modelos Ollama completado

> Nota temporal de sesión. Migrar a `docs/ias/` cuando se procese.

## Lo que se hizo

Pull exitoso de 2 modelos nuevos en paralelo:

```bash
# Terminal 1
docker exec ollama ollama pull llama3.1:8b

# Terminal 2  
docker exec ollama ollama pull nomic-embed-text
```

## Estado final modelos en Ollama

| Modelo | Tamaño aprox | Uso |
|---|---|---|
| `qwen2.5-coder:7b` | 4.7GB | Código, tools, completions |
| `qwen2.5:3b` | 1.9GB | Chat rápido, tools |
| `llama3.1:8b` | 4.7GB | Chat general, razonamiento |
| `nomic-embed-text` | ~274MB | Embeddings RAG → Qdrant |

## Pendiente
- [ ] Pull `bge-m3` (más grande, para RAG avanzado)
- [ ] Configurar Open WebUI para usar `llama3.1:8b` por defecto
- [ ] Pipeline n8n: texto → `nomic-embed-text` → Qdrant
- [ ] Verificar embeddings funcionando: `curl -s http://localhost:11435/api/tags`

## Notas técnicas
- `nomic-embed-text` va al contenedor `ollama-embeddings` (puerto 11435), no al `ollama` principal (11434)
- `llama3.1:8b` descargado en `ollama` (11434) con soporte tools
- AP RTL8188FTV estable durante toda la sesión — cero INTERFACE-DISABLED en dmesg ✅

---
_Procesar en próxima revisión dominical → migrar a `docs/ias/modelos-ollama.md`_
