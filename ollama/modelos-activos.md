---
tags: [tipo/inventario, estado/activo, ollama, ia, modelos]
fecha: 2026-07-01
validado: true
---

# 🤖 Ollama — Modelos activos en madre

> Estado: ✅ Validado 01-jul-2026
> Host: madre (`100.91.112.32:11434`)
> Fuente: `inbox/2026-07-01-modelos-ollama-completos.md` + `inbox/2026-06-30-ollama-modelos-pull.md`

## Modelos instalados

| Modelo | Tamaño | Contexto | Uso principal |
|---|---|---|---|
| `qwen2.5-coder:7b` | 4.7GB | 32k | Código · thdora bot |
| `qwen2.5:3b` | 1.9GB | 32k | Chat rápido |
| `llama3.1:8b` | 4.7GB | 128k | Chat general |
| `bge-m3` | 1.2GB | — | Embeddings RAG (contenedor separado `:11435`) |
| `nomic-embed-text` | 0.3GB | — | Embeddings rápidos |

**Total en disco:** ~12.8GB

## Comandos útiles

```bash
# Listar modelos
curl http://100.91.112.32:11434/api/tags | jq '.models[].name'

# Test rápido
curl -X POST http://100.91.112.32:11434/api/generate \
  -d '{"model":"qwen2.5:3b","prompt":"hola","stream":false}'

# Ver uso VRAM
nvidia-smi
```

## ⚠️ Pendiente (Fase 5)

- [ ] Auditar si Ollama `:11434` está expuesto sin auth fuera de Tailscale
- [ ] Configurar `OLLAMA_HOST=127.0.0.1` o bind solo a Tailscale IP
- [ ] Revisar si Open-WebUI tiene auth activado
