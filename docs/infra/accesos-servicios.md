---
tags: [tipo/ficha, estado/activo, infra/docker, infra/accesos]
fecha: 2026-07-01
---

# 🔑 Accesos — Servicios Batcueva

> SSOT de URLs, usuarios y credenciales de todos los servicios.
> Las passwords reales van en `.env` (nunca en el repo).
> Este fichero documenta el esquema, no los secretos.

---

## varopc — `100.91.112.32`

### 🤖 IA

| Servicio | URL | Auth |
|---|---|---|
| Open WebUI | `http://100.91.112.32:3001` | cuenta local |
| Ollama API | `http://100.91.112.32:11434` | sin auth |
| Ollama Embeddings | `http://100.91.112.32:11435` | sin auth |
| Qdrant API | `http://100.91.112.32:6333` | sin auth |

### 📈 Observabilidad

| Servicio | URL | Auth |
|---|---|---|
| Portainer | `http://100.91.112.32:9000` | admin / ver `.env` |
| Grafana | `http://100.91.112.32:3000` | admin / ver `.env` |
| Uptime Kuma | `http://100.91.112.32:3002` | cuenta local |
| Prometheus | `http://100.91.112.32:9090` | sin auth |

### 🛠️ Desarrollo

| Servicio | URL | Auth |
|---|---|---|
| Gitea | `http://100.91.112.32:3003` | cuenta local |
| Code Server | `https://100.91.112.32:8443` | password en `.env` |
| n8n | `http://100.91.112.32:5678` | cuenta local |

### 🤖 Bot

| Servicio | URL | Auth |
|---|---|---|
| THDORA API | `http://100.91.112.32:8000` | sin auth (red interna) |
| THDORA Docs | `http://100.91.112.32:8000/docs` | sin auth |

### 🔍 Pentest / OSINT — 🔜 EN DESPLIEGUE

| Servicio | URL | Usuario | Credencial |
|---|---|---|---|
| SpiderFoot | `http://100.91.112.32:5001` | — | sin auth por defecto |
| Kali Desktop | `https://100.91.112.32:6901` | `kasm_user` | `$KALI_VNC_PASSWORD` (`.env`) |

> 🔐 **Credencial Kali por defecto:** `batcueva2026`
> Cambiar antes de exponer fuera de Tailscale:
> ```bash
> echo 'KALI_VNC_PASSWORD=nueva_password_segura' >> ~/yggdrasil-dew/osint-stack/.env
> docker compose -f osint-stack/docker-compose.kali.yml up -d
> ```

---

## Acer / Theodora — `100.86.119.102`

| Servicio | URL | Auth |
|---|---|---|
| Netdata | `http://100.86.119.102:19999` | sin auth (Tailscale only) |

---

## 🚨 Reglas de seguridad

1. **Nunca** subir passwords reales al repo — usar `.env` local
2. Todos los servicios accesibles **solo via Tailscale** (100.x.x.x)
3. SpiderFoot y Kali especialmente — no exponer a internet
4. `.env` en `.gitignore` siempre
5. Rotar password Kali antes de usar en pentest real

---
_Actualizado: 01 jul 2026 — Perplexity vía MCP_
_Ver: [[ESTADO-SISTEMA]] · [[docker/README]]_
