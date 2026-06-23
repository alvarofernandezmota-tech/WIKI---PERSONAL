---
tags: [inbox, batcueva, osint, ivre, recon-ng, docker, gemini, python]
fecha: 2026-06-23
estado: REVISAR-ANTES-DE-EJECUTAR
fuente: Gemini
validado-por: Perplexity
---

# 🤖 Gemini — Expansión OSINT: IVRE + Recon-ng + Orquestador Python

## 🧠 Decisión de arquitectura (filtrado por RAM)

| Herramienta | Decisión | Motivo |
|---|---|---|
| TheHive + Cortex | ❌ Descartada | JVM + OpenSearch > 10GB RAM |
| Wazuh | ❌ Descartada | OpenSearch colapsa con 16GB |
| Maltego CE | 💻 varopc | GUI pesada, no para servidor headless |
| **Recon-ng** | ✅ Madre Docker | CLI ultraligero, ~50MB RAM |
| **IVRE** | ✅ Madre Docker | Shodan self-hosted, MongoDB ligero |

---

## ⚠️ Notas de revisión (Perplexity)

| Item | Estado | Nota |
|---|---|---|
| `ivre/web:latest` | ❓ Verificar | Comprobar imagen en Docker Hub |
| `ivre/client:latest` | ❓ Verificar | Ídem |
| `mountainsec/recon-ng:latest` | ❓ Verificar | Imagen no oficial — puede no existir |
| Puerto 8089 (IVRE web) | ✅ Libre | Sin conflicto |
| MongoDB expuesto en 27017 | ⚠️ Solo interno | No exponer puerto al host sin autenticación |
| `osint_orchestrator.py` indentación | ⚠️ Errores | El código tiene errores de indentación — requiere fix antes de ejecutar |
| `network_mode: host` en ivre-client | ⚠️ Revisar | Conflicto potencial con otros contenedores |

---

## 🚀 docker-compose.yml (IVRE + Recon-ng)

```yaml
version: '3.8'

services:
  ivre-db:
    image: mongo:6.0
    container_name: ivre-mongodb
    restart: unless-stopped
    environment:
      - TZ=Europe/Madrid
    volumes:
      - ivre_db_data:/data/db

  ivre-web:
    image: ivre/web:latest
    container_name: ivre-webui
    restart: unless-stopped
    ports:
      - "8089:80"
    environment:
      - TZ=Europe/Madrid
    depends_on:
      - ivre-db

  ivre-client:
    image: ivre/client:latest
    container_name: ivre-cli
    restart: unless-stopped
    network_mode: "host"
    environment:
      - TZ=Europe/Madrid
    volumes:
      - ./ivre/scans:/workspace
    depends_on:
      - ivre-db

  recon-ng:
    image: mountainsec/recon-ng:latest  # ⚠️ verificar imagen
    container_name: batcueva-reconng
    restart: unless-stopped
    stdin_open: true
    tty: true
    environment:
      - TZ=Europe/Madrid
    volumes:
      - recon_ng_data:/root/.recon-ng

volumes:
  ivre_db_data:
  recon_ng_data:
```

---

## 🐍 osint_orchestrator.py (corregido)

```python
import os
import json
import requests
from datetime import datetime
from pymongo import MongoClient

OLLAMA_URL = "http://100.91.112.32:11434/api/generate"
OBSIDIAN_INBOX = "/home/alvaro/yggdrasil-dew/inbox"

def analizar_banner_con_llm(service_name, banner):
    prompt = f"Actúa como experto en ciberseguridad. Analiza este banner: Service: {service_name}, Banner: {banner}. Identifica CVEs comunes o configuraciones inseguras de forma concisa."
    payload = {"model": "llama3:latest", "prompt": prompt, "stream": False}
    try:
        response = requests.post(OLLAMA_URL, json=payload, timeout=60)
        return response.json().get("response", "No se pudo generar análisis.")
    except Exception as e:
        return f"Error conectando con Ollama: {str(e)}"

def generar_nota_obsidian(target, datos_servicio, analisis_ia):
    date_str = datetime.now().strftime("%Y-%m-%d")
    filename = f"OSINT_Target_{target}_{datetime.now().strftime('%Y%m%d_%H%M%S')}.md"
    filepath = os.path.join(OBSIDIAN_INBOX, filename)
    content = f"""---
tags: [osint, target-recon, batcueva, ia-analisis]
date: {date_str}
target: {target}
---

# Reporte OSINT — {target}

## Datos Técnicos (IVRE)
```json
{json.dumps(datos_servicio, indent=2, default=str)}
```

## Análisis IA (Ollama)
{analisis_ia}
"""
    with open(filepath, "w") as f:
        f.write(content)
    print(f"[+] Nota generada: {filepath}")

def main():
    print("[*] Conectando a IVRE MongoDB...")
    try:
        client = MongoClient('mongodb://127.0.0.1:27017/', serverSelectionTimeoutMS=2000)
        db = client.ivre
        results = db.results.find({"service": {"$exists": True}}).limit(5)
        for res in results:
            target = res.get("addr", "IP_Desconocida")
            service = res.get("service", "Unknown")
            banner = res.get("banner", "No Banner")
            print(f"[*] Analizando: {target} ({service})")
            analisis = analizar_banner_con_llm(service, banner)
            generar_nota_obsidian(target, res, analisis)
    except Exception as e:
        print(f"[-] Error en pipeline: {str(e)}")

if __name__ == "__main__":
    main()
```

---

## 📋 Caddyfile — añadir a /etc/caddy/Caddyfile

```
ivre.madre.tailscale {
    reverse_proxy 127.0.0.1:8089
}
```

---

## ✅ Próximos pasos

1. Verificar imágenes: `docker pull ivre/web:latest && docker pull ivre/client:latest`
2. Verificar Recon-ng: `docker pull mountainsec/recon-ng:latest`  
   Si no existe → alternativa: `docker pull tiagodread/recon-ng:latest`
3. Si imágenes OK → `cd /home/alvaro/docker/batcueva-osint && docker compose up -d`
4. Instalar dependencias del orquestador: `pip install pymongo requests`
5. Lanzar primer escaneo IVRE y probar el pipeline

---

_Fuente: Gemini (23/06/2026) · Corregido por Perplexity · MCP GitHub_
