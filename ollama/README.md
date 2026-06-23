---
tags: [ollama, modelos-locales, llm-local, madre, acer]
fecha: 2026-06-23
---

# Ollama — Modelos Locales en Madre y Acer

Esta carpeta documenta los **modelos LLM que corren localmente** via Ollama.
No son "agentes" — son motores de inferencia local instalados en las máquinas.

## Diferencia clave

| Carpeta | Qué contiene |
|---|---|
| `agentes/` | LLMs externos que usas tú en el navegador (Claude, Gemini, GPT, Perplexity) |
| `ollama/` | Modelos locales que corren en Madre/Acer via Ollama |
| `tools/` | Código que corre en Madre (RAG, bots, scripts) |

## Modelos disponibles

- `llama3.2:3b` — LLM principal del RAG en Madre
- `nomic-embed-text` — embeddings para ChromaDB
- `deepseek-r1` — razonamiento profundo
- `gemma3` — general purpose
- `phi4` — ligero, rápido
- `qwen2.5-72b` — potente, requiere mucha RAM
- `codegemma` / `starcoder2` — especializados en código
- `mistral-7b` — general, ligero
- `llama3.3-70b` — potente, solo Madre con suficiente VRAM

## Comandos básicos

```bash
# Instalar Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Arrancar
ollama serve

# Modelos del RAG (instalar primero)
ollama pull llama3.2:3b
ollama pull nomic-embed-text

# Ver modelos instalados
ollama list
```
