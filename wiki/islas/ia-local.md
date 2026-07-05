---
tipo: isla
nombre: IA Local
descripcion: Infraestructura de inteligencia artificial 100% local en Madre
repo_principal: https://github.com/alvarofernandezmota-tech/ollama-stack
github_issues: https://github.com/alvarofernandezmota-tech/ollama-stack/issues
obsidian_link: "[[ia-local]]"
depende_de: [infra]
sirve_a: [thdora, cerebro]
estado: activo
---

# 🤖 Isla: IA Local

IA 100% local corriendo en la GTX 1060 6GB de Madre. Sin ningún servicio externo, sin APIs de pago, sin enviar datos fuera.

## Repos

| Repo | Propósito | URL |
|---|---|---|
| `ollama-stack` | Infraestructura Ollama: modelos, config, compose | https://github.com/alvarofernandezmota-tech/ollama-stack |
| `local-brain` | RAG, memoria vectorial, Qdrant, embeddings | https://github.com/alvarofernandezmota-tech/local-brain |
| `investigacion-ia` | PoCs, experimentos, benchmarks de modelos | https://github.com/alvarofernandezmota-tech/investigacion-ia |

## Modelos en Madre

| Modelo | Tamaño | Uso |
|---|---|---|
| `llama3.1:8b` | ~5GB | General, razonamiento |
| `mistral:7b` | ~5GB | Código + razonamiento |
| `codellama:7b` | ~4GB | Código puro |

```bash
# Verificar modelos
ollama list

# Test rápido
ollama run mistral:7b 'hola, funciona?'

# API
curl http://localhost:11434/api/generate -d '{"model": "mistral:7b", "prompt": "hola"}'
```

## Acceso desde Acer vía Tailscale

```bash
curl http://100.91.112.32:11434/api/generate \
  -d '{"model": "mistral:7b", "prompt": "hola"}'
```

## Arquitectura objetivo (Fase 8)

```
Cualquier cliente MCP
    ↓
Servidor MCP propio (Madre :3000)
    ├──► Ollama API (Madre :11434)  ← modelos locales
    └──► GitHub API (yggdrasil-dew) ← repos y issues
```

## Conexiones

- ← [[infra]] (depende de la GPU de Madre)
- → [[thdora]] (THDORA usa los modelos locales)
- → [[cerebro]] (los resultados se documentan en dew)

## Docs clave

- `ollama-stack/` → compose y config de Ollama
- `local-brain/` → implementación RAG
- `yggdrasil-dew/docs/herramientas/ollama.md` → documentación de uso

---
_Actualizado: 2026-07-05 · Perplexity-MCP_
