---
tags: [inbox, yggdrasil, v4, pendiente-implementar, ollama, bloqueado]
fecha: 2026-06-23
estado: bloqueado-por-ollama
destino: tools/local-brain/
bloqueado-por: Ollama descargando qwen2.5:3b
relacionado-anterior: [[inbox/2026-06-23-yggdrasil-v4-diario-maestro]]
relacionado-siguiente:
ruta-obsidian: inbox/2026-06-23-v4-pendiente-ollama.md
---

# v4 — Pendiente Implementar (esperar Ollama)

> ⛔ NO implementar hasta que Ollama esté descargado y validado.
> Todo el diseño está en [[inbox/2026-06-23-yggdrasil-v4-diario-maestro]].

## Orden de implementación cuando Ollama esté listo

1. **Validar Ollama funcionando**
   ```bash
   ollama run qwen2.5:3b
   # "Hola, ¿funcionas?"
   ```

2. **Crear archivos v4** (en este orden)
   - [ ] `tools/local-brain/database.py` — SQLite SSoT + grafo
   - [ ] `tools/local-brain/code_aware.py` — chunking consciente de código
   - [ ] `tools/local-brain/ingest_engine.py` — ingestor reactivo + sha256 IDs
   - [ ] `tools/local-brain/scheduler.py` — VRAMBudgetScheduler
   - [ ] `tools/local-brain/main.py` — actualizar con SSE streaming
   - [ ] `tools/local-brain/bot_handler.py` — throttling Telegram
   - [ ] `tools/systemd/local-brain.service` — health check ExecStartPre
   - [ ] `tools/systemd/ollama.service` — arranque automático

3. **Testear pipeline completo**
   ```bash
   curl -X POST http://127.0.0.1:8001/index
   curl -X POST http://127.0.0.1:8001/query -d '{"prompt": "qué es thdora"}'
   ```

4. **Migrar todas las notas del inbox de hoy**

## Todo el diseño está documentado en

- [[inbox/2026-06-23-yggdrasil-v4-diario-maestro]] — arquitectura completa + todo el código
- [[inbox/2026-06-23-ollama-rag-investigacion]] — comparativa Claude vs Gemini
- [[inbox/2026-06-23-tools-pendientes]] — lista de tools pendientes
