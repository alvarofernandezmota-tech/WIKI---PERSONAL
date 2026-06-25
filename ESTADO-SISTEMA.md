---
tags: [estado, sistema, operativo, servicios, ahora]
fecha-actualizacion: 2026-06-25
hora: 12:33
---

# 📊 ESTADO DEL SISTEMA — 25 jun 2026

> Este archivo refleja el estado REAL operativo ahora mismo.
> Actualizar cada vez que cambie algo importante.
> Ver auditoría completa en [[diarios/2026-06-25-DIARIO-MAESTRO]]

---

## 🖥️ Máquinas

| Máquina | Estado | Observaciones |
|---|---|---|
| **Madre** | ✅ encendida y accesible | SSH funciona por IP (100.91.112.32) · alias `madre` pendiente ~/.ssh/config |
| **varopc** | ✅ activo | Usando ahora mismo |
| **Redmi A5** | ✅ activo | Tailscale pendiente instalar desde Play Store |

---

## 🐳 Docker — Estado Madre

### Stack Fase 1+2 — LEVANTADO Y HEALTHY ✅

| Contenedor | Puerto | Estado |
|---|---|---|
| `ollama` | 11434 | ✅ healthy |
| `open-webui` | 3001 | ✅ healthy |
| `qdrant` | 6333 | ✅ healthy |

> Incidencias resueltas hoy: puerto 11434 ocupado por ollama nativo (pkill) · healthcheck qdrant /healthz (docker compose down completo)

### Stack Fase 3 — YML LISTO, NO EJECUTADO ⏳
```
batcueva-fase3.yml → n8n (:5678) + Paperless-ngx (:8010) + Vaultwarden (:8888)
```
- Pendiente: verificar dependencias previas antes de `docker compose -f batcueva-fase3.yml up -d`
- Investigación en curso con Gemini → guardar en `setup/servidor/investigacion/`

### Stack Fase 4 — YML LISTO, NO EJECUTADO ⏳
```
batcueva-fase4.yml → LiteLLM + Caddy + Watchtower
```
- Pendiente: `litellm-config.yaml` mínimo antes de arrancar

### Stack OSINT — YML LISTO, NO EJECUTADO ⏳
```
batcueva-osint.yml → SpiderFoot (:5001) + IVRE
```

### Imágenes descargadas en Madre ✅
```
ghcr.io/open-webui/open-webui   6.7GB
ollama/ollama                   8.29GB
n8nio/n8n                       2.39GB
ghcr.io/paperless-ngx           2.01GB
ghcr.io/berriai/litellm         1.53GB
grafana/grafana                 1.46GB
jc21/nginx-proxy-manager        1.77GB
lscr.io/linuxserver/code-server 1.08GB
louislam/uptime-kuma            707MB
vaultwarden/server              347MB
portainer/portainer-ce          242MB
qdrant/qdrant                   269MB
gitea/gitea                     247MB
postgres:15-alpine              417MB
redis:7-alpine                  58.9MB
containrrr/watchtower           22.2MB
thdora-bot                      531MB
```

---

## 🤖 Ollama — Estado modelos

| Modelo | Estado | Verificado |
|---|---|---|
| qwen2.5:3b | ✅ listo | 25 jun 12:10 |
| qwen2.5:14b | ❌ no presente | — verificar si falló descarga |
| qwen2.5:7b | ❌ no presente | pendiente `ollama pull` |
| llama3.1:8b | ❌ no presente | pendiente `ollama pull` |
| mistral:7b | ❌ no presente | pendiente `ollama pull` |
| bge-m3 | ❌ no presente | pendiente `ollama pull` |
| nomic-embed-text | ❌ no presente | pendiente `ollama pull` |

> Comando para tirar pulls en background sin que se corten:
> ```bash
> ssh madre "nohup bash -c 'for m in qwen2.5:7b llama3.1:8b mistral:7b bge-m3 nomic-embed-text; do docker exec ollama ollama pull $m; done' > /tmp/ollama-pulls.log 2>&1 &"
> ```

---

## 🗂️ Repos GitHub

| Repo | Último commit | Estado |
|---|---|---|
| yggdrasil-dew | 25 jun 12:33 | ✅ actualizado |
| thdora | 24 jun 03:12 | 🔧 pendiente handlers /estado /inbox /diario |
| local-brain | 24 jun 03:13 | ⚠️ pendiente documentar Docker |
| osint-stack | 24 jun 03:13 | ⚠️ pendiente documentar Docker |
| personal | 24 jun 02:19 | ✅ ok |

---

## 📥 Inbox

| Estado | Detalle |
|---|---|
| ~93 archivos en inbox/ | ⚠️ SIN MIGRAR — llevan 2 días pendientes |
| Script migración | ✅ generado pero NO ejecutado |
| Regla activa | máx 10 archivos, vida 24h — ver [[inbox/README]] |

---

## 🔐 Red y acceso

| Servicio | Estado |
|---|---|
| Tailscale varopc | ✅ activo |
| Tailscale Madre | ⚠️ pendiente autoarranque — ver setup/servidor/tailscale-autoarranque.md |
| Tailscale Redmi A5 | ⚠️ pendiente instalar — Play Store (APK split no funciona por ADB) |
| SSH varopc→Madre por IP | ✅ funciona (varopc@100.91.112.32) |
| SSH alias `madre` | ⚠️ pendiente añadir en ~/.ssh/config |
| SSH sin contraseña | ✅ clave instalada en Madre hoy |
| UFW Madre | ⚠️ pendiente activar reglas definitivas |
| SSH hardening | ⚠️ documentado en fase1b-seguridad.md — NO aplicado |

---

## 🪟 Windows 11 ISO (UUP)

| Estado | Detalle |
|---|---|
| Descarga | ❌ fallida — checksum error en 4 archivos grandes |
| Causa | Set UUP expirado (links Microsoft caducan) |
| Solución | Generar nuevo set en uupdump.net → W11 24H2 · amd64 · es-ES · Pro |
| Script | `~/Downloads/uup/uup_download_linux.sh` |

---

## 📋 Próximas acciones inmediatas (orden de prioridad)

1. `~/.ssh/config` → añadir entrada `Host madre` para alias sin password
2. Tailscale Redmi A5 → instalar desde Play Store
3. Modelos Ollama → lanzar pulls en background (comando arriba)
4. Fase 3 Docker → revisar respuesta Gemini → ejecutar en Madre
5. Inbox → vaciar 93 archivos a sus carpetas definitivas
6. UFW + SSH hardening en Madre

---
_Actualizado: 25 jun 2026 12:33 CEST — Perplexity vía MCP_
_Ver: [[MASTER-PENDIENTES]] · [[diarios/2026-06-25-DIARIO-MAESTRO]] · [[inbox/README]]_
