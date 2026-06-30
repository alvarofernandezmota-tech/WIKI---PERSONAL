---
tags: [ia/llm, ia/rag, infra/docker, estado/draft]
fecha: 2026-07-01
hora: 00:44
---

# 📥 INBOX — Stack Ollama completo — 5/5 modelos

> Verificado 01-jul 00:44 CEST. Migrar a `docs/ias/modelos-ollama.md`.

## Estado final modelos

| Modelo | ID | Tamaño | Uso |
|---|---|---|---|
| `llama3.1:8b` | `46e0c10c039e` | 4.9 GB | Chat general, razonamiento, tools |
| `nomic-embed-text` | `0a109f422b47` | 274 MB | Embeddings RAG → Qdrant |
| `bge-m3` | `790764642607` | 1.2 GB | Embeddings avanzados, multilingue |
| `qwen2.5-coder:7b` | `dae161e27b0e` | 4.7 GB | Código, completions, tools |
| `qwen2.5:3b` | `357c53fb659c` | 1.9 GB | Chat rápido, tools |

**Total: ~13 GB** de modelos locales en Madre.

## Próximos pasos con estos modelos
- [ ] Pipeline RAG: `nomic-embed-text` / `bge-m3` → Qdrant → Open WebUI
- [ ] Configurar Open WebUI: `llama3.1:8b` como modelo por defecto
- [ ] Auditoría THDORA: ver `~/Projects/thdora/src/` para handlers del bot
- [ ] Conectar THDORA bot con Ollama para respuestas IA

---
_Descarga iniciada 30-jun 22:08 — completada antes de 01-jul 00:44_
