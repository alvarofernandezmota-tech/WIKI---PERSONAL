"""
MCP Server - Yggdrasil Ecosystem
Madre runtime | Compatible: Cursor, Claude Desktop, agentes locales
SIEMPRE dry_run=True por defecto. Audit log obligatorio.
"""
import json
import subprocess
import datetime
from pathlib import Path
from mcp.server.fastmcp import FastMCP

AUDIT_LOG = Path("/srv/yggdrasil-dew/logs/mcp-audit.jsonl")
ROADMAP   = Path("/srv/yggdrasil-dew/ROADMAP-MASTER.md")
INBOX     = Path("/srv/yggdrasil-dew/inbox")
DEW_ROOT  = Path("/srv/yggdrasil-dew")

mcp = FastMCP("yggdrasil-mcp")

def _audit(tool: str, args: dict, result: str, dry_run: bool):
    AUDIT_LOG.parent.mkdir(parents=True, exist_ok=True)
    entry = {
        "ts": datetime.datetime.utcnow().isoformat(),
        "tool": tool,
        "args": args,
        "dry_run": dry_run,
        "result_snippet": result[:200]
    }
    with AUDIT_LOG.open("a") as f:
        f.write(json.dumps(entry) + "\n")

@mcp.tool()
def check_docker(dry_run: bool = True) -> str:
    """Lista contenedores Docker y su estado. [AUTO]"""
    result = subprocess.run(
        ["docker", "ps", "-a", "--format", "{{.Names}}\t{{.Status}}\t{{.Image}}"],
        capture_output=True, text=True
    )
    out = result.stdout or "Sin contenedores"
    _audit("check_docker", {"dry_run": dry_run}, out, dry_run)
    return out

@mcp.tool()
def get_ecosystem_state(dry_run: bool = True) -> str:
    """Estado global: contenedores + servicios críticos. [AUTO]"""
    containers = subprocess.run(
        ["docker", "ps", "--format", "{{.Names}}:{{.Status}}"],
        capture_output=True, text=True
    ).stdout
    _audit("get_ecosystem_state", {}, containers, dry_run)
    return f"=== ECOSYSTEM STATE ===\n{containers}"

@mcp.tool()
def read_roadmap() -> str:
    """Lee ROADMAP-MASTER.md completo. [AUTO]"""
    if ROADMAP.exists():
        content = ROADMAP.read_text(encoding="utf-8")
        _audit("read_roadmap", {}, content[:100], False)
        return content
    return "ROADMAP-MASTER.md no encontrado."

@mcp.tool()
def list_services(dry_run: bool = True) -> str:
    """Lista servicios activos en Madre. [AUTO]"""
    result = subprocess.run(
        ["docker", "ps", "--filter", "status=running",
         "--format", "{{.Names}}\t{{.Ports}}"],
        capture_output=True, text=True
    )
    out = result.stdout or "Sin servicios activos"
    _audit("list_services", {"dry_run": dry_run}, out, dry_run)
    return out

@mcp.tool()
def write_inbox(content: str, filename: str, dry_run: bool = True) -> str:
    """Escribe un mensaje en el inbox del ecosistema. [AUTO] dry_run por defecto."""
    _audit("write_inbox", {"filename": filename, "dry_run": dry_run}, content[:100], dry_run)
    if dry_run:
        return f"[DRY_RUN] Escribiría en inbox/{filename}:\n{content[:200]}"
    INBOX.mkdir(parents=True, exist_ok=True)
    target = INBOX / filename
    target.write_text(content, encoding="utf-8")
    return f"✅ Escrito en inbox/{filename}"

@mcp.tool()
def list_issues(label: str = "") -> str:
    """Lista issues GitHub de yggdrasil-dew. Requiere gh CLI configurado. [AUTO]"""
    cmd = ["gh", "issue", "list", "--repo", "alvarofernandezmota-tech/yggdrasil-dew",
           "--json", "number,title,labels,state", "--limit", "20"]
    if label:
        cmd += ["--label", label]
    result = subprocess.run(cmd, capture_output=True, text=True)
    out = result.stdout or result.stderr
    _audit("list_issues", {"label": label}, out[:100], False)
    return out

@mcp.tool()
def restart_container(name: str, dry_run: bool = True) -> str:
    """Reinicia un contenedor Docker. [RISKY] dry_run=True por defecto."""
    _audit("restart_container", {"name": name, "dry_run": dry_run}, "", dry_run)
    if dry_run:
        return f"[DRY_RUN] Reiniciaría contenedor: {name}"
    result = subprocess.run(["docker", "restart", name], capture_output=True, text=True)
    return result.stdout or result.stderr

if __name__ == "__main__":
    mcp.run(transport="stdio")
