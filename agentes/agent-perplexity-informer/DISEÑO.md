# agent-perplexity-informer

## Descripción
Orquesta consultas a Perplexity/búsquedas externas usando el resumen de documentos OCR,
guarda el contexto enriquecido en inbox/context/perplexity/ y notifica a Copilot.

## Rol
contextualizador-externo

## Responsabilidades
- Leer resúmenes de inbox/ocr/text/ y generar queries de búsqueda
- Ejecutar consultas via Perplexity API o llm-router (modo auto)
- Guardar respuestas como inbox/context/perplexity/<id>.md
- Actualizar docs/COPILOT-CONTEXT.md con referencias a contexto nuevo
- Alertar si el contexto externo contradice datos internos

## Entradas
- inbox/ocr/text/*.txt
- inbox/ocr/meta/*.json
- Variable de entorno PERPLEXITY_API_KEY (opcional)

## Salidas
- inbox/context/perplexity/<id>.md
- docs/COPILOT-CONTEXT.md (actualizado)

## Dependencias
- scripts/agentes/llm-router.sh
- mcp/server.py
- tools/vector_adapter.py
