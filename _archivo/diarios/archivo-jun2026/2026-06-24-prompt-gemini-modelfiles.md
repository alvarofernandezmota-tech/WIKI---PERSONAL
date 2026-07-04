---
tags: [gemini, investigacion, prompt, modelfiles, especializacion, rag, lora]
fecha: 2026-06-24
estado: enviar-a-gemini
ruta-obsidian: inbox/2026-06-24-prompt-gemini-modelfiles.md
---

# Prompt para Gemini — Investigación profunda Modelfiles + especialización LLM

> Copia este prompt COMPLETO y pégalo en Gemini 2.0 Pro (contexto 1M tokens).
> Gemini devuelve el análisis completo — guardar resultado en `ollama/GUIA-ESPECIALIZACION.md`

---

## PROMPT COMPLETO — copiar desde aquí

```
Eres un experto en LLMs locales, Ollama, y optimización de modelos de lenguaje para hardware limitado.

CONTEXTO DEL SISTEMA:
- Servidor Madre: CPU-only (sin GPU), Arch Linux, Docker
- Ollama corriendo con: qwen2.5:3b (activo), qwen2.5:7b (descargando), bge-m3, nomic-embed-text
- Stack: Ollama + Qdrant + Open WebUI + n8n + thdora (bot Telegram Python)
- Objetivo: máxima especialización con mínimo consumo de RAM
- Repo de referencia: https://github.com/alvarofernandezmota-tech/yggdrasil-dew

NECESITO UNA INVESTIGACIÓN PROFUNDA sobre:

## 1. MODELFILES EN OLLAMA
- ¿Qué parámetros del Modelfile tienen más impacto en especialización?
- ¿Cómo hacer que qwen2.5:3b sea 10x mejor en una tarea específica solo con Modelfile?
- Parámetros clave: temperature, top_p, num_ctx, repeat_penalty, stop tokens
- ¿Qué diferencia hay entre FROM qwen2.5:3b y FROM qwen2.5:7b para tareas especializadas?
- Dame 4 Modelfiles completos y listos para usar:
  a) TOKI — asistente personal Telegram (contexto: diarios, tareas, estado sistema)
  b) CODIGO — experto Python/bash/Docker (contexto: repos del ecosistema)
  c) OSINT — analista investigación (contexto: metodología, herramientas)
  d) CEREBRO — procesador de notas (convierte texto crudo en markdown estructurado)

## 2. RAG vs MODELFILE vs FINE-TUNING
- ¿Cuándo usar cada técnica? Tabla comparativa con casos de uso reales
- Para un bot Telegram personal: ¿RAG o Modelfile especializado? ¿O los dos?
- ¿Cómo combinar Modelfile + RAG en Open WebUI para máxima efectividad?
- Coste computacional real de cada técnica en CPU-only

## 3. CONSUMO RAM EN OLLAMA CPU-ONLY
- Tabla de consumo RAM real por modelo: 3b / 7b / 14b / 72b
- ¿Cuántos modelos puede tener Madre cargados simultáneamente con 16GB RAM?
- Parámetro OLLAMA_MAX_LOADED_MODELS: óptimo para CPU-only
- ¿Cómo funciona el offloading automático de Ollama?
- Estrategia óptima: ¿un modelo 7b general o tres modelos 3b especializados?

## 4. FINE-TUNING LORA SIN GPU
- ¿Es posible hacer fine-tuning LoRA en CPU? ¿Tiempos reales?
- Alternativas: Google Colab free / AI Studio / Modal.com
- ¿Qué cantidad mínima de datos necesito para que un LoRA sea útil?
- Herramienta ai-toolkit (kohya): ¿compatible con qwen2.5?
- Pipeline completo: datos propios → LoRA → merge → Ollama Modelfile

## 5. FLUJO NOCTURNO AUTOMATIZADO
- Diseña un sistema donde:
  * Por la noche: n8n audita repos, genera resumen, hace commits
  * Al despertar: Telegram notifica resumen del ecosistema
  * El modelo CEREBRO procesa el inbox y sugiere migraciones
- ¿Qué workflows de n8n son prioritarios para esto?
- ¿Cómo conectar n8n → Ollama API → GitHub API en un workflow?

## 6. ESTRUCTURA ÓPTIMA DE MODELFILES EN EL REPO
```
ollama/
  Modelfile.toki
  Modelfile.codigo  
  Modelfile.osint
  Modelfile.cerebro
  GUIA-ESPECIALIZACION.md
  GUIA-SELECCION.md
```
¿Esta estructura es correcta? ¿Qué añadirías?

FORMATO DE RESPUESTA:
- Todo en markdown
- Modelfiles completos y listos para `ollama create nombre -f Modelfile.xxx`
- Tablas comparativas donde aplique
- Comandos bash ejecutables
- Sección final: «Plan de 7 días» paso a paso para implementar todo esto
- Guardar resultado en: ollama/GUIA-ESPECIALIZACION.md del repo yggdrasil-dew
```

---

## Cómo usar este prompt

1. Abre Gemini 2.0 Pro en `https://aistudio.google.com`
2. Selecciona modelo: `gemini-2.0-pro` (contexto 1M)
3. Pega el prompt completo de arriba
4. Cuando Gemini responda — guarda la respuesta como:
   `ollama/GUIA-ESPECIALIZACION.md` en yggdrasil-dew
5. Pide a Perplexity que lo suba al repo vía MCP

---

_Generado: 24 jun 2026 05:41 CEST_
