---
tags: [inbox, local-brain, ollama, rag, pendiente]
fecha: 2026-06-23
estado: en-progreso
---

# Local Brain Setup — 2026-06-23

## Estado actual

- [x] Scripts RAG híbrido creados en `tools/local-brain/`
- [x] Versión Gemini creada (pendiente subir)
- [ ] Ollama descargando (nativo, sin Docker)
- [ ] Modelos pendientes de pull
- [ ] Backend RAG pendiente de arrancar
- [ ] Vault indexado

---

## Contexto

Docker pull de `ollama/ollama:latest` fallaba repetidamente con `tls: bad record MAC` siempre en 678.6MB — problema de MTU/red, no del script.

Decisión: instalar Ollama nativo primero, validar todo, luego dockerizar.

---

## Comandos completos — ejecutar en orden

### 1. Instalar Ollama nativo
```bash
curl -fsSL https://ollama.com/install.sh | sh
```

### 2. Arrancar Ollama (terminal 1 — dejar corriendo)
```bash
ollama serve
```

### 3. Verificar que responde
```bash
curl http://localhost:11434/api/tags
```

### 4. Descargar modelos (terminal 2)
```bash
ollama pull llama3.2:3b
ollama pull nomic-embed-text
```

### 5. Lanzar backend RAG
```bash
cd ~/Projects/yggdrasil-dew
chmod +x tools/local-brain/deploy_brain.sh
./tools/local-brain/deploy_brain.sh
```

### 6. Indexar el vault
```bash
curl -X POST http://127.0.0.1:8001/index
```

### 7. Probar consulta
```bash
curl -X POST http://127.0.0.1:8001/query \
  -H "Content-Type: application/json" \
  -d '{"prompt": "qué pendientes tengo con thdora?", "top_k": 4}'
```

### 8. Health check
```bash
curl http://127.0.0.1:8001/health
```

---

## Arquitectura

```
yggdrasil-dew (*.md)
       ↓ indexa
 ChromaDB  +  BM25
       ↓ RAG híbrido
  llama3.2:3b (Ollama :11434)
       ↓
  FastAPI :8001
       ↓
  Thdora / curl / Obsidian plugin
```

---

## Scripts en el repo

| Script | Ruta | Para qué |
|---|---|---|
| `deploy_brain.sh` | `tools/local-brain/` | Setup + arranque (Ollama) |
| `main.py` | `tools/local-brain/` | Backend RAG FastAPI |
| `deploy_brain_gemini.sh` | `tools/local-brain-gemini/` | Versión cloud con Gemini API |

---

## Próximos pasos (cuando funcione nativo)

1. Validar `/index` y `/query` funcionan
2. Conectar Thdora al endpoint `/query`
3. Dockerizar — añadir servicio `local-brain` al `docker-compose.yml` de batcueva
4. Systemd unit para `ollama serve` en arranque

---

## Fix MTU (si vuelves a Docker)

```bash
# Ver MTU actual
ip link show | grep mtu

# Bajar MTU para evitar bad record MAC
sudo ip link set docker0 mtu 1400

# Reintentar pull
docker pull ollama/ollama:latest
```
