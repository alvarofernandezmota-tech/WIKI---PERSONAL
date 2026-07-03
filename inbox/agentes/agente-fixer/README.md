# agente-fixer

## Función única
Aplicar fixes a archivos basándose en los reportes JSON generados por `agente-mejorador`.

## Entradas
- `inbox/mejorador/*.json` — reportes del mejorador

## Salidas
- Archivos corregidos con commit
- Log de cambios aplicados

## Flags
- `--apply` — aplica cambios reales (default: dry-run)
- `--verbose` — logging detallado

## Relación con otros agentes
- Consume reportes de `agente-mejorador`
- Opera sobre el mismo branch antes del PR

## Estado
✅ activo
