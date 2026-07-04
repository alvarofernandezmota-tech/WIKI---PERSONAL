# OPERATIONAL PLAYBOOK — Yggdrasil-Dew

**Version:** 2.0  
**Fecha:** 2026-07-04  
**Autor:** Perplexity + Copilot  

---

## Reglas operativas (anti-ruido)

### Regla 1 — Bot Writes
Ningun workflow o agente puede commitear directamente en `main`.

- Crear rama `bot/<workflow>-<ts>`.
- Commit en esa rama.
- Abrir PR draft hacia main.
- **Revision humana obligatoria** antes del merge.

### Regla 2 — Inbox Conventions

| Carpeta | Tipo de archivo |
|---|---|
| `inbox/drop/` | Zona de aterrizaje — cualquier fichero nuevo entra aqui |
| `inbox/ocr/raw/` | Archivos binarios para OCR |
| `inbox/ocr/text/` | Textos OCR procesados (.txt) |
| `inbox/sesiones/` | Cierres de sesion `cierre-YYYYMMDD-*.md` |
| `inbox/context/perplexity/` | Respuestas Perplexity con `PERCENT_COMPLETE: XX%` |
| `inbox/context/obsidian/` | Notas exportadas desde Obsidian (ultimas 24h) |
| `inbox/_meta/` | Reportes de auditoria, clasificacion y meta-deep |

### Regla 3 — PII and Secrets

- Sanitizar prompts antes de enviar a cualquier LLM.
- CI ejecuta secret-scan en todos los PRs.
- Nunca subir `.env` real; usar exclusivamente `.env.template`.
- API keys solo en GitHub Secrets o variables de entorno locales.

### Regla 4 — File Size

- No subir archivos > 10 MB al repo.
- Binarios grandes → Git LFS o storage externo.

### Regla 5 — Agents Ownership

- Cada agente en `agentes/` debe tener: `DISEÑO.md`, `PROFILE.md`, `test.sh`.
- Owner registrado en `docs/OWNERS.md`.

### Regla 6 — Perplexity Monitoring

- Todos los prompts deben incluir `PERCENT_COMPLETE: XX%` en la respuesta esperada.
- `scripts/agentes/agente-meta-deep.sh` extrae el valor y abre issue automatico si < 70%.
- Reports en `reports/meta-deep/`.

### Regla 7 — Master Runner

- Punto de entrada unico: `scripts/maintenance/master_run.sh`.
- **Siempre dry-run primero**, luego `--apply` en produccion.
- Orden de ejecucion: estructura → informer → meta-deep → obsidian → smoke-tests.

### Regla 8 — Branch Naming

| Tipo | Patron |
|---|---|
| Feature | `feat/<descripcion>` |
| Fix | `fix/<descripcion>` |
| Maintenance | `maintenance/<descripcion>-<ts>` |
| Bot | `bot/<workflow>-<ts>` |
| Hotfix | `hotfix/<descripcion>` |

---

## Flujo sesion a sesion

```bash
# 1. Sincronizar
git pull origin main

# 2. Iniciar logger
source scripts/session-logger.sh

# 3. Trabajar normalmente
#    (edits, scripts, commits...)

# 4. Dry-run del master runner
bash scripts/maintenance/master_run.sh

# 5. Aplicar si todo es correcto
bash scripts/maintenance/master_run.sh --apply

# 6. Generar documento de cierre
bash scripts/session-terminal-doc.sh "descripcion breve de la sesion"

# 7. Pushear cierre
git add inbox/sesiones/cierre-*.md
git commit -m "docs(sesion): cierre $(date +%Y-%m-%d)"
git push origin main
```

---

## Estado del ecosistema (2026-07-04)

| Modulo | Estado | Completitud |
|---|---|---|
| Perplexity adapter | ✅ Activo | 100% |
| Agent informer | ✅ Activo | 100% |
| Agente meta-deep | ✅ Activo | 100% |
| Obsidian observer | ✅ Activo | 100% |
| Docker compose | ✅ Listo | 100% |
| Master runner | ✅ Activo | 100% |
| Smoke tests | ✅ Activo | 100% |
| CI workflows | ✅ Activo | 100% |
| Inbox clasificador | ✅ Activo | 100% |
| Session logger | ✅ Activo | 100% |
| Estructura carpetas | ✅ Conforme | 100% |
| MCP server | ⚠️ Pendiente auditoria | ~60% |
| Core modules | ⚠️ Pendiente auditoria | ~50% |
| Tests coverage | ⚠️ Pendiente auditoria | ~40% |
| Islas | ⚠️ Pendiente auditoria | ~30% |
| OSINT stack | ⚠️ Pendiente auditoria | ~30% |
| Ollama integration | ⚠️ Pendiente auditoria | ~20% |

---

## Proximos modulos a auditar

1. **`mcp/`** — server.py, requirements, endpoints, seguridad
2. **`core/`** — modulos y dependencias
3. **`agentes/`** — DISEÑO.md + PROFILE.md + test.sh por agente
4. **`tests/`** — cobertura actual vs objetivo
5. **`islas/`** — estado de cada isla
6. **`osint-stack/`** — stack y documentacion
7. **`ollama/`** — integracion con modelos locales
8. **`server.js`** — API Node.js: endpoints, seguridad, tests
