#!/usr/bin/env python3
# mcp/server.py — Servidor MCP real (stdio + HTTP streamable)
# Arrancar: python3 mcp/server.py --port 8080

import sys
import json
import os
import subprocess
import argparse
import threading
from http.server import HTTPServer, BaseHTTPRequestHandler

ROOT = os.getenv("YGGDRASIL_ROOT", os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
TOKEN = os.getenv("MCP_TOKEN", "")

# ── Tools registry ────────────────────────────────────────────────────────────

def tool_orquestador_total(args: dict) -> dict:
    phase = args.get("phase", "all")
    script = os.path.join(ROOT, "scripts", "orquestador-total.sh")
    if not os.path.isfile(script):
        return {"error": f"script not found: {script}"}
    try:
        out = subprocess.run(["bash", script, phase],
                            capture_output=True, text=True, timeout=120,
                            env={**os.environ, "YGGDRASIL_ROOT": ROOT})
        return {"stdout": out.stdout, "stderr": out.stderr, "returncode": out.returncode}
    except Exception as e:
        return {"error": str(e)}

def tool_llm_router(args: dict) -> dict:
    prompt = args.get("prompt", "")
    mode = args.get("mode", "auto")
    script = os.path.join(ROOT, "scripts", "agentes", "llm-router.sh")
    try:
        out = subprocess.run(["bash", script, prompt, mode],
                            capture_output=True, text=True, timeout=60,
                            env={**os.environ, "YGGDRASIL_ROOT": ROOT})
        return {"response": out.stdout.strip(), "stderr": out.stderr, "returncode": out.returncode}
    except Exception as e:
        return {"error": str(e)}

def tool_agent_test(args: dict) -> dict:
    agent = args.get("agent", "")
    script = os.path.join(ROOT, "agentes", agent, "test.sh")
    if not os.path.isfile(script):
        return {"error": f"test.sh not found for agent: {agent}"}
    try:
        out = subprocess.run(["bash", script],
                            capture_output=True, text=True, timeout=60,
                            env={**os.environ, "YGGDRASIL_ROOT": ROOT})
        return {"stdout": out.stdout, "stderr": out.stderr, "returncode": out.returncode}
    except Exception as e:
        return {"error": str(e)}

def tool_inbox_commit(args: dict) -> dict:
    description = args.get("description", "auto commit")
    script = os.path.join(ROOT, "scripts", "inbox-commit.sh")
    try:
        out = subprocess.run(["bash", script, description],
                            capture_output=True, text=True, timeout=60,
                            env={**os.environ, "YGGDRASIL_ROOT": ROOT})
        return {"stdout": out.stdout, "stderr": out.stderr, "returncode": out.returncode}
    except Exception as e:
        return {"error": str(e)}

TOOLS = {
    "orquestador_total": tool_orquestador_total,
    "llm_router":        tool_llm_router,
    "agent_test":        tool_agent_test,
    "inbox_commit":      tool_inbox_commit,
}

# ── Dispatch ──────────────────────────────────────────────────────────────────

def dispatch(msg: dict) -> dict:
    if msg.get("type") == "list_tools":
        return {"type": "tools", "tools": [
            {"name": "orquestador_total", "description": "Run orquestador-total.sh", "args": {"phase": "all|audit|inbox|health"}},
            {"name": "llm_router",        "description": "Route a prompt to best available LLM", "args": {"prompt": "str", "mode": "auto|ollama|openai|anthropic"}},
            {"name": "agent_test",         "description": "Run test.sh for a given agent", "args": {"agent": "agent-name"}},
            {"name": "inbox_commit",       "description": "Commit inbox/drop contents", "args": {"description": "str"}},
        ]}
    if msg.get("type") == "call_tool":
        tool_name = msg.get("tool", "")
        tool_args = msg.get("arguments", {})
        if tool_name not in TOOLS:
            return {"type": "error", "error": f"unknown tool: {tool_name}"}
        result = TOOLS[tool_name](tool_args)
        return {"type": "tool_result", "tool": tool_name, "result": result}
    return {"type": "error", "error": "unknown message type"}

# ── Stdio loop ────────────────────────────────────────────────────────────────

def stdio_loop():
    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue
        try:
            msg = json.loads(line)
        except json.JSONDecodeError as e:
            sys.stdout.write(json.dumps({"type": "error", "error": str(e)}) + "\n")
            sys.stdout.flush()
            continue
        response = dispatch(msg)
        sys.stdout.write(json.dumps(response) + "\n")
        sys.stdout.flush()

# ── HTTP handler ──────────────────────────────────────────────────────────────

class MCPHandler(BaseHTTPRequestHandler):
    def log_message(self, format, *args):
        pass  # suppress default logs

    def _auth_ok(self):
        if not TOKEN:
            return True
        auth = self.headers.get("Authorization", "")
        return auth == f"Bearer {TOKEN}"

    def do_POST(self):
        if not self._auth_ok():
            self.send_response(401)
            self.end_headers()
            return
        length = int(self.headers.get("Content-Length", 0))
        body = self.rfile.read(length)
        try:
            msg = json.loads(body)
        except Exception as e:
            self.send_response(400)
            self.end_headers()
            self.wfile.write(json.dumps({"error": str(e)}).encode())
            return
        response = dispatch(msg)
        data = json.dumps(response).encode()
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def do_GET(self):
        if self.path == "/health":
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b'{"status":"ok"}')
        else:
            self.send_response(404)
            self.end_headers()

# ── Main ──────────────────────────────────────────────────────────────────────

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--port", type=int, default=0, help="HTTP port (0 = stdio only)")
    parser.add_argument("--stdio", action="store_true", help="Force stdio mode")
    args = parser.parse_args()

    if args.port:
        server = HTTPServer(("0.0.0.0", args.port), MCPHandler)
        print(f"MCP server listening on :{args.port}", file=sys.stderr)
        t = threading.Thread(target=server.serve_forever, daemon=True)
        t.start()

    print("MCP stdio ready", file=sys.stderr)
    stdio_loop()
