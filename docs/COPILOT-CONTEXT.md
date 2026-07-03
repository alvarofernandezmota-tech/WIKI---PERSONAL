# COPILOT CONTEXT — yggdrasil-dew

> **Archivo clave para GitHub Copilot y cualquier IA que trabaje en este repo.**
> Lee este archivo primero antes de cualquier tarea en el ecosistema.

## Identidad del ecosistema

- **Nombre:** yggdrasil-dew
- **Propósito:** Plataforma operativa y gobernada para automatización IA, scripts, agentes y workflows GitHub.
- **Madre:** Raspberry Pi / servidor local donde se ejecutan scripts y el MCP server.
- **Idioma:** Español en docs, inglés en código y nombres de archivos.

## Estructura sagrada (NO modificar sin auditoría)

```
yggdrasil-dew/
├── docs/              ← Fuente de verdad. CORE-ECOSISTEMA.md es la biblia.
├── scripts/           ← Scripts bash del ecosistema
│   └── agentes/       ← Agentes especializados (función única cada uno)
├── mcp/               ← MCP Server Python — expone tools a IAs
│   └── server.py      ← Punto de entrada MCP
├── .github/
│   └── workflows/     ← GitHub Actions
├── inbox/             ← Logs temporales, pendientes de procesar
├── diary/             ← Reportes permanentes de sesión
└── islas/             ← Proyectos específicos (isla-proyectos, isla-hardware...)
```

## Reglas CORE para Copilot

1. **Cada script/agente tiene UNA función única** — declarada en cabecera `FUNCIÓN:`
2. **Plantilla estándar obligatoria** en todos los scripts (ver sección Plantilla)
3. **Todo cierre de sesión** → documentar en `inbox/` y `diary/`
4. **Nunca borrar** `docs/CORE-ECOSISTEMA.md`, `inbox/`, `diary/` sin auditoría
5. **Abre issue** automático si detectas problema crítico (usa `gh issue create`)
6. **El MCP server** (`mcp/server.py`) es el punto de integración para IAs externas
7. **llm_router** soporta Ollama (local, preferido) y OpenAI/Anthropic (remoto, fallback)
8. **Galatea** (`scripts/agentes/galatea-fabrica-agentes.sh`) genera nuevos agentes con plantilla

## Plantilla estándar de scripts

```bash
#!/usr/bin/env bash
# ============================================================
# NOMBRE:   scripts/[nombre].sh
# VERSION:  1.0.0
# FUNCIÓN:  [descripción única y específica]
# TIPO:     auditor | gestor | reporter | orquestador | vigilante
# AUTOR:    yggdrasil-dew ecosystem
# REPO:     alvarofernandezmota-tech/yggdrasil-dew
# USO:      bash scripts/[nombre].sh
# ============================================================
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}}")/.." && pwd)"
# ... lógica ...
```

## Agentes MCP disponibles

| Tool MCP | Script bash equivalente | Función |
|---|---|---|
| `orquestador_total` | `scripts/orquestador-total.sh` | Coordina todo el ecosistema |
| `galatea_fabrica_agente` | `scripts/agentes/galatea-fabrica-agentes.sh` | Genera agentes nuevos |
| `agente_meta_deep` | `scripts/agentes/agente-meta-deep.sh` | Auditoría profunda con LLM |
| `llm_router` | `scripts/agentes/llm-router.sh` | Enruta a Ollama/OpenAI/Anthropic |
| `struct_auditor` | `scripts/struct-auditor.sh` | Detecta duplicados/fantasmas |
| `ghost_file_detector` | `scripts/ghost-file-detector.sh` | Archivos huérfanos |
| `isla_sync_validator` | `scripts/isla-sync-validator.sh` | Valida mapas de islas |
| `watchdog` | `scripts/watchdog.sh` | Monitor SLAs |
| `diary_writer` | — | Escribe entradas de diario |
| `issue_creator` | — | Crea issues GitHub |
| `health_check` | — | Pulso del ecosistema |

## Inicio rápido en Madre

```bash
# 1. Instalar dependencias MCP
cd ~/yggdrasil-dew && pip install -r mcp/requirements.txt

# 2. Iniciar MCP server
python3 mcp/server.py --port 8080

# 3. O en modo stdio (para Claude CLI / agentes)
python3 mcp/server.py --stdio

# 4. Ejecutar orquestador completo
bash scripts/orquestador-total.sh completo

# 5. Crear un agente nuevo (Galatea)
bash scripts/agentes/galatea-fabrica-agentes.sh "mi-agente" "Función específica" "auditor"
```

## Variables de entorno necesarias en Madre

```bash
export YGGDRASIL_ROOT=/srv/yggdrasil-dew  # o la ruta real
export OPENAI_API_KEY=sk-...              # opcional
export ANTHROPIC_API_KEY=sk-ant-...       # opcional
# Ollama: instalar desde https://ollama.ai (preferido, local)
```

## Workflows GitHub activos

| Workflow | Trigger | Función |
|---|---|---|
| `orquestador-total.yml` | Diario 06:00 UTC + manual | Orquesta todo el ecosistema |
| `meta-deep-audit.yml` | Domingos 22:00 UTC + manual | Auditoría profunda con LLM |
| `watchdog.yml` | Cada 6h | Monitor de SLAs |

## Deuda técnica conocida (2026-07-03)

- [ ] `diary/` y `diarios/` duplicados — consolidar en `diary/`
- [ ] `osint/` y `osint-stack/` duplicados — consolidar
- [ ] MCP server: HTTP mode requiere `uvicorn` instalado en Madre
- [ ] Scripts sin cabecera estándar — revisar con `agente-meta-deep.sh`
- [ ] `cross-ref-checker.sh` — pendiente de implementar lógica completa
