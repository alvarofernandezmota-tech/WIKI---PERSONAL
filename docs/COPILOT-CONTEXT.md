# COPILOT-CONTEXT.md — Yggdrasil Dew
> Actualizado: 2026-07-04 | Auditoría completa post-commit 93173615

Este fichero es el contexto principal para GitHub Copilot y cualquier agente LLM que trabaje sobre este repo.
**Léelo completo antes de tocar cualquier archivo.**

---

## Estado actual del ecosistema

### ✅ PRESENTE Y FUNCIONAL

#### `mcp/`
- `mcp/server.py` — MCP server Python
- `mcp/server.js` — MCP server Node.js
- `mcp/llm_adapters.py` — adaptadores LLM (OpenAI, Ollama, Perplexity)
- `mcp/llm-router.js` — router LLM JS
- `mcp/mcp_client.c` — cliente C MCP
- `mcp/requirements.txt` — dependencias Python
- `mcp/package.json` — dependencias Node
- `mcp/mcp-config.json` — configuración MCP
- `mcp/test-mcp.js` — tests MCP

#### `tools/`
- `tools/retrieval_api.py` — API retrieval (puerto 9001, sirve desde vector_index/)
- `tools/vector_index/.gitkeep` — carpeta de índice vectorial

#### `scripts/maintenance/`
- `scripts/maintenance/repo_audit_full.sh` — auditoría completa (11 secciones)

#### `scripts/agentes/agent-templates/`
- `scripts/agentes/agent-templates/PROFILE-TEMPLATE.md` — plantilla PROFILE agente
- `scripts/agentes/agent-templates/TEST-TEMPLATE.sh` — plantilla test agente

#### `.github/workflows/`
- `.github/workflows/secret-scan.yml` — CI scan de secretos

#### `inbox/`
- `inbox/ocr/raw/` — zona aterrizaje OCR
- `inbox/ocr/text/` — textos extraídos OCR
- `inbox/ocr/processed/` — OCR procesado
- `inbox/context/perplexity/` — contexto Perplexity
- `inbox/drop/` — zona de aterrizaje general
- `inbox/_meta/` — reportes de auditoría

#### Docs raíz
- `ECOSISTEMA.md`, `ECOSYSTEM-ARCHITECTURE.md`, `CONVENCIONES.md`
- `MAPA-ISLAS.md`, `ROADMAP-MASTER.md`, `ESTADO-SISTEMA.md`
- `COPILOT-CONTEXT.md` (este archivo)
- `AGENT.md`, `CONTEXT.md`, `HERRAMIENTAS-ECOSISTEMA.md`

---

### ❌ PENDIENTE — 5 CARPETAS PRIORITARIAS

Estas son las carpetas que **deben crearse con sus archivos**.
Copilot: implementa cada una respetando las convenciones de `CONVENCIONES.md`.

---

#### PENDIENTE 1: `scripts/ingest/`
```
scripts/ingest/
├── ocr-ingest.sh              # Lanza tesseract sobre inbox/ocr/raw/, guarda en inbox/ocr/text/
├── ocr-worker-loop.sh         # Loop daemon: vigila inbox/ocr/raw/ y llama ocr-ingest.sh
├── pdf-split.sh               # Divide PDFs en páginas individuales antes de OCR
└── ingest-status.sh           # Muestra cuántos archivos hay en raw/text/processed
```
**Convenciones:**
- `set -euo pipefail` en todos
- Log a `logs/ingest-YYYYMMDD.log`
- Al terminar cada archivo, moverlo de `raw/` a `processed/`
- Nunca modificar archivos fuera de `inbox/ocr/`

---

#### PENDIENTE 2: `scripts/agentes/`
```
scripts/agentes/
├── agente-meta-deep.sh        # Auditor meta: lee reports/, genera resumen, extrae PERCENT_COMPLETE
├── llm-router.sh              # Router bash: recibe PROMPT, sanitiza PII, llama mcp/llm-router.js
├── galatea-fabrica-agentes.sh # Fábrica: dado un nombre, genera carpeta agentes/<nombre>/ con PROFILE+test
├── galatea-create-pr.sh       # Crea PR draft en GitHub con los cambios pendientes
└── agente-health-check.sh     # Comprueba que MCP server, retrieval API y Ollama responden
```
**Convenciones:**
- `llm-router.sh` DEBE sanitizar: DNI/NIE (`[0-9]{8}[A-Z]`), SSN (`[0-9]{3}-[0-9]{2}-[0-9]{4}`), emails, teléfonos
- `galatea-create-pr.sh` usa `gh pr create --draft`
- `agente-meta-deep.sh` extrae `PERCENT_COMPLETE: XX%` y crea issue si <70%

