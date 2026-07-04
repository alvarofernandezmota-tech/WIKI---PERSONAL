# OPERATIONAL PLAYBOOK — Yggdrasil-Dew

> Versión: 2.0 — 2026-07-04  
> Autor: Perplexity + @alvarofernandezmota-tech

---

## Regla 1 — Bot Writes (Anti-ruido)
Ningún workflow o agente puede commitear directamente en `main`.  
Si necesita escribir:
1. Crear rama `bot/<workflow>-<ts>`.
2. Commit en esa rama.
3. Abrir PR draft hacia `main`.
4. **Revisión humana obligatoria** antes de mergear.

## Regla 2 — Inbox Conventions
| Carpeta | Contenido |
|---|---|
| `inbox/drop/` | Zona de aterrizaje — archivos nuevos del operador |
| `inbox/ocr/raw/` | Archivos binarios para OCR |
| `inbox/ocr/text/` | Textos extraídos por OCR |
| `inbox/sesiones/` | Cierres de sesión `cierre-YYYYMMDD-*.md` |
| `inbox/context/perplexity/` | Respuestas Perplexity con `PERCENT_COMPLETE: XX%` |
| `inbox/context/obsidian/` | Exports del vault de Obsidian |
| `inbox/_meta/` | Reportes de auditoría automáticos |

## Regla 3 — PII y Secrets
- Sanitizar prompts antes de enviar a LLMs externos.
- CI ejecuta secret-scan en todos los PRs.
- Nunca incluir API keys en el código — usar `.env` (en `.gitignore`) o GitHub Secrets.

## Regla 4 — Tamaño de archivos
- No subir archivos > 10 MB al repo.
- Binarios grandes → `inbox/ocr/raw/` y documentados en `.gitignore` si son temporales.

## Regla 5 — Ownership de agentes
Cada agente en `agentes/` debe tener:
- `DISEÑO.md` — arquitectura y flujo.
- `PROFILE.md` — metadatos y owner.
- `test.sh` — smoke test propio.
- Owner declarado en `docs/OWNERS.md`.

## Regla 6 — Monitoreo Perplexity
- Prompts DEBEN incluir `PERCENT_COMPLETE: XX%` en la respuesta solicitada.
- `agente-meta-deep.sh` extrae el valor y abre issue automático si < 70%.
- Revisar `reports/meta-deep/` después de cada run.

## Regla 7 — Sesiones de trabajo
Flujo obligatorio:
```bash
git pull origin main
source scripts/session-logger.sh          # iniciar logging
# ... trabajo ...
bash scripts/session-terminal-doc.sh "descripción de la sesión"
git add inbox/sesiones/cierre-*.md
git commit -m "docs(sesion): cierre YYYY-MM-DD — descripción"
git push origin main
```

## Regla 8 — Terminal Madre
`scripts/maintenance/master_run.sh` es el punto de entrada único.  
Siempre correr dry-run primero:
```bash
bash scripts/maintenance/master_run.sh           # dry-run — ver qué haría
bash scripts/maintenance/master_run.sh --apply   # ejecutar de verdad
```
