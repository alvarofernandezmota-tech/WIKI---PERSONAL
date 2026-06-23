---
tags: [batcueva, osint, stack, planificacion, servidor, docker, instalacion]
fecha: 2026-06-23
estado: TODO
prioridad: alta
---

# 🦇 Batcueva — Stack Definitivo (todo open source, coste 0€)

> Documentado el 23/06/2026. Todo revisado para eliminar herramientas de pago.
> Decisión clave: **el dashboard es la capa central** que embebe todo.

---

## Stack OSINT / Mundo físico — 5 herramientas

| # | Herramienta | Capa | Qué hace | Coste | Estado |
|---|---|---|---|---|---|
| 1 | **SpiderFoot** | OSINT digital | IPs, dominios, emails, personas, redes sociales | Gratis OS | ⏳ A medias |
| 2 | **Shadowbroker** | Mundo físico | Aviones militares+civiles, 25k barcos AIS, GPS jamming | Gratis OS | ❌ Por instalar |
| 3 | **OSIRIS** | Mundo global | Globo 3D: satélites, cámaras CCTV, seísmos, nuclear | Gratis OS | ❌ Por instalar |
| 4 | **Kismet** | Red local | WiFi, Bluetooth, dispositivos físicos alrededor | Gratis OS | ❌ Por instalar |
| 5 | **Censys / ZoomEye** | Internet expuesto | Cámaras y servidores expuestos en internet | Web gratis | ✅ Sin instalar |

> **Maltego fuera** — SpiderFoot ya cubre el 90%+ y es 100% open source.
> **Shodan** — web gratuita suficiente para uso casual, sin instalar.

---

## Stack ingeniero / Infraestructura — ya instalado ✅

| Herramienta | Puerto | Estado |
|---|---|---|
| Tailscale | — | ✅ Operativo (IP: 100.91.112.32) |
| Docker | — | ✅ Operativo |
| Ollama | 11434 | ✅ Operativo |
| Prometheus | 9090 | ✅ Operativo |
| Grafana | 3000 | ✅ Operativo |
| thdora API + bot | 8000 | ✅ Operativo |
| PostgreSQL | 5432 | ✅ Operativo |
| Netdata multi-nodo | — | ✅ Madre + Acer |

---

## Stack ingeniero / Por instalar — orden de prioridad

```
FASE 1 — Esta semana (impacto inmediato)
├── Open WebUI      → UI web para Ollama (:3001)
├── Uptime Kuma     → vigilar que todo vive (:3002)
├── SpiderFoot      → OSINT (estaba a medias) (:5001)
├── Portainer       → UI Docker (:9000)
└── UFW + fail2ban  → seguridad Madre

FASE 2 — Próxima semana
├── Shadowbroker    → aviones + barcos + GPS jamming
├── OSIRIS          → globo 3D satélites + cámaras
├── Kismet          → red local WiFi/Bluetooth
├── Pi-hole         → DNS + bloqueo anuncios
└── tmux            → sesiones persistentes

FASE 3 — Cuando todo lo anterior funcione
├── n8n             → automatización (reemplaza Zapier, gratis OS)
├── Homepage/Homarr → dashboard central que une TODO
├── Headscale       → reemplaza Tailscale cloud (self-hosted)
├── Gitea           → GitHub propio
└── Code Server     → VSCode en el browser
```

---

## El flujo real de la batcueva

```
VES avión sospechoso en Shadowbroker
    ↓
Buscas matrícula/dueño en SpiderFoot
    ↓
Localizas IP del aeropuerto en Censys (web)
    ↓
OSIRIS te da satélites + cámaras CCTV del área
    ↓
Kismet detecta dispositivos WiFi cerca de ti
```

---

## Decisiones tomadas hoy

- **Maltego eliminado** → sustituido por SpiderFoot (más potente y 100% OS)
- **Zapier eliminado** → sustituido por n8n (open source, self-hosted, gratis)
- **Shodan** → usar web gratuita, sin instalar
- **El dashboard Heimdall** no es un proyecto secundario — es la UI central que embebe todo
- **Headscale** como alternativa futura a Tailscale cloud (ya estaba en repo como pendiente)

---

## Comandos de instalación rápida (Fase 1)

```bash
# Open WebUI
docker run -d -p 3001:8080 \
  -e OLLAMA_BASE_URL=http://localhost:11434 \
  --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  --name open-webui --restart always \
  ghcr.io/open-webui/open-webui:main

# Uptime Kuma
docker run -d --restart=always \
  -p 3002:3001 \
  -v uptime-kuma:/app/data \
  --name uptime-kuma louislam/uptime-kuma:1

# Portainer
docker run -d -p 9000:9000 \
  --name=portainer --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest

# SpiderFoot (si no está clonado)
git clone https://github.com/smicallef/spiderfoot.git ~/spiderfoot
cd ~/spiderfoot
pip3 install -r requirements.txt
python3 sf.py -l 0.0.0.0:5001
```

---

_Creado por Perplexity (Claude Sonnet 4.6) vía MCP GitHub · 23 jun 2026_
