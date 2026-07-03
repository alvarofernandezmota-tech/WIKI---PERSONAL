# mcp/server.py — MCP Server stdio + HTTP con auth token
import os, sys, json, argparse, threading
from http.server import BaseHTTPRequestHandler, HTTPServer
from subprocess import run

ROOT = os.getenv("YGGDRASIL_ROOT", os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))
TOOLS = {
  "orquestador_total":      f"bash {ROOT}/scripts/orquestador-total.sh orquestador-total",
  "agent_meta_deep":        f"bash {ROOT}/scripts/agentes/agente-meta-deep.sh",
  "llm_router":             f"bash {ROOT}/scripts/agentes/llm-router.sh",
  "galatea_fabrica_agente": f"bash {ROOT}/scripts/agentes/galatea-fabrica-agentes.sh",
  "galatea_create_pr":      f"bash {ROOT}/scripts/agentes/galatea-create-pr.sh"
}
API_TOKEN = os.getenv("MCP_API_TOKEN", "")

def run_cmd(cmd, timeout=120):
  try:
    p = run(cmd, shell=True, capture_output=True, text=True, timeout=timeout)
    return {"status": "ok", "output": p.stdout.strip() or p.stderr.strip()}
  except Exception as e:
    return {"status": "error", "error": str(e)}

class Handler(BaseHTTPRequestHandler):
  def _auth(self):
    if not API_TOKEN: return True
    h = self.headers.get("Authorization", "")
    return h == f"Bearer {API_TOKEN}"

  def _send(self, code, body):
    self.send_response(code)
    self.send_header("Content-Type", "application/json")
    self.end_headers()
    self.wfile.write(json.dumps(body).encode())

  def do_POST(self):
    if not self._auth(): return self._send(401, {"error": "unauthorized"})
    length = int(self.headers.get("Content-Length", "0"))
    raw = self.rfile.read(length).decode()
    req = json.loads(raw)
    tool = req.get("tool")
    args = req.get("arguments", {})
    if tool not in TOOLS: return self._send(404, {"error": "tool not found"})
    cmd = TOOLS[tool]
    if isinstance(args, dict) and args:
      safe = json.dumps(args).replace('"', '\\"')
      cmd = f'{cmd} "{safe}"'
    res = run_cmd(cmd)
    return self._send(200, res)

  def log_message(self, format, *args):
    pass  # silenciar logs HTTP

def start_http(port):
  server = HTTPServer(("0.0.0.0", port), Handler)
  server.serve_forever()

def stdin_loop():
  for line in sys.stdin:
    if not line.strip(): continue
    req = json.loads(line)
    if req.get("type") != "call_tool":
      print(json.dumps({"error": "unsupported type"}))
      continue
    tool = req.get("tool")
    args = req.get("arguments", {})
    if tool not in TOOLS:
      print(json.dumps({"error": "tool not found"}))
      continue
    cmd = TOOLS[tool]
    if isinstance(args, dict) and args:
      safe = json.dumps(args).replace('"', '\\"')
      cmd = f'{cmd} "{safe}"'
    print(json.dumps(run_cmd(cmd)), flush=True)

if __name__ == "__main__":
  p = argparse.ArgumentParser()
  p.add_argument("--port", type=int, default=0)
  p.add_argument("--stdio", action="store_true")
  args = p.parse_args()
  if args.port:
    t = threading.Thread(target=start_http, args=(args.port,), daemon=True)
    t.start()
  if args.stdio or not args.port:
    stdin_loop()
