# DISEÑO: MCP Server de Madre

> **Estado:** SPEC LISTO — listo para implementar en Cursor  
> **Destino:** `agentes/mcp-server/DISEÑO.md`  
> **Runtime:** Docker en Madre, puerto 3100 (solo red interna Tailscale)

---

## Objetivo

Exponer las capacidades reales de Madre como MCP tools para que Cursor, Claude Desktop y cualquier IA compatible puedan:
- Consultar el estado real del ecosistema
- Escribir en el inbox
- Leer el roadmap
- Crear issues en GitHub
- Consultar el RAG

---

## Estructura de archivos

```
agentes/mcp-server/
├── DISEÑO.md          ← este archivo
├── mcp_server.py      ← servidor principal
├── tools/
│   ├── docker_tools.py    ← check_docker, restart_container
│   ├── ecosystem_tools.py ← get_ecosystem_snapshot
│   ├── github_tools.py    ← create_issue, list_issues
│   ├── rag_tools.py       ← query_rag
│   └── inbox_tools.py     ← write_inbox, read_inbox
├── docker-compose.yml
├── requirements.txt
└── audit.log
```

---

## Código base: `mcp_server.py`

```python
#!/usr/bin/env python3
"""MCP Server de Madre — expone el ecosistema Yggdrasil como tools MCP."""

from mcp.server import Server
from mcp.server.stdio import stdio_server
from mcp import types
import asyncio
import docker
import requests
import json
from datetime import datetime
from pathlib import Path

SERVER_NAME = "madre-mcp"
SERVER_VERSION = "0.1.0"
AUDIT_LOG = Path("/srv/yggdrasil-dew/audit.log")
INBOX_PATH = Path("/srv/yggdrasil-dew/inbox")
GITHUB_REPO = "alvarofernandezmota-tech/yggdrasil-secops"
GITHUB_TOKEN_ENV = "GITHUB_TOKEN"

app = Server(SERVER_NAME)


def audit(tool_name: str, args: dict, result: str):
    """Audit log obligatorio en cada llamada."""
    entry = {
        "ts": datetime.utcnow().isoformat(),
        "tool": tool_name,
        "args": args,
        "result_preview": result[:200]
    }
    AUDIT_LOG.parent.mkdir(parents=True, exist_ok=True)
    with AUDIT_LOG.open("a") as f:
        f.write(json.dumps(entry) + "\n")


@app.list_tools()
async def list_tools() -> list[types.Tool]:
    return [
        types.Tool(
            name="check_docker",
            description="Lista contenedores Docker con su estado (running/stopped/restarting)",
            inputSchema={"type": "object", "properties": {}, "required": []}
        ),
        types.Tool(
            name="get_ecosystem_snapshot",
            description="Devuelve snapshot completo del ecosistema: contenedores + servicios + workflows",
            inputSchema={"type": "object", "properties": {}, "required": []}
        ),
        types.Tool(
            name="write_inbox",
            description="Escribe un archivo Markdown en el inbox de yggdrasil-dew",
            inputSchema={
                "type": "object",
                "properties": {
                    "filename": {"type": "string", "description": "Nombre del archivo, ej: 2026-07-03-nota.md"},
                    "content": {"type": "string", "description": "Contenido Markdown"}
                },
                "required": ["filename", "content"]
            }
        ),
        types.Tool(
            name="create_github_issue",
            description="Crea un issue en yggdrasil-secops con título y cuerpo",
            inputSchema={
                "type": "object",
                "properties": {
                    "title": {"type": "string"},
                    "body": {"type": "string"},
                    "labels": {"type": "array", "items": {"type": "string"}}
                },
                "required": ["title", "body"]
            }
        ),
        types.Tool(
            name="query_rag",
            description="Pregunta al RAG local (Qdrant + bge-m3) sobre el ecosistema o el second-brain",
            inputSchema={
                "type": "object",
                "properties": {
                    "question": {"type": "string"}
                },
                "required": ["question"]
            }
        )
    ]


@app.call_tool()
async def call_tool(name: str, arguments: dict) -> list[types.TextContent]:
    result = ""

    if name == "check_docker":
        client = docker.from_env()
        containers = client.containers.list(all=True)
        lines = [f"{c.name}: {c.status}" for c in containers]
        result = "\n".join(lines) if lines else "No containers found"

    elif name == "get_ecosystem_snapshot":
        client = docker.from_env()
        containers = [{"name": c.name, "status": c.status} for c in client.containers.list(all=True)]
        result = json.dumps({"timestamp": datetime.utcnow().isoformat(), "containers": containers}, indent=2)

    elif name == "write_inbox":
        filename = arguments["filename"]
        content = arguments["content"]
        target = INBOX_PATH / filename
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text(content, encoding="utf-8")
        result = f"Written: {target}"

    elif name == "create_github_issue":
        import os
        token = os.environ.get(GITHUB_TOKEN_ENV, "")
        payload = {"title": arguments["title"], "body": arguments["body"]}
        if "labels" in arguments:
            payload["labels"] = arguments["labels"]
        resp = requests.post(
            f"https://api.github.com/repos/{GITHUB_REPO}/issues",
            json=payload,
            headers={"Authorization": f"token {token}", "Accept": "application/vnd.github+json"}
        )
        data = resp.json()
        result = f"Issue creado: #{data.get('number')} — {data.get('html_url')}"

    elif name == "query_rag":
        # Placeholder: conectar con el RAG local cuando esté desplegado
        result = f"[RAG pendiente de conectar] Pregunta recibida: {arguments['question']}"

    else:
        result = f"Tool desconocida: {name}"

    audit(name, arguments, result)
    return [types.TextContent(type="text", text=result)]


async def main():
    async with stdio_server() as (read_stream, write_stream):
        await app.run(read_stream, write_stream, app.create_initialization_options())


if __name__ == "__main__":
    asyncio.run(main())
```

---

## `docker-compose.yml`

```yaml
version: '3.8'

services:
  madre-mcp:
    build: .
    container_name: madre-mcp-server
    restart: unless-stopped
    environment:
      - GITHUB_TOKEN=${GITHUB_TOKEN}
    volumes:
      - /srv/yggdrasil-dew:/srv/yggdrasil-dew
      - /var/run/docker.sock:/var/run/docker.sock
    ports:
      - "127.0.0.1:3100:3100"  # Solo red interna
    networks:
      - yggdrasil-internal

networks:
  yggdrasil-internal:
    external: true
```

---

## `requirements.txt`

```
mcp>=1.0.0
docker>=7.0.0
requests>=2.31.0
uvicorn>=0.30.0
```

---

## Configuración en Cursor

Añadir en `~/.cursor/mcp.json` o Settings → MCP Servers:

```json
{
  "mcpServers": {
    "madre": {
      "command": "python",
      "args": ["/srv/yggdrasil-dew/agentes/mcp-server/mcp_server.py"],
      "env": {
        "GITHUB_TOKEN": "<tu-token>"
      }
    }
  }
}
```

---

## Pasos de implementación (para hacer en Cursor)

```bash
# 1. Crear estructura
mkdir -p agentes/mcp-server/tools

# 2. Copiar archivos de este spec

# 3. Instalar dependencias en Madre
pip install mcp docker requests

# 4. Test local
python agentes/mcp-server/mcp_server.py

# 5. Configurar Cursor
# Settings → MCP Servers → añadir "madre"

# 6. Test: en Cursor preguntar
# "usa la tool check_docker y díme qué contenedores están caídos"
```

---

*Generado: 2026-07-03 17:22 CEST | Listo para implementar con Cursor*
