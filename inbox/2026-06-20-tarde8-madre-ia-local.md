# Inbox — Madre: IA Local + Ollama + Plan Completo · 20 junio 2026

> Tags: `#madre` `#ollama` `#ia-local` `#docker` `#open-webui` `#llm` `#open-source` `#hardware`
> Estado: 🟡 Pendiente ejecutar
> Procesar a: `projects/ia-local-madre.md` · `setup/madre.md`

---

## 🖥️ Hardware Madre — Estado actual

| Componente | Valor | Para IA |
|---|---|---|
| CPU | Intel i5-8400 | ⚠️ Lento en CPU-only (1-3 tok/s) |
| RAM | 15 Gi | ✅ OK para modelos 7B-13B |
| Disco | 930 GB (8% usado) | ✅ Espacio de sobra |
| GPU | Sin GPU dedicada | ❌ Cuello de botella |
| Docker | Instalado, inactivo | ⚠️ Arrancar |

### GPUs recomendadas (segunda mano)
| GPU | VRAM | Modelos | Precio |
|---|---|---|---|
| RTX 3060 | 12 GB | 7B-8B completos a 30-50 tok/s | ⭐ mejor opción |
| RTX 4060 Ti | 16 GB | hasta 14B o 22B cuantizados | más caro pero future-proof |

> Sin GPU: Ollama corre en CPU — funciona pero lento. Útil para empezar.

---

## 🧠 Modelos open-source recomendados (Junio 2026)

| Modelo | Tamaño | Puntos fuertes | Ideal para |
|---|---|---|---|
| **Llama 3.1/3.2** | 8B Q4 | Español, 128k contexto | Asistente general |
| **Mistral 7B** | 7B | Eficiencia, técnico | Scripts, automatizaciones |
| **Codestral** | 22B | Código superior | Programación avanzada |
| **Phi-3.5/4** | 3.8B-7B | Ultra rápido | Respuestas rápidas |
| **DeepSeek-Coder-V2** | 16B Lite | Mejor que GPT-4 en código | Neovim, VS Code |

---

## 🐳 Docker Compose — Ollama + Open WebUI

Crear en Madre:
```bash
mkdir -p ~/docker/ai-stack
cd ~/docker/ai-stack
nvim docker-compose.yml
```

Contenido `docker-compose.yml`:
```yaml
version: '3.8'

services:
  ollama:
    image: ollama/ollama:latest
    container_name: ollama
    restart: unless-stopped
    ports:
      - "11434:11434"
    volumes:
      - ./ollama_data:/root/.ollama
    # Descomentar si hay GPU NVIDIA:
    # deploy:
    #   resources:
    #     reservations:
    #       devices:
    #         - driver: nvidia
    #           count: all
    #           capabilities: [gpu]

  open-webui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: open-webui
    restart: unless-stopped
    ports:
      - "3000:8080"
    volumes:
      - ./webui_data:/app/backend/data
    environment:
      - OLLAMA_BASE_URL=http://ollama:11434
    depends_on:
      - ollama
```

Levantar:
```bash
sudo systemctl enable --now docker
docker compose up -d
```

Descargar modelos:
```bash
docker exec -it ollama ollama run llama3.1
docker exec -it ollama ollama run mistral
```

Abrir en navegador: `http://100.91.112.32:3000` (desde Acer via Tailscale)

---

## 🧠 Conceptos clave IA local

- **Cuantización (Q4/Q8)**: comprimir modelo para que quepa en menos RAM. 8B Q4 = ~4.8GB, 95% inteligencia original
- **Context Window**: memoria de la conversación. Llama 3.1 = 128k tokens. Limitar a 8k-16k para fluidez en local
- **RAG**: darle documentos al modelo (PDFs, logs, notas) para que los lea y responda. Open WebUI lo incluye nativo → útil para analizar logs del sistema, yggdrasil-dew, etc.

---

## 📝 Pendientes Madre — orden de ejecución

### Ahora mismo
- [ ] Arreglar salvapantallas/hyprlock en Madre
- [ ] Verificar `~/Projects/thdora` y `~/dev/thdora`
- [ ] Arrancar Docker: `sudo systemctl enable --now docker`
- [ ] Ver contenedores configurados: `docker ps -a`

### Red (failover)
- [ ] Activar USB tethering en móvil
- [ ] Ver interfaz USB: `ip link show`
- [ ] Script failover WiFi → USB automático

### IA Local
- [ ] Crear `~/docker/ai-stack/docker-compose.yml`
- [ ] `docker compose up -d`
- [ ] Descargar llama3.1:8b + mistral:7b
- [ ] Abrir Open WebUI en `http://100.91.112.32:3000`
- [ ] Conectar desde Acer via Tailscale

### Dashboard
- [ ] Fase 1 HTML estático con datos reales
- [ ] Añadir card Ollama: modelos cargados, uso RAM
- [ ] Añadir logs bot Telegram
- [ ] Añadir estado Docker containers

---

_Tags: `#ollama` `#docker` `#ia-local` `#madre` `#llm` `#open-source` `#dashboard`_
