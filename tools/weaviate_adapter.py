#!/usr/bin/env python3
"""
tools/weaviate_adapter.py
Adapter Weaviate para indexar/buscar documentos.
NO conecta en import — llamar connect() explícitamente.
Requiere: pip install weaviate-client
Variables de entorno: WEAVIATE_URL, WEAVIATE_API_KEY (opcional)
"""
import os, json
from typing import Optional

CLASS_NAME = "YggdrasilDoc"

class WeaviateAdapter:
    def __init__(self):
        self.client = None
        self.url = os.getenv("WEAVIATE_URL", "http://localhost:8080")
        self.api_key = os.getenv("WEAVIATE_API_KEY", "")

    def connect(self):
        try:
            import weaviate
            auth = weaviate.auth.AuthApiKey(self.api_key) if self.api_key else None
            self.client = weaviate.Client(url=self.url, auth_client_secret=auth)
            print(f"[weaviate] Conectado a {self.url}")
        except ImportError:
            raise RuntimeError("Instala: pip install weaviate-client")

    def ensure_schema(self):
        if self.client.schema.exists(CLASS_NAME):
            return
        self.client.schema.create_class({
            "class": CLASS_NAME,
            "properties": [
                {"name": "source", "dataType": ["string"]},
                {"name": "text",   "dataType": ["text"]},
                {"name": "meta",   "dataType": ["string"]},
            ]
        })
        print(f"[weaviate] Schema {CLASS_NAME} creado")

    def index(self, doc: dict):
        self.ensure_schema()
        self.client.data_object.create({
            "source": doc.get("source", ""),
            "text":   doc.get("text", ""),
            "meta":   json.dumps(doc.get("meta", {})),
        }, CLASS_NAME)

    def search(self, query: str, limit: int = 5) -> list:
        self.ensure_schema()
        res = (
            self.client.query
            .get(CLASS_NAME, ["source", "text", "meta"])
            .with_bm25(query=query)
            .with_limit(limit)
            .do()
        )
        return res.get("data", {}).get("Get", {}).get(CLASS_NAME, [])


if __name__ == "__main__":
    adapter = WeaviateAdapter()
    adapter.connect()
    print(adapter.search("test"))
