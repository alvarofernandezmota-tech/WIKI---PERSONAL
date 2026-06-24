# Alternativas a Ollama — LLM self-hosted

> Ollama es la elección actual. Aquí hay alternativas por si escala o cambia el hardware.
> Actualizado: 24 jun 2026

---

## Por qué Ollama ahora

- Setup más rápido (1 comando)
- API OpenAI-compatible
- Integra con Open WebUI sin config extra
- Funciona bien en CPU (i5-8400 de Madre)
- Comunidad grande, muchos modelos pre-cuantizados

---

## Alternativas reales (junio 2026)

| Herramienta | Tipo | Mejor para | URL |
|---|---|---|---|
| **LocalAI** | Servidor API | OpenAI-compatible, más flexible que Ollama | github.com/mudler/LocalAI |
| **LM Studio** | Desktop + API | Explorar modelos, interfaz visual | lmstudio.ai |
| **TabbyAPI** | Servidor GPU | Cuando Madre tenga RTX — exl2, muy eficiente | github.com/theroyallab/tabbyAPI |
| **Aphrodite Engine** | Servidor GPU | Múltiples usuarios paralelos, todas las cuantizaciones | github.com/PygmalionAI/Aphrodite-engine |
| **llama.cpp** | Binario directo | Control total, sin abstracción, CPU+GPU | github.com/ggerganov/llama.cpp |
| **GPT4All** | Desktop | Sin servidor, todo local en el PC | gpt4all.io |
| **AnythingLLM** | Workspace completo | Reemplaza Ollama+LangChain+RAG+UI en uno | github.com/Mintplex-Labs/anything-llm |
| **Jan** | Desktop + servidor | GUI limpia + API server local | jan.ai |
| **Dify** | Plataforma agentes | n8n para IA — workflows de agentes visuales | dify.ai |

---

## Cuándo migrar de Ollama

| Situación | Alternativa recomendada |
|---|---|
| Madre tiene RTX 3060 | TabbyAPI — exl2 mucho más eficiente en VRAM |
| Quieres todo en uno (RAG + chat + agentes) | AnythingLLM |
| Necesitas más control sobre cuantización | llama.cpp directo |
| Quieres workflows visuales de agentes IA | Dify (como n8n pero para IA) |
| Múltiples usuarios en Madre | Aphrodite Engine |

---

## AnythingLLM — vale la pena investigar

Reemplaza: Ollama + LangChain + Qdrant + Open WebUI en un solo contenedor.
- RAG automático con citas de fichero
- Agente con búsqueda web sin código
- Completamente privado y self-hosted
- Docker: `docker pull mintplexlabs/anythingllm`

Pendiente: evaluar si merece reemplazar el stack actual en Fase 5.

---

## Modelos recomendados por VRAM (sin GPU ahora)

| VRAM disponible | Modelo recomendado |
|---|---|
| Solo CPU (ahora) | qwen2.5:3b, qwen2.5:7b Q4 |
| 6GB GPU | llama3.1:8b o qwen2.5:7b |
| 12GB GPU (RTX 3060) | qwen2.5:14b — el rey de su tamaño |
| 24GB GPU | Command-R 35B, qwen2.5:32b |

---
_Ver: [ROADMAP.md](../../ROADMAP.md) · [ESTADO-SISTEMA.md](../../ESTADO-SISTEMA.md) · [estructura-madre.md](../estructura-madre.md)_
