# tools/vector_adapter.py — Adaptador Vector DB (Weaviate/Milvus/FAISS local)
import os
import json
from pathlib import Path

ROOT = os.getenv("YGGDRASIL_ROOT", str(Path(__file__).parent.parent))

def index_text_local(text_id: str, text: str, metadata: dict) -> bool:
    """Guarda en JSON local para desarrollo/pruebas."""
    outdir = Path(ROOT) / "tools" / "vector_index"
    outdir.mkdir(parents=True, exist_ok=True)
    entry = {"id": text_id, "text": text, "meta": metadata}
    (outdir / f"{text_id}.json").write_text(json.dumps(entry, ensure_ascii=False, indent=2))
    return True

def index_text_weaviate(text_id: str, text: str, metadata: dict) -> bool:
    """Indexa en Weaviate. Requiere WEAVIATE_URL y WEAVIATE_API_KEY en env."""
    try:
        import weaviate
        client = weaviate.Client(
            url=os.getenv("WEAVIATE_URL", "http://localhost:8080"),
            auth_client_secret=weaviate.AuthApiKey(os.getenv("WEAVIATE_API_KEY", ""))
        )
        client.data_object.create(
            data_object={"text": text, "source": text_id, **metadata},
            class_name="YggdrasilDoc"
        )
        return True
    except Exception as e:
        print(f"[vector_adapter] Weaviate error: {e} — usando fallback local")
        return index_text_local(text_id, text, metadata)

def index_ocr_directory(ocr_text_dir: str = None) -> list:
    """Indexa todos los .txt de inbox/ocr/text/."""
    ocr_dir = Path(ocr_text_dir or (Path(ROOT) / "inbox" / "ocr" / "text"))
    indexed = []
    for txt_file in ocr_dir.glob("*.txt"):
        text_id = txt_file.stem
        text = txt_file.read_text(errors="ignore")
        meta_file = txt_file.parent.parent / "meta" / f"{text_id}.json"
        metadata = json.loads(meta_file.read_text()) if meta_file.exists() else {}
        if index_text_local(text_id, text, metadata):
            indexed.append(text_id)
    return indexed

if __name__ == "__main__":
    result = index_ocr_directory()
    print(f"Indexados: {len(result)} documentos")
    for r in result:
        print(f"  - {r}")
