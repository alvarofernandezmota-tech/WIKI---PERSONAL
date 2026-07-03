# mcp_server_v2.py
# MCP Server v2 — Gatekeeper + RBAC + Rate limiting + Tool registry dinámico
# Mejoras sobre v1: seguridad, observabilidad, más tools
# Docs: agentes/LABORATORIO-AGENTES.md
# Instalar: pip install mcp fastapi uvicorn

import subprocess
import json
import uuid
from pathlib import Path
from datetime import datetime
from collections import defaultdict
from typing import Optional
from mcp.server import Server
from mcp.server.stdio import stdio_server
from mcp import types

# ─── Config ──────────────────────────────────────

YGGDRASIL_DEW = Path("/srv/yggdrasil-dew")
AUDIT_LOG = Path("/srv/mcp-server/audit-v2.jsonl")
RATE_LIMIT_PER_MINUTE = 20  # por tool por caller

# RBAC: qué callers pueden usar qué tools
# Callers: cursor, claude, open-webui, health-agent, roadmap-agent
RBAC = {
    "*": [  # todos pueden
        "check_docker", "get_ecosystem_state", "read_roadmap",
        "list_services", "query_rag"
    ],
    "cursor": [
        "create_issue", "run_script_safe", "search_yggdrasil"
    ],
    "claude": [
        "create_issue", "search_yggdrasil"
    ],
    "health-agent": [
        "create_issue", "notify_telegram", "restart_container_safe"
    ],
    "roadmap-agent": [
        "create_issue", "update_roadmap_safe"
    ],
}

server = Server("madre-ecosystem-v2")
_call_counts: dict = defaultdict(lambda: defaultdict(int))
_call_timestamps: dict = defaultdict(list)


# ─── Gatekeeper ─────────────────────────────────

def gatekeeper(caller: str, tool: str, trace_id: str) -> tuple[bool, str]:
    allowed = RBAC.get("*", []) + RBAC.get(caller, [])
    if tool not in allowed:
        return False, f"RBAC: '{caller}' no tiene permiso para '{tool}'"
    now = datetime.utcnow().timestamp()
    key = f"{caller}:{tool}"
    _call_timestamps[key] = [
        t for t in _call_timestamps[key] if now - t < 60
    ]
    if len(_call_timestamps[key]) >= RATE_LIMIT_PER_MINUTE:
        return False, f"Rate limit: {RATE_LIMIT_PER_MINUTE}/min para {tool}"
    _call_timestamps[key].append(now)
    return True, "ok"


def audit(caller: str, tool: str, args: dict, trace_id: str,
          success: bool, error: Optional[str] = None):
    AUDIT_LOG.parent.mkdir(parents=True, exist_ok=True)
    entry = {
        "ts": datetime.utcnow().isoformat(),
        "trace_id": trace_id,
        "caller": caller,
        "tool": tool,
        "args_keys": list(args.keys()),
        "success": success,
        "error": error
    }
    with AUDIT_LOG.open("a") as f:
        f.write(json.dumps(entry, ensure_ascii=False) + "\n")


# ─── Tool definitions ────────────────────────────

TOOL_REGISTRY = [
    types.Tool(
        name="check_docker",
        description="Lista contenedores Docker con estado actual. Safe, read-only.",
        inputSchema={"type": "object", "properties": {
            "container": {"type": "string", "description": "Filtrar por nombre (opcional)"},
            "caller": {"type": "string", "description": "Identificador del caller"}
        }}
    ),
    types.Tool(
        name="get_ecosystem_state",
        description="Lee ECOSYSTEM-STATE.md o ESTADO-SISTEMA.md actual.",
        inputSchema={"type": "object", "properties": {
            "caller": {"type": "string"}
        }}
    ),
    types.Tool(
        name="read_roadmap",
        description="Lee ROADMAP-MASTER.md completo.",
        inputSchema={"type": "object", "properties": {
            "caller": {"type": "string"}
        }}
    ),
    types.Tool(
        name="list_services",
        description="Lista servicios activos del ecosistema.",
        inputSchema={"type": "object", "properties": {
            "caller": {"type": "string"}
        }}
    ),
    types.Tool(
        name="search_yggdrasil",
        description="Busca texto en los ficheros de yggdrasil-dew. Grep recursivo.",
        inputSchema={"type": "object", "properties": {
            "query": {"type": "string", "description": "Término a buscar"},
            "path": {"type": "string", "description": "Subdirectorio opcional"},
            "caller": {"type": "string"}
        }, "required": ["query"]}
    ),
    types.Tool(
        name="create_issue",
        description="Crea un issue en yggdrasil-dew. Requiere permiso. Registra en audit.",
        inputSchema={"type": "object", "properties": {
            "title": {"type": "string"},
            "body": {"type": "string"},
            "labels": {"type": "array", "items": {"type": "string"}},
            "caller": {"type": "string"}
        }, "required": ["title", "body"]}
    ),
    types.Tool(
        name="run_script_safe",
        description="Ejecuta un script del ecosistema. dry_run=true por defecto.",
        inputSchema={"type": "object", "properties": {
            "script_name": {"type": "string", "description": "Nombre del script en scripts/"},
            "args": {"type": "array", "items": {"type": "string"}},
            "dry_run": {"type": "boolean", "default": True},
            "caller": {"type": "string"}
        }, "required": ["script_name"]}
    ),
]


