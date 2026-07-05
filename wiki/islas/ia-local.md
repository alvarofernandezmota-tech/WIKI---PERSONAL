---
tipo: isla
nombre: IA Local
descripcion: Inteligencia artificial 100% local — sin APIs externas, sin datos fuera
repo_principal: https://github.com/alvarofernandezmota-tech/ollama-stack
github_issues: https://github.com/alvarofernandezmota-tech/ollama-stack/issues
obsidian_link: "[[ia-local]]"
depende_de: [infra]
sirve_a: [thdora, cerebro]
estado: estable
author: Alvaro Fernandez Mota
creado: 2026-07-05
actualizado: 2026-07-05
---

# 🤖 Isla: IA Local

IA 100% local corriendo en la GTX 1060 6GB de Madre. Sin ningún servicio externo, sin APIs de pago, sin enviar datos fuera.

> ⚡ Config técnica → [`ollama-stack`](https://github.com/alvarofernandezmota-tech/ollama-stack) · [`local-brain`](https://github.com/alvarofernandezmota-tech/local-brain)

---

## Repos

| Repo | Propósito | URL |
|---|---|---|
| `ollama-stack` | Ollama, modelos, compose, config | https://github.com/alvarofernandezmota-tech/ollama-stack |
| `local-brain` | RAG, memoria vectorial, Qdrant, embeddings | https://github.com/alvarofernandezmota-tech/local-brain |
| `investigacion-ia` | PoCs, experimentos, benchmarks de modelos | https://github.com/alvarofernandezmota-tech/investigacion-ia |

---

## Modelos activos

| Modelo | Tamaño | Uso |
|---|---|---|
| `llama3.1:8b` | ~5GB | General, razonamiento |
| `mistral:7b` | ~5GB | Código + razonamiento |
| `codellama:7b` | ~4GB | Código puro |

---

## Arquitectura objetivo (Fase 8)

```
Cualquier cliente MCP
    ↓
Servidor MCP propio (Madre :3000)
    ├──► Ollama API (Madre :11434)  ← modelos locales
    └──► GitHub API (yggdrasil-dew) ← repos y issues
```

---

## Conexiones

- ← [[infra]] (depende de la GPU de Madre)
- → [[thdora]] (THDORA usa los modelos locales)
- → [[cerebro]] (los resultados se documentan en dew)

---
_Actualizado: 2026-07-05 21:00 CEST · Perplexity-MCP_
