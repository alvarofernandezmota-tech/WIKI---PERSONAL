# agent-ocr-auditor

## Descripción
Audita documentos procesados por el pipeline OCR: valida calidad del texto extraído,
detecta anomalías y genera reportes estructurados para Copilot.

## Rol
auditor-ocr

## Responsabilidades
- Verificar que inbox/ocr/text/*.txt tengan contenido válido (no vacíos, no solo ruido)
- Extraer metadatos clave: fecha, autor, tipo de documento
- Indexar en vector DB via tools/vector_adapter.py
- Generar reporte en reports/agent-ocr-auditor/
- Notificar a Copilot si hay documentos con baja calidad OCR (<50 palabras)

## Entradas
- inbox/ocr/text/*.txt
- inbox/ocr/meta/*.json

## Salidas
- reports/agent-ocr-auditor/audit-TIMESTAMP.md
- tools/vector_index/*.json

## Dependencias
- scripts/ingest/ocr-ingest.sh
- tools/vector_adapter.py
- mcp/server.py (herramienta: agent_meta_deep)
