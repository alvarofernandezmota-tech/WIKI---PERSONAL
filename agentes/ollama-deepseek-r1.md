---
tags: [agente, ia, llm, ollama, deepseek, local, razonamiento]
fecha-actualizacion: 2026-06-22
---

# 🐋 DeepSeek-R1 & V4 — Razonamiento por Cadena de Pensamiento Abierta

## Modelo y versión
- **Identificador:** deepseek-r1 (variantes 8B-32B para local) / deepseek-v4 en API
- **Versión:** Estable — línea R1 consolidada, V4 lanzado 24 abril 2026

## Empresa y lanzamiento
- **Desarrollador:** DeepSeek (Laboratorio de IA)
- **Licencia:** MIT (open source)

## Arquitectura y entrenamiento
- **Tipo cloud (671B):** Mixture of Experts (MoE) — 671B totales, 37B activos
- **Tipo local:** Variantes densas destiladas basadas en arquitecturas Qwen y Llama
- **Entrenamiento:** RL puro a gran escala (GRPO) con auto-verificación lógica intermedia
- **Output especial:** Cadena de pensamiento explícita `<think>...</think>` antes de la respuesta

## Ventana de contexto
- **Capacidad:** 128.000 tokens

## Modalidades
- **Entrada:** Texto, Datos estructurados, Código
- **Salida:** `<think>` (razonamiento visible) + respuesta final estructurada

## Benchmarks (junio 2026)
- **Math & Code:** Extremadamente competitivo vs soluciones propietarias occidentales
- **Coste/rendimiento:** ~18x más económico que alternativas cloud equivalentes via API

## Mejor para
- Deducción lógica pura y auditorías de seguridad paso a paso
- Resolución de problemas algorítmicos intrincados
- Depuración asistida local con razonamiento visible

## Peor para (usar otra IA)
- Respuestas instantáneas de baja latencia — el modelo "piensa" antes de responder
- Conversaciones simples sin necesidad de razonamiento profundo

## Coste
- **API Cloud:** ~0,55$/M tokens entrada | ~2,19$/M tokens salida
- **Local:** Gratuito (MIT)

## Privacidad y datos
- **Local:** Privacidad absoluta — logs y trazas de pensamiento 100% en tu máquina
- **API:** Datos procesados en servidores DeepSeek (China)

## Hardware y despliegue Ollama

### Variante recomendada Acer: DeepSeek-R1-Distill 8B
- **RAM mínima:** 6-8 GB libres ✅ Funciona en Acer
- **Velocidad Acer (i5/8GB CPU):** ~2-4 tokens/s — funcional para uso pausado interactivo

### Variante Madre: 32B
- **RAM mínima:** 22-24 GB libres
- **Velocidad:** Depende de GPU/RAM de Madre

```bash
# Variante Acer (recomendada)
ollama pull deepseek-r1:8b
ollama run deepseek-r1:8b

# Variante Madre
ollama pull deepseek-r1:32b
ollama run deepseek-r1:32b
```

---
_Ver también: [[agentes/ollama-mistral-7b]] · [[agentes/ollama-gemma3]] · [[agentes/ollama-phi4]]_
