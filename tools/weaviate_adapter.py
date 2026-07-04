#!/usr/bin/env python3
# tools/weaviate_adapter.py
# Template adapter: stores locally as JSON; swap for real Weaviate client when ready
import sys, json, os

ROOT = os.getenv("YGGDRASIL_ROOT", ".")

def index_text(id, path, meta_json):
    with open(path, "r", encoding="utf8") as fh:
        text = fh.read()
    meta = json.loads(meta_json)
    outdir = os.path.join(ROOT, "tools", "vector_index")
    os.makedirs(outdir, exist_ok=True)
    outpath = os.path.join(outdir, f"{id}.json")
    with open(outpath, "w", encoding="utf8") as fh:
        json.dump({"id": id, "text": text, "meta": meta}, fh, ensure_ascii=False, indent=2)
    print(outpath)
    return 0

if __name__ == "__main__":
    cmd = sys.argv[1] if len(sys.argv) > 1 else ""
    if cmd == "index_text":
        _, _, id_, path, meta = sys.argv
        sys.exit(index_text(id_, path, meta))
    else:
        print("Usage: weaviate_adapter.py index_text <id> <path> <meta_json>")
        sys.exit(2)
