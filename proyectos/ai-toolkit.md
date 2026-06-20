---
tags: [proyecto, activo, ia, opensource, infraestructura]
---

# 🛠️ ai-toolkit — Stack IA Open Source

> Repo: [alvarofernandezmota-tech/ai-toolkit](https://github.com/alvarofernandezmota-tech/ai-toolkit)
> Creado: abril 2026 · Estado: **activo**

## Qué es

Stack completo de desarrollo con IA. Open source. Coste 0€. Filosofía BYOK (Bring Your Own Key).

## Componentes

- **Claude Code** — agente de código en terminal
- **OpenRouter** — acceso multi-modelo con una sola API key
- **Ollama** — modelos locales (sin coste, sin privacidad comprometida)
- **n8n** — automatización de flujos (por levantar en Docker)

## Estado actual

- Ollama en Madre: `llama3.2:3b` ✅
- Ollama en varopc: `qwen2.5-coder:14b` · `deepseek-r1:14b` · `qwen3:8b` ✅
- OpenCode configurado ✅
- n8n: ⏳ por levantar en Docker

## Pendiente

- [ ] Corregir `CEREBRO.md` — referencia a `personal` → actualizar a [[proyectos/yggdrasil-dew]]
- [ ] Levantar n8n en Docker en Madre
- [ ] Documentar configuración OpenRouter

## Relación con el ecosistema

- Alimenta a [[proyectos/thdora]] con modelos Ollama
- Usa [[proyectos/yggdrasil-dew]] como contexto para agentes

---

Volver a [[HOME]] · [[ECOSISTEMA]]
