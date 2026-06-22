---
tags: [agente, ia, llm, claude-sonnet-4.6]
fecha-actualizacion: 2026-06-22
---

# 🤖 Claude Sonnet 4.6 — Orquestador Principal de Desarrollo de Software Complejo

## Modelo y versión
- **Identificador:** claude-sonnet-4.6 (alias de actualización continua en la plataforma)
- **Versión:** Producción / Estable — Lanzamiento de optimización agéntica

## Empresa y lanzamiento
- **Desarrollador:** Anthropic
- **Fecha de lanzamiento:** 17 de febrero de 2026

## Arquitectura y entrenamiento
- **Tipo:** Modelo propietario transformador autorregresivo híbrido
- **Optimización:** Post-entrenamiento enfocado en autonomía agéntica, planificación de largo horizonte y mitigación avanzada de prompt injections
- **Alineamiento:** Constitutional AI (CAI) — conjunto de principios éticos que el modelo usa para auto-evaluarse

## Ventana de contexto
- **API Beta:** 1.000.000 tokens
- **Interfaz web claude.ai:** 200.000 tokens estándar
- **Límite de salida:** 8.192 tokens de generación

## Modalidades
- **Entrada:** Texto, Código, Imágenes (visión multimodal de alta densidad)
- **Salida:** Texto estructurado, código nativo, JSON/XML limpio

## Herramientas nativas
- **MCP (Model Context Protocol):** Soporte nativo para conectores que interactúan con entornos locales o SaaS externos
- **Search and Fetch:** Búsqueda web con auto-ejecución de código interno para filtrar ruido
- **Computer Use:** Control autónomo de escritorios e interfaces gráficas web mediante coordenadas espaciales

## Modos especiales
- **Adaptive Thinking:** Evalúa la dificultad técnica del prompt y determina dinámicamente los tokens de razonamiento interno
- **Extended Thinking:** Cadena de pensamiento explícita para problemas complejos
- **Interleaved thinking with tool calls:** Razonamiento intercalado con llamadas a herramientas

## Benchmarks (junio 2026)
- **OSWorld-Verified:** 72,5% — Liderazgo absoluto en interacción con sistemas operativos
- **SWE-bench:** 79,6% — Top en resolución de issues reales de código
- **Vending-Bench Arena:** Máximo rendimiento en consistencia estratégica multitarea

## Mejor para
- Refactorización y depuración de código en repositorios complejos (yggdrasil-dew)
- Orquestación de flujos autónomos y automatización agéntica via MCP
- Escritura y actualización de archivos directamente en GitHub
- Auditorías de repo, arquitectura, documentación técnica

## Peor para (usar otra IA)
- Consumo masivo de vídeo continuo nativo → usar Gemini
- Casos con limitaciones críticas de coste por volumen bruto de tokens
- Investigación de mercado o datos frescos → usar Grok

## Coste
- **API:** 3,00$/M tokens entrada | 15,00$/M tokens salida
- **claude.ai Pro:** ~20$/mes — incluido en suscripción personal
- **Free tier:** Disponible con límites diarios

## Privacidad y datos
- Anthropic **no entrena** con datos enviados via API comercial ni entornos Enterprise
- Constitutional AI: principios de honestidad, utilidad y evitar daños
- Informes de seguridad públicos disponibles en anthropic.com

## Integración en el ecosistema de Álvaro
- **Rol:** Agente principal — todo output final pasa por aquí porque tiene MCP GitHub
- **Protocolo:** Grok/Gemini investigan → Perplexity (Claude) valida y sube al repo

## Cómo arranco sesión
```
Lee AGENT.md y CONTEXT.md de yggdrasil-dew y dime el estado actual del ecosistema.
Repo: https://github.com/alvarofernandezmota-tech/yggdrasil-dew
```

---
_Ver también: [[agentes/grok]] · [[agentes/gemini]] · [[agentes/opencode]] · [[HOME]]_
