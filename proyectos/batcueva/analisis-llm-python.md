---
tags: [python, llm-runtime, local-ai, ollama, virtualenv]
fecha: 2026-06-20
estado: referencia
ruta-obsidian: proyectos/batcueva/analisis-llm-python.md
---

# Análisis — LLM + Python en Madre

> Movido desde inbox/ · Auditoría Grok 23/06/2026

## Hardware disponible
- GTX 1060 6GB VRAM → modelos hasta 7B en GGUF Q4
- 16GB RAM → modelos CPU hasta 13B lentos

## Stack elegido
- Ollama (`:11434`) — runtime principal
- Open WebUI (`:3001`) — interfaz web
- nomic-embed-text — embeddings para RAG

Ver [[proyectos/batcueva/modelos-ollama-hardware]] para tabla completa.
