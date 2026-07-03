# 🔄 Scripts → Tools de Agentes

> Los scripts NO desaparecen. Se convierten en las **tools** que los agentes llaman.  
> Cada script existente tiene un rol exacto en la arquitectura de agentes.  
> Actualizado: 2026-07-03

---

## Principio de transformación

```
ANTES:   humano ejecuta script manualmente
AHORA:   agente llama a script como tool
FUTURO:  agente decide CUÁNDO y CON QUÉ ARGS llamar al script
```

El script no cambia. Lo que cambia es quién lo invoca y por qué.

---

## Mapa completo

### 🟢 Tools de health-agent

| Script | Tool expuesta | Agente | Safe |
|---|---|---|---|
| `scripts/infra/docker-health-check.sh` | `check_docker(container?)` | health-agent | ✅ read-only |
| `scripts/maintenance/ecosystem-map.sh` | `get_ecosystem_map()` | health-agent | ✅ read-only |
| `scripts/maintenance/night-cron.sh` | `run_maintenance(dry_run=True)` | health-agent | ⚠️ dry_run first |
| `scripts/thdora/bot-session-report.sh` | `get_session_report()` | health-agent | ✅ read-only |
| `scripts/tests/smoke-test-scripts.sh` | `run_smoke_tests()` | health-agent | ✅ read-only |

### 🟡 Tools de roadmap-agent

| Script | Tool expuesta | Agente | Safe |
|---|---|---|---|
| `scripts/maintenance/labels-setup.sh` | `sync_labels(dry_run=True)` | roadmap-agent | ⚠️ dry_run first |
| `scripts/setup-labels.sh` | `setup_labels(dry_run=True)` | roadmap-agent | ⚠️ dry_run first |
| `scripts/maintenance/close-session.sh` | `close_session(summary)` | roadmap-agent | ⚠️ review needed |
| `scripts/gemini-brief.md` | referencia de contexto | roadmap-agent | ✅ read-only |

### 🔵 Tools de mcp-server (expuestas a IAs externas)

| Script/Fuente | Tool MCP | Disponible para |
|---|---|---|
| `docker ps` | `check_docker` | Cursor, Claude, Open WebUI |
| `ROADMAP-MASTER.md` | `read_roadmap` | Cursor, Claude, Open WebUI |
| `ESTADO-SISTEMA.md` | `get_ecosystem_state` | Cursor, Claude, Open WebUI |
| Tailscale API | `list_services` | Cursor, Claude, Open WebUI |
| GitHub API | `create_issue` | Cursor (con approval) |
| Qdrant | `query_rag` | Cursor, Claude, Open WebUI |

### 🟣 Tools de research-agent (futuro)

| Script/Fuente | Tool expuesta | Agente | Safe |
|---|---|---|---|
| `scripts/thdora-dev/README.md` | contexto desarrollo | research-agent | ✅ read-only |
| Qdrant (bge-m3) | `semantic_search(query)` | research-agent | ✅ read-only |
| GitHub API | `search_issues(q)` | research-agent | ✅ read-only |
| Ollama `/api/generate` | `synthesize(content)` | research-agent | ✅ read-only |

---

## Scripts que NO se convierten en tools (todavía)

| Script | Razón | Cuándo |
|---|---|---|
| `scripts/08-fase6-thdora-handlers.sh` | muy específico de setup | cuando F10 arranque |
| `scripts/thdora/thdora-scaffold.sh` | one-shot, no recurrente | cuando se cree nuevo bot |
| `scripts/SCRIPTS.md` | es documentación | siempre manual |

---

## Patrón de wrapper (cómo convertir un script en tool)

```python
# Patrón estándar para cualquier script existente
def script_as_tool(
    script_path: str,
    args: list[str] = [],
    dry_run: bool = True,
    timeout: int = 30
) -> dict:
    """
    Wrapper universal para scripts del ecosistema.
    Siempre dry_run=True por defecto.
    """
    audit_log("script_as_tool", {"script": script_path, "args": args, "dry_run": dry_run})
    
    if dry_run:
        return {
            "executed": False,
            "dry_run": True,
            "would_run": f"bash {script_path} {' '.join(args)}"
        }
    
    result = subprocess.run(
        ["bash", script_path] + args,
        capture_output=True,
        text=True,
        timeout=timeout
    )
    
    return {
        "executed": True,
        "returncode": result.returncode,
        "stdout": result.stdout[:2000],  # cap output
        "stderr": result.stderr[:500] if result.returncode != 0 else ""
    }
```

---

## Estado de conversión

- ✅ Diseñado: 12 scripts mapeados a tools
- ⬜ Implementado: 0 (pendiente despliegue en Madre)
- ⬜ Testeado: 0
- ⬜ Integrado en agente: 0

**Siguiente paso:** implementar los 5 tools del health-agent primero.

---

*Mapa v1.0 — 2026-07-03*
