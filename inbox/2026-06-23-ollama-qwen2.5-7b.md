---
tags: [inbox, ollama, qwen, llm-local, potente, madre, pendiente-migrar]
fecha: 2026-06-23
estado: pendiente-migrar
destino: ollama/qwen2.5-7b.md
relacionado-anterior: [[inbox/2026-06-23-ollama-rag-investigacion]]
ruta-obsidian: inbox/2026-06-23-ollama-qwen2.5-7b.md
---

# qwen2.5:7b — LLM Potente Local (Modo Conectado)

Versión grande de Qwen 2.5. Techo real de la GTX 1060 6GB.
Usar solo en modo potente cuando se acepta más latencia.

## Hardware

| Variante | VRAM Q4_K_M | Velocidad | Nota |
|---|---|---|---|
| qwen2.5:7b | ~5.5 GB | ~5 tok/s | Justo en 6GB |

## Advertencia

Con contexto RAG largo (varios chunks) puede spillar a RAM via PCIe.
Velocidad baja a ~2-3 tok/s con offloading.

## Cuándo usarlo

- Modo “potente local” cuando la latencia no importa
- Tareas que requieren más razonamiento que qwen2.5:3b
- Preferible Groq API si hay conexión (más rápido y gratis)

```bash
ollama pull qwen2.5:7b
# En .env para modo potente:
LLM_MODEL=qwen2.5:7b
```

## Ver también
- [[ollama/qwen2.5-3b]] — versión ligera principal
- [[agentes/grok-3]] — alternativa cloud gratuita y mucho más rápida
