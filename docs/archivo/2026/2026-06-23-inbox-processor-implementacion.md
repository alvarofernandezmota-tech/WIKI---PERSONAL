---
tags: [docs, inbox, processor, automatizacion, python]
fecha: 2026-06-23
estado: concepto
ruta-obsidian: docs/2026-06-23-inbox-processor-implementacion.md
fuente: inbox/2026-06-23-inbox-processor-implementacion.md
---

# Inbox Processor — implementación

> Script Python que vacía la inbox automáticamente usando Ollama.

## Flujo

```
inbox/*.md
    ↓
Leer frontmatter (tags, destino-1, destino-2)
    ↓
Si tiene destino definido → git mv directo
Si no tiene destino → preguntar a Ollama qwen2.5:3b
    ↓
Ollama decide carpeta destino
    ↓
git mv + actualizar frontmatter (estado: migrado)
    ↓
git commit -m "inbox: migrar <archivo> → <destino>"
```

## Código base

```python
import os
import subprocess
import frontmatter
from pathlib import Path

INBOX = Path('inbox/')
PERMANENTES = {'README.md', 'MASTER-PENDIENTES.md', '.gitkeep'}

def procesar_inbox():
    for archivo in INBOX.glob('*.md'):
        if archivo.name in PERMANENTES:
            continue
        post = frontmatter.load(archivo)
        destino = post.get('destino-1')
        if destino:
            mover(archivo, Path(destino))
        else:
            destino = decidir_con_ollama(archivo, post)
            mover(archivo, destino)

def mover(origen, destino):
    destino.parent.mkdir(parents=True, exist_ok=True)
    subprocess.run(['git', 'mv', str(origen), str(destino)])
```

## Siguientes pasos

- [ ] Implementar `decidir_con_ollama()`
- [ ] Añadir dry-run mode
- [ ] Integrar en thdora como `/procesar-inbox`

## Referencias
- [[tools/2026-06-23-tools-pendientes]]
- [[ollama/README]]
