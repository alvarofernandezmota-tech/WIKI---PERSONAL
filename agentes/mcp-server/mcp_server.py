# mcp_server.py
# MCP Server propio de Madre — expone tools del ecosistema a IAs externas
# Estado: ESQUELETO — Fase 1 MVP
# Docs: agentes/mcp-server/DISEÑO.md
# Instalar: pip install mcp fastapi uvicorn

import subprocess
import json
from pathlib import Path
from datetime import datetime
from mcp.server import Server
from mcp.server.stdio import stdio_server
from mcp import types

# ─── Config ─────────────────────────────────────────
# Cargar desde env en producción
YGGDRASIL_DEW = Path("/srv/yggdrasil-dew")
AUDIT_LOG = Path("/srv/mcp-server/audit.log")

server = Server("madre-ecosystem")


# ─── Audit log (inmutable, append-only) ──────────────────────
def audit(tool_name: str, args: dict, caller: str = "unknown"):
    AUDIT_LOG.parent.mkdir(parents=True, exist_ok=True)
    entry = {
        "ts": datetime.utcnow().isoformat(),
        "tool": tool_name,
        "args": args,
        "caller": caller
    }
    with AUDIT_LOG.open("a") as f:
        f.write(json.dumps(entry) + "\n")


# ─── Tool definitions ──────────────────────────────────
@server.list_tools()
async def list_tools():
    return [
        types.Tool(
            name="check_docker",
            description="Lista todos los contenedores Docker con su estado actual.",
            inputSchema={
                "type": "object",
                "properties": {
                    "container": {
                        "type": "string",
                        "description": "Nombre del contenedor específico (opcional)"
                    }
                }
            }
        ),
        types.Tool(
            name="get_ecosystem_state",
            description="Lee el estado actual del ecosistema (ECOSYSTEM-STATE.md).",
            inputSchema={"type": "object", "properties": {}}
        ),
        types.Tool(
            name="read_roadmap",
            description="Lee el ROADMAP-MASTER.md del ecosistema.",
            inputSchema={"type": "object", "properties": {}}
        ),
        types.Tool(
            name="list_services",
            description="Lista los servicios activos del ecosistema con su estado.",
            inputSchema={"type": "object", "properties": {}}
        ),
    ]


# ─── Tool implementations ────────────────────────────────
@server.call_tool()
async def call_tool(name: str, arguments: dict):
    audit(name, arguments)

    if name == "check_docker":
        try:
            cmd = ["docker", "ps", "--format",
                   '{{json .}}']
            if arguments.get("container"):
                cmd += ["--filter", f"name={arguments['container']}"]
            result = subprocess.run(cmd, capture_output=True, text=True, timeout=10)
            lines = [json.loads(l) for l in result.stdout.strip().split("\n") if l]
            return [types.TextContent(
                type="text",
                text=json.dumps(lines, indent=2, ensure_ascii=False)
            )]
        except Exception as e:
            return [types.TextContent(type="text", text=f"Error: {e}")]

    elif name == "get_ecosystem_state":
        path = YGGDRASIL_DEW / "ECOSYSTEM-STATE.md"  # thdora tiene el suyo
        # Intentar también el de yggdrasil-dew
        state_path = YGGDRASIL_DEW / "ESTADO-SISTEMA.md"
        content = ""
        for p in [path, state_path]:
            if p.exists():
                content = p.read_text(encoding="utf-8")
                break
        if not content:
            content = "ECOSYSTEM-STATE.md no encontrado en la ruta configurada."
        return [types.TextContent(type="text", text=content)]

    elif name == "read_roadmap":
        path = YGGDRASIL_DEW / "ROADMAP-MASTER.md"
        if not path.exists():
            return [types.TextContent(type="text", text="ROADMAP-MASTER.md no encontrado.")]
        return [types.TextContent(type="text", text=path.read_text(encoding="utf-8"))]

    elif name == "list_services":
        # Lee el ESTADO-SISTEMA.md y extrae sección de servicios
        path = YGGDRASIL_DEW / "ESTADO-SISTEMA.md"
        if path.exists():
            content = path.read_text(encoding="utf-8")
            # Devolver las primeras 100 líneas con sección de servicios
            lines = content.split("\n")
            return [types.TextContent(type="text", text="\n".join(lines[:80]))]
        return [types.TextContent(type="text", text="Estado del sistema no disponible.")]

    return [types.TextContent(type="text", text=f"Tool '{name}' no implementada.")]


# ─── Entry point ───────────────────────────────────────
if __name__ == "__main__":
    import asyncio
    asyncio.run(stdio_server(server))
