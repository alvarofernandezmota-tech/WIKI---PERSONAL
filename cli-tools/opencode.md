---
tags: [cli-tools, opencode, terminal, coding-assistant, ia-terminal]
fecha-actualizacion: 2026-06-23
ruta-obsidian: cli-tools/opencode.md
---

# OpenCode — Coding Assistant en Terminal

Agente de código que corre en terminal. Compatible con Claude, GPT y Ollama local.

## Instalación

```bash
npm install -g opencode-ai
# o
bun install -g opencode-ai
```

## Configuración en Madre

Requiere `opencode.json` en el directorio del proyecto.

## Uso básico

```bash
# Arrancar en el directorio del proyecto
opencode

# Con modelo específico
opencode --model claude-sonnet-4-6
opencode --model ollama/llama3.2:3b  # modo 100% local
```

## Ver también

- [[cli-tools/README]] — otras herramientas CLI
- [[agentes/claude-sonnet-4.6]] — Claude como backend
- [[ollama/llama3.2-3b]] — Ollama como backend local
