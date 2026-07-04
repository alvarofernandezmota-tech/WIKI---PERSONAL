# tools/auth_gateway.py
# Auth gateway: validates token and scopes before forwarding to MCP backend
import os, json, sys
from http.server import BaseHTTPRequestHandler, HTTPServer
import requests

MCP_URL = os.getenv("MCP_BACKEND", "http://127.0.0.1:8081")
API_TOKEN = os.getenv("GATEWAY_TOKEN", "")
PORT = int(os.getenv("GATEWAY_PORT", "8080"))

class Handler(BaseHTTPRequestHandler):
    def _send(self, code, body):
        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        self.end_headers()
        self.wfile.write(json.dumps(body).encode())

    def do_POST(self):
        auth = self.headers.get("Authorization", "")
        if API_TOKEN and auth != f"Bearer {API_TOKEN}":
            return self._send(401, {"error": "unauthorized"})
        length = int(self.headers.get("Content-Length", "0"))
        raw = self.rfile.read(length).decode()
        payload = json.loads(raw)
        tool = payload.get("tool", "")
        # Scope check: galatea tools require auth
        if tool.startswith("galatea") and auth != f"Bearer {API_TOKEN}":
            return self._send(403, {"error": "forbidden"})
        try:
            r = requests.post(MCP_URL, json=payload, timeout=30)
            return self._send(r.status_code, r.json())
        except Exception as e:
            return self._send(502, {"error": str(e)})

if __name__ == "__main__":
    server = HTTPServer(("0.0.0.0", PORT), Handler)
    print(f"Auth gateway listening on :{PORT}", flush=True)
    server.serve_forever()
