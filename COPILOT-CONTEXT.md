# COPILOT CONTEXT — yggdrasil-dew
<!-- FUNCIÓN: Contexto persistente para GitHub Copilot, agentes IA y revisiones CI/CD -->
<!-- AGENTE: Copilot, thdora-guardian, todos los workflows -->
<!-- ACTUALIZADO: 2026-07-03 -->

## Resumen
yggdrasil-dew es el repositorio Madre que contiene documentación, scripts, GitHub Actions, agentes IA, diario de sesiones e islas. Todo vive en este repo por diseño — un único cerebro central.

## Arquitectura por capas

```
CAPA 1 — Humano
  apertura-sesion.sh → sesión de trabajo → cierre-sesion.sh

CAPA 2 — Actions en cada push (síncronas)
  audit-on-push.yml
  diary-writer.yml
  lint-commits.yml
  tripwire-repo.yml
  new-file-bootstrap.yml
  clasificador.yml

CAPA 3 — Actions por cron (asíncronas)
  autonomous-cron.yml
  health-check.yml
  repo-audit.yml
  inbox-cleanup.yml
  mapa-islas-sync.yml
  ecosystem-guardian.yml
  resumen-diario.yml
  orquestador-maestro.yml
  agent-monitor.yml        ← NUEVO 2026-07-03

CAPA 4 — Agentes IA locales (Ollama en Madre)
  Modelos: gemma3, llama3, mistral
  MCP server: mcp_server.py (socket /tmp/mcp.sock)
  Thdora: handlers en scripts/thdora/
  IA local empieza por C: Codestral (Mistral local) o deepseek-coder
```

## Estructura de carpetas

| Carpeta | Propósito | Estado |
|---|---|---|
| `inbox/` | Archivos nuevos sin clasificar | ⚠️ pendientes |
| `diarios/` | Diario oficial de sesiones | ✅ activo |
| `diary/` | DUPLICADO — fusionar con diarios/ | ❌ deuda técnica |
| `docs/` | Documentación general | ✅ |
| `scripts/` | Scripts de automatización | ✅ |
| `agentes/` | Configuración de agentes IA | ✅ |
| `proyectos/` | Proyectos activos | ✅ |
| `osint/` | Investigación OSINT | ✅ activo |
| `osint-stack/` | DUPLICADO — fusionar con osint/ | ❌ deuda técnica |
| `islas/` | Islas del ecosistema | ✅ |
| `thdora/` | Bot guardian handlers | ✅ |
| `ollama/` | Configs modelos locales | ✅ |
| `infra/` | Infraestructura y docker | ✅ |
| `formacion/` | Material de formación | ✅ |
| `hardware/` | Docs hardware Madre | ✅ |

## Deuda técnica activa — 2026-07-03

```
🔴 CRÍTICO
  - MCP socket /tmp/mcp.sock no operativo → agentes no pueden usar GitHub API autónomamente
  - Carpetas duplicadas: diarios/ + diary/ → consolidar en diarios/
  - Carpetas duplicadas: osint/ + osint-stack/ → consolidar en osint/

🟡 IMPORTANTE
  - inbox/ con archivos sin clasificar → ejecutar clasificador manualmente
  - diary-writer.yml usa solo git log → falta análisis con Ollama
  - apertura-sesion.sh no carga DEUDA-TECNICA.md ni issues urgentes

🟢 PENDIENTE
  - Falta: struct-auditor.sh + Action  ← GENERADO 2026-07-03
  - Falta: ghost-file-detector.sh + Action
  - Falta: between-sessions.yml
  - Falta: agent-monitor.yml           ← GENERADO 2026-07-03
  - Cross-ref-checker: links internos rotos
  - isla-sync-validator: MAPA-ISLAS.md vs realidad
```

## Reglas de commit

```
feat:      nueva funcionalidad
fix:       corrección de bug
chore:     mantenimiento
docs:      documentación
refactor:  refactorización sin cambio funcional
[AUTO]     sufijo para commits generados por Actions
```

## Etiquetas de issues

`deuda-tecnica` `automatizacion` `estructura` `agentes` `seguridad` `osint` `investigacion` `urgente` `duplicado`

## Servicios locales en Madre

| Servicio | Puerto | Estado |
|---|---|---|
| Ollama | :11434 | ✅ |
| n8n | :5678 | ✅ |
| Portainer | :9000 | ✅ |
| Grafana | :3000 | ✅ |
| Uptime Kuma | :3001 | ✅ |
| Qdrant | :6333 | ✅ |
| MCP agent | :8000 | ❌ socket caído |

## IA local — empieza por C

**Codestral** (Mistral) o **deepseek-coder** vía Ollama — modelos especializados en código disponibles localmente. Para usarlos: `ollama run codestral` o `ollama run deepseek-coder`.

## Objetivo del sistema

Automatizar entre sesiones: detectar problemas, abrir issues, proponer fixes, ejecutar auditorías, actualizar docs y preparar contexto para el humano. Ningún estado inconsistente puede existir más de 1 hora sin que el sistema lo detecte, registre en un issue, y proponga el fix.

## Instrucciones para Copilot

1. Revisar y completar scripts: `scripts/apertura-sesion.sh`, `scripts/cierre-sesion.sh`
2. Scripts ya generados: `scripts/struct-auditor.sh`, `.github/workflows/agent-monitor.yml`
3. Generar scripts pendientes: `scripts/ghost-file-detector.sh`, `scripts/between-sessions.sh`
4. Añadir cabeceras estándar a Actions y scripts: `# FUNCIÓN`, `# TRIGGER`, `# AGENTE`, `# ETIQUETAS`, `# RUTAS`
5. Mejorar `diary-writer.yml` para usar análisis con Ollama vía `curl http://localhost:11434/api/generate`
6. Proponer plantilla replicable para islas
7. Archivar carpetas duplicadas: mover contenido de `diary/` → `diarios/` y `osint-stack/` → `osint/`

## Prompts de alta precisión para Copilot Chat

### ghost-file-detector.sh
```
Basándote en COPILOT-CONTEXT.md, escribe scripts/ghost-file-detector.sh completo.
Debe: (1) encontrar archivos vacíos (0 bytes) en todo el repo; (2) encontrar archivos
referenciados en docs/ que no existen en disco; (3) loggear en diarios/ con fecha;
(4) usar gh issue create con label estructura si detecta fantasmas.
Sigue cabecera estándar del proyecto.
```

### between-sessions.yml
```
Crea .github/workflows/between-sessions.yml que se ejecute cada 2h entre las 00:00
y las 08:00 UTC. Debe: (1) verificar estado de servicios locales usando health-check;
(2) clasificar inbox/ automáticamente; (3) generar resumen de actividad nocturna;
(4) preparar brief para la próxima sesión en diarios/brief-YYYY-MM-DD.md.
```

### diary-writer con Ollama
```
Mejora .github/workflows/diary-writer.yml para que después de generar el git log,
haga una llamada a Ollama local: curl -s http://localhost:11434/api/generate con
modelo mistral y prompt que analice los commits del día e identifique: (1) patrones
de deuda técnica, (2) componentes más activos, (3) riesgos detectados. Añade el
análisis al diary de ese día como sección ## Análisis IA.
```
