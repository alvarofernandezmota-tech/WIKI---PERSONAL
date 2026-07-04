#!/usr/bin/env python3
"""
tools/prometheus_exporter.py
Exporta métricas Yggdrasil en formato Prometheus (puerto 9090)
Métricas:
  ygg_inbox_files_total{zone}  — archivos en cada zona del inbox
  ygg_index_docs_total          — documentos en vector_index/
  ygg_last_ingest_ts            — timestamp del último archivo procesado
Uso: python3 tools/prometheus_exporter.py
"""
import os, time
from http.server import BaseHTTPRequestHandler, HTTPServer

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))

ZONES = {
    "raw":       os.path.join(ROOT, "inbox", "ocr", "raw"),
    "text":      os.path.join(ROOT, "inbox", "ocr", "text"),
    "processed": os.path.join(ROOT, "inbox", "ocr", "processed"),
    "drop":      os.path.join(ROOT, "inbox", "drop"),
    "perplexity":os.path.join(ROOT, "inbox", "context", "perplexity"),
}
INDEX_DIR = os.path.join(ROOT, "tools", "vector_index")

def count_files(d):
    if not os.path.isdir(d):
        return 0
    return sum(1 for f in os.listdir(d) if f != ".gitkeep" and not f.startswith("."))

def last_ingest_ts():
    proc = ZONES["processed"]
    if not os.path.isdir(proc):
        return 0
    files = [os.path.getmtime(os.path.join(proc, f)) for f in os.listdir(proc) if f != ".gitkeep"]
    return max(files) if files else 0

def metrics() -> str:
    lines = ["# HELP ygg_inbox_files_total Archivos en zona inbox",
             "# TYPE ygg_inbox_files_total gauge"]
    for zone, path in ZONES.items():
        lines.append(f'ygg_inbox_files_total{{zone="{zone}"}} {count_files(path)}')
    idx = count_files(INDEX_DIR)
    lines += ["# HELP ygg_index_docs_total Documentos indexados en vector_index",
              "# TYPE ygg_index_docs_total gauge",
              f"ygg_index_docs_total {idx}",
              "# HELP ygg_last_ingest_ts Timestamp último archivo procesado",
              "# TYPE ygg_last_ingest_ts gauge",
              f"ygg_last_ingest_ts {last_ingest_ts()}"]
    return "\n".join(lines) + "\n"

class Handler(BaseHTTPRequestHandler):
    def log_message(self, *_): pass
    def do_GET(self):
        body = metrics().encode()
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; version=0.0.4")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

if __name__ == "__main__":
    print("[prometheus_exporter] escuchando en :9090 — GET /metrics")
    HTTPServer(("0.0.0.0", 9090), Handler).serve_forever()
