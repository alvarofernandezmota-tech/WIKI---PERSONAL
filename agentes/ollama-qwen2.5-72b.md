---
tags: [agente, ia, llm, ollama, qwen, local]
fecha-actualizacion: 2026-06-22
---

# 🇨🇳 Qwen 2.5 72B — Razonamiento Técnico Local Avanzado y Soporte de Código Pesado

## Modelo y versión
- **Identificador:** qwen2.5:72b
- **Versión:** Instruct / Pesos Abiertos

## Empresa y lanzamiento
- **Desarrollador:** Alibaba Cloud
- **Licencia:** Apache 2.0

## Arquitectura y entrenamiento
- **Tipo:** Transformador denso de solo decodificador con tokenización optimizada de alta densidad para código
- **Parámetros:** 72.000 millones
- **Especialización:** Python, SQL, automatización industrial

## Ventana de contexto
- **Capacidad:** 128.000 tokens

## Modalidades
- **Entrada:** Texto, Código técnico avanzado
- **Salida:** Texto, Scripts limpios estructurados

## Benchmarks (junio 2026)
- **HumanEval:** Excepcionalmente alto para modelo abierto — compite con alternativas cloud comerciales

## Mejor para
- Generación local offline de scripts Python complejos
- Consultas avanzadas SQL relacional
- Automatización estructurada sobre Docker u orquestadores locales

## Peor para (usar otra IA)
- Hardware con <42GB RAM libre → usar variantes más pequeñas
- Tareas de análisis de imágenes o vídeo

## Coste
- **Licencia:** Apache 2.0 — coste cero

## Privacidad y datos
- **Privacidad absoluta:** Ejecución local aislada de WAN durante inferencia

## Hardware y despliegue Ollama
- **RAM/VRAM mínima:** 42-48 GB libres para Q4 sin caídas de rendimiento
- **Velocidad en Acer (i5/8GB):** ⚠️ Inviable — OOM instantáneo
- **Formato recomendado:** Q4_K_M

```bash
ollama pull qwen2.5:72b
ollama run qwen2.5:72b
```

---
_Ver también: [[agentes/ollama-llama3.3-70b]] · [[agentes/ollama-deepseek-r1]]_