---

#### PENDIENTE 3: `scripts/verify/`
```
scripts/verify/
├── run-smoke-tests.sh         # Ejecuta todos los test.sh en agentes/*/test.sh y reporta
├── check-structure.sh         # Valida que no haya archivos prohibidos en raíz ni carpetas vacías
├── validate-workflows.sh      # Parsea .github/workflows/*.yml y detecta git push directos
└── e2e-local.sh               # Simula el flujo completo: ingest → classify → index → retrieve
```
**Convenciones:**
- Salida: `reports/verify/smoke-YYYYMMDD-HHMMSS.md`
- Exit code 1 si algún test falla
- `validate-workflows.sh` usa `grep -E 'git push|git commit'` sobre workflows

---

#### PENDIENTE 4: `tools/`  (archivos que faltan)
```
tools/
├── vector_adapter.py          # Indexa texto en tools/vector_index/ como JSON {id, text, meta}
├── weaviate_adapter.py        # Adapter Weaviate (template, usa WEAVIATE_URL del .env)
├── prometheus_exporter.py     # Exporta métricas: archivos en inbox, índice size, last_ingest_ts
└── auth_gateway.py            # Middleware: valida Bearer token antes de servir retrieval_api
```
**Convenciones:**
- `vector_adapter.py`: guarda cada doc como `tools/vector_index/<hash_sha256>.json`
- `weaviate_adapter.py`: no debe conectar en import, solo en `connect()` explícito
- `prometheus_exporter.py`: puerto 9090, métricas `ygg_inbox_files_total`, `ygg_index_docs_total`
- `auth_gateway.py`: lee `AUTH_TOKEN` de env, 401 si falta o incorrecto

---

#### PENDIENTE 5: `.github/workflows/` (workflows que faltan)
```
.github/workflows/
├── e2e-full-flow.yml          # E2E: ingest mock → classify → index → retrieve query → assert
├── ci-agentes.yml             # CI: ejecuta scripts/verify/run-smoke-tests.sh en cada PR
├── session-close.yml          # Mueve inbox/sesiones/cierre-*.md a diarios/ al push
└── pause-noisy-workflows.sh   # (en scripts/maintenance/) pausa workflows escritores
```
**Convenciones:**
- Todos usan `ubuntu-latest`
- `e2e-full-flow.yml` y `ci-agentes.yml`: trigger en `push` a `main` y `pull_request`
- `session-close.yml`: trigger en `push` a `main`, solo si `inbox/sesiones/cierre-*.md` existe
- Ningún workflow hace `git push` directo a `main` sin PR

---

## Arquitectura de flujo (resumen)

```
terminal
  └─► inbox/drop/  ──► scripts/inbox-clasificador.sh
                            ├─► inbox/ocr/raw/  ──► scripts/ingest/ocr-ingest.sh
                            │                          └─► inbox/ocr/text/
                            │                                └─► tools/vector_adapter.py
                            │                                        └─► tools/vector_index/*.json
                            │                                                └─► tools/retrieval_api.py (9001)
                            ├─► inbox/context/perplexity/
                            └─► inbox/sesiones/  ──► diarios/ (via session-close.yml)
```

---

## Reglas que Copilot NUNCA debe romper

1. **No commitear a `main` directamente** desde scripts automáticos — siempre PR draft
2. **No subir secretos** — `.env` está en `.gitignore`; usar `.env.template`
3. **No archivos binarios >5MB** en el repo — usar referencias externas
4. **Toda salida de scripts** va a `logs/` o `reports/`, nunca a la raíz
5. **Sanitizar PII** en `llm-router.sh` antes de enviar al LLM externo
6. **`set -euo pipefail`** en todos los scripts bash

---

## Comandos de referencia rápida

```bash
# Auditoría completa
bash scripts/maintenance/repo_audit_full.sh

# Ver items faltantes
grep '\[MISSING\]' reports/audit/full-audit-*.md

# Aplicar templates a agentes sin PROFILE/test
for a in agentes/*/; do
  [ -f "${a}PROFILE.md" ] || cp scripts/agentes/agent-templates/PROFILE-TEMPLATE.md "${a}PROFILE.md"
  [ -f "${a}test.sh" ]    || cp scripts/agentes/agent-templates/TEST-TEMPLATE.sh "${a}test.sh"
done

# Arrancar retrieval API
python3 tools/retrieval_api.py &
curl 'http://localhost:9001/?q=sesion'

# Iniciar sesión
source scripts/session-logger.sh

# Cerrar sesión
bash scripts/session-terminal-doc.sh "descripción"
git add inbox/sesiones/ && git commit -m "docs(sesion): cierre" && git push
```
