---
tipo: pendientes-maestro
fecha: 2026-06-25
hora: "01:44"
status: activo
tags: [madre, pendientes, docker, ollama, thdora, litellm, sops, n8n, homelab]
priority: REFERENCIA
---

# 🖥️ MADRE — Pendientes Maestro

> Documento vivo. Todo lo que hay que hacer cuando la máquina madre esté operativa.
> Generado 2026-06-25 01:44 CEST. Actualizar con cada sesión.

---

## 🔴 Estado Actual de Madre

| Item | Estado |
|---|---|
| Máquina física | ✅ Existe (Arch Linux) |
| Hyprland | ✅ Instalado |
| Ollama instalado | ✅ Sí |
| Modelo qwen2.5:7b | ⏳ Descargando / pendiente verificar |
| Modelo bge-m3 | ⏳ Pendiente descargar |
| Docker instalado | ⚠️ Pendiente verificar |
| Stack Docker completo | 🔴 No desplegado |
| Red interna Docker | 🔴 Sin configurar |
| hypridle | ⚠️ Desactivado manualmente (para descargas nocturnas) |
| Obsidian | ✅ Instalado (vault sincroniza con repo) |
| Conexión Vault→GitHub | ✅ OK vía obsidian-git |

---

## 📦 FASE 1 — Setup Base (hacer primero)

### 1.1 Verificar Ollama + Modelos

```bash
# Verificar que Ollama corre
curl http://localhost:11434/api/tags

# Modelos que deben estar descargados
ollama list
# Esperado:
# qwen2.5:7b   ~4.7GB
# bge-m3       ~0.6GB (embeddings)
# nomic-embed  ~0.3GB (alternativa embeddings ligera)

# Si no están, descargar:
ollama pull qwen2.5:7b
ollama pull bge-m3
```

### 1.2 Verificar Docker

```bash
docker --version
docker compose version
docker ps

# Si no está instalado (Arch Linux):
sudo pacman -S docker docker-compose
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
```

### 1.3 Activar hypridle de nuevo (post-descargas)

```bash
# Volver a activar cuando las descargas terminen
systemctl --user enable hypridle
systemctl --user start hypridle
```

---

## 🐳 FASE 2 — Stack Docker Completo

> Decisión ADR-003: Ollama como servidor principal (ganó vs llama.cpp)
> Ver: docs/adr/ADR-003-ollama-vs-llamacpp.md

### 2.1 Arquitectura del Stack

```
Madre (16GB RAM / Arch Linux)
├── ollama-chat (puerto 11434)     → qwen2.5:7b  → conversación
├── ollama-embeddings (puerto 11435) → bge-m3    → RAG / Qdrant
├── litellm (puerto 4000)          → proxy unificado de modelos
├── open-webui (puerto 3000)       → interfaz web
├── n8n (puerto 5678)              → automatizaciones
├── qdrant (puerto 6333)           → vector DB para RAG
├── nginx-proxy-manager (puerto 81)→ reverse proxy
└── perplexica (puerto 3001)       → búsqueda local con IA
```

### 2.2 Límites RAM por servicio

| Servicio | RAM Límite | RAM Real | Prioridad |
|---|---|---|---|
| ollama-chat | 8 GB | ~6.5 GB (qwen2.5:7b) | CRÍTICA |
| ollama-embeddings | 2 GB | ~0.6 GB (bge-m3) | ALTA |
| litellm | 512 MB | ~200 MB | ALTA |
| open-webui | 512 MB | ~300 MB | MEDIA |
| n8n | 1 GB | ~400 MB | MEDIA |
| qdrant | 1 GB | ~200 MB | MEDIA |
| nginx-proxy-manager | 256 MB | ~100 MB | BAJA |
| **TOTAL** | **~13.5 GB** | **~8.3 GB real** | ✅ Viable |

### 2.3 Docker Compose — Dos Ollama

```yaml
services:
  ollama-chat:
    image: ollama/ollama:latest
    container_name: ollama-chat
    ports: ["11434:11434"]
    volumes: ["./data/ollama_chat:/root/.ollama"]
    environment:
      - OLLAMA_NUM_PARALLEL=1
      - OLLAMA_MAX_LOADED_MODELS=1
    deploy:
      resources:
        limits: { cpus: '3.0', memory: 8g }
    restart: unless-stopped

  ollama-embeddings:
    image: ollama/ollama:latest
    container_name: ollama-embeddings
    ports: ["11435:11434"]
    volumes: ["./data/ollama_embed:/root/.ollama"]
    environment:
      - OLLAMA_NUM_PARALLEL=1
      - OLLAMA_MAX_LOADED_MODELS=1
    deploy:
      resources:
        limits: { cpus: '1.0', memory: 2g }
    restart: unless-stopped
```

