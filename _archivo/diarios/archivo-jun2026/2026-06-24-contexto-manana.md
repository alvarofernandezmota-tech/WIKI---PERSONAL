---
tags: [contexto, manana, configuracion, prioridades, descargas]
fecha: 2026-06-24
estado: leer-primero
ruta-obsidian: inbox/2026-06-24-contexto-manana.md
---

# Contexto mañana — 24 jun 2026

> Leer esto LO PRIMERO al despertar antes de tocar nada.
> Las 3 terminales han estado trabajando toda la noche.

---

## Estado esperado al despertar

### Terminal 1 — Docker descargas (Fase 3 + 4)
```
✅ n8nio/n8n:latest
✅ gitea/gitea:latest
✅ lscr.io/linuxserver/code-server:latest
✅ headscale/headscale:latest
✅ vaultwarden/server:latest
✅ jc21/nginx-proxy-manager:latest
✅ containrrr/watchtower:latest
✅ ghcr.io/berriai/litellm:main-latest
```

### Terminal 2 — Ollama modelos
```
✅ qwen2.5:3b     (ya estaba)
✅/⏳ nomic-embed-text
✅/⏳ bge-m3
✅/⏳ qwen2.5:7b
✅/⏳ qwen2.5:14b
✅/⏳ llama3.1:8b
✅/⏳ mistral:7b
```

### Terminal 3 — Maestro nocturno
```
✅/⏳ Ollama modelos (skip si T2 los hizo)
✅/⏳ Seguridad: suspensión deshabilitada
✅/⏳ UFW activo con reglas del stack
✅/⏳ sysctl hardening aplicado
✅/⏳ Fase 3 levantada (n8n+gitea+code-server+headscale)
✅/⏳ Fase 4 levantada (nginx+watchtower+litellm)
```

---

## Primero al despertar — verificar estado

```bash
# 1. Ver qué terminó
ssh madre
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
ollama list

# 2. Ver logs de lo que no terminó
tail -50 /tmp/t3-maestro.log
tail -50 /tmp/descargas-madre.log

# 3. Si T3 no llegó a levantar las fases, lanzar manual:
cd ~/Projects/yggdrasil-dew
git pull
docker compose -f setup/servidor/batcueva-fase3.yml up -d
docker compose -f setup/servidor/batcueva-fase4.yml up -d
```

---

## Orden de configuración mañana (paso a paso)

### PASO 1 — Verificar y completar descargas (5 min)
- `docker ps` — confirmar todos los contenedores healthy
- `ollama list` — confirmar modelos
- Si algo falta: relanzar el script que corresponda

### PASO 2 — Configurar servicios nuevos (30 min)

#### n8n (:5678)
- Abrir `http://100.91.112.32:5678`
- Crear cuenta admin
- Primer workflow: **inbox Telegram → fichero yggdrasil-dew**
- Ver: `setup/servidor/batcueva-fase3-doc.md`

#### Gitea (:3003)
- Abrir `http://100.91.112.32:3003`
- Crear cuenta admin (mismo user que GitHub)
- Crear org `alvarofernandezmota-tech`
- Hacer mirror de repos clave: thdora, yggdrasil-dew
- **Por qué:** backup local de GitHub, funciona sin internet

#### Code Server (:8443)
- Abrir `http://100.91.112.32:8443`
- VSCode en el browser desde cualquier dispositivo
- Workspace ya apunta a yggdrasil-dew
- Cambiar PASSWORD en `.env` antes de levantar

#### Open WebUI RAG (:3001)
- Subir docs de yggdrasil-dew como base de conocimiento
- Probar query: *¿Cuál es el estado actual de Madre?»*
- Conectar modelo: `qwen2.5:7b` como principal

### PASO 3 — Seguridad (15 min)
- Verificar UFW: `sudo ufw status numbered`
- Verificar sysctl: `cat /etc/sysctl.d/99-madre-hardening.conf`
- Si T3 no lo hizo: `bash setup/servidor/scripts/t3-maestro-nocturno.sh` (re-ejecutable)
- SSH hardening: ver `inbox/2026-06-24-ssh-hardening.md`

### PASO 4 — LiteLLM proxy (:4000) (20 min)
- Crear `setup/servidor/litellm-config.yaml`
- Conecta todos los modelos Ollama bajo una API unificada
- OpenCode + thdora + n8n usan LiteLLM como punto de entrada único

### PASO 5 — Auditar inbox yggdrasil-dew (con Perplexity)
- Pedirle a Perplexity: *«audita el inbox de ygg y migra todo lo completo»*
- Ficheros del inbox listos para migrar:
  - `2026-06-23-auditoria-ollama.md` → `ollama/`
  - `2026-06-23-ollama-guia-seleccion.md` → `ollama/GUIA-SELECCION.md`
  - `2026-06-23-ollama-rag-investigacion.md` → `ollama/RAG-INVESTIGACION.md`
  - `2026-06-24-ssh-hardening.md` → `setup/servidor/ssh-hardening.md`
  - `2026-06-24-kernel-sysctl-hardening.md` → `setup/servidor/kernel-sysctl.md`

---

## Servicios completos cuando todo esté up

| Servicio | URL | Para qué |
|---|---|---|
| Ollama API | `http://madre:11434` | Modelos IA locales |
| Open WebUI | `http://madre:3001` | Chat con tus docs (RAG) |
| Qdrant | `http://madre:6333` | Vector store |
| Portainer | `http://madre:9000` | Gestionar Docker visual |
| Uptime Kuma | `http://madre:3001` | Monitor servicios |
| Heimdall | `http://madre:8090` | Dashboard servicios |
| n8n | `http://madre:5678` | Automatización workflows |
| Gitea | `http://madre:3003` | GitHub local backup |
| Code Server | `http://madre:8443` | VSCode en browser |
| Headscale | `http://madre:8085` | VPN propia (reemplaza Tailscale) |
| SpiderFoot | `http://madre:5001` | OSINT |
| LiteLLM | `http://madre:4000` | Proxy unificado IA |
| Nginx Proxy Mgr | `http://madre:81` | Proxy inverso + HTTPS |
| Watchtower | — | Auto-update contenedores |

---

## Notas importantes

- **LiteLLM necesita** `setup/servidor/litellm-config.yaml` antes de levantar — crear mañana
- **Code Server**: cambiar PASSWORD en `.env` antes de abrir al exterior
- **Headscale**: alternativa self-hosted a Tailscale — migrar cuando esté estable
- **Fase 3 no tiene Paperless ni Vaultwarden** en el compose actual — añadir si se necesitan
- **SpiderFoot** ya está en `batcueva-fase2.yml` como `smicallef/spiderfoot:latest`

---

_Generado: 24 jun 2026 05:37 CEST por Perplexity vía MCP_
_Ver: [MASTER-PENDIENTES.md](../MASTER-PENDIENTES.md) · [ESTADO-SISTEMA.md](../ESTADO-SISTEMA.md)_
