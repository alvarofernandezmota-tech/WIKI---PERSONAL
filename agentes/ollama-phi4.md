---
tags: [agente, ia, llm, ollama, phi4, microsoft, local]
fecha-actualizacion: 2026-06-22
---

# 🧬 Phi-4 — Alta Densidad Lógica y Razonamiento Compacto Local

## Modelo y versión
- **Identificador:** phi4
- **Versión:** 14B — modelo de parámetros reducidos de última generación

## Empresa y lanzamiento
- **Desarrollador:** Microsoft Research
- **Licencia:** Abierta para uso comercial e investigación

## Arquitectura y entrenamiento
- **Tipo:** Modelo denso transformador de solo decodificador
- **Entrenamiento:** Masivamente basado en datos sintéticos altamente filtrados de calidad educativa premium ("textbooks"), libros académicos + DPO (Direct Preference Optimization)

## Ventana de contexto
- **Capacidad:** 16.000 tokens

## Modalidades
- **Entrada:** Texto, Estructuras lógicas escritas (optimizado principalmente para inglés)
- **Salida:** Texto técnico, bloques lógicos deductivos

## Herramientas nativas
- Adhesión estricta al formato de chat `<|im_start|>` / `<|im_end|>` para evitar degradación del hilo

## Modos especiales
- **Inferencia de Alta Densidad:** Máximo rendimiento lógico con mínimos parámetros — ideal para CPU locales y chips embebidos

## Benchmarks (junio 2026)
- **Reasoning and Logic Evals:** Supera ampliamente a modelos de su mismo tamaño de generaciones previas en tareas deductivas

## Mejor para
- Seguimiento estricto de reglas sintácticas
- Formateo estructurado preciso de datos intermedios
- Análisis lógico ágil con recursos físicos limitados

## Peor para (usar otra IA)
- Generación de contenido fluido en idiomas distintos al inglés — rendimiento decae notablemente
- Contexto largo >16K tokens

## Coste
- **Licencia:** Abierta — coste cero de despliegue local

## Privacidad y datos
- Operación local via Ollama — datos confinados en disco y memoria local

## Hardware y despliegue Ollama
- **RAM mínima:** 10-12 GB libres
- **Velocidad Acer (i5/8GB CPU):** ~1-2 tokens/s — ⚠️ Cerrar apps en segundo plano antes de ejecutar
- **Formato:** Q4_K_M

```bash
ollama pull phi4
ollama run phi4
```

---
_Ver también: [[agentes/ollama-gemma3]] · [[agentes/ollama-mistral-7b]] · [[agentes/ollama-deepseek-r1]]_
