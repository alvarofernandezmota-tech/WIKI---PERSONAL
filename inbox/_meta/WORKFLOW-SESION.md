# WORKFLOW DE SESIÓN

## Apertura de sesión

```bash
bash scripts/apertura-sesion.sh
```

1. `git pull` — sincronizar con remoto
2. Verificar servicios críticos (Docker, Ollama, MCP socket)
3. Revisar backlog e issue maestro en GitHub
4. Ejecutar vigilante — revisar alertas pendientes
5. Revisar `inbox/` — procesar entradas anteriores
6. Generar snapshot inicial del estado del sistema

## Durante la sesión

- Documentar hallazgos directamente en `inbox/<ecosistema>/`
- Ejecutar investigadores cuando falte contexto
- Actualizar roadmap si salen nuevas tareas
- Mover entradas clasificadas a su destino final cuando estén listas

## Cierre de sesión

```bash
bash scripts/cierre-sesion.sh
```

1. Ejecutar `orquestador-inbox.sh` — clasificar entradas del día
2. Ejecutar auditorías (struct-auditor, ghost-file-detector)
3. Documentar en `diary/` — resumen técnico
4. Documentar en `inbox/sesiones/` — contexto para próxima sesión
5. Actualizar issue de próxima sesión en GitHub
6. `git add . && git commit -m '...' && git push`
7. Generar informe final

## Regla de sesión

Ninguna sesión termina con el inbox sucio.
Ninguna sesión termina sin commit.
Ninguna sesión termina sin documentar el siguiente paso.
