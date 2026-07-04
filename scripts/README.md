# scripts/ — README

> **Regla:** Este directorio contiene SOLO scripts ejecutables (`.sh`) y herramientas.  
> Ningun archivo `.md` de sesion o diario debe vivir aqui.

---

## Scripts principales

| Script | Proposito | Uso |
|---|---|---|
| `scripts/maintenance/master_run.sh` | Terminal madre — punto de entrada unico | `bash scripts/maintenance/master_run.sh [--apply]` |
| `scripts/maintenance/create_perplexity_patch.sh` | Crea todos los ficheros del ecosistema Perplexity | `bash scripts/maintenance/create_perplexity_patch.sh [--apply]` |
| `scripts/verify/run-smoke-tests.sh` | Comprueba que todos los ficheros clave existen | `bash scripts/verify/run-smoke-tests.sh` |
| `scripts/agentes/agente-meta-deep.sh` | Extrae PERCENT_COMPLETE y abre issue si < 70% | `bash scripts/agentes/agente-meta-deep.sh` |
| `scripts/observador-obsidian.sh` | Exporta notas Obsidian modificadas en 24h | `bash scripts/observador-obsidian.sh` |
| `scripts/inbox-commit.sh` | Commitea archivos de `inbox/drop/` | `bash scripts/inbox-commit.sh "descripcion"` |
| `scripts/inbox-clasificador.sh` | Clasifica `inbox/drop/` a destinos correctos | `bash scripts/inbox-clasificador.sh [--dry-run]` |
| `scripts/session-logger.sh` | Logger de sesion de terminal | `source scripts/session-logger.sh` |
| `scripts/session-terminal-doc.sh` | Genera documento de cierre de sesion | `bash scripts/session-terminal-doc.sh "descripcion"` |

---

## Flujo rapido sesion

```bash
# 1. Inicio
git pull origin main
source scripts/session-logger.sh

# 2. Ver que haria el ecosistema (siempre primero)
bash scripts/maintenance/master_run.sh

# 3. Ejecutar
bash scripts/maintenance/master_run.sh --apply

# 4. Cierre
bash scripts/session-terminal-doc.sh "resumen de la sesion"
git add inbox/sesiones/cierre-*.md
git commit -m "docs(sesion): cierre $(date +%Y-%m-%d)"
git push origin main
```

---

## Variables de entorno relevantes

| Variable | Descripcion | Requerida para |
|---|---|---|
| `YGGDRASIL_ROOT` | Raiz del repositorio | Todos los scripts |
| `PERPLEXITY_URL` | URL endpoint Perplexity | agent-informer, adapter |
| `PERPLEXITY_API_KEY` | Token API Perplexity | agent-informer, adapter |
| `OBSIDIAN_VAULT` | Ruta al vault de Obsidian | observador-obsidian |
| `GITHUB_REMOTE` | Remote de git (default: origin) | create_perplexity_patch |
