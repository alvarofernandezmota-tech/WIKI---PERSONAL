# PLANTILLA UNIVERSAL DE AGENTE — yggdrasil-dew

> Usa esta plantilla para crear cualquier agente nuevo.
> Copia este archivo a `docs/agentes/<nombre>/DISEÑO.md`

---

## Identidad

| Campo | Valor |
|---|---|
| **Nombre** | `agent-XXXX` |
| **Versión** | `1.0.0` |
| **Tipo** | `auditor \| gestor \| reporter \| orquestador \| vigilante` |
| **Creado** | YYYY-MM-DD |
| **Creado por** | `Galatea \| humano \| meta-deep` |

## Rol y personalidad

**Una frase que define al agente:**
> _[Ejemplo: "Soy el guardián de la estructura del repo. Detecto duplicados y abro issues automáticamente."]_

**Tono:** técnico / formal / directo  
**Límites:** no borra archivos sin confirmación / no sale del scope definido

## Entradas

| Entrada | Tipo | Descripción | Requerida |
|---|---|---|---|
| `$1` | string | Descripción del parámetro | Sí/No |

## Salidas

| Salida | Destino | Descripción |
|---|---|---|
| Log de ejecución | `inbox/<nombre>-YYYYMMDD-HHMMSS.log` | Log completo |
| Reporte | `diary/<nombre>-YYYY-MM-DD.md` | Resumen de resultados |
| Issue GitHub | GitHub Issues | Si se detectan problemas críticos |

## Función única

_Describe en UNA frase qué hace este agente y nada más:_

> [Función específica y acotada]

## Lógica (pseudocódigo)

```
1. Validar entorno (ROOT, deps)
2. [Paso principal 1]
3. [Paso principal 2]
4. Documentar en inbox/
5. Si hay problemas críticos → abrir issue
6. Escribir reporte en diary/
```

## Métricas de éxito

- [ ] Tiempo de ejecución < 60s
- [ ] Log generado en inbox/
- [ ] Reporte generado en diary/
- [ ] 0 errores no controlados
- [ ] SLA: ejecutar al menos cada 24h (si es periódico)

## Tests

```bash
# Test básico
bash scripts/agentes/<nombre>.sh --test

# Test de salida
bash scripts/agentes/<nombre>.sh && [ -f inbox/<nombre>-*.log ] && echo "✅" || echo "❌"
```

## Prompts de ejemplo (para llm_router)

```
"Analiza el último reporte de <nombre> y detecta 3 mejoras prioritarias"
"¿Qué problemas detectó <nombre> en la última ejecución?"
```

## Integración MCP

Tool MCP correspondiente: `<tool_name>`  
Workflow GitHub: `.github/workflows/<nombre>.yml`

## Deuda técnica

- [ ] Pendiente 1
- [ ] Pendiente 2
