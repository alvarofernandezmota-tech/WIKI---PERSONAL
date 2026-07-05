---
tags: [infra, accesos, servicios, urls]
fecha-actualizacion: 2026-07-05
---

# 🔗 Accesos y servicios

Todas las URLs, puertos y accesos del ecosistema Batcueva.

## Servicios Madre (Tailscale: 100.91.112.32)

| Servicio | URL | Para qué |
|---|---|---|
| Open WebUI | `http://100.91.112.32:3001` | IA local — chat con modelos Ollama |
| Portainer | `http://100.91.112.32:9000` | Gestión Docker |
| Grafana | `http://100.91.112.32:3000` | Métricas y monitorización |
| Gitea | `http://100.91.112.32:3003` | Git local |
| SpiderFoot | `http://100.91.112.32:5001` | OSINT |
| Kali Desktop | `https://100.91.112.32:6901` | Pentest |

## Acceso SSH

```bash
ssh varopc@100.91.112.32
```

## VPN
- Proveedor: Tailscale
- IP Madre: `100.91.112.32`

## Notas
- Todos los servicios accesibles solo desde Tailscale
- Credenciales en gestor de contraseñas, NO aquí
