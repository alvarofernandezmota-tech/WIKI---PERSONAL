#!/usr/bin/env python3
"""
RAG OSINT Engine — Batcueva
Pipeline: IVRE MongoDB → Qdrant vectorial → Ollama análisis → Obsidian inbox
Deps: pip install pymongo requests qdrant-client
"""
import os
import json
import requests
from datetime import datetime
from pymongo import MongoClient
from qdrant_client import QdrantClient
from qdrant_client.models import Distance, VectorParams, PointStruct

IP_MADRE = "100.91.112.32"
OLLAMA_EMBED_URL = f"http://{IP_MADRE}:11434/api/embeddings"
OLLAMA_GENERATE_URL = f"http://{IP_MADRE}:11434/api/generate"
OBSIDIAN_INBOX = "/home/alvaro/yggdrasil-dew/inbox"
COLLECTION_NAME = "batcueva_osint_vectors"

mongo_client = MongoClient('mongodb://127.0.0.1:27017/')
db_ivre = mongo_client.ivre
qdrant_client = QdrantClient(host="127.0.0.1", port=6333)

try:
    qdrant_client.create_collection(
        collection_name=COLLECTION_NAME,
        vectors_config=VectorParams(size=768, distance=Distance.COSINE),
    )
except Exception:
    pass


def obtener_embedding(texto):
    try:
        response = requests.post(OLLAMA_EMBED_URL, json={
            "model": "nomic-embed-text",
            "prompt": texto
        }, timeout=10)
        return response.json().get("embedding")
    except Exception as e:
        print(f"[-] Error embedding: {e}")
        return None


def buscar_contexto_historico(vector):
    try:
        resultados = qdrant_client.search(
            collection_name=COLLECTION_NAME,
            query_vector=vector,
            limit=2
        )
        return "\n".join([
            f"- Histórico ({r.payload.get('addr')}): {r.payload.get('banner')}"
            for r in resultados
        ])
    except Exception:
        return ""


def main():
    print("[*] Leyendo datos IVRE MongoDB...")
    try:
        scans = db_ivre.results.find({"service": {"$exists": True}}).limit(5)
    except Exception as e:
        print(f"[-] Error MongoDB: {e}")
        return

    for scan in scans:
        ip = scan.get("addr", "IP_Desconocida")
        servicio = scan.get("service", "Unknown")
        banner = scan.get("banner", "No Banner")
        texto = f"IP: {ip} | Servicio: {servicio} | Banner: {banner}"

        vector = obtener_embedding(texto)
        if not vector:
            continue

        contexto = buscar_contexto_historico(vector)

        prompt = f"""Analista de ciberinteligencia. Objetivo: {texto}.
Historial correlacionado: {contexto or 'Primer avistamiento.'}
Identifica vulnerabilidades y CVEs relevantes de forma concisa."""

        try:
            res = requests.post(OLLAMA_GENERATE_URL, json={
                "model": "llama3:latest", "prompt": prompt, "stream": False
            }, timeout=90)
            analisis = res.json().get("response")
        except Exception as e:
            analisis = f"Error Ollama: {e}"

        qdrant_client.upsert(
            collection_name=COLLECTION_NAME,
            points=[PointStruct(
                id=hash(ip) & 0xFFFFFFFFFFFFFFFF,
                vector=vector,
                payload={"addr": ip, "service": servicio, "banner": banner,
                         "timestamp": datetime.now().isoformat()}
            )]
        )

        filename = f"OSINT_RAG_{ip}_{datetime.now().strftime('%Y%m%d_%H%M%S')}.md"
        with open(os.path.join(OBSIDIAN_INBOX, filename), "w") as f:
            f.write(f"""---
tags: [osint-intelligence, rag-core, batcueva]
target: {ip}
date: {datetime.now().strftime('%Y-%m-%d')}
---

# Reporte RAG — {ip}

## Firma Técnica
- **IP:** {ip} | **Servicio:** {servicio} | **Banner:** `{banner}`

## Historial Correlacionado (Qdrant)
{contexto or '_Primer avistamiento._'}

## Análisis IA (Ollama)
{analisis}
""")
        print(f"[+] Nota generada para {ip}")


if __name__ == "__main__":
    main()
