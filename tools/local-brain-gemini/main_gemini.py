import os
import re
import glob
import requests
from typing import List
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import chromadb
from rank_bm25 import BM25Okapi

app = FastAPI(title="Local Brain RAG Engine — Gemini", version="2.0")

VAULT_PATH  = os.getenv("OBSIDIAN_VAULT", os.path.expanduser("~/Projects/yggdrasil-dew"))
GEMINI_KEY  = os.getenv("GEMINI_API_KEY")
LLM_MODEL   = os.getenv("LLM_MODEL", "gemini-2.0-flash")
EMBED_MODEL = os.getenv("EMBED_MODEL", "text-embedding-004")
GEMINI_BASE = "https://generativelanguage.googleapis.com/v1beta"

chroma_client = chromadb.PersistentClient(path="./chroma_db")
bm25_index = None
bm25_docs  = []

class QueryRequest(BaseModel):
    prompt: str
    top_k: int = 15  # Gemini 1M token context — aprovechar al máximo

# ─── Embeddings batch (hasta 100 chunks por request) ─────────────────────────

def get_embeddings_batch(texts: List[str]) -> List[List[float]]:
    """Batch embeddings — hasta 100 chunks por petición HTTP."""
    if not texts:
        return []
    url = f"{GEMINI_BASE}/models/{EMBED_MODEL}:batchEmbedContents?key={GEMINI_KEY}"
    requests_body = [
        {
            "model": f"models/{EMBED_MODEL}",
            "content": {"parts": [{"text": t}]},
            "taskType": "RETRIEVAL_DOCUMENT"
        } for t in texts
    ]
    r = requests.post(url, json={"requests": requests_body})
    if r.status_code != 200:
        raise HTTPException(status_code=500, detail=f"Batch Embedding error: {r.text}")
    return [emb["values"] for emb in r.json()["embeddings"]]

def get_embedding_query(text: str) -> List[float]:
    """Embedding single para queries (taskType diferente)."""
    url = f"{GEMINI_BASE}/models/{EMBED_MODEL}:embedContent?key={GEMINI_KEY}"
    r = requests.post(url, json={
        "model": f"models/{EMBED_MODEL}",
        "content": {"parts": [{"text": text}]},
        "taskType": "RETRIEVAL_QUERY"  # distinto al de indexación
    })
    if r.status_code != 200:
        raise HTTPException(status_code=500, detail=f"Embedding error: {r.text}")
    return r.json()["embedding"]["values"]

# ─── Chunking ─────────────────────────────────────────────────────────────────

def chunk_markdown(content: str, max_chars: int = 1200) -> List[str]:
    content = re.sub(r'^---[\s\S]+?---', '', content)
    paragraphs = content.split("\n\n")
    chunks, current = [], ""
    for p in paragraphs:
        if len(current) + len(p) < max_chars:
            current += p + "\n\n"
        else:
            if current.strip(): chunks.append(current.strip())
            current = p + "\n\n"
    if current.strip(): chunks.append(current.strip())
    return chunks

# ─── Indexación con batch embeddings ─────────────────────────────────────────

@app.post("/index")
def index_vault():
    global bm25_index, bm25_docs
    if not os.path.exists(VAULT_PATH):
        raise HTTPException(status_code=400, detail=f"Vault no encontrado: {VAULT_PATH}")
    try:
        chroma_client.delete_collection("obsidian_notes")
    except: pass
    coll = chroma_client.create_collection(
        name="obsidian_notes",
        metadata={"hnsw:space": "cosine"}
    )
    md_files = glob.glob(os.path.join(VAULT_PATH, "**/*.md"), recursive=True)
    docs, metas, ids, corpus = [], [], [], []
    print(f"Indexando {len(md_files)} archivos...")
    for idx, filepath in enumerate(md_files):
        filename = os.path.basename(filepath)
        with open(filepath, "r", encoding="utf-8", errors="ignore") as f:
            content = f.read()
        for ci, chunk in enumerate(chunk_markdown(content)):
            text = f"--- {filename} ---\n{chunk}"
            docs.append(text)
            metas.append({"source": filename, "path": filepath})
            ids.append(f"{filename}_{idx}_{ci}")
            corpus.append(text)

    # Batch de 50 — margen seguro para payload y rate limits
    batch_size = 50
    embeddings = []
    for i in range(0, len(docs), batch_size):
        batch_embs = get_embeddings_batch(docs[i:i+batch_size])
        embeddings.extend(batch_embs)
        print(f"  Embeddings: {min(i+batch_size, len(docs))}/{len(docs)}")

    if ids:
        coll.add(embeddings=embeddings, documents=docs, metadatas=metas, ids=ids)
    bm25_index = BM25Okapi([d.lower().split() for d in corpus])
    bm25_docs  = corpus
    return {"status": "ok", "files": len(md_files), "chunks": len(ids)}

# ─── Query RAG Híbrido ────────────────────────────────────────────────────────

@app.post("/query")
def query_brain(request: QueryRequest):
    global bm25_index, bm25_docs
    if not bm25_docs:
        index_vault()
    q_vec   = get_embedding_query(request.prompt)
    coll    = chroma_client.get_collection("obsidian_notes")
    v_res   = coll.query(query_embeddings=[q_vec], n_results=request.top_k)
    vec_ctx = v_res['documents'][0] if v_res['documents'] else []
    lex_ctx = bm25_index.get_top_n(
        request.prompt.lower().split(), bm25_docs, n=request.top_k
    ) if bm25_index else []
    context     = list(dict.fromkeys(vec_ctx + lex_ctx))[:request.top_k]
    context_str = "\n\n".join(context)
    system = (
        "Eres el cerebro secundario del usuario. "
        "Responde SOLO con lo que aparece en el contexto de sus notas personales. "
        "Si no está en el contexto, dilo claramente. Sé directo y técnico.\n\n"
        f"CONTEXTO:\n{context_str}"
    )
    url = f"{GEMINI_BASE}/models/{LLM_MODEL}:generateContent?key={GEMINI_KEY}"
    r = requests.post(url, json={
        "system_instruction": {"parts": [{"text": system}]},
        "contents": [{"role": "user", "parts": [{"text": request.prompt}]}],
        "generationConfig": {"temperature": 0.2, "maxOutputTokens": 4096}
    })
    if r.status_code != 200:
        raise HTTPException(status_code=500, detail=f"Gemini error: {r.text}")
    answer = r.json()["candidates"][0]["content"]["parts"][0]["text"]
    return {"response": answer, "sources": context}

@app.get("/health")
def health():
    return {"status": "ok", "vault": VAULT_PATH, "llm": LLM_MODEL, "embed": EMBED_MODEL}
