# ingest_yggdrasil.py
# Indexa todo yggdrasil-dew en Qdrant con bge-m3 via Ollama
# Ejecutar: python ingest_yggdrasil.py
# Prerequisitos: pip install qdrant-client requests tqdm
# Qdrant corriendo en localhost:6333
# bge-m3 disponible en Ollama: ollama pull bge-m3

import json
import hashlib
from pathlib import Path
from datetime import datetime
from typing import Optional
import requests
from tqdm import tqdm

try:
    from qdrant_client import QdrantClient
    from qdrant_client.http.models import (
        VectorParams, Distance, PointStruct, Filter,
        FieldCondition, MatchValue
    )
except ImportError:
    print("❌ Instalar: pip install qdrant-client")
    exit(1)

# ─── Config ──────────────────────────────────────
YGGDRASIL_DEW = Path("/srv/yggdrasil-dew")
QDRANT_URL = "http://localhost:6333"
COLLECTION = "yggdrasil-dew"
EMBEDDING_MODEL = "bge-m3"  # ollama pull bge-m3
OLLAMA_URL = "http://localhost:11434/api/embeddings"
VECTOR_SIZE = 1024  # bge-m3 produce vectores de 1024 dims
CHUNK_SIZE = 800    # caracteres por chunk
CHUNK_OVERLAP = 100

# Extensiones a indexar
INDEX_EXTENSIONS = {".md", ".py", ".sh", ".yml", ".yaml", ".json", ".txt"}

# Directorios a excluir
EXCLUDE_DIRS = {".git", ".github", "node_modules", "__pycache__", ".venv"}


# ─── Chunking ────────────────────────────────────

def chunk_text(text: str, path: str) -> list[dict]:
    """Divide el texto en chunks con overlap. Respeta líneas."""
    lines = text.split("\n")
    chunks = []
    current = []
    current_len = 0

    for line in lines:
        current.append(line)
        current_len += len(line) + 1
        if current_len >= CHUNK_SIZE:
            chunk_text = "\n".join(current)
            chunks.append({
                "text": chunk_text,
                "path": path,
                "chunk_index": len(chunks),
                "hash": hashlib.md5(chunk_text.encode()).hexdigest()[:8]
            })
            # Overlap: mantener últimas líneas
            overlap_lines = current[-3:]
            current = overlap_lines
            current_len = sum(len(l) + 1 for l in overlap_lines)

    if current:
        chunk_text = "\n".join(current)
        if chunk_text.strip():
            chunks.append({
                "text": chunk_text,
                "path": path,
                "chunk_index": len(chunks),
                "hash": hashlib.md5(chunk_text.encode()).hexdigest()[:8]
            })
    return chunks


# ─── Embeddings ──────────────────────────────────

def get_embedding(text: str) -> Optional[list[float]]:
    try:
        resp = requests.post(OLLAMA_URL, json={
            "model": EMBEDDING_MODEL,
            "prompt": text
        }, timeout=30)
        resp.raise_for_status()
        return resp.json()["embedding"]
    except Exception as e:
        print(f"  ❌ Error embedding: {e}")
        return None


# ─── Qdrant setup ────────────────────────────────

def setup_collection(client: QdrantClient):
    collections = [c.name for c in client.get_collections().collections]
    if COLLECTION not in collections:
        client.create_collection(
            collection_name=COLLECTION,
            vectors_config=VectorParams(
                size=VECTOR_SIZE,
                distance=Distance.COSINE
            )
        )
        print(f"✅ Colección '{COLLECTION}' creada")
    else:
        print(f"ℹ️  Colección '{COLLECTION}' ya existe")


# ─── Main ingesta ────────────────────────────────

def ingest():
    print(f"🚀 Iniciando ingesta de {YGGDRASIL_DEW}")
    print(f"   Qdrant: {QDRANT_URL} | Colección: {COLLECTION}")
    print(f"   Modelo: {EMBEDDING_MODEL}")
    print()

    client = QdrantClient(url=QDRANT_URL)
    setup_collection(client)

    # Recopilar ficheros
    files = []
    for ext in INDEX_EXTENSIONS:
        for f in YGGDRASIL_DEW.rglob(f"*{ext}"):
            if not any(ex in f.parts for ex in EXCLUDE_DIRS):
                files.append(f)

    print(f"📂 {len(files)} ficheros encontrados")

    total_chunks = 0
    total_errors = 0
    points_batch = []
    point_id = 1

    for file_path in tqdm(files, desc="Indexando"):
        try:
            text = file_path.read_text(encoding="utf-8", errors="ignore")
            if not text.strip() or len(text) < 50:
                continue

            rel_path = str(file_path.relative_to(YGGDRASIL_DEW))
            chunks = chunk_text(text, rel_path)

            for chunk in chunks:
                embedding = get_embedding(chunk["text"])
                if not embedding:
                    total_errors += 1
                    continue

                points_batch.append(PointStruct(
                    id=point_id,
                    vector=embedding,
                    payload={
                        "text": chunk["text"],
                        "path": chunk["path"],
                        "chunk_index": chunk["chunk_index"],
                        "hash": chunk["hash"],
                        "extension": file_path.suffix,
                        "ingested_at": datetime.utcnow().isoformat()
                    }
                ))
                point_id += 1
                total_chunks += 1

                # Batch upsert cada 50 chunks
                if len(points_batch) >= 50:
                    client.upsert(collection_name=COLLECTION, points=points_batch)
                    points_batch = []

        except Exception as e:
            tqdm.write(f"  ⚠️ Error en {file_path.name}: {e}")
            total_errors += 1

    # Flush último batch
    if points_batch:
        client.upsert(collection_name=COLLECTION, points=points_batch)

    print()
    print(f"✅ Ingesta completada:")
    print(f"   Chunks indexados: {total_chunks}")
    print(f"   Errores: {total_errors}")
    print(f"   Qdrant: {QDRANT_URL}/collections/{COLLECTION}")


if __name__ == "__main__":
    ingest()
