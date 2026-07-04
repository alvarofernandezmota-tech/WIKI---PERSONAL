---
tags: [adr, arquitectura, ollama, agentes, decision]
fecha: 2026-06-23
estado: decision-tomada
tipo: adr
ruta-obsidian: inbox/2026-06-23-adr-ollama-en-agentes.md
---

# ADR — Separación agentes/ vs ollama/

> Architecture Decision Record · Sesión 2026-06-23

## Contexto

Había confusión: los modelos Ollama estaban duplicados en `agentes/` (como `ollama-qwen2.5-72b.md`) y en `ollama/`. Había que decidir qué va en cada carpeta.

## Decisión

### `agentes/` — IAs externas con API
Solo contiene IAs que se consumen via API externa:
- Claude (Anthropic)
- ChatGPT / o3 (OpenAI)
- Gemini (Google)
- Grok (xAI)
- Perplexity
- Mistral API
- AI Toolkit, opencode
- Especializados: OCR, audio, embeddings externos

### `ollama/` — Todo lo local
Contiene todo lo que corre en Madre localmente:
- Modelos locales (fichas técnicas + VRAM + casos uso)
- RAG — investigación, implementación, Qdrant
- Embeddings locales — bge-m3, nomic-embed-text
- Open WebUI
- Guía selección de modelos

## Cambios a ejecutar

- [ ] Eliminar fichas `agentes/ollama-*.md` (están duplicadas)
- [ ] Verificar que `ollama/` tiene todas las fichas equivalentes
- [ ] Actualizar `agentes/README.md` — quitar referencias a modelos locales
- [ ] Actualizar `ollama/README.md` — es la fuente de verdad de modelos locales

## Regla

> Si necesita internet para funcionar → `agentes/`
> Si corre en Madre → `ollama/`

## Referencias
- [[agentes/README]]
- [[ollama/README]]
- [[inbox/2026-06-23-auditoria-ollama]]
