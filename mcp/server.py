#!/usr/bin/env python3
# ============================================================
# NOMBRE:   mcp/server.py
# VERSION:  1.0.0
# FUNCIÓN:  MCP Server principal — expone TODOS los agentes
#           y herramientas del ecosistema yggdrasil-dew como
#           tools MCP (Streamable HTTP + stdio)
# AUTOR:    yggdrasil-dew ecosystem
# REPO:     alvarofernandezmota-tech/yggdrasil-dew
# USO:      python3 mcp/server.py [--port 8080] [--stdio]
# ============================================================

import argparse
import asyncio
import json
import os
import subprocess
import sys
from datetime import datetime
from pathlib import Path
from typing import Any

try:
    from mcp.server import Server
    from mcp.server.stdio import stdio_server
    from mcp.server.sse import SseServerTransport
    from mcp import types
except ImportError:
    print("[ERROR] MCP SDK no instalado. Ejecuta: pip install mcp", file=sys.stderr)
    sys.exit(1)

ROOT = Path(os.environ.get("YGGDRASIL_ROOT", Path(__file__).parent.parent))
SCRIPTS = ROOT / "scripts"
AGENTES = ROOT / "scripts" / "agentes"
INBOX = ROOT / "inbox"
DIARY = ROOT / "diary"

app = Server("yggdrasil-mcp")

# ──────────────────────────────────────────
# REGISTRO DE TOOLS
# ──────────────────────────────────────────

@app.list_tools()
async def list_tools() -> list[types.Tool]:
    return [
        types.Tool(
            name="orquestador_total",
            description="Ejecuta el orquestador completo del ecosistema: audita, sincroniza islas, verifica CORE y genera reporte.",
            inputSchema={"type": "object", "properties": {"modo": {"type": "string", "enum": ["completo", "rapido", "solo-auditoria"], "default": "completo"}}, "required": []}
        ),
        types.Tool(
            name="galatea_fabrica_agente",
            description="Fabrica un nuevo agente bash con plantilla estándar del ecosistema. Recibe nombre, función y tipo.",
            inputSchema={"type": "object", "properties": {"nombre": {"type": "string"}, "funcion": {"type": "string"}, "tipo": {"type": "string", "enum": ["auditor", "gestor", "reporter", "orquestador", "vigilante"], "default": "auditor"}}, "required": ["nombre", "funcion"]}
        ),
        types.Tool(
            name="agente_meta_deep",
            description="Audita profundamente el ecosistema con LLM local (Ollama) y propone mejoras, detecta deuda técnica y genera issues.",
            inputSchema={"type": "object", "properties": {"scope": {"type": "string", "enum": ["full", "scripts", "docs", "workflows", "islas"], "default": "full"}, "modelo": {"type": "string", "default": "llama3"}}, "required": []}
        ),
        types.Tool(
            name="llm_router",
            description="Enruta prompts al LLM adecuado: Ollama (local) u OpenAI/Anthropic (remoto). Soporte multi-modelo.",
            inputSchema={"type": "object", "properties": {"prompt": {"type": "string"}, "proveedor": {"type": "string", "enum": ["ollama", "openai", "anthropic", "auto"], "default": "auto"}, "modelo": {"type": "string"}, "temperatura": {"type": "number", "default": 0.3}}, "required": ["prompt"]}
        ),
        types.Tool(
            name="struct_auditor",
            description="Detecta carpetas duplicadas, archivos fantasma y estructura inconsistente. Abre issues automáticos.",
            inputSchema={"type": "object", "properties": {"fix": {"type": "boolean", "default": False}}, "required": []}
        ),
        types.Tool(
            name="ghost_file_detector",
            description="Encuentra archivos vacíos, huérfanos o referenciados en docs pero inexistentes en disco.",
            inputSchema={"type": "object", "properties": {"ruta": {"type": "string", "default": "."}}, "required": []}
        ),
        types.Tool(
            name="isla_sync_validator",
            description="Verifica que MAPA-ISLAS.md y docs de islas reflejan la estructura real del repo.",
            inputSchema={"type": "object", "properties": {}, "required": []}
        ),
        types.Tool(
            name="watchdog",
            description="Monitor continuo del ecosistema: detecta SLA violations, agentes colgados y genera alertas.",
            inputSchema={"type": "object", "properties": {"sla_horas": {"type": "integer", "default": 24}}, "required": []}
        ),
        types.Tool(
            name="diary_writer",
            description="Escribe entrada de diario con estado del ecosistema, pendientes y deuda técnica.",
            inputSchema={"type": "object", "properties": {"titulo": {"type": "string"}, "contenido": {"type": "string"}}, "required": ["titulo", "contenido"]}
        ),
        types.Tool(
            name="issue_creator",
            description="Crea issue en GitHub con template estándar del ecosistema.",
            inputSchema={"type": "object", "properties": {"titulo": {"type": "string"}, "cuerpo": {"type": "string"}, "labels": {"type": "array", "items": {"type": "string"}}}, "required": ["titulo", "cuerpo"]}
        ),
        types.Tool(
            name="health_check",
            description="Pulso completo del ecosistema: scripts, workflows, MCP server, Ollama, APIs remotas.",
            inputSchema={"type": "object", "properties": {}, "required": []}
        )
    ]

