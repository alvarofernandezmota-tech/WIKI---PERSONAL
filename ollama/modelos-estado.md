# 🤖 Estado de Modelos Ollama

> Actualizado: 2026-06-25
> Origen: `inbox/2026-06-24-DESCARGAS-COMPLETAS-06h10.md` + sesiones anteriores

## Modelos confirmados descargados

| Modelo | Tamaño | Uso asignado | Estado |
|--------|--------|--------------|--------|
| `qwen2.5:3b` | ~2GB | Agente ligero / móvil | ✅ Descargado |
| `qwen2.5:7b` | ~4.5GB | Agente general | ✅ Descargado |
| `bge-m3` | ~570MB | Embeddings RAG | ✅ Descargado |

## Modelos PENDIENTES de descarga (las 5 del día 24)

| Modelo | Tamaño | Prioridad | Notas |
|--------|--------|-----------|-------|
| `llama3.2:3b` | ~2GB | Alta | Fase 1 |
| `mistral:7b` | ~4.1GB | Alta | Agente OSINT |
| `nomic-embed-text` | ~274MB | Media | Embeddings alt |
| `phi3:mini` | ~2.3GB | Media | Agente rápido |
| `deepseek-r1:7b` | ~4.7GB | Baja | Razonamiento |

## Comandos para relanzar descargas pendientes
```bash
# Ejecutar en la Madre cuando haya conexión estable
ollama pull llama3.2:3b
ollama pull mistral:7b
ollama pull nomic-embed-text
ollama pull phi3:mini
ollama pull deepseek-r1:7b

# Verificar estado
ollama list
```

## Modelfiles custom
- `Erika` → ver `inbox/2026-06-24-ollama-modelfile-erika.md` → mover a `ollama/modelfiles/erika.Modelfile`

## Referencias
- `inbox/2026-06-23-ollama-qwen2.5-3b.md`
- `inbox/2026-06-23-ollama-qwen2.5-7b.md`
- `inbox/2026-06-23-ollama-bge-m3.md`
- `inbox/2026-06-24-BITACORA-FINAL-OLLAMA-VS-LLAMACPP.md` → **ganó Ollama**
