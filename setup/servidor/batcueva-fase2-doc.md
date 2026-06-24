---
tags: [setup, fase2, portainer, uptime-kuma, spiderfoot, heimdall, monitoring]
fecha: 2026-06-24
estado: listo-para-ejecutar
---

# Batcueva Fase 2 — Monitoring + OSINT + Dashboard

> Requiere Fase 1 activa (Ollama + WebUI + Qdrant).

---

## Servicios

| Servicio | Puerto | Para qué |
|---|---|---|
| Portainer | :9000 | UI visual para gestionar todos los contenedores Docker |
| Uptime Kuma | :3001 | Monitor de servicios — alerta si cae algo |
| SpiderFoot | :5001 | OSINT automático — recon de dominios, IPs, emails |
| Heimdall | :8090 | Dashboard central con accesos rápidos a todo |

---

## Ejecutar

```bash
# 1. Descargar imágenes (si no se hizo con pre-descarga-todo.sh)
bash setup/servidor/scripts/descarga-fase2.sh

# 2. Levantar y configurar todo
bash setup/servidor/scripts/configurar-fase2.sh

# 3. Verificar
docker compose -f setup/servidor/batcueva-fase2.yml ps
```

---

## Uptime Kuma — configurar monitores

Abrir http://IP:3001 → Add Monitor para cada servicio:

```
Ollama API   → http://localhost:11434
Open WebUI   → http://localhost:3000
Qdrant       → http://localhost:6333
Portainer    → http://localhost:9000
SpiderFoot   → http://localhost:5001
```

Alertas → Telegram → poner token y chat_id de thdora.

---

## SpiderFoot — primer scan

```bash
# Abrir http://IP:5001
# New Scan → target: tu dominio o IP pública
# Modules: todos activados
# Resultados en la UI
```

---

## Heimdall — configurar dashboard

Abrir http://IP:8090 → Add Application para cada servicio del stack.
Queda como panel de control central de la Batcueva.

---

## Verificación final

```bash
docker compose -f setup/servidor/batcueva-fase2.yml ps
sudo ufw status | grep -E '9000|3001|5001|8090'
curl -s http://localhost:3001 | head -5
```

---
_Ver: [[batcueva-fase1]] · [[batcueva-fase3-doc]] · [[plan-maestro]]_