# ──────────────────────────────────────────
# IMPLEMENTACIÓN DE TOOLS
# ──────────────────────────────────────────

@app.call_tool()
async def call_tool(name: str, arguments: dict[str, Any]) -> list[types.TextContent]:
    try:
        result = await _dispatch(name, arguments)
        return [types.TextContent(type="text", text=result)]
    except Exception as e:
        return [types.TextContent(type="text", text=f"[ERROR] {name}: {e}")]

async def _dispatch(name: str, args: dict) -> str:
    if name == "orquestador_total":
        return await _run_script("orquestador-total.sh", [args.get("modo", "completo")])
    elif name == "galatea_fabrica_agente":
        return await _galatea(args)
    elif name == "agente_meta_deep":
        return await _meta_deep(args)
    elif name == "llm_router":
        return await _llm_router(args)
    elif name == "struct_auditor":
        return await _run_script("struct-auditor.sh", ["--fix"] if args.get("fix") else [])
    elif name == "ghost_file_detector":
        return await _run_script("ghost-file-detector.sh", [args.get("ruta", ".")])
    elif name == "isla_sync_validator":
        return await _run_script("isla-sync-validator.sh", [])
    elif name == "watchdog":
        return await _run_script("watchdog.sh", [str(args.get("sla_horas", 24))])
    elif name == "diary_writer":
        return _diary_write(args["titulo"], args["contenido"])
    elif name == "issue_creator":
        return await _issue_create(args)
    elif name == "health_check":
        return await _health_check()
    else:
        return f"[ERROR] Tool desconocida: {name}"

async def _run_script(script: str, extra_args: list[str]) -> str:
    script_path = SCRIPTS / script
    if not script_path.exists():
        script_path = AGENTES / script
    if not script_path.exists():
        return f"[WARN] Script no encontrado: {script} — pendiente de implementar"
    cmd = ["bash", str(script_path)] + extra_args
    proc = await asyncio.create_subprocess_exec(*cmd, stdout=asyncio.subprocess.PIPE, stderr=asyncio.subprocess.PIPE, cwd=str(ROOT))
    stdout, stderr = await asyncio.wait_for(proc.communicate(), timeout=120)
    output = stdout.decode() + ("\n[STDERR]\n" + stderr.decode() if stderr else "")
    return output[:4000] if len(output) > 4000 else output

async def _galatea(args: dict) -> str:
    nombre = args["nombre"].lower().replace(" ", "-")
    funcion = args["funcion"]
    tipo = args.get("tipo", "auditor")
    timestamp = datetime.now().strftime("%Y-%m-%d")
    plantilla = f"""#!/usr/bin/env bash
# ============================================================
# NOMBRE:   scripts/agentes/{nombre}.sh
# VERSION:  1.0.0
# FUNCIÓN:  {funcion}
# TIPO:     {tipo}
# CREADO:   {timestamp} por Galatea (mcp/server.py)
# REPO:     alvarofernandezmota-tech/yggdrasil-dew
# USO:      bash scripts/agentes/{nombre}.sh
# ============================================================
set -euo pipefail
ROOT="$(cd "$(dirname "${{BASH_SOURCE[0]}}")/../../" && pwd)"
INBOX="$ROOT/inbox"
DIARY="$ROOT/diary"
LOG="$INBOX/{nombre}-$(date +%Y%m%d-%H%M%S).log"
mkdir -p "$INBOX" "$DIARY"
echo "[$(date)] [{nombre}] Inicio" | tee "$LOG"

# ── LÓGICA PRINCIPAL ──────────────────────────────────────
# TODO: Implementar lógica de: {funcion}
echo "[$(date)] [{nombre}] Función: {funcion}" | tee -a "$LOG"

# ── DOCUMENTAR ────────────────────────────────────────────
echo "[$(date)] [{nombre}] Completado OK" | tee -a "$LOG"
echo "  → Log: $LOG"
"""
    target = AGENTES / f"{nombre}.sh"
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(plantilla)
    target.chmod(0o755)
    return f"[OK] Agente generado: scripts/agentes/{nombre}.sh\nFunción: {funcion}\nTipo: {tipo}\nPendiente: implementar lógica en sección TODO"