### 2.4 Pasos de despliegue

- [ ] Clonar o crear directorio `/opt/yggdrasil-stack/`
- [ ] Poner el docker-compose.yml (ver inbox/2026-06-24-docker-compose-final-completo.md)
- [ ] Crear estructura de directorios `./data/`
- [ ] `docker compose pull` — descargar todas las imágenes
- [ ] `docker compose up -d` — arrancar stack
- [ ] Verificar con `docker ps` que todos los containers están `Up`
- [ ] Pre-cargar modelos en Ollama containers:
  ```bash
  docker exec ollama-chat ollama pull qwen2.5:7b
  docker exec ollama-embeddings ollama pull bge-m3
  ```

---

## 🤖 FASE 3 — THDORA + Agentes

> Ver repo THDORA para el código. Aquí solo arquitectura y decisiones.

### 3.1 Clasificación de Comandos THDORA

| Tipo | Ejemplo | Necesita IA | Resolución |
|---|---|---|---|
| Consulta instantánea | /status /ram /cpu | ❌ No | subprocess / psutil |
| Control Docker | /up /down /restart | ❌ No | docker SDK / subprocess |
| Consulta con LLM | /pregunta /explica | ✅ Sí | Ollama API (qwen2.5:7b) |
| Acción de negocio | reserva / cita | ✅ Sí | function calling |
| Alerta automática | RAM > 85% / container caído | ❌ No | monitor + scheduler |
| Flujo conversacional | onboarding cliente | ✅ Sí | estado + Ollama |
| Embeddings / RAG | buscar en docs | ✅ Sí | bge-m3 + Qdrant |

### 3.2 Conexiones THDORA → Stack

```python
# THDORA sabe a qué Ollama llamar según la tarea
OLLAMA_CHAT_URL  = "http://ollama-chat:11434"       # qwen2.5:7b
OLLAMA_EMBED_URL = "http://ollama-embeddings:11434"  # bge-m3
LITELLM_URL      = "http://litellm:4000"             # proxy unificado
QDRANT_URL       = "http://qdrant:6333"              # vector DB

# Para conversación:
response = ollama_chat.chat(model="qwen2.5:7b", messages=[...])

# Para RAG:
vector = ollama_embed.embeddings(model="bge-m3", prompt=query)
results = qdrant.search(collection="docs", query_vector=vector)
```

### 3.3 Pendientes THDORA

- [ ] Inventariar todos los comandos actuales en repo THDORA
- [ ] Clasificar cada uno por la tabla 3.1
- [ ] Implementar conexión a ollama-chat
- [ ] Implementar conexión a ollama-embeddings + Qdrant
- [ ] Probar con qwen2.5:7b cuando esté en madre
- [ ] Medir RAM real con ambos Ollama activos

---

## 🔐 FASE 4 — LiteLLM + SOPS (Secretos)

> Ver inbox/2026-06-24-fase4-litellm-sops-plan.md para el plan completo (9KB)

### 4.1 LiteLLM como proxy unificado

LiteLLM permite que cualquier servicio (THDORA, n8n, open-webui) hable con UN solo endpoint, y LiteLLM decide si manda la petición a Ollama local o a una API externa (OpenAI, Anthropic, Gemini).

```
THDORA → LiteLLM:4000 → [ollama-chat local]
                       → [OpenAI API] (si se configura)
                       → [Gemini API] (si se configura)
```

### 4.2 SOPS para secretos

- [ ] Instalar `sops` en madre: `sudo pacman -S sops`
- [ ] Generar clave age: `age-keygen -o ~/.config/sops/key.txt`
- [ ] Crear `.sops.yaml` en la raíz del repo
- [ ] Cifrar secrets: API keys de OpenAI, Anthropic, etc.
- [ ] NUNCA commitear `.env` sin cifrar

### 4.3 Pendientes LiteLLM + SOPS

- [ ] Desplegar litellm container
- [ ] Configurar `litellm_config.yaml` con modelos locales
- [ ] Apuntar THDORA a LiteLLM en vez de Ollama directamente
- [ ] Configurar SOPS antes de añadir cualquier API key externa

