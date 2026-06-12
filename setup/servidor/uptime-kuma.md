# Uptime Kuma — Monitor de servicios

> Última actualización: 13 junio 2026
> Host: Madre (Docker)

---

## Estado

| Item | Estado |
|---|---|
| Uptime Kuma en Madre | ⏳ Pendiente (incluido en bootstrap) |
| Alertas a THDORA/Telegram | ⏳ Pendiente configurar |

---

## Docker Compose

```yaml
services:
  uptime-kuma:
    image: louislam/uptime-kuma:latest
    container_name: uptime-kuma
    ports:
      - "3001:3001"
    volumes:
      - ./data:/app/data
    restart: unless-stopped
```

```bash
docker compose up -d
```

**Dashboard:** http://100.91.112.32:3001 (desde Acer por Tailscale)

---

## Servicios a monitorizar

| Servicio | Tipo check | URL/Puerto |
|---|---|---|
| sshd | TCP | `100.91.112.32:22` |
| wayvnc | TCP | `100.91.112.32:5900` |
| Ollama | HTTP | `http://100.91.112.32:11434` |
| Open WebUI | HTTP | `http://100.91.112.32:3000` |
| PostgreSQL | TCP | `100.91.112.32:5432` |
| Pi-hole | HTTP | `http://100.91.112.32:80` |

---

## Alerta a Telegram (THDORA)

En Uptime Kuma → Settings → Notifications → Telegram:
- Bot Token: el de THDORA
- Chat ID: tu chat personal

---

_Ver también: [ollama.md](ollama.md) · [plan-maestro.md](plan-maestro.md)_
_Volver al índice: [README.md](README.md)_
