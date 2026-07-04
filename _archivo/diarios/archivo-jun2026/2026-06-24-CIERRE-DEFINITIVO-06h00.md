---
tags: [cierre, monitor, ollama, docker, gemini, prompt]
fecha: 2026-06-24
hora: 06:00
estado: archivado
---

# Cierre definitivo — 24 jun 2026 06:00

---

## Estado final confirmado

### Docker — ✅ COMPLETO (19 imágenes)
No hay nada más que descargar.

### Ollama — ⏳ Descargando en background
Script: `nohup` corriendo en madre → `/tmp/ollama-nocturno.log`

| # | Modelo | Tamaño | Estado |
|---|---|---|---|
| 1 | qwen2.5:3b | 1.9GB | ✅ listo |
| 2 | qwen2.5:14b | ~9.0GB | ⏳ EN CURSO (~3h31m) |
| 3 | qwen2.5:7b | ~4.7GB | ⏳ en cola |
| 4 | llama3.1:8b | ~4.7GB | ⏳ en cola |
| 5 | mistral:7b | ~4.1GB | ⏳ en cola |
| 6 | bge-m3 | ~1.2GB | ⏳ en cola |
| 7 | nomic-embed-text | ~0.3GB | ⏳ en cola |

**Total restante: ~24GB — estimado ~8h — listo ~14:00h**

---

## Monitor para mañana

```bash
watch -n 20 'ssh madre "
echo \"━━━ OLLAMA LISTOS ━━━\" && ollama list
echo \"\" && echo \"━━━ PROGRESO ━━━\" && tail -3 /tmp/ollama-nocturno.log
echo \"\" && echo \"━━━ DOCKER ━━━\" && docker ps --format \"table {{.Names}}\t{{.Status}}\"
"'
```

---

## Lo que queda mañana — SOLO código y config

1. `docker compose up -d` en las 4 fases
2. Crear `litellm-config.yaml`
3. n8n primer workflow (Telegram → inbox)
4. Gitea mirrors de repos clave
5. Open WebUI RAG con docs yggdrasil-dew
6. Auditar inbox con Perplexity

---

## Prompt Gemini — investigación antes de dormir

```
Soy un dev con un homelab en Arch Linux con Docker.
Tengo corriendo: Ollama, Open WebUI, n8n, LiteLLM, Qdrant, Gitea.
Modelos descargando: qwen2.5:14b, qwen2.5:7b, llama3.1:8b, mistral:7b, bge-m3, nomic-embed-text.

Quiero investigar:
1. ¿Cuál es la mejor arquitectura para conectar n8n + LiteLLM + Ollama para agentes IA locales?
2. ¿Cómo crear Modelfiles en Ollama para personalidades específicas (asistente personal, agente OSINT)?
3. ¿Qué workflows de n8n tienen más valor inmediato para un sistema PKM (Telegram → Obsidian → Git)?
4. ¿Flowise o n8n para orquestar agentes con modelos locales?

Dame respuestas concretas con ejemplos de config/código, no teoría.
```

---

_Generado: 24 jun 2026 06:00 CEST por Perplexity vía MCP_
_Ver: [ESTADO-CIERRE-NOCHE.md](2026-06-24-ESTADO-CIERRE-NOCHE.md) · [contexto-manana.md](2026-06-24-contexto-manana.md)_
