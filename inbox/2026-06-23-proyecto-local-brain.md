---
tags: [inbox, proyecto, local-brain, rag, ollama, fastapi, pendiente-migrar]
fecha: 2026-06-23
estado: pendiente-migrar
destino: proyectos/local-brain.md
relacionado-anterior: [[inbox/2026-06-23-decision-arquitectura-proyectos]]
ruta-obsidian: inbox/2026-06-23-proyecto-local-brain.md
---

# Proyecto Local Brain — RAG Ollama 100% Local

## Qué es

API RAG híbrida (vector + BM25) sobre el vault de Obsidian.
100% local, sin datos saliendo de Madre.

## Estado actual

- v2 implementada en `tools/local-brain/`
- v4 diseñada, pendiente implementar (bloqueado por Ollama)
- Ver: [[inbox/2026-06-23-yggdrasil-v4-diario-maestro]]

## Responsabilidad única

API de consulta al vault. No sabe nada de clientes.

## Stack v4

- FastAPI + uvicorn
- Ollama (qwen2.5:3b + nomic-embed-text)
- ChromaDB (acelerador vectorial)
- SQLite FTS5 (SSoT + búsqueda léxica)
- BM25 + RRF
- SSE streaming

## Puertos

- `:8001` — local-brain (Ollama)
- `:8002` — local-brain-claude (Claude API)

## Hardware target

- Máquina Madre: GTX 1060 6GB · i5-8400 · Arch Linux

## Ver también

- [[tools/local-brain/]] — código
- [[inbox/2026-06-23-yggdrasil-v4-diario-maestro]] — arquitectura completa
- [[ollama/README]] — modelos usados
