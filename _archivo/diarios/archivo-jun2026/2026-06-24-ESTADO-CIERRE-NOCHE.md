---
tags: [estado, cierre, docker, ollama, descargas, mañana]
fecha: 2026-06-24
hora: 05:57
estado: leer-al-despertar
---

# Estado cierre noche — 24 jun 2026 05:57

> Leer esto junto con `2026-06-24-contexto-manana.md` al despertar.

---

## ✅ Docker — COMPLETO (no descargar nada más)

Todas las imágenes están en madre:

| Imagen | Tamaño |
|---|---|
| ghcr.io/open-webui/open-webui | 6.7GB |
| ollama/ollama | 8.29GB |
| n8nio/n8n | 2.39GB |
| ghcr.io/paperless-ngx/paperless-ngx | 2.01GB |
| ghcr.io/berriai/litellm | 1.53GB |
| grafana/grafana | 1.46GB |
| ghcr.io/ajnart/homarr | 1.5GB |
| jc21/nginx-proxy-manager | 1.77GB |
| lscr.io/linuxserver/code-server | 1.08GB |
| louislam/uptime-kuma | 707MB |
| vaultwarden/server | 347MB |
| portainer/portainer-ce | 242MB |
| qdrant/qdrant | 269MB |
| gitea/gitea | 247MB |
| prom/prometheus | 427MB |
| postgres:15-alpine | 417MB |
| redis:7-alpine | 58.9MB |
| containrrr/watchtower | 22.2MB |
| thdora-bot | 531MB |

**→ CERO imágenes pendientes. No lanzar ningún pull de Docker.**

---

## ⏳ Ollama — Descargando en background

Script corriendo: `/tmp/ollama-nocturno.log`

| Modelo | Tamaño | Estado |
|---|---|---|
| qwen2.5:3b | 1.9GB | ✅ ya estaba |
| qwen2.5:14b | ~9GB | ⏳ descargando ~2h36m (arrancó 05:55) |
| qwen2.5:7b | ~4.7GB | ⏳ en cola |
| llama3.1:8b | ~4.7GB | ⏳ en cola |
| mistral:7b | ~4.1GB | ⏳ en cola |
| bge-m3 | ~1.2GB | ⏳ en cola |
| nomic-embed-text | ~0.3GB | ⏳ en cola |

**Estimado total: ~7-8 horas → todo listo ~13:00h**

Verificar por la mañana:
```bash
ssh madre "ollama list && tail -10 /tmp/ollama-nocturno.log"
```

---

## 🎯 Lo que queda — solo código y config

### PRIORIDAD 1 — Levantar los stacks (30 min)
Docker tiene las imágenes pero los contenedores no están todos corriendo.
```bash
cd ~/Projects/yggdrasil-dew
git pull
docker compose -f setup/servidor/batcueva-fase1.yml up -d
docker compose -f setup/servidor/batcueva-fase2.yml up -d
docker compose -f setup/servidor/batcueva-fase3.yml up -d
docker compose -f setup/servidor/batcueva-fase4.yml up -d
```

### PRIORIDAD 2 — LiteLLM config (20 min)
Crear `setup/servidor/litellm-config.yaml` — proxy unificado para todos los modelos Ollama.
Ver: `inbox/2026-06-24-fase4-litellm-sops-plan.md`

### PRIORIDAD 3 — n8n primer workflow (30 min)
- Abrir `http://100.91.112.32:5678`
- Workflow: Telegram → fichero inbox yggdrasil-dew

### PRIORIDAD 4 — Gitea mirrors (15 min)
- Abrir `http://100.91.112.32:3003`
- Mirror de thdora + yggdrasil-dew desde GitHub

### PRIORIDAD 5 — Auditar inbox (con Perplexity)
Pedir: *«audita el inbox y migra todo lo procesado a su carpeta definitiva»*

---

## 🔍 Investigar mañana

- **Headscale** — alternativa self-hosted a Tailscale, evaluar migración
- **Flowise vs n8n** — cuál usar para agentes IA (flowise está descargado)
- **Modelfiles Ollama** — crear personalidades: Erika (asistente), agente OSINT
  - Ver: `inbox/2026-06-24-ollama-modelfile-erika.md`
- **Open WebUI RAG** — subir docs de yggdrasil-dew como base de conocimiento

---

_Generado: 24 jun 2026 05:57 CEST por Perplexity vía MCP_
_Ver: [contexto-manana.md](2026-06-24-contexto-manana.md) · [MASTER-PENDIENTES.md](../MASTER-PENDIENTES.md)_
