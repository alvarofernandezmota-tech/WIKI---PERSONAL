# PROFILE — {{AGENT_NAME}}

## Identidad

- **Nombre**: {{AGENT_NAME}}
- **Versión**: 0.1.0
- **Propietario**: yggdrasil-dew
- **Fecha de creación**: {{FECHA}}

## Misión

<!-- Descripción en una línea de lo que hace este agente -->
{{MISION}}

## Entradas

| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `--input` | string | Ruta al archivo de entrada |
| `--dry-run` | flag | Simular sin modificar |

## Salidas

| Artefacto | Ubicación | Descripción |
|-----------|-----------|-------------|
| Reporte | `reports/{{AGENT_NAME}}/` | Resultado de la ejecución |

## Dependencias

- bash ≥5.0
- git

## Flujo de ejecución

1. Lee entradas
2. Procesa
3. Escribe reporte en `reports/{{AGENT_NAME}}/`
4. Devuelve exit code 0 (OK) o 1 (error)

## Siguiente-paso

<!-- Qué debe ocurrir después de que este agente termina -->
- Revisar `reports/{{AGENT_NAME}}/` y proceder con la siguiente fase.
