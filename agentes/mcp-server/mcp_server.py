#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Yggdrasil-DEW Ecosistema - Model Context Protocol Server
Nodo: Madre (varpc) | Puerto: 8002
Estilo: Python 3.11+, Type Hints, async, no globals mutables.
Última modificación: 2026-07-03 [AUTO]

Tools expuestas:
  - write_inbox: escribe .md en inbox/ → dispara inbox-watcher → GitHub Actions
  - read_roadmap: lee ROADMAP-MASTER.md (fuente de verdad)
  - list_issues: lista issues por label via gh CLI
  - ecosystem_health: snapshot rápido del estado del sistema
  - list_scripts: inventario de scripts disponibles
"""

import os
import json
import logging
import subprocess
from typing import Any
from pathlib import Path
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field

# ── Logging estructurado ───────────────────────────────────────────────────────
logging.basicConfig(
    level=logging.INFO,
    format="[%(asctime)s] [%(levelname)s] [AUTO] %(message)s",
    handlers=[
        logging.FileHandler("/var/log/mcp-server.log"),
        logging.StreamHandler(),
    ],
)
logger = logging.getLogger(__name__)

# ── Configuración ─────────────────────────────────────────────────────────────
REPO_ROOT = Path(os.getenv("YGG_REPO_DIR", "/srv/yggdrasil-dew"))
INBOX_DIR = REPO_ROOT / "inbox"
SCRIPTS_DIR = REPO_ROOT / "scripts"

app = FastAPI(
    title="Yggdrasil-DEW MCP Server",
    description="Expone el ecosistema Yggdrasil como tools para LLMs via MCP/HTTP",
    version="1.0.0",
)


# ── Schemas Pydantic ──────────────────────────────────────────────────────────
class WriteInboxPayload(BaseModel):
    content: str = Field(..., description="Contenido Markdown a escribir en inbox/")
    filename: str = Field(..., description="Nombre del archivo. Ej: '2026-07-03-nota.md'")


class ListIssuesPayload(BaseModel):
    label: str = Field("AUTO", description="Label a filtrar: AUTO, HUMAN, RISKY, DRIFT")


class RunScriptPayload(BaseModel):
    script_name: str = Field(..., description="Nombre del script en scripts/ (sin ruta)")
    dry_run: bool = Field(True, description="Si true, ejecuta con YGG_DRY_RUN=true")


# ── Helpers internos ──────────────────────────────────────────────────────────
def _safe_filename(filename: str) -> str:
    """Sanitiza nombre de archivo — solo permite alfanumérico, guiones, puntos."""
    import re
    clean = re.sub(r"[^a-zA-Z0-9_\-\.]", "_", Path(filename).name)
    if not clean.endswith(".md"):
        clean += ".md"
    return clean


def _run_gh_cli(args: list[str]) -> dict[str, Any]:
    """Ejecuta gh CLI heredando la sesión SSH de varopc."""
    try:
        result = subprocess.run(
            ["gh"] + args,
            capture_output=True,
            text=True,
            check=True,
            cwd=str(REPO_ROOT),
        )
        return {"status": "success", "data": json.loads(result.stdout) if result.stdout.strip() else []}
    except subprocess.CalledProcessError as e:
        logger.error(f"gh CLI error: {e.stderr}")
        return {"status": "error", "message": e.stderr}
    except json.JSONDecodeError:
        return {"status": "success", "data": result.stdout}


# ── Tools / Endpoints ─────────────────────────────────────────────────────────

@app.get("/health")
async def health_check() -> dict[str, Any]:
    """Estado del MCP server y del ecosistema."""
    return {
        "status": "online",
        "ecosystem": "yggdrasil-dew",
        "node": "Madre (varpc)",
        "repo_root": str(REPO_ROOT),
        "repo_exists": REPO_ROOT.exists(),
        "inbox_exists": INBOX_DIR.exists(),
    }


@app.post("/tools/write_inbox")
async def tool_write_inbox(payload: WriteInboxPayload) -> dict[str, Any]:
    """
    Escribe un .md en inbox/ → inbox-watcher lo detecta →
    commit [AUTO] → push → GitHub Actions disparadas.
    """
    try:
        filename = _safe_filename(payload.filename)
        inbox_path = INBOX_DIR / filename
        INBOX_DIR.mkdir(parents=True, exist_ok=True)
        inbox_path.write_text(payload.content, encoding="utf-8")
        logger.info(f"write_inbox: {filename} ({len(payload.content)} chars)")
        return {
            "status": "success",
            "message": f"Escrito en inbox/{filename}. inbox-watcher detectará y hará commit [AUTO].",
            "path": str(inbox_path),
        }
    except Exception as e:
        logger.error(f"write_inbox error: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/tools/read_roadmap")
async def tool_read_roadmap() -> dict[str, Any]:
    """Lee ROADMAP-MASTER.md — fuente de verdad del ecosistema."""
    roadmap_path = REPO_ROOT / "ROADMAP-MASTER.md"
    if not roadmap_path.exists():
        raise HTTPException(status_code=404, detail="ROADMAP-MASTER.md no encontrado")
    content = roadmap_path.read_text(encoding="utf-8")
    logger.info(f"read_roadmap: {len(content)} chars leídos")
    return {"status": "success", "content": content, "size_chars": len(content)}


@app.post("/tools/list_issues")
async def tool_list_issues(payload: ListIssuesPayload) -> dict[str, Any]:
    """Lista issues de GitHub filtrados por label."""
    result = _run_gh_cli([
        "issue", "list",
        "--label", payload.label,
        "--json", "number,title,state,createdAt,labels",
    ])
    return result


@app.get("/tools/list_scripts")
async def tool_list_scripts() -> dict[str, Any]:
    """Inventario de scripts disponibles en el ecosistema."""
    if not SCRIPTS_DIR.exists():
        return {"status": "error", "message": "scripts/ no encontrado"}
    scripts = [
        {"name": f.name, "size_bytes": f.stat().st_size, "type": f.suffix}
        for f in sorted(SCRIPTS_DIR.iterdir())
        if f.is_file() and f.suffix in (".sh", ".py")
    ]
    return {"status": "success", "count": len(scripts), "scripts": scripts}


@app.post("/tools/run_script")
async def tool_run_script(payload: RunScriptPayload) -> dict[str, Any]:
    """
    Ejecuta un script safe del ecosistema.
    Por defecto en DRY_RUN=true — nunca ejecuta en producción sin confirmación.
    """
    script_path = SCRIPTS_DIR / Path(payload.script_name).name
    if not script_path.exists():
        raise HTTPException(status_code=404, detail=f"Script no encontrado: {payload.script_name}")
    if not script_path.suffix in (".sh", ".py"):
        raise HTTPException(status_code=400, detail="Solo se permiten .sh y .py")

    env = os.environ.copy()
    env["YGG_DRY_RUN"] = "true" if payload.dry_run else "false"

    try:
        result = subprocess.run(
            ["bash", str(script_path)] if script_path.suffix == ".sh" else ["python3", str(script_path)],
            capture_output=True,
            text=True,
            timeout=60,
            cwd=str(REPO_ROOT),
            env=env,
        )
        logger.info(f"run_script: {payload.script_name} dry={payload.dry_run} rc={result.returncode}")
        return {
            "status": "success" if result.returncode == 0 else "error",
            "dry_run": payload.dry_run,
            "returncode": result.returncode,
            "stdout": result.stdout[-2000:],  # últimos 2000 chars
            "stderr": result.stderr[-500:],
        }
    except subprocess.TimeoutExpired:
        raise HTTPException(status_code=408, detail="Script timeout (60s)")


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8002, log_level="info")
