---
tags: [operaciones, arranque, runbook]
fecha-actualizacion: 2026-07-05
---

# ▶️ Arranque del ecosistema

Cómo arrancar el ecosistema Batcueva desde cero.

## Verificar que Madre está online

```bash
ping 100.91.112.32
ssh varopc@100.91.112.32
```

## Verificar contenedores Docker

```bash
docker ps
docker ps -a  # ver también los parados
```

## Arrancar contenedores parados

```bash
docker start $(docker ps -aq)
# o por compose:
cd ~/docker && docker compose up -d
```

## Verificar servicios

```bash
curl -s http://localhost:3001  # Open WebUI
curl -s http://localhost:9000  # Portainer
curl -s http://localhost:3000  # Grafana
```

## Si algo no arranca
→ Ver [`incidencias.md`](incidencias.md)
