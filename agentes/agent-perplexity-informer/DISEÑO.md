# DISEÑO — agent-perplexity-informer

## Proposito
Leer archivos de texto OCR desde `inbox/ocr/text/`, enviarlos a la API de Perplexity usando el adaptador, y generar documentos `.md` en `inbox/context/perplexity/` con el analisis y el valor `PERCENT_COMPLETE`.

## Entradas
- `inbox/ocr/text/*.txt` — textos OCR procesados
- `inbox/context/perplexity/PERPLEXITY_PROMPT_TEMPLATE.txt` — plantilla de prompt

## Salidas
- `inbox/context/perplexity/<id>.md` — analisis Perplexity con PERCENT_COMPLETE
- `inbox/context/perplexity/<id>.prompt.txt` — prompt generado (para debug)

## Variables de entorno requeridas
| Variable | Descripcion |
|---|---|
| `PERPLEXITY_URL` | URL del endpoint de la API |
| `PERPLEXITY_API_KEY` | Token de autenticacion |
| `YGGDRASIL_ROOT` | Raiz del repositorio (por defecto `pwd`) |

## Ejecucion
```bash
YGGDRASIL_ROOT=/ruta/repo bash agentes/agent-perplexity-informer/run.sh
```

## Owner
@alvarofernandezmota-tech
