# feat/inbox-cleanup — Migración masiva del inbox

## Objetivo

Vaciar `inbox/` de los 138 ficheros pendientes moviéndolos a sus carpetas definitivas.

## Plan de ejecución

### Opción A: Script en la Madre (RECOMENDADO)
```bash
# Clonar rama
git checkout feat/inbox-cleanup

# Preview sin ejecutar
bash tools/inbox-processor.sh --dry-run

# Ejecutar migración
bash tools/inbox-processor.sh

# Push
git push origin feat/inbox-cleanup
```

### Opción B: Manual por lotes (Perplexity MCP)
Perplexity puede crear ficheros en destino + borrar de inbox de 10 en 10.

## Mapa de destinos

| Patrón nombre | Destino |
|---|---|
| `adr-*` | `docs/adr/` |
| `ollama*` | `ollama/` |
| `sesion-*`, `cierre-*` | `diarios/` |
| `proyecto-*` | `proyectos/` |
| `prompt-*`, `debate-*` | `docs/ias/` |
| `decision-*` | `docs/decisiones/` |
| `setup*`, `arch-linux*` | `setup/` |
| `osint*` | `osint/` |
| `formacion*` | `formacion/` |
| Resto | `docs/` |

## Estado

- [ ] inbox reducido a 0 ficheros
- [ ] PR a main con log de migración

---
*Rama creada: 2026-06-25 | Perplexity MCP*
