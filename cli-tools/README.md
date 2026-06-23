---
tags: [cli-tools, terminal, ia-terminal, opencode, aider, coding-assistant]
fecha-actualizacion: 2026-06-23
ruta-obsidian: cli-tools/README.md
---

# CLI Tools — Herramientas IA de Terminal

> Herramientas que funcionan desde la terminal con capacidades de IA.
> Distinto de `agentes/` (chat web) y `ollama/` (modelos puros).
> Estas herramientas COMBINAN modelos (Ollama local o APIs externas) con flujos de trabajo CLI.

## Herramientas activas

| Tool | Modelo backend | Para qué | Estado |
|---|---|---|---|
| **OpenCode** | Claude / GPT / Ollama | Coding assistant en terminal | ✅ Configurado |
| **Ollama CLI** | Cualquier modelo local | Chat directo en terminal | ✅ Nativo |

## Herramientas a explorar

| Tool | Para qué |
|---|---|
| `aider` | Coding assistant CLI, edita archivos directamente |
| `shell_gpt` | Comandos bash generados con IA |
| `fabric` | Pipelines de prompts en terminal |
| `llm` (simonw) | CLI universal para cualquier LLM |

## OpenCode en terminal

```bash
# Desde el directorio del proyecto
opencode
# Lee opencode.json automáticamente
```

## Ollama como CLI

```bash
# Chat directo
ollama run llama3.2:3b
ollama run deepseek-r1:8b

# One-shot desde terminal
echo "explica este error" | ollama run llama3.2:3b

# Con un archivo
cat main.py | ollama run llama3.2:3b "revisa este código"
```

## Fichas individuales

- [[cli-tools/opencode]] — coding assistant principal

## Ver también

- [[ollama/README]] — modelos que usan estas herramientas
- [[agentes/README]] — IAs externas de chat
- [[tools/README]] — scripts y APIs propias
