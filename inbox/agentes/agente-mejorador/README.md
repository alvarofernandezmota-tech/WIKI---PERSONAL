# agente-mejorador

## Función única
Detectar problemas en scripts y docs, generar branches `agent-fix/*` con fixes simples y abrir PRs.

## Entradas
- Scripts `.sh` sin shebang o sin strict mode
- Cualquier archivo con `TODO`
- Repositorio completo (excluyendo `.git/`)

## Salidas
- `inbox/mejorador/*.json` — reporte de análisis por archivo
- Branch `agent-fix/<archivo>-<ts>` con fix aplicado
- PR automático via `gh` si `--apply`

## Flags
- `--apply` — aplica fixes y hace push (default: dry-run)
- `--verbose` — logging detallado
- `--out DIR` — directorio de reportes

## Relación con otros agentes
- Sus reportes JSON son consumidos por `agente-fixer`
- El workflow `auto-pr.yml` crea el PR cuando se pushea el branch

## Estado
✅ activo
