---
tags: [agentes, ia-externa, llm, chat, investigacion, workflows]
fecha-actualizacion: 2026-06-23
ruta-obsidian: agentes/README.md
---

# Agentes IA — IAs Externas de Chat e Investigación

> IAs que usas tú en el navegador o integradas via API/MCP.
> Son herramientas de investigación, documentación y razonamiento — NO corren en Madre.

## Estructura de carpetas del ecosistema

| Carpeta | Qué contiene |
|---|---|
| `agentes/` | IAs externas de chat — Claude, Gemini, GPT, Perplexity, Grok |
| `ollama/` | Modelos locales en Madre/Acer — llama3.2, deepseek, phi4... |
| `cli-tools/` | Herramientas IA de terminal — opencode, aider, shell_gpt |
| `tools/` | Scripts y APIs propias — ollama-rag, inbox-processor, thdora |

## IAs activas

| IA | Acceso | Rol principal | Estado |
|---|---|---|---|
| **Perplexity** (Sonnet 4.6) | Web + MCP GitHub | Código · repos · docs · arquitectura | ✅ Principal |
| **Grok 3** (xAI) | Web + X/Twitter | Investigación · mercado · datos frescos | ✅ Activo |
| **Gemini 2.5 Pro** | Web | Contexto 1M tokens · código largo | ✅ Activo |
| **Claude Sonnet 4.6** | Web + API | Razonamiento · escritura técnica | ✅ Activo |
| **ChatGPT o3** | Web | Matemáticas · razonamiento formal | ✅ Activo |
| **Mistral Le Chat** | Web | Investigación EU · privacidad | ⏳ Parcial |

## Protocolo de handoff

```
Grok (investiga) → Perplexity (valida + sube al repo)
Gemini (diseña / código largo) → Perplexity (sube al repo)
Claude (razona / escribe) → Perplexity (documenta)
OpenCode (terminal) → commits locales → Perplexity documenta
```

**Regla de oro:** output final en GitHub → siempre pasa por Perplexity (tiene MCP GitHub).

## Cómo arrancar una sesión nueva

### Con Perplexity
```
Lee AGENT.md y CONTEXT.md de yggdrasil-dew y díme el estado actual.
Repo: https://github.com/alvarofernandezmota-tech/yggdrasil-dew
```

### Con Grok
```
Soy Álvaro. Ecosistema en: https://github.com/alvarofernandezmota-tech/yggdrasil-dew
Investiga [TEMA] y dame opciones con pros/contras.
```

### Con Gemini
```
Soy Álvaro. Contexto en: yggdrasil-dew/ECOSISTEMA.md
Implementa [TAREA LARGA] completa.
```

### Con Claude
```
Soy Álvaro. Lee CONTEXT.md: https://github.com/alvarofernandezmota-tech/yggdrasil-dew
Necesito razonar sobre [TEMA].
```

## Fichas individuales

- [[agentes/perplexity]] — Perplexity + MCP GitHub
- [[agentes/claude-sonnet-4.6]] — Claude Sonnet
- [[agentes/gemini-2.5-pro]] — Gemini Pro
- [[agentes/chatgpt-o3]] — ChatGPT o3
- [[agentes/grok-3]] — Grok 3
- [[agentes/mistral-large-2]] — Mistral

## Ver también

- [[ollama/README]] — modelos locales
- [[cli-tools/README]] — herramientas de terminal
- [[tools/README]] — scripts y APIs propias
- [[AGENT.md]] — roles completos del ecosistema
