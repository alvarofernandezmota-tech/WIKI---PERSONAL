# agent-perplexity-informer — Diseño

## Propósito
Leer textos OCR de `inbox/ocr/text/`, enviarlos a Perplexity vía `tools/perplexity_adapter.py`
y escribir respuestas estructuradas con `PERCENT_COMPLETE` en `inbox/context/perplexity/`.

## Flujo de datos
```
inbox/ocr/text/*.txt
  └─► [prompt builder]
        └─► tools/perplexity_adapter.py
              └─► PERPLEXITY_URL (HTTP POST)
                    └─► inbox/context/perplexity/<id>.md
                          └─► agente-meta-deep.sh (extrae PERCENT_COMPLETE)
```

## Variables de entorno
| Variable | Requerida | Default | Descripción |
|---|---|---|---|
| `PERPLEXITY_URL` | Sí | — | URL del endpoint Perplexity |
| `PERPLEXITY_API_KEY` | No | — | Bearer token |
| `PERPLEXITY_TIMEOUT` | No | 30 | Timeout en segundos |
| `YGGDRASIL_ROOT` | No | `$(pwd)` | Raíz del repo |

## Outputs
- `inbox/context/perplexity/<id>.md` — respuesta + metadatos + PERCENT_COMPLETE
- `inbox/context/perplexity/<id>.prompt.txt` — prompt exacto enviado (para debugging)

## Error handling
- Si `PERPLEXITY_URL` no está set → escribe `{"error":"PERPLEXITY_URL not set"}` en el `.md`
- Si el archivo de entrada no existe → skip silencioso
- Nunca falla con código de error distinto de 0 (pipeline seguro)
