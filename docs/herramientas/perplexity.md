---
tags: [herramientas, ia, perplexity, llm, mcp]
fecha-actualizacion: 2026-07-02
---

# 🤖 Perplexity — Herramienta IA principal

## Qué es Perplexity

Perplexity es un asistente IA con búsqueda web en tiempo real integrada. No es solo un chatbot: combina modelos LLM con acceso a internet y herramientas (MCPs, conectores). Lo que lo diferencia de ChatGPT o Claude directo es que siempre cita fuentes y puede conectarse a repos, Drive, etc.

---

## Motores LLM disponibles en Perplexity (2026)

Perplexity no tiene un solo modelo — permite elegir entre varios motores reales de distintas compañías:

| Motor | Empresa | Mejor para |
|---|---|---|
| **Sonet 4.5 / Claude 4** | Anthropic | Razonamiento profundo, código complejo, documentación larga |
| **GPT-4o / o3** | OpenAI | Generalista, bueno en todo, muy rápido |
| **Gemini 2.5 Pro** | Google | Contexto muy largo (1M tokens), documentos grandes |
| **Grok 3** | xAI (Elon Musk) | Actualidad, Twitter/X, respuestas directas sin filtros |
| **Sonar (propio)** | Perplexity | Motor propio, más rápido, optimizado para búsqueda web |
| **r1 / DeepSeek** | DeepSeek | Razonamiento paso a paso (chain-of-thought), matemáticas |

### Cuál usar según tarea

| Tarea | Motor recomendado |
|---|---|
| Código, scripts, infraestructura | Claude (Sonnet 4.5) o GPT-4o |
| Documentación larga, contexto grande | Gemini 2.5 Pro |
| Noticias, actualidad, rapidez | Grok 3 o Sonar |
| Razonamiento, matemáticas, lógica | DeepSeek r1 |
| Búsqueda web rápida | Sonar (defecto Perplexity) |
| Proyectos largos con memoria de sesión | Claude Sonnet 4.5 |

---

## Acceso MCP — GitHub conectado

Perplexity tiene MCP de GitHub configurado para `alvarofernandezmota-tech`. Esto permite:
- Leer y escribir ficheros en repos directamente desde el chat
- Crear commits, PRs, issues sin salir de Perplexity
- Cualquier IA dentro de Perplexity puede usar el MCP **si el usuario lo activa**

### Importante
El MCP es **por sesión y por usuario** — no cualquier IA externa puede acceder al repo. Solo funciona cuando:
1. Estás en Perplexity con tu cuenta
2. El MCP de GitHub está activado
3. El token tiene permisos sobre el repo

---

## Uso con @GitHub en web

- La UI actual de Perplexity (2026) usa `@GitHub` como conector en el chat web
- Conectores no persisten entre mensajes en **Chromium 148 Arch Linux** — ver `chromium-perplexity.md`
- Funciona correctamente en **móvil** y en **Firefox**
- Alternativa recomendada: **Comet** (navegador propio de Perplexity)

---

## Espacios (Spaces)

Los Spaces de Perplexity permiten configurar contexto persistente con instrucciones del sistema, fuentes fijas y MCP activo. El Space `Repo Personal` tiene como fuente prioritaria `github.com/alvarofernandezmota-tech`.

---
_Creado: 02-jul-2026 — Perplexity vía MCP_
