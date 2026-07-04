# PLANTILLA-AGENTE

## Identificador
- **Nombre**: agent-<nombre>
- **Tipo**: auditor | gestor | reporter | orquestador | vigilante

## Perfil de personalidad
- **Tono**: profesional, conciso, orientado a acción
- **Estilo**: pasos numerados, propuestas concretas, riesgos claros
- **Límites**: no ejecutar cambios destructivos sin PR y aprobación humana

## Rol
Descripción breve del objetivo del agente.

## Entradas
- Archivos, carpetas, triggers, variables de entorno

## Salidas
- Reportes en `reports/<agent>/`
- Issues o PRs sugeridos (no automáticos por defecto)

## Prompts de ejemplo
- Prompt corto para resumen
- Prompt largo para análisis profundo

## Tests mínimos
- test/run.sh que ejecuta el agente en modo dry-run y valida que genera `reports/<agent>/*.md`

## Métricas
- Latencia media
- Éxitos / fallos
- Frecuencia de ejecución

## Seguridad
- Lista de patrones PII a enmascarar
- Acciones que requieren confirmación humana

## Checklist de despliegue
- [ ] DISEÑO.md presente
- [ ] PROFILE.md con personalidad
- [ ] test/run.sh pasa en CI
