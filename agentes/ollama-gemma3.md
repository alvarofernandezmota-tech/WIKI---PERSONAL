---
tags: [agente, ia, llm, ollama, gemma, google, local, multimodal]
fecha-actualizacion: 2026-06-22
---

# 💎 Gemma 3 — Asistente Local Multimodal Moderno de Alta Velocidad

## Modelo y versión
- **Identificador:** gemma3 (tamaños: 1B, 4B, 12B, 27B)
- **Versión:** Pesos abiertos / Última generación agéntica portátil

## Empresa y lanzamiento
- **Desarrollador:** Google (Open Models Team)
- **Licencia:** Gemma Terms of Use (uso comercial permitido)

## Arquitectura y entrenamiento
- **Tipo:** Modelos ligeros construidos compartiendo base de investigación y datos de la línea Gemini
- **Ventana nativa:** 128.000 tokens — expansión masiva vs generaciones previas

## Ventana de contexto
- **Capacidad:** 128.000 tokens

## Modalidades
- **Entrada:** Texto, Código, Imágenes, fragmentos de vídeo corto (visión nativa)
- **Salida:** Texto estructurado, automatizaciones

## Herramientas nativas
- **Function Calling:** Soporte nativo para llamadas a funciones externas
- **Structured Output:** Estructuración rígida de salidas formales de datos
- **Optimización Edge:** Versiones oficiales para baja latencia en portátiles y GPUs integradas

## Benchmarks (junio 2026)
- **Chatbot Arena Elo:** Liderazgo en categoría de modelos ejecutables en local en un único nodo

## Mejor para
- Análisis visual local ágil (con capacidad de visión)
- Asistentes conversacionales de alta velocidad en movilidad (Acer)
- Prototipado rápido de agentes offline
- Flujos que requieran ventana de contexto amplia local sin sobrecargar RAM

## Peor para (usar otra IA)
- Tareas empresariales que requieran cruce masivo de bases de datos globales en tiempo real
- Razonamiento matemático muy complejo

## Coste
- **Licencia:** Abierta — coste cero de ejecución local

## Privacidad y datos
- Procesamiento 100% local — sin telemetría hacia servidores remotos durante inferencia

## Hardware y despliegue Ollama

### Gemma 3 4B — ⭐ Recomendada para Acer
- **RAM mínima:** 3-4 GB libres ✅ Perfecta para Acer
- **Velocidad Acer (i5/8GB CPU):** ~6-10 tokens/s — rápida y fluida para uso diario

### Gemma 3 12B — Madre
- **RAM mínima:** 9-10 GB

### Gemma 3 27B — Solo Madre con GPU
- **RAM mínima:** 18-20 GB

```bash
# Acer — variante recomendada
ollama pull gemma3:4b
ollama run gemma3:4b

# Madre
ollama pull gemma3:12b
ollama run gemma3:12b
```

---
_Ver también: [[agentes/ollama-mistral-7b]] · [[agentes/ollama-deepseek-r1]] · [[agentes/ollama-phi4]]_
