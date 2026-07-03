---
estado: NUEVO
fecha-entrada: 2026-07-03
destino: docs/tareas/
etiquetas: investigacion, agentes, automatizacion
prioridad: alta
---

# TAREA COPILOT: INVESTIGACIÓN PROFUNDA

## Qué hacer
Abrir Copilot Chat en el repo con este prompt:

```
Lee docs/COPILOT-CONTEXT.md y docs/COPILOT-15-AGENTES.md.

Haz una investigación profunda en GitHub usando gh api search/repositories:

1. Busca repos sobre: autonomous agents ollama mcp local
2. Busca repos sobre: github actions AI automation self-hosted
3. Busca repos sobre: crew ai langchain local llm agents
4. Busca en Hugging Face: modelos < 7B que superen mistral en reasoning
5. Busca awesome-lists: awesome-llm-agents, awesome-selfhosted

Para cada hallazgo relevante:
- Evalúa compatibilidad con el ecosistema
- Genera entrada en investigacion/YYYY-MM-DD-hallazgo.md
- Si resuelve la deuda MCP socket, crea issue URGENTE

Usa lenguaje de búsqueda exacto en GitHub:
  - stars:>500 topic:ollama
  - stars:>200 topic:mcp-server
  - stars:>100 topic:ai-agents pushed:>2026-01-01
```

## La IA local que empieza por C
**Copilot** — GitHub Copilot. Lo tienes integrado en el repo.
Pero también:
- **Continue.dev** — extensión VSCode con Ollama local
- **Cursor** — IDE con IA integrada
- **Cody** — Sourcegraph AI

Y los modelos locales en Madre:
- **gemma3** (Google, ligero, análisis)
- **llama3** (Meta, razonamiento)
- **mistral** (Mistral AI, código + razonamiento)

Todos corriendo en Ollama :11434 en Madre.
