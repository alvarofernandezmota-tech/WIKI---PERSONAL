---
tags: [inbox, ollama, qwen, llm-local, rag, madre, pendiente-migrar]
fecha: 2026-06-23
estado: pendiente-migrar
destino: ollama/qwen2.5-3b.md
relacionado-anterior: [[inbox/2026-06-23-ollama-rag-investigacion]]
ruta-obsidian: inbox/2026-06-23-ollama-qwen2.5-3b.md
---

# qwen2.5:3b — LLM Principal del RAG

Modelo de Alibaba. Reemplaza a llama3.2:3b como LLM principal del local-brain.
Mismo footprint de VRAM, mucho mejor español e instruction-following.

## Hardware

| Variante | VRAM Q4_K_M | Velocidad Madre | Máquina |
|---|---|---|---|
| qwen2.5:3b | ~2.0 GB | ~30 tok/s | Acer + Madre ✅ |

## Por qué mejor que llama3.2:3b

- Entrenado en datos multilingües masivos
- Instruction-following más preciso en español
- Mejor síntesis de contexto en RAG
- Mismo consumo de VRAM

## Cuándo usarlo

- LLM principal en local-brain RAG (:8001)
- Clasificador en inbox-processor
- Respuestas rápidas en español

## Peor para

- Razonamiento profundo → usar deepseek-r1
- Contextos muy largos → usar qwen2.5:7b

```bash
ollama pull qwen2.5:3b
ollama run qwen2.5:3b
```

## Config en .env

```bash
LLM_MODEL=qwen2.5:3b
```

## Ver también
- [[ollama/llama3.2-3b]] — modelo anterior que reemplaza
- [[ollama/qwen2.5-7b]] — versión potente
- [[tools/local-brain/]] — donde se usa
