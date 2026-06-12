# Ollama + Open WebUI — LLM Local

> Stack completo para correr LLMs locales en el Ordenador Madre.
> Diseñado por Gemini · Integrado por Perplexity · 12 junio 2026
> Hardware: i5-8400 · 16GB RAM · GTX 1060 6GB

---

## Requisito previo — NVIDIA Container Toolkit

```bash
# En Arch Linux (AUR)
yay -S nvidia-container-toolkit

# Reiniciar Docker para que detecte la GPU
sudo systemctl restart docker

# Verificar que Docker ve la GPU
docker run --rm --gpus all nvidia/cuda:12.0-base nvidia-smi
```

---

## Docker Compose

Crea `~/servidor/ollama/docker-compose.yml`:

```yaml
services:
  ollama:
    image: ollama/ollama:latest
    container_name: ollama
    ports:
      - "11434:11434"
    volumes:
      - ./ollama:/root/.ollama
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]

  open-webui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: open-webui
    ports:
      - "3000:8080"
    environment:
      - OLLAMA_BASE_URL=http://ollama:11434
    volumes:
      - ./webui:/app/backend/data
    depends_on:
      - ollama
```

---

## Arrancar el stack

```bash
# Levantar en background
docker compose up -d

# Verificar que corren
docker compose ps

# Ver logs
docker compose logs -f
```

**Open WebUI disponible en:** http://localhost:3000 (o desde otra máquina: http://IP_MADRE:3000)

---

## Modelos recomendados para GTX 1060 6GB

| Modelo | VRAM | Velocidad | Uso recomendado |
|---|---|---|---|
| `llama3.2:3b` | ~2GB | Rápido | Chat diario, respuestas rápidas |
| `codellama:7b-q4` | ~4GB | Medio | Código, programación |
| `mistral:7b-q4` | ~4GB | Medio | Razonamiento general |
| `phi3:mini` | ~2GB | Muy rápido | Tareas ligeras |

```bash
# Descargar modelo (ejecutar dentro del contenedor)
docker exec -it ollama ollama pull llama3.2:3b
docker exec -it ollama ollama pull codellama:7b-q4
```

---

## Integración con THDORA (futuro)

```python
# THDORA llamando al LLM local
import httpx

response = httpx.post(
    "http://IP_MADRE:11434/api/generate",
    json={"model": "llama3.2:3b", "prompt": "...", "stream": False}
)
```

---

## Estado

| Tarea | Estado |
|---|---|
| NVIDIA Container Toolkit instalado | ⏳ Pendiente |
| docker-compose.yml creado | ✅ Documentado aquí |
| Primer `docker compose up` | ⏳ Pendiente |
| Modelo descargado | ⏳ Pendiente |
| Open WebUI accesible desde LAN | ⏳ Pendiente |
| THDORA integrado con Ollama | ⏳ Futuro |