@server.list_tools()
async def list_tools():
    return TOOL_REGISTRY


# ─── Tool implementations ──────────────────────────

@server.call_tool()
async def call_tool(name: str, arguments: dict):
    trace_id = str(uuid.uuid4())[:8]
    caller = arguments.get("caller", "unknown")

    ok, reason = gatekeeper(caller, name, trace_id)
    if not ok:
        audit(caller, name, arguments, trace_id, False, reason)
        return [types.TextContent(type="text", text=f"❌ Gatekeeper: {reason}")]

    try:
        result = await _dispatch(name, arguments, trace_id)
        audit(caller, name, arguments, trace_id, True)
        return result
    except Exception as e:
        audit(caller, name, arguments, trace_id, False, str(e))
        return [types.TextContent(type="text", text=f"❌ Error: {e}")]


async def _dispatch(name: str, args: dict, trace_id: str):
    if name == "check_docker":
        cmd = ["docker", "ps", "--format", "{{json .}}"]
        if args.get("container"):
            cmd += ["--filter", f"name={args['container']}"]
        r = subprocess.run(cmd, capture_output=True, text=True, timeout=10)
        lines = [json.loads(l) for l in r.stdout.strip().split("\n") if l]
        return [types.TextContent(type="text", text=json.dumps({
            "trace_id": trace_id,
            "containers": lines,
            "count": len(lines)
        }, indent=2))]

    elif name == "get_ecosystem_state":
        for p in [YGGDRASIL_DEW / "ESTADO-SISTEMA.md",
                  YGGDRASIL_DEW / "ECOSYSTEM-STATE.md"]:
            if p.exists():
                return [types.TextContent(type="text",
                    text=f"[trace:{trace_id}]\n" + p.read_text(encoding="utf-8"))]
        return [types.TextContent(type="text", text="Estado del sistema no encontrado.")]

    elif name == "read_roadmap":
        p = YGGDRASIL_DEW / "ROADMAP-MASTER.md"
        if p.exists():
            return [types.TextContent(type="text",
                text=f"[trace:{trace_id}]\n" + p.read_text(encoding="utf-8"))]
        return [types.TextContent(type="text", text="ROADMAP-MASTER.md no encontrado.")]

    elif name == "list_services":
        p = YGGDRASIL_DEW / "ESTADO-SISTEMA.md"
        content = p.read_text(encoding="utf-8")[:1500] if p.exists() else "No disponible."
        return [types.TextContent(type="text", text=f"[trace:{trace_id}]\n" + content)]

    elif name == "search_yggdrasil":
        query = args.get("query", "")
        search_path = args.get("path", "")
        target = YGGDRASIL_DEW / search_path if search_path else YGGDRASIL_DEW
        r = subprocess.run(
            ["grep", "-r", "-l", "-i", query, str(target)],
            capture_output=True, text=True, timeout=15
        )
        files = [l for l in r.stdout.strip().split("\n") if l]
        return [types.TextContent(type="text", text=json.dumps({
            "trace_id": trace_id,
            "query": query,
            "files_found": len(files),
            "files": files[:20]
        }, indent=2))]

    elif name == "create_issue":
        # En producción: llamada a GitHub API
        # Por ahora: registrar la intención y devolver dry_run
        return [types.TextContent(type="text", text=json.dumps({
            "trace_id": trace_id,
            "action": "create_issue",
            "dry_run": True,
            "title": args.get("title"),
            "note": "Conectar a GitHub API con token de agente para activar"
        }, indent=2))]

    elif name == "run_script_safe":
        script_name = args.get("script_name", "")
        script_path = YGGDRASIL_DEW / "scripts" / script_name
        dry_run = args.get("dry_run", True)
        if dry_run or not script_path.exists():
            return [types.TextContent(type="text", text=json.dumps({
                "trace_id": trace_id,
                "dry_run": True,
                "would_run": f"bash {script_path}",
                "exists": script_path.exists()
            }, indent=2))]
        r = subprocess.run(
            ["bash", str(script_path)] + args.get("args", []),
            capture_output=True, text=True, timeout=60
        )
        return [types.TextContent(type="text", text=json.dumps({
            "trace_id": trace_id,
            "returncode": r.returncode,
            "stdout": r.stdout[:2000],
            "stderr": r.stderr[:500]
        }, indent=2))]

    return [types.TextContent(type="text", text=f"Tool '{name}' no implementada en v2.")]


# ─── Entry point ────────────────────────────────
if __name__ == "__main__":
    import asyncio
    asyncio.run(stdio_server(server))
