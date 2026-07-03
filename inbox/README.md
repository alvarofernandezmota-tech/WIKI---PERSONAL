# Inbox — Flujo de Captura

El inbox es la **entrada de todo** al ecosistema Yggdrasil.
Refleja la **misma taxonomía** que la repo principal y las islas: no guarda código productivo, sino contexto, entradas, pendientes, reportes y documentación operativa.

## Flujo

```
📱 Idea / nota / tarea rápida
        ↓
   inbox/*.md          ← Captura rápida, sin procesar
        ↓  (orquestador-inbox.sh)
 inbox/<ecosistema>/   ← Clasificado por isla/dominio
        ↓  (migrate-inbox.sh)
   docs/               ← Conocimiento permanente del ecosistema
        ↓  (si aplica)
 GitHub Issues          ← Tareas accionables con seguimiento
```

## Estructura de ecosistemas

La inbox refleja las mismas islas que la repo:

```
inbox/
├── _meta/           ← Reglas, estructura, workflow, reportes del orquestador
├── agentes/         ← Documentación operativa de agentes y workflows
├── sesiones/        ← Contexto de sesiones: decisiones, bloqueos, próximo paso
├── infra/           ← Docker, Ollama, MCP, Tailscale, Madre
├── proyectos/       ← Roadmaps, planes, sprints
├── formacion/       ← Python, cursos, aprendizaje
├── hardware/        ← Routers, drivers, USB, WiFi
├── osint/           ← Inteligencia, investigación, vigilancia
├── thdora/          ← Bots Telegram, automatización
├── yo/              ← Personal, contexto propio
├── clasificados/    ← Entradas sin ecosistema claro (temporal)
├── descartados/     ← Entradas descartadas
└── archive/         ← Histórico
```

## Reglas

1. **Captura rápida**: un archivo = una idea/sesión/tarea
2. **Nombre**: `YYYY-MM-DD-descripcion-corta.md`
3. **No procesar en el momento**: captura ahora, clasifica después
4. **El inbox debe estar vacío** al final de cada sesión de trabajo
5. **Toda automatización** que escriba en inbox deja traza en `_meta/`
6. **Si nace una isla nueva** en la repo, nace su espejo en inbox
7. **Clasificados/** es temporal — se migra o descarta en la siguiente sesión

## Scripts relacionados

```bash
# Orquestar inbox (clasificar entradas por ecosistema)
bash scripts/orquestador-inbox.sh

# Dry-run (ver qué haría sin ejecutar)
bash scripts/orquestador-inbox.sh --dry-run

# Migrar procesados a docs/
bash scripts/maintenance/migrate-inbox.sh

# Auditoría completa
bash scripts/maintenance/audit-full.sh
```

## Sesión 2026-07-03 — Temas tratados

Todo lo diseñado en la sesión de hoy está en `inbox/_meta/`:

- `REGLAS-INBOX.md` — reglas operativas de la inbox
- `ESTRUCTURA-INBOX.md` — inbox como espejo de islas
- `WORKFLOW-SESION.md` — apertura, trabajo y cierre
- `ROADMAP-ORQUESTACION.md` — mapa de agentes y conexiones
- `SESION-2026-07-03.md` — síntesis completa de la sesión

## Bloque Bots & RAG (activo)

- Bot 1: **Centinela** — alertas de red, backups, SSH
- Bot 2: **Investigador Maestro / Mimir** — RAG local sobre Yggdrasil-dew
- Bot 3: **Intendente** — n8n, automatización general

Pendiente: mover notas de bots a `docs/bots/` y `docs/infra/` + crear issues GitHub.

## Escalado futuro

Cuando el agente IA esté operativo, leerá inbox, clasificará entradas y las migrará automáticamente.
El MCP server es la pieza que habilita esa autonomía real.

_Yggdrasil Ecosystem — actualizado 03-jul-2026_