async def _meta_deep(args: dict) -> str:
    scope = args.get("scope", "full")
    modelo = args.get("modelo", "llama3")
    scripts_list = []
    if scope in ("full", "scripts"):
        for p in SCRIPTS.rglob("*.sh"):
            scripts_list.append(str(p.relative_to(ROOT)))
    docs_issues = []
    if scope in ("full", "docs"):
        for p in (ROOT / "docs").glob("*.md"):
            docs_issues.append(str(p.relative_to(ROOT)))
    context = f"Ecosistema yggdrasil-dew\nScripts encontrados: {len(scripts_list)}\nDocs: {len(docs_issues)}\nScope: {scope}"
    prompt = f"""Eres un auditor técnico de nivel ingeniero para el repositorio yggdrasil-dew.
{context}
Analiza el ecosistema y responde en español:
1. ¿Qué gaps críticos detectas?
2. ¿Qué scripts o agentes faltan?
3. ¿Qué mejoras propones con prioridad alta?
4. ¿Hay deuda técnica urgente?
Sé específico, milimétrico y accionable."""
    llm_result = await _llm_router({"prompt": prompt, "proveedor": "ollama", "modelo": modelo})
    ts = datetime.now().strftime("%Y-%m-%d-%H%M%S")
    log_path = INBOX / f"meta-deep-{ts}.md"
    log_path.write_text(f"# Auditoría Meta-Deep\n**Fecha:** {ts}\n**Scope:** {scope}\n**Modelo:** {modelo}\n\n{llm_result}\n")
    return f"[OK] Auditoría meta-deep completada\nLog: inbox/meta-deep-{ts}.md\n\n{llm_result[:2000]}"

async def _llm_router(args: dict) -> str:
    prompt = args["prompt"]
    proveedor = args.get("proveedor", "auto")
    modelo = args.get("modelo", "")
    temperatura = args.get("temperatura", 0.3)
    if proveedor == "auto":
        try:
            proc = await asyncio.create_subprocess_exec("ollama", "list", stdout=asyncio.subprocess.PIPE, stderr=asyncio.subprocess.PIPE)
            await asyncio.wait_for(proc.communicate(), timeout=5)
            proveedor = "ollama"
        except Exception:
            proveedor = "openai" if os.environ.get("OPENAI_API_KEY") else "anthropic"
    if proveedor == "ollama":
        m = modelo or "llama3"
        try:
            proc = await asyncio.create_subprocess_exec("ollama", "run", m, prompt, stdout=asyncio.subprocess.PIPE, stderr=asyncio.subprocess.PIPE)
            stdout, _ = await asyncio.wait_for(proc.communicate(), timeout=120)
            return stdout.decode().strip() or "[Ollama: sin respuesta]"
        except FileNotFoundError:
            return "[WARN] Ollama no instalado. Instala desde https://ollama.ai"
        except asyncio.TimeoutError:
            return "[WARN] Ollama timeout — modelo tardó más de 120s"
    elif proveedor == "openai":
        api_key = os.environ.get("OPENAI_API_KEY", "")
        if not api_key:
            return "[ERROR] OPENAI_API_KEY no configurada"
        try:
            import urllib.request, json as _json
            m = modelo or "gpt-4o-mini"
            payload = _json.dumps({"model": m, "messages": [{"role": "user", "content": prompt}], "temperature": temperatura}).encode()
            req = urllib.request.Request("https://api.openai.com/v1/chat/completions", data=payload, headers={"Authorization": f"Bearer {api_key}", "Content-Type": "application/json"})
            with urllib.request.urlopen(req, timeout=60) as r:
                data = _json.loads(r.read())
            return data["choices"][0]["message"]["content"]
        except Exception as e:
            return f"[ERROR] OpenAI: {e}"
    elif proveedor == "anthropic":
        api_key = os.environ.get("ANTHROPIC_API_KEY", "")
        if not api_key:
            return "[ERROR] ANTHROPIC_API_KEY no configurada"
        try:
            import urllib.request, json as _json
            m = modelo or "claude-3-haiku-20240307"
            payload = _json.dumps({"model": m, "max_tokens": 2048, "messages": [{"role": "user", "content": prompt}]}).encode()
            req = urllib.request.Request("https://api.anthropic.com/v1/messages", data=payload, headers={"x-api-key": api_key, "anthropic-version": "2023-06-01", "Content-Type": "application/json"})
            with urllib.request.urlopen(req, timeout=60) as r:
                data = _json.loads(r.read())
            return data["content"][0]["text"]
        except Exception as e:
            return f"[ERROR] Anthropic: {e}"
    return f"[ERROR] Proveedor desconocido: {proveedor}"

