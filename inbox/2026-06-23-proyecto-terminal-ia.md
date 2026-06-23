---
tags: [inbox, proyecto, terminal, ia, ollama, aider, opencode, idea]
fecha: 2026-06-23
estado: idea
destino: proyectos/terminal-ia.md
relacionado-anterior: [[inbox/2026-06-23-decision-arquitectura-proyectos]]
ruta-obsidian: inbox/2026-06-23-proyecto-terminal-ia.md
---

# Idea — Terminal IA para el Repo

> Estado: IDEA — evaluar cuando local-brain v4 esté validado.

## Concepto

Terminal inteligente que entiende el repo completo y puede editar archivos,
hacer commits y responder preguntas sobre el código desde la CLI.

## Candidatos

| Tool | Backend | Edita archivos | Commits | Ya tienes |
|---|---|---|---|---|
| **opencode** | Ollama/Groq | ✅ | ✅ | ✅ en cli-tools/ |
| **Aider** | Ollama/GPT | ✅ | ✅ | ❌ instalar |
| **shell + Ollama** | Ollama local | Manual | Manual | ✅ |

## Recomendación

Empezar con **opencode** que ya está en `cli-tools/`.
Si no cubre las necesidades → evaluar Aider.

## Prereqs

- [ ] Ollama funcionando (qwen2.5:3b descargado)
- [ ] opencode configurado con Ollama como backend
