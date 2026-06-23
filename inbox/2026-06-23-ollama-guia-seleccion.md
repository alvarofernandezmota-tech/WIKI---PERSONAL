---
tags: [inbox, ollama, guia, hardware, madre, acer, pendiente-migrar]
fecha: 2026-06-23
estado: pendiente-migrar
destino: ollama/GUIA-SELECCION.md
relacionado-anterior: [[inbox/2026-06-23-ollama-rag-investigacion]]
ruta-obsidian: inbox/2026-06-23-ollama-guia-seleccion.md
---

# Guía de Selección de Modelos Ollama

> Hardware: GTX 1060 6GB (Madre) · Arch Linux Hyprland (~1.5GB VRAM OS)
> VRAM disponible para modelos: ~4.5 GB cómodo · 5.5 GB máximo

## Por caso de uso

| Tarea | Modelo | VRAM | Velocidad |
|---|---|---|---|
| RAG español (principal) | **qwen2.5:3b** | 2.0 GB | ~30 tok/s |
| Embeddings RAG | **nomic-embed-text** | 270 MB | — |
| Embeddings ES avanzado | **bge-m3** | 570 MB | — |
| Razonamiento / debug | **deepseek-r1:8b** | 6 GB | ~10 tok/s |
| Autocompletado código | **codegemma / starcoder2** | 4 GB | ~6 tok/s |
| General rápido | **phi4** | 2.5 GB | ~25 tok/s |
| Potente local | **qwen2.5:7b** | 5.5 GB | ~5 tok/s |
| Potente con red | **Groq llama-3.3-70b** | 0 GB | ~300 tok/s |

## Regla VRAM rápida

```
Modelos que caben cómodos juntos en 6GB:
  qwen2.5:3b (2.0) + nomic-embed-text (0.27) + OS (1.5) = 3.77 GB ✅
  qwen2.5:3b (2.0) + bge-m3 (0.57) + OS (1.5) = 4.07 GB ✅

Modelos que ocupan toda la VRAM (solo uno a la vez):
  deepseek-r1:8b = ~6 GB ⚠️
  qwen2.5:7b     = ~5.5 GB ⚠️

Modelos que no caben (offloading a RAM):
  qwen2.5:72b, llama3.3:70b ❌
```

## keep_alive en Ollama

```bash
# Mantener modelos co-residentes en VRAM (no descargar entre llamadas)
export OLLAMA_KEEP_ALIVE=10m

# En systemd:
Environment=OLLAMA_KEEP_ALIVE=10m
```

## ¿Local o cloud?

```
Sin internet / privacidad → Ollama local
Respuesta rápida + calidad → Groq API (gratis, llama-3.3-70b)
Máxima calidad → Claude Sonnet 4.6 API
```
