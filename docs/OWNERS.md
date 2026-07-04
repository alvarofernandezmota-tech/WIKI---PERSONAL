# OWNERS — Yggdrasil-Dew

**Ultima actualizacion:** 2026-07-04  

---

## Propietarios por modulo

| Modulo | Owner | Backup | Estado |
|---|---|---|---|
| `tools/perplexity_adapter.py` | @alvarofernandezmota-tech | — | ✅ Activo |
| `agentes/agent-perplexity-informer/` | @alvarofernandezmota-tech | — | ✅ Activo |
| `scripts/agentes/agente-meta-deep.sh` | @alvarofernandezmota-tech | — | ✅ Activo |
| `scripts/observador-obsidian.sh` | @alvarofernandezmota-tech | — | ✅ Activo |
| `docker/` | @alvarofernandezmota-tech | — | ✅ Listo |
| `scripts/maintenance/master_run.sh` | @alvarofernandezmota-tech | — | ✅ Activo |
| `scripts/verify/run-smoke-tests.sh` | @alvarofernandezmota-tech | — | ✅ Activo |
| `.github/workflows/` | @alvarofernandezmota-tech | — | ✅ Activo |
| `inbox/` | @alvarofernandezmota-tech | — | ✅ Activo |
| `diarios/` | @alvarofernandezmota-tech | — | ✅ Activo |
| `mcp/` | @alvarofernandezmota-tech | — | ⚠️ Pendiente auditoria |
| `core/` | @alvarofernandezmota-tech | — | ⚠️ Pendiente auditoria |
| `tests/` | @alvarofernandezmota-tech | — | ⚠️ Pendiente auditoria |
| `islas/` | @alvarofernandezmota-tech | — | ⚠️ Pendiente auditoria |
| `osint-stack/` | @alvarofernandezmota-tech | — | ⚠️ Pendiente auditoria |
| `ollama/` | @alvarofernandezmota-tech | — | ⚠️ Pendiente auditoria |
| `server.js` | @alvarofernandezmota-tech | — | ⚠️ Pendiente auditoria |

---

## Regla de ownership de agentes
Cada agente en `agentes/` debe tener:
- `DISEÑO.md` — proposito, entradas, salidas, variables de entorno
- `PROFILE.md` — version, tipo, estado, frecuencia, dependencias
- `test.sh` — test basico ejecutable sin dependencias externas
- Entrada en este fichero
