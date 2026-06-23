---
tags: [ollama, modelos-locales, llm-local, madre, acer, inferencia]
fecha-actualizacion: 2026-06-23
ruta-obsidian: ollama/README.md
---

# Ollama — Modelos LLM Locales

> Modelos de inferencia que corren localmente en Madre (varopc) o Acer.
> NO son "agentes" — son motores. Los usas desde terminal, desde el RAG o desde cli-tools.

## Diferencia con agentes/

| `agentes/` | `ollama/` |
|---|---|
| IAs externas en el navegador | Modelos que corren en tu hardware |
| Claude, Gemini, GPT, Perplexity | llama3.2, deepseek, phi4, gemma3 |
| Requieren conexión | 100% offline, privados |
| No los controlas | Tú los instalas y gestionas |

## Instalación

```bash
# Instalar Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Arrancar servidor
ollama serve

# Ver modelos instalados
ollama list

# Usar en terminal
ollama run llama3.2:3b
```

## Modelos del RAG (instalar primero)

```bash
ollama pull llama3.2:3b        # LLM principal RAG
ollama pull nomic-embed-text   # embeddings ChromaDB
```

## Modelos disponibles

| Modelo | Hardware | Para qué |
|---|---|---|
| `llama3.2:3b` | GTX 1060 6GB ✔️ | LLM principal RAG |
| `nomic-embed-text` | CPU ✔️ | Embeddings ChromaDB |
| `deepseek-r1:8b` | 6-8GB RAM ✔️ | Razonamiento profundo |
| `gemma3` | 4-8GB ✔️ | General purpose |
| `phi4` | 4GB ✔️ | Ligero y rápido |
| `mistral:7b` | 5GB ✔️ | General, ligero |
| `codegemma` | 4-7GB ✔️ | Autocompletado código |
| `starcoder2` | 4-7GB ✔️ | Autocompletado código |
| `qwen2.5:72b` | +40GB ❌ solo con mucha RAM | Potente, requiere mucho |
| `llama3.3:70b` | +40GB ❌ solo con mucha RAM | Potente, requiere mucho |

## Fichas individuales

- [[ollama/llama3.2-3b]] — LLM principal RAG
- [[ollama/nomic-embed-text]] — embeddings
- [[ollama/ollama-deepseek-r1]] — razonamiento
- [[ollama/ollama-gemma3]] — general
- [[ollama/ollama-phi4]] — ligero
- [[ollama/ollama-mistral-7b]] — general ligero
- [[ollama/ollama-codegemma-starcoder2]] — código

## Ver también

- [[tools/ollama-rag/README]] — cómo usa Ollama el RAG
- [[cli-tools/README]] — opencode y otras CLI con IA
- [[agentes/README]] — IAs externas de chat
