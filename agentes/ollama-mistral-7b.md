---
tags: [agente, ia, llm, ollama, mistral, local, ligero]
fecha-actualizacion: 2026-06-22
---

# ⛵ Mistral 7B & Mixtral Local — Inferencia Ágil y Ligera

## Modelo y versión
- **Identificador:** mistral:7b / mixtral:8x7b
- **Versión:** Estables de pesos abiertos / Optimizados para instrucciones

## Empresa y lanzamiento
- **Desarrollador:** Mistral AI
- **Licencia:** Apache 2.0

## Arquitectura y entrenamiento
- **mistral:7b:** Modelo denso compacto de alta eficiencia
- **mixtral:8x7b:** Mixture of Experts (MoE) — activa solo fracción de parámetros por token

## Ventana de contexto
- **Capacidad:** 32.000 tokens

## Modalidades
- **Entrada:** Texto, Código
- **Salida:** Texto fluido, secuencias de comandos

## Benchmarks (junio 2026)
- **Efficiency Arena:** Mejor relación velocidad/precisión para modelos locales <10B

## Mejor para
- Redacción rápida de notas técnicas
- Asistencia inline ágil en configuraciones de terminal
- Automatizaciones de scripts ligeros
- Uso interactivo diario en hardware portátil (Acer)

## Peor para (usar otra IA)
- Razonamiento matemático complejo de alta abstracción
- Análisis masivo multicapa de datos científicos
- Contexto largo >32K tokens

## Coste
- **Software:** Gratuito (Apache 2.0)

## Privacidad y datos
- Procesamiento local sin telemetría externa obligatoria

## Hardware y despliegue Ollama

### Mistral 7B (recomendado Acer)
- **RAM mínima:** 6 GB libres ✅ Funciona en Acer
- **Velocidad Acer (i5/8GB CPU):** ~3-5 tokens/s — fluido y usable en consola
- **Formato:** Q4_K_M

### Mixtral 8x7B (solo Madre)
- **RAM mínima:** 26-30 GB
- **Velocidad:** Depende de GPU Madre

```bash
# Acer
ollama pull mistral:7b
ollama run mistral:7b

# Madre
ollama pull mixtral:8x7b
ollama run mixtral:8x7b
```

---
_Ver también: [[agentes/ollama-gemma3]] · [[agentes/ollama-deepseek-r1]] · [[agentes/ollama-phi4]]_
