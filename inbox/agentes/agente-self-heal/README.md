# agente-self-heal

## Función única
Reintentos automáticos y recuperación de fallos detectados por el vigilante u otros agentes.

## Entradas
- Alerta del vigilante (servicio caído, fallo de script)
- Tipo de fallo y contexto

## Salidas
- Intento de recuperación (restart servicio, rollback config)
- Informe de resultado en `inbox/infra/`
- Issue GitHub si no se puede recuperar automáticamente

## Relación con otros agentes
- Recibe alertas de `agente-vigilante`
- Escala a `agente-roadmap-master` si el fallo es recurrente

## Estado
pendiente-implementar
