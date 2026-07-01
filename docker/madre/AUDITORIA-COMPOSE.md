---
tags: [tipo/adr, estado/activo, #infra/docker]
---

# Auditoría Compose — Estado Real Madre

> ✅ ACTIVO — VALIDADO: 2026-07-01

## Problema detectado (Regla 14)

En madre hay **14 servicios corriendo** pero el repo solo documentaba 4.
Esta auditoría mapea todos los compose encontrados y su estado real.

---

## Compose encontrados en madre

| Ruta | Servicios | Estado |
|------|-----------|--------|
| `~/docker-compose.yml` | ollama, ollama-embeddings, qdrant, open-webui | ✅ ACTIVO |
| `~/Projects/thdora/docker-compose.yml` | thdora, thdora-bot | ✅ ACTIVO |
| `~/Projects/thdora/docker/docker-compose.yml` | thdora (alt) | ❓ revisar |
| `~/spiderfoot/docker-compose.yml` | spiderfoot | ✅ ACTIVO |
| `~/spiderfoot/docker-compose-full.yml` | spiderfoot full | ⏳ no levantado |
| `~/spiderfoot/docker-compose-dev.yml` | spiderfoot dev | ⏳ no levantado |
| `~/docker/batcueva-nueva/docker-compose.yml` | batcueva nueva | ⏳ pendiente revisar |
| `~/Obsidian/cerebro/.../docker-compose.yml` | antiguo cerebro | 📦 archivo |

---

## Servicios corriendo NO documentados en repo

Estos 10 servicios están en producción pero su compose no está en `docker/madre/`:

| Servicio | Puerto | Origen probable |
|----------|--------|-----------------|
| `code-server` | 8443 | compose separado pendiente localizar |
| `n8n` | 5678 | compose separado pendiente localizar |
| `gitea` | 3003/2222 | compose separado pendiente localizar |
| `uptime-kuma` | 3002 | compose separado pendiente localizar |
| `portainer` | 9000 | compose separado pendiente localizar |
| `grafana` | 3000 | compose separado pendiente localizar |
| `prometheus` | 9090 | compose separado pendiente localizar |
| `thdora` | 8000 | `~/Projects/thdora/` |
| `thdora-bot` | — | `~/Projects/thdora/` |
| `spiderfoot` | 5001 | `~/spiderfoot/` |

---

## Problema de seguridad detectado

Todos los servicios escuchan en `0.0.0.0` — accesibles desde cualquier dispositivo en la LAN.

**Servicios críticos sin autenticación:**
- `ollama :11434` — API IA sin auth 🔴
- `qdrant :6333` — BD vectorial sin auth 🔴
- `prometheus :9090` — métricas raw sin auth 🔴

**Plan de hardening:**
1. Cambiar puertos a `127.0.0.1:XXXX:XXXX` en los compose
2. O configurar Traefik como reverse proxy con auth
3. UFW: permitir solo desde tailscale0 e interfaz local

---

## Próximos pasos

- [ ] Localizar compose de: code-server, n8n, gitea, uptime-kuma, portainer, grafana, prometheus
- [ ] Migrar todos a `docker/madre/` en el repo
- [ ] Aplicar hardening de puertos (`127.0.0.1` binding)
- [ ] Crear `docker-compose.madre-completo.yml` con los 14 servicios
- [ ] Etiquetar cada servicio con `# VALIDADO: YYYY-MM-DD`
