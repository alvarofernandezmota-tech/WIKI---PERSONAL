#!/usr/bin/env python3
"""
tools/retrieval_api.py — Retrieval API mínimo sobre tools/vector_index/

Sirve nearest-neighbors básico por texto desde los JSON del índice local.
Puerto: 9001

USO:
  python3 tools/retrieval_api.py
  # GET http://localhost:9001/?q=tu+consulta

Formato esperado en tools/vector_index/*.json:
  {"id": "<id>", "text": "<contenido>", "source": "<ruta>"}
"""
import os
import json
from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import urlparse, parse_qs

ROOT = os.getenv("YGGDRASIL_ROOT", os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
INDEX_DIR = os.path.join(ROOT, "tools", "vector_index")


def load_index():
    docs = []
    if not os.path.isdir(INDEX_DIR):
        return docs
    for fname in os.listdir(INDEX_DIR):
        if not fname.endswith(".json"):
            continue
        try:
            with open(os.path.join(INDEX_DIR, fname), "r", encoding="utf-8") as fh:
                doc = json.load(fh)
                if isinstance(doc, list):
                    docs.extend(doc)
                else:
                    docs.append(doc)
        except Exception:
            pass
    return docs


def search(query: str, docs: list, top_k: int = 5) -> list:
    """Búsqueda simple por presencia de términos (BM25-like sin pesos)."""
    if not query:
        return docs[:top_k]
    terms = query.lower().split()
    scored = []
    for doc in docs:
        text = doc.get("text", "").lower()
        score = sum(text.count(t) for t in terms)
        if score > 0:
            scored.append((score, doc))
    scored.sort(key=lambda x: x[0], reverse=True)
    return [
        {"id": d.get("id"), "source": d.get("source"), "snippet": d.get("text", "")[:300], "score": s}
        for s, d in scored[:top_k]
    ]


class RetrievalHandler(BaseHTTPRequestHandler):
    def log_message(self, fmt, *args):  # silenciar logs verbose
        pass

    def do_GET(self):
        parsed = urlparse(self.path)
        params = parse_qs(parsed.query)
        query = params.get("q", [""])[0]
        top_k = int(params.get("k", ["5"])[0])
        docs = load_index()
        results = search(query, docs, top_k)
        body = json.dumps({"query": query, "results": results, "total_indexed": len(docs)}, ensure_ascii=False, indent=2)
        self.send_response(200)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()
        self.wfile.write(body.encode("utf-8"))

    def do_HEAD(self):
        self.send_response(200)
        self.end_headers()


if __name__ == "__main__":
    port = int(os.getenv("RETRIEVAL_PORT", "9001"))
    print(f"[retrieval_api] Escuchando en 0.0.0.0:{port}")
    print(f"[retrieval_api] Índice: {INDEX_DIR}")
    print(f"[retrieval_api] GET /?q=consulta[&k=N]")
    HTTPServer(("0.0.0.0", port), RetrievalHandler).serve_forever()
