# SCRIPTS-AUDITORIA

**Fecha ultima actualizacion:** 2026-07-04T20:57:00Z  
**Autor:** Perplexity / Operaciones  

---

## Parche Perplexity Full (20260704) — COMPLETADO

### Ficheros creados/actualizados

| Fichero | Proposito | Estado |
|---|---|---|
| `tools/perplexity_adapter.py` | Cliente HTTP Perplexity | ✅ |
| `agentes/agent-perplexity-informer/run.sh` | Agente Perplexity | ✅ |
| `agentes/agent-perplexity-informer/DISEÑO.md` | Documentacion agente | ✅ |
| `agentes/agent-perplexity-informer/PROFILE.md` | Perfil agente | ✅ |
| `agentes/agent-perplexity-informer/test.sh` | Tests agente | ✅ |
| `inbox/context/perplexity/PERPLEXITY_PROMPT_TEMPLATE.txt` | Plantilla prompt | ✅ |
| `inbox/drop/.gitkeep` | Zona aterrizaje | ✅ |
| `scripts/agentes/agente-meta-deep.sh` | Extrae PERCENT_COMPLETE | ✅ |
| `scripts/observador-obsidian.sh` | Observer Obsidian | ✅ |
| `docker/mcp/Dockerfile` | Docker MCP | ✅ |
| `docker/retrieval/Dockerfile` | Docker retrieval | ✅ |
| `docker/docker-compose.yml` | Compose orquestacion | ✅ |
| `scripts/maintenance/master_run.sh` | Terminal madre | ✅ |
| `scripts/maintenance/create_perplexity_patch.sh` | Script maestro | ✅ |
| `scripts/verify/run-smoke-tests.sh` | Smoke tests | ✅ |
| `.github/workflows/ci-readonly.yml` | CI readonly | ✅ |
| `.github/workflows/bot-writer-template.yml` | Bot writer template | ✅ |
| `docs/OPERATIONAL-PLAYBOOK.md` | Playbook v2.0 | ✅ |
| `docs/OWNERS.md` | Ownership | ✅ |
| `docs/AUDIT-LOG.md` | Audit log | ✅ |
| `scripts/README.md` | README scripts | ✅ |
| `scripts/SCRIPTS-AUDITORIA.md` | Este fichero | ✅ |

---

## Modulos PENDIENTES — siguiente bloque de auditoria

### BLOQUE A — Alta prioridad

- [ ] **`mcp/`**
  - Revisar `mcp/server.py`: endpoints, autenticacion, manejo de errores
  - Verificar `mcp/requirements.txt`: dependencias actualizadas, sin vulnerabilidades
  - Crear `mcp/DISEÑO.md` si no existe
  - Comprobar que el Dockerfile de `docker/mcp/` referencia correctamente los ficheros

- [ ] **`agentes/` — completar documentacion por agente**
  - Para cada agente existente: comprobar DISEÑO.md + PROFILE.md + test.sh
  - Listar agentes sin documentacion completa y crearla

### BLOQUE B — Media prioridad

- [ ] **`core/`** — revisar modulos, imports, dependencias circulares
- [ ] **`tests/`** — cobertura actual, tests faltantes, integracion con CI
- [ ] **`server.js`** — endpoints Node.js, seguridad, autenticacion

### BLOQUE C — Normal

- [ ] **`islas/`** — estado de cada isla, documentacion, conexiones
- [ ] **`osint-stack/`** — herramientas, pipeline, documentacion
- [ ] **`ollama/`** — modelos configurados, integracion con agentes
- [ ] **`infra/`** — IaC, despliegue, secretos en produccion

---

## Comandos rapidos de verificacion

```bash
# Ver estado del ecosistema
bash scripts/verify/run-smoke-tests.sh

# Dry-run del master runner
bash scripts/maintenance/master_run.sh

# Ver estructura de carpetas criticas
tree inbox/ -L 3
tree agentes/ -L 3
tree scripts/ -L 3
```
