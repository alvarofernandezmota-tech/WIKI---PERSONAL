# MCP Server — Yggdrasil-dew

## FUNCIÓN ÚNICA
Exponer todas las herramientas del ecosistema (orquestador, watchdog, Galatea, agentes, inbox, auditoría, llm_router) como tools MCP compatibles con Claude Desktop, Copilot MCP y cualquier cliente MCP estándar.

## Requisitos
- Node 18+
- `@modelcontextprotocol/sdk` (`npm install` en esta carpeta)
- Scripts del ecosistema en `scripts/`
- Variable `YGGDRASIL_ROOT` apuntando al root del repo

## Instalación

```bash
cd /srv/yggdrasil-dew/mcp
npm install
```

## Arranque

```bash
export YGGDRASIL_ROOT="/srv/yggdrasil-dew"
node mcp/server.js
```

## Integración Claude Desktop

Copia `mcp-config.json` a `~/.config/claude/mcp.json` (Linux) o `~/Library/Application Support/Claude/mcp.json` (macOS) y rellena las API keys si usas modelos remotos.

## Tools expuestas (34 total)

| Tool | Script | Descripción |
|---|---|---|
| `orquestador_supremo` | `orquestador-supremo.sh` | Coordina agentes y auditorías principales |
| `orquestador_total` | `orquestador-total.sh` | Lanza todos los agentes, reporte maestro |
| `watchdog_monitor` | `watchdog-monitor.sh` | Monitoriza reportes y detecta cuelgues |
| `agent_monitor` | `agent-monitor.sh` | Monitor secundario de agentes |
| `clasificador_maestro` | `clasificador-maestro.sh` | Clasifica inbox por tipo y contexto |
| `gestor_estados_inbox` | `gestor-estados-inbox.sh` | Gestiona estados NUEVO→EN-PROCESO→PROCESADO |
| `procesar_inbox_masivo` | `procesar-inbox-masivo.sh` | Procesa en lote el inbox |
| `inbox_watcher` | `inbox-watcher.sh` | Watcher en tiempo real del inbox |
| `struct_auditor` | `struct-auditor.sh` | Auditoría estructural del repo |
| `ghost_file_detector` | `ghost-file-detector.sh` | Detecta archivos fantasma |
| `cross_ref_checker` | `cross-ref-checker.sh` | Detecta links internos rotos |
| `tool_inventory_auditor` | `tool-inventory-auditor.sh` | Audita cabeceras FUNCIÓN en scripts |
| `isla_sync_validator` | `isla-sync-validator.sh` | Valida MAPA-ISLAS.md vs repo real |
| `ecosystem_snapshot` | `ecosystem-snapshot.sh` | Snapshot completo del estado |
| `audit_and_migrate` | `audit-and-migrate.sh` | Migra estructuras obsoletas |
| `code_drift_detector` | `code-drift-detector.sh` | Detecta deriva de código |
| `repo_research` | `repo-research.sh` | Investigación profunda del repo |
| `task_analyzer` | `task-analyzer.sh` | Analiza tareas pendientes |
| `issue_creator` | `issue-creator.sh` | Crea issues GitHub para deuda técnica |
| `create_issues` | `create-issues.sh` | Batch de issues desde plantilla |
| `setup_labels` | `setup-labels.sh` | Configura labels GitHub del ecosistema |
| `apertura_sesion` | `apertura-sesion.sh` | Ritual de apertura de sesión |
| `inicio_sesion` | `inicio-sesion.sh` | Inicio de sesión rápido |
| `cierre_sesion` | `cierre-sesion.sh` | Ritual de cierre de sesión |
| `between_sessions` | `between-sessions.sh` | Tareas automáticas entre sesiones |
| `deploy` | `deploy.sh` | Despliega el ecosistema |
| `deploy_madre` | `deploy-madre.sh` | Despliega cambios en Madre |
| `batcueva_control` | `batcueva-control.sh` | Control del entorno Batcueva |
| `galatea_fabrica_agente` | `galatea-fabrica-agentes.sh` | Crea nuevo agente con plantilla base |
| `galatea_isla_bot` | `galatea-islas-bots.sh` | Crea isla o bot Galatea |
| `galatea_scan` | `galatea-scan.sh` | Escanea y cataloga agentes |
| `llm_router` | — | Router: ollama/openai/anthropic/http |
| `core_estado` | `docs/CORE-ECOSISTEMA.md` | Lee fuente de verdad del sistema |
| `inbox_cleanup` | `inbox-cleanup-jun2026.sh` | Limpieza profunda del inbox |

## Ejemplos de llamada MCP (JSON)

```json
{ "type": "call_tool", "tool": "orquestador_total", "arguments": {} }
```

```json
{ "type": "call_tool", "tool": "llm_router", "arguments": { "model": "ollama:llama3", "prompt": "Resume el último reporte maestro" } }
```

```json
{ "type": "call_tool", "tool": "galatea_fabrica_agente", "arguments": { "nombre": "agent-docs-enhancer", "rol": "Mejora automática de docs", "scope": "docs", "tags": "docs,enhancer" } }
```

## Arquitectura

```
Cliente MCP (Claude / Copilot / IA en C)
        │ JSON-RPC over stdio
        ▼
  mcp/server.js
        │ execSync / readFileSync
        ▼
  scripts/*.sh  →  inbox/ docs/ diary/  →  GitHub API (gh cli)
```
