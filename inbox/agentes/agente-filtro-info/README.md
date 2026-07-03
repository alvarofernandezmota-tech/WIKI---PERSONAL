# agente-filtro-info

## Función única
Filtrar entradas que llegan a inbox: separar señal de ruido, descartar duplicados y clasificar por relevancia.

## Entradas
- Archivos nuevos en `inbox/` raíz (sin clasificar)

## Salidas
- Archivos movidos al ecosistema correcto
- Duplicados a `descartados/`
- Ruido a `descartados/`
- Traza en `inbox/_meta/`

## Relación con otros agentes
- Precede al `orquestador-inbox` en el flujo
- Reduce carga del orquestador filtrando antes

## Estado
pendiente-implementar
