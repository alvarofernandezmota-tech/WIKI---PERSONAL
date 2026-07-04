#!/usr/bin/env python3
"""
tools/vector_adapter.py
Indexa archivos de texto en tools/vector_index/ como JSON {id, text, meta, ts}
Uso:
  python3 tools/vector_adapter.py --input inbox/ocr/text/
  python3 tools/vector_adapter.py --input inbox/ocr/text/ --clear
"""
import os, sys, json, hashlib, argparse
from datetime import datetime, timezone

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
INDEX_DIR = os.path.join(ROOT, "tools", "vector_index")

def index_file(path: str) -> dict:
    with open(path, "r", encoding="utf-8", errors="replace") as f:
        text = f.read()
    doc_id = hashlib.sha256(text.encode()).hexdigest()[:16]
    return {
        "id": doc_id,
        "source": os.path.basename(path),
        "text": text,
        "meta": {"size": len(text), "lines": text.count("\n")},
        "ts": datetime.now(timezone.utc).isoformat()
    }

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", required=True, help="Carpeta con archivos .txt")
    parser.add_argument("--clear", action="store_true", help="Limpiar índice antes de indexar")
    args = parser.parse_args()

    os.makedirs(INDEX_DIR, exist_ok=True)

    if args.clear:
        for f in os.listdir(INDEX_DIR):
            if f.endswith(".json"):
                os.remove(os.path.join(INDEX_DIR, f))
        print("[vector_adapter] Índice limpiado")

    input_dir = os.path.abspath(args.input)
    if not os.path.isdir(input_dir):
        print(f"ERROR: {input_dir} no existe", file=sys.stderr)
        sys.exit(1)

    indexed = 0
    for fname in os.listdir(input_dir):
        if fname == ".gitkeep" or not fname.endswith(".txt"):
            continue
        fpath = os.path.join(input_dir, fname)
        doc = index_file(fpath)
        out = os.path.join(INDEX_DIR, f"{doc['id']}.json")
        with open(out, "w", encoding="utf-8") as fh:
            json.dump(doc, fh, ensure_ascii=False, indent=2)
        print(f"[OK] {fname} -> {doc['id']}.json")
        indexed += 1

    print(f"[vector_adapter] {indexed} documentos indexados en {INDEX_DIR}")

if __name__ == "__main__":
    main()
