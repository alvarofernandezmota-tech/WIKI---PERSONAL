---
tags: [agente, ia, llm, ollama, codegemma, starcoder, local, codigo]
fecha-actualizacion: 2026-06-22
---

# 💻 CodeGemma & StarCoder2 — Especialistas en Autocompletado y Código Puro Local

## Modelo y versión
- **Identificadores:** codegemma / starcoder2
- **Versión:** Pesos abiertos dedicados a ingeniería de software

## Empresa y lanzamiento
- **CodeGemma:** Google
- **StarCoder2:** BigCode Project (ServiceNow + Hugging Face)
- **Licencia:** Abierta / BigCode OpenRAIL-M

## Arquitectura y entrenamiento
- **Tipo:** Modelos densos autorregresivos con tokenización orientada a sintaxis exacta de múltiples lenguajes
- **Datos:** Repositorios públicos de GitHub con licencias permisivas — +80 lenguajes de código
- **Fill-in-the-Middle (FIM):** Autocompletado insertando bloques en medio de archivo abierto

## Ventana de contexto
- **CodeGemma:** 8.000 tokens
- **StarCoder2:** 16.000 tokens

## Modalidades
- **Entrada:** Código, comentarios técnicos, texto plano
- **Salida:** Código autocompletado inline, funciones completas

## Herramientas nativas
- **Fill-in-the-Middle (FIM):** Autocompletado contextual — sabe qué hay arriba y abajo del cursor
- **Integración IDEs:** Extensiones para Neovim, VS Code, Helix

## Modos especiales
- **Generación Inline de Baja Latencia:** Optimizado para respuestas ultrarrápidas desde extensiones de editor

## Benchmarks (junio 2026)
- **HumanEval (Code Completion):** Excelente en predicción de bloques sintácticos complejos Python y bajo nivel

## Mejor para
- Motor de sugerencia inline y autocompletado en tiempo real en Arch Linux
- Alternativa privada local a GitHub Copilot
- Generación rápida de funciones y scripts sin enviar código a la nube

## Peor para (usar otra IA)
- Conversaciones generales o explicaciones conceptuales amplias
- Documentación de carácter no técnico

## Coste
- **Licencia:** Abierta — gratuita para desarrollo personal e industrial

## Privacidad y datos
- **Privacidad absoluta local:** Evita fuga de propiedad intelectual, tokens de acceso o contraseñas presentes en archivos de código

## Hardware y despliegue Ollama
- **RAM mínima (3B/7B):** 4-7 GB libres ✅ Funciona en Acer
- **Velocidad Acer (i5/8GB, variante 3B/7B):** ~3-6 tokens/s — suficiente para sugerencias de código

```bash
# CodeGemma
ollama pull codegemma
ollama run codegemma

# StarCoder2
ollama pull starcoder2
ollama run starcoder2
```

---
_Ver también: [[agentes/ollama-gemma3]] · [[agentes/ollama-deepseek-r1]] · [[agentes/opencode]]_
