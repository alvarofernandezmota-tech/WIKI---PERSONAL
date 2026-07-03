# 🤖 AGENTE: copilot-orquestador-agent

## FUNCIÓN ÚNICA
Conectar Copilot con todas las islas del ecosistema.
Generar prompts especializados por isla, recoger resultados
y distribuirlos al destino correcto.

## MODELO
GitHub Copilot (via API) + ollama/mistral (coordinación local)

## TRIGGER
- workflow_dispatch con parámetro `isla` y `tarea`
- Post-sesión (cierre-sesion.sh lo activa)

## HERRAMIENTAS
### Por isla:

**isla-obsidian**
- Indexar nuevos docs en knowledge base
- Generar resúmenes semánticos
- Actualizar grafo de conocimiento

**isla-alvaro**  
- Proponer issues basados en actividad reciente
- Generar PRs de mejora
- Revisar roadmap y sugerir próximos pasos

**isla-health**
- Analizar logs de servicios
- Detectar patrones de fallo
- Proponer fixes para MCP socket

**isla-mcp**
- Buscar alternativas al socket actual
- Generar código de fix
- Testear conectividad

**isla-secops**
- Escanear secrets en código
- Auditar permisos de workflows
- Revisar dependencias

**isla-diary**
- Enriquecer entradas de diary con análisis
- Detectar patrones en sesiones
- Proponer mejoras al workflow personal

**isla-roadmap**
- Actualizar estado de fases
- Detectar bloqueos
- Reordenar prioridades

## PROMPT BASE PARA COPILOT CHAT
```
Soy el orquestador del ecosistema yggdrasil-dew.
Tengo acceso a docs/COPILOT-CONTEXT.md con el contexto completo.
Actúa como ingeniero senior especializado en automatización.

Para cada tarea que te asigne:
1. Lee COPILOT-CONTEXT.md antes de responder
2. Sigue las convenciones de cabecera de scripts y Actions
3. Genera código production-ready, no prototipos
4. Incluye manejo de errores y logs
5. Genera tests básicos cuando corresponda
6. Si detectas deuda técnica adicional, menciónala
```

## ISLAS CONECTADAS
Todas: obsidian, alvaro, health, mcp, secops, diary, roadmap, producción

## SALIDA
```
Scripts y Actions generados → PR automático
Issues de mejora → label según isla
Resúmenes → diarios/copilot-YYYY-MM-DD.md
```
