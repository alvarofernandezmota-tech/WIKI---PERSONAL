---
tags: [ollama, vram-optimization, quantization, hardware-specs, gtx-1060]
fecha: 2026-06-23
estado: referencia
ruta-obsidian: proyectos/batcueva/modelos-ollama-hardware.md
---

# Modelos Ollama — Hardware Madre

> Movido desde inbox/ · Auditoría Grok 23/06/2026

## Hardware
- GTX 1060 6GB VRAM · i5-8400 · 16GB RAM

## Modelos recomendados (VRAM 6GB)

| Modelo | VRAM | Calidad |
|---|---|---|
| llama3:8b-instruct-q4_K_M | ~4.5GB | ⭐⭐⭐⭐ |
| mistral:7b-instruct-q4_K_M | ~4.1GB | ⭐⭐⭐⭐ |
| nomic-embed-text | ~274MB | embeddings RAG |
| phi4:14b-q3_K_M | ~6.2GB | ⭐⭐⭐⭐⭐ (justo) |

## Modelos a evitar (>6GB VRAM)
- llama3:70b, qwen2.5:72b → CPU only (muy lento)

## Instalar
```bash
ollama pull llama3:latest
ollama pull nomic-embed-text:latest
```
