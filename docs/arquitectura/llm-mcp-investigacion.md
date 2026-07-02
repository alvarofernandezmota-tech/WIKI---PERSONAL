---
tipo: arquitectura
author: Perplexity-MCP <alvarofernandezmota@gmail.com>
creado: 2026-07-03 01:05 CEST
actualizado: 2026-07-03 01:05 CEST
ruta: docs/arquitectura/llm-mcp-investigacion.md
tags: [llm, mcp, ollama, local, investigacion, arquitectura]
status: borrador
---

# Investigación: LLMs locales + MCP — Fase 1

> Preguntas lanzadas a Gemini en paralelo. Resultados a documentar aquí.

---

## Preguntas de investigación

### Bloque A — LLMs locales en hardware del ecosistema

1. **¿Qué modelos LLM funcionan mejor en CPU-only con 16GB RAM (i5-8400)?**
   - Comparativa Qwen2.5-7B vs Llama3.1-8B vs Mistral-7B en Q4_K_M
   - Velocidad tokens/s esperada con num_thread=4, num_ctx=2048
   - Consumo RAM real en inferencia

2. **¿Qué modelos aprovechan la GTX 1060 6GB del Acer para inferencia?**
   - VRAM mínima por modelo y cuantización
   - Ollama vs llama.cpp directo: overhead real
   - Modelos especializados: código (Qwen2.5-Coder), embeddings (nomic-embed-text)

3. **¿Cómo se configura Ollama para servir modelos a través de Tailscale?**
   - OLLAMA_HOST y binding correcto
   - Seguridad: autenticación entre nodos
   - Latencia esperada en red Tailscale

### Bloque B — MCP: arquitectura y opciones

4. **¿Qué es MCP exactamente y cómo funciona el protocolo?**
   - Diferencia MCP server vs MCP client
   - Cómo Cursor/Perplexity consumen un MCP server
   - Formato `mcp.json` y sus opciones

5. **¿Qué MCP servers open-source existen para automatizar un homelab?**
   - MCP filesystem (leer/escribir ficheros locales)
   - MCP bash/shell (ejecutar comandos)
   - MCP Docker (gestionar contenedores)
   - MCP SQLite / bases de datos locales

6. **¿Se puede montar un MCP server propio en Madre accesible por Tailscale?**
   - Stack mínimo: Python + FastAPI o Node.js
   - Cómo exponer el MCP server solo en red Tailscale
   - Autenticación y seguridad

### Bloque C — Integración LLM + MCP

7. **¿Cómo conectar Ollama (LLM local) con un MCP server?**
   - ¿Ollama tiene soporte nativo MCP?
   - Alternativas: Open WebUI + MCP, LangChain + Ollama + MCP
   - Viabilidad en hardware Madre (CPU-only)

8. **¿Qué flujo permite a Perplexity/Cursor usar Ollama local como LLM?**
   - Proxy LLM: redirigir llamadas a Ollama via Tailscale
   - Open WebUI como frontend unificado
   - Coste vs beneficio frente a usar Perplexity directo

---

## Estado investigación

| Pregunta | Estado | Fuente | Resultado |
|---|---|---|---|
| A1 — Modelos CPU Madre | ⏳ pendiente Gemini | — | — |
| A2 — Modelos GPU Acer | ✅ parcial | `gemini-fase1-investigacion.md` | Ver tabla modelos |
| A3 — Ollama + Tailscale | ⏳ pendiente | — | — |
| B4 — MCP protocolo | ✅ claro | Perplexity MCP activo | Funciona vía `mcp.json` |
| B5 — MCP servers OSS | ⏳ pendiente Gemini | — | — |
| B6 — MCP server propio | ⏳ pendiente | — | — |
| C7 — Ollama + MCP | ⏳ pendiente | — | — |
| C8 — Perplexity + Ollama | ⏳ pendiente | — | — |

---

## Preguntas exactas para lanzar a Gemini

```
PREGUNTA 1:
Tengo un homelab con dos máquinas:
- Madre: i5-8400, 16GB RAM, sin GPU, Arch Linux, Docker
- Acer: i5-8250U, 8GB RAM, GTX 1060 6GB, Arch Linux
Ambas conectadas por Tailscale.

Qué modelos LLM locales recomiendas para cada una?
Comparativa: Qwen2.5-7B, Llama3.1-8B, Mistral-7B en Q4_K_M.
Tokens/s esperados, RAM real en inferencia, y si hay modelos
especializados en código o embeddings que encajen en este hardware.

PREGUNTA 2:
Qué MCP servers open-source existen para automatizar un homelab?
Especialmente: filesystem, bash/shell, Docker, SQLite.
Cómo se monta un MCP server propio en Python/FastAPI accesible
solo por red Tailscale con autenticación básica.

PREGUNTA 3:
Cómo conectar Ollama (corriendo en Madre CPU-only) con un MCP server
para que Cursor/Perplexity puedan usarlo como LLM local?
Viabilidad real, latencia esperada, y alternativas más simples.
```

---

## Próximos pasos

1. Lanzar las 3 preguntas a Gemini CLI cuando esté configurado en Madre
2. Documentar respuestas en este fichero (sección Resultados)
3. Crear issues para cada línea de acción que salga
4. Cruzar con `docs/arquitectura/gemini-fase1-investigacion.md`
