---
tags: [inbox, inbox-processor, automatizacion, ollama, watchdog, pendiente]
fecha: 2026-06-23
estado: pendiente-implementar
destino: tools/inbox-processor/
relacionado-anterior: [[inbox/2026-06-23-auditoria-tools-inbox-dashboard]]
relacionado-siguiente:
ruta-obsidian: inbox/2026-06-23-inbox-processor-implementacion.md
---

# Inbox Processor — Plan de Implementación

> Implementar después de que el RAG esté funcionando.
> El modo inteligente depende de Ollama corriendo en :11434.

## Flujo completo

```
Archivo nuevo en inbox/
        ↓ watchdog detecta
inbox_processor.py
        ↓ lee frontmatter YAML
        ↓ si tiene 'destino:' → mover directamente
        ↓ si no tiene 'destino:' → llamar a Ollama
Ollama llama3.2 / qwen2.5:3b
        ↓ analiza contenido
        ↓ decide carpeta destino
        ↓ genera frontmatter completo
Mover archivo a destino
        ↓
git add + commit automático
```

## Archivos a crear

### inbox_processor.py

```python
import time
import shutil
import subprocess
import frontmatter
import requests
from pathlib import Path
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

VAULT    = Path("~/Projects/yggdrasil-dew").expanduser()
INBOX    = VAULT / "inbox"
OLLAMA   = "http://localhost:11434"
MODEL    = "qwen2.5:3b"

CARPETAS = [
    "agentes", "ollama", "cli-tools", "tools",
    "proyectos", "diarios", "setup", "batcueva"
]

class InboxHandler(FileSystemEventHandler):
    def on_created(self, event):
        if event.is_directory or not event.src_path.endswith(".md"):
            return
        procesar(Path(event.src_path))

def procesar(filepath: Path):
    post = frontmatter.load(filepath)
    destino = post.metadata.get("destino")

    if not destino:
        # Modo inteligente: preguntar a Ollama
        destino = ollama_decide(post.content, filepath.name)

    dest_path = VAULT / destino / filepath.name
    dest_path.parent.mkdir(parents=True, exist_ok=True)
    shutil.move(str(filepath), str(dest_path))
    git_commit(dest_path, filepath.name)
    print(f"[+] Movido: {filepath.name} → {destino}/")

def ollama_decide(contenido: str, filename: str) -> str:
    prompt = (
        f"Eres un clasificador de notas Obsidian. "
        f"Carpetas disponibles: {', '.join(CARPETAS)}. "
        f"Nombre del archivo: {filename}. "
        f"Contenido (primeras 500 chars): {contenido[:500]}. "
        f"Responde SOLO con el nombre de la carpeta destino, sin explicación."
    )
    r = requests.post(f"{OLLAMA}/api/generate",
        json={"model": MODEL, "prompt": prompt, "stream": False})
    return r.json().get("response", "inbox").strip()

def git_commit(filepath: Path, filename: str):
    subprocess.run(["git", "-C", str(VAULT), "add", str(filepath)])
    subprocess.run(["git", "-C", str(VAULT), "commit",
                    "-m", f"📥 inbox-processor: {filename}"])

if __name__ == "__main__":
    observer = Observer()
    observer.schedule(InboxHandler(), str(INBOX), recursive=False)
    observer.start()
    print(f"[*] Vigilando {INBOX}...")
    try:
        while True: time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
```

## Dependencias

```
watchdog>=4.0.0
python-frontmatter>=1.1.0
requests>=2.32.0
```

## Prioridad

⏳ Implementar cuando Ollama esté validado funcionando con el RAG.
