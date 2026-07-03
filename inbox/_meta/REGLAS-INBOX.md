# REGLAS INBOX

## Propósito

La inbox es la **puerta de entrada** de todo al ecosistema Yggdrasil.
No guarda código productivo: guarda contexto, entradas, pendientes, reportes y documentación operativa.

## Reglas operativas

1. Inbox refleja la misma taxonomía que repo e islas.
2. Todo archivo nuevo debe caer en un ecosistema concreto.
3. Si no encaja en ningún ecosistema, pasa a `clasificados/` (temporal).
4. Toda automatización que escriba en inbox debe dejar traza en `_meta/`.
5. Cada ecosistema debe tener `README.md` explicando qué entra ahí.
6. El orquestador debe generar reporte en `_meta/` tras cada ejecución.
7. Si nace una isla nueva en la repo, nace su espejo en inbox.
8. `clasificados/` se vacía en cada sesión de trabajo.
9. Un archivo = una idea, sesión o tarea. No mezclar temas.
10. Nombre de archivo: `YYYY-MM-DD-descripcion-corta.md`

## Ecosistemas válidos

```
agentes | sesiones | infra | proyectos | formacion
hardware | osint | thdora | yo | clasificados | descartados
```

## Tags válidos

```
regla | docker | bot | script | infra | osint | seguridad
docs | deuda-tecnica | sprint | idea | agente | mcp | llm
```

## Estados del flujo

```
pendiente-clasificar  → acaba de entrar, sin revisar
pendiente-implementar → revisado, listo para hacer
en-progreso           → alguien lo está haciendo
hecho                 → completado, mover a destino y borrar de inbox
```
