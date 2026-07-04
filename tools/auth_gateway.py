#!/usr/bin/env python3
"""
tools/auth_gateway.py
Middleware Bearer token para proteger retrieval_api.
Uso standalone (proxy en :9002 -> :9001):
  AUTH_TOKEN=mi_token python3 tools/auth_gateway.py
O importar check_auth() en retrieval_api.py
"""
import os
from http.server import BaseHTTPRequestHandler, HTTPServer
import urllib.request, urllib.error

AUTH_TOKEN = os.getenv("AUTH_TOKEN", "")
UPSTREAM    = os.getenv("RETRIEVAL_URL", "http://localhost:9001")
PORT        = int(os.getenv("AUTH_GATEWAY_PORT", "9002"))

def check_auth(headers) -> bool:
    if not AUTH_TOKEN:
        return True  # Sin token configurado: acceso libre (dev mode)
    auth = headers.get("Authorization", "")
    return auth == f"Bearer {AUTH_TOKEN}"

class GatewayHandler(BaseHTTPRequestHandler):
    def log_message(self, *_): pass

    def do_GET(self):
        if not check_auth(self.headers):
            self.send_response(401)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(b'{"error": "Unauthorized"}')
            return
        try:
            url = f"{UPSTREAM}{self.path}"
            with urllib.request.urlopen(url, timeout=5) as r:
                body = r.read()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(body)
        except Exception as e:
            self.send_response(502)
            self.end_headers()
            self.wfile.write(f'{{"error": "{e}"}}'.encode())

if __name__ == "__main__":
    mode = "OPEN (dev)" if not AUTH_TOKEN else "SECURED"
    print(f"[auth_gateway] Puerto {PORT} -> {UPSTREAM} | Modo: {mode}")
    HTTPServer(("0.0.0.0", PORT), GatewayHandler).serve_forever()