---

## 🔄 FASE 5 — n8n Automatizaciones

> Ver inbox/2026-06-24-n8n-litellm-integracion.md

### 5.1 Flujos prioritarios a crear en n8n

- [ ] **Sync Obsidian → GitHub**: Trigger en cambio de fichero → commit automático
- [ ] **Monitor RAM**: Cada 5min → si RAM > 85% → alerta Telegram/webhook
- [ ] **Monitor Docker**: Cada minuto → si container caído → restart + alerta
- [ ] **Inbox Processor**: Nuevo fichero en inbox → clasificar con LLM → mover a carpeta correcta
- [ ] **Daily digest**: A las 08:00 → resumen de pendientes del día

### 5.2 Pendientes n8n

- [ ] Acceder a n8n en `http://madre-ip:5678`
- [ ] Crear workflows de los 5 puntos anteriores
- [ ] Conectar n8n a LiteLLM para los workflows con IA

---

## 🗄️ FASE 6 — RAG sobre la Repo (Local Brain)

> Ver inbox/2026-06-24-langchain-ollama-optimizacion.md y inbox/2026-06-23-local-brain-setup.md

### 6.1 Objetivo

Que THDORA / cualquier agente pueda responder preguntas sobre la documentación del repo usando RAG local.

### 6.2 Stack RAG

```
Repo yggdrasil-dew (Markdown)
    ↓  (ingest)
bge-m3 (embeddings) → Qdrant (vector store)
    ↓  (query)
qwen2.5:7b (LLM) → respuesta
```

### 6.3 Pendientes RAG

- [ ] Script de ingest: leer todos los `.md` del repo → embedir con bge-m3 → guardar en Qdrant
- [ ] Colección Qdrant: `yggdrasil-docs`
- [ ] API de consulta: recibe pregunta → embede → busca en Qdrant → manda al LLM
- [ ] Integrar en THDORA como comando `/buscar <query>`

---

## 🌐 FASE 7 — Acceso Externo (Nginx + Red)

> Ver inbox/2026-06-24-nginx-proxy-manager.md

### 7.1 Pendientes red

- [ ] Configurar IP fija para madre en la red local
- [ ] Instalar nginx-proxy-manager container
- [ ] Crear subdominios locales: `ollama.local`, `n8n.local`, `webui.local`
- [ ] Configurar HTTPS local con certificados auto-firmados
- [ ] (Futuro) Exponer servicios externos con Cloudflare Tunnel

---

## 🔬 FASE 8 — OSINT Stack

> Ver inbox/2026-06-24-osint-visual-personas-camaras.md y inbox/2026-06-23-auditoria-osint.md

### 8.1 Herramientas a desplegar

- [ ] SpiderFoot (error de descarga pendiente resolver — ver inbox/2026-06-24-error-spiderfoot-descarga.md)
- [ ] Maltego CE
- [ ] Sherlock
- [ ] Integración OSINT → RAG (ver inbox/2026-06-23-osint-rag-mover.md)

---

## 📋 CHECKLIST FINAL — Orden de ejecución

```
□ FASE 1: Verificar Ollama + modelos + Docker
□ FASE 2: Desplegar stack Docker completo
□ FASE 4: SOPS antes de tocar secretos
□ FASE 3: Conectar THDORA al stack
□ FASE 4: LiteLLM como proxy
□ FASE 5: Crear workflows n8n
□ FASE 6: Montar RAG local
□ FASE 7: Red + Nginx
□ FASE 8: OSINT stack
```

---

## 🔗 Referencias en el repo

- `docs/adr/ADR-003-ollama-vs-llamacpp.md` — Ollama es el ganador
- `docs/adr/ADR-004-estrategia-ramas-github.md` — ramas por feature
- `inbox/2026-06-24-ECOSISTEMA-COMPLETO-MIGRACION.md` — ecosistema completo
- `inbox/2026-06-24-fase4-litellm-sops-plan.md` — LiteLLM + SOPS detallado
- `inbox/2026-06-24-docker-compose-final-completo.md` — docker-compose real
- `inbox/2026-06-24-langchain-ollama-optimizacion.md` — optimización LangChain
- `inbox/2026-06-24-SESION-INVESTIGACION-MODELOS-COMPLETA.md` — investigación modelos completa

---

*Última actualización: 2026-06-25 01:44 CEST — Perplexity + revisión inbox completa*