def _diary_write(titulo: str, contenido: str) -> str:
    ts = datetime.now().strftime("%Y-%m-%d")
    fname = DIARY / f"{ts}-{titulo.lower().replace(' ','-')[:40]}.md"
    DIARY.mkdir(parents=True, exist_ok=True)
    fname.write_text(f"# {titulo}\n**Fecha:** {ts}\n\n{contenido}\n")
    return f"[OK] Diario escrito: {fname.relative_to(ROOT)}"

async def _issue_create(args: dict) -> str:
    titulo = args["titulo"]
    cuerpo = args["cuerpo"]
    labels = args.get("labels", ["ecosistema", "auto-generated"])
    labels_str = ",".join(labels)
    try:
        proc = await asyncio.create_subprocess_exec(
            "gh", "issue", "create", "--title", titulo, "--body", cuerpo, "--label", labels_str,
            stdout=asyncio.subprocess.PIPE, stderr=asyncio.subprocess.PIPE, cwd=str(ROOT)
        )
        stdout, stderr = await asyncio.wait_for(proc.communicate(), timeout=30)
        return stdout.decode().strip() or stderr.decode().strip()
    except FileNotFoundError:
        return "[WARN] gh CLI no instalado — issue no creado automáticamente"

async def _health_check() -> str:
    checks = []
    checks.append(f"ROOT: {ROOT} — {'✅' if ROOT.exists() else '❌'}") 
    checks.append(f"scripts/: {'✅' if SCRIPTS.exists() else '❌'}")
    checks.append(f"inbox/: {'✅' if INBOX.exists() else '❌'}")
    checks.append(f"diary/: {'✅' if DIARY.exists() else '❌'}")
    checks.append(f"docs/CORE-ECOSISTEMA.md: {'✅' if (ROOT/'docs'/'CORE-ECOSISTEMA.md').exists() else '❌'}")
    try:
        proc = await asyncio.create_subprocess_exec("ollama", "list", stdout=asyncio.subprocess.PIPE, stderr=asyncio.subprocess.PIPE)
        stdout, _ = await asyncio.wait_for(proc.communicate(), timeout=5)
        checks.append(f"Ollama: ✅ ({stdout.decode().count(chr(10))-1} modelos)")
    except Exception:
        checks.append("Ollama: ❌ no disponible")
    checks.append(f"OPENAI_API_KEY: {'✅ configurada' if os.environ.get('OPENAI_API_KEY') else '⚠️  no configurada'}")
    checks.append(f"ANTHROPIC_API_KEY: {'✅ configurada' if os.environ.get('ANTHROPIC_API_KEY') else '⚠️  no configurada'}")
    return "\n".join(checks)

# ──────────────────────────────────────────
# ENTRYPOINT
# ──────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(description="Yggdrasil MCP Server")
    parser.add_argument("--port", type=int, default=8080)
    parser.add_argument("--stdio", action="store_true")
    args = parser.parse_args()
    if args.stdio:
        asyncio.run(stdio_server(app))
    else:
        from mcp.server.sse import SseServerTransport
        import uvicorn
        from starlette.applications import Starlette
        from starlette.routing import Route, Mount
        transport = SseServerTransport("/messages")
        async def handle_sse(request):
            async with transport.connect_sse(request.scope, request.receive, request._send) as streams:
                await app.run(streams[0], streams[1], app.create_initialization_options())
        starlette_app = Starlette(routes=[Route("/sse", endpoint=handle_sse), Mount("/messages", app=transport.handle_post_message)])
        print(f"[MCP] Yggdrasil MCP Server escuchando en http://0.0.0.0:{args.port}/sse")
        uvicorn.run(starlette_app, host="0.0.0.0", port=args.port)

if __name__ == "__main__":
    main()
