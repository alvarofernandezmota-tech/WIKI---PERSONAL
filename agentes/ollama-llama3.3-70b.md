---
tags: [agente, ia, llm, ollama, llama, local]
fecha-actualizacion: 2026-06-22
---

# 🦙 Llama 3.3 70B — El Caballo de Batalla Local para Automatización General

## Modelo y versión
- **Identificador:** llama3.3:70b
- **Versión:** Pesos abiertos optimizados para instrucciones (instruct)

## Empresa y lanzamiento
- **Desarrollador:** Meta AI
- **Licencia:** Llama 3.3 Community License (open weights)

## Arquitectura y entrenamiento
- **Tipo:** Transformador denso de solo decodificador
- **Parámetros:** 70.000 millones — cuantización Q4_K_M para despliegues locales
- **Alineamiento:** RLHF avanzado — alta resistencia a desviaciones instruccionales

## Ventana de contexto
- **Capacidad:** 128.000 tokens

## Modalidades
- **Entrada:** Texto, Código
- **Salida:** Texto, Código

## Herramientas nativas
- Soporte nativo para integración de herramientas locales via formateo estructurado en Ollama

## Benchmarks (junio 2026)
- **MMLU / GSM8K:** Rendimiento equivalente a modelos propietarios de generación anterior
- Cima de la eficiencia local para hardware de nivel entusiasta

## Mejor para
- Automatización de administración de sistemas locales
- Procesamiento offline de textos confidenciales
- Análisis sintáctico de logs
- Desarrollo general en servidores dedicados (Madre)

## Peor para (usar otra IA)
- Inferencia en portátiles con <32GB RAM → usar Gemma 3 o DeepSeek-R1:8b
- Tareas que requieran acceso a internet o datos frescos

## Coste
- **Software:** Gratuito (Open Source Llama 3.3)
- **Hardware:** Consumo eléctrico local

## Privacidad y datos
- **Privacidad absoluta:** Datos no salen del entorno local bajo ninguna circunstancia

## Hardware y despliegue Ollama
- **RAM/VRAM mínima:** 40 GB combinados para Q4_K_M
- **Velocidad en Acer (i5/8GB CPU):** ⚠️ Inviable (<0,2 tokens/s) — usar solo en Madre
- **Velocidad en Madre (con GPU):** Depende de VRAM disponible
- **Formato recomendado:** Q4_K_M

```bash
# Instalar
ollama pull llama3.3:70b

# Ejecutar
ollama run llama3.3:70b
```

> ⚠️ No intentar correr en el Acer. Solo para Madre con soporte GPU o RAM suficiente.

---
_Ver también: [[agentes/ollama-gemma3]] · [[agentes/ollama-deepseek-r1]] · [[agentes/ollama-mistral-7b]]_
