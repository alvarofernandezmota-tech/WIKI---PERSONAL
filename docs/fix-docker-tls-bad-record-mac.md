---
tags: [docker, fix, tls, ollama, open-webui, madre, servidor]
fecha: 2026-06-23
estado: referencia
ruta-obsidian: docs/fix-docker-tls-bad-record-mac.md
---

# Fix — Docker `tls: bad record MAC`

## Síntoma

```
docker: failed to copy: local error: tls: bad record MAC
```

Aparece al hacer `docker run` descargando imágenes grandes (>500MB).
La descarga se corta a mitad con error TLS.

## Causa

Error de red durante la descarga de capas grandes.
Docker usa TLS para descargar capas del registry — si la conexión
se interrumpe o hay corrupción de paquetes, falla el MAC (Message Authentication Code).

Ocurrió el 23/06/2026 descargando:
- `ollama/ollama:latest` (3.2GB) — falló 2 veces
- `ghcr.io/open-webui/open-webui:main` (1.1GB) — falló 1 vez
Contexto: wifi de parque con señal inestable.

## Solución correcta

### Opción A — Pull separado antes del run
```bash
docker pull ollama/ollama:latest
# Repetir si se corta — Docker reanuda por capas
```

### Opción B — Limpiar y reintentar (recomendada si falla varias veces)
```bash
docker rm -f ollama open-webui 2>/dev/null
docker rmi ollama/ollama:latest ghcr.io/open-webui/open-webui:main 2>/dev/null
docker system prune -f
# Luego usar docker compose pull (más robusto que docker run)
```

### Opción C — Docker Compose (más robusto para descargas grandes)
```bash
# docker compose pull reanuda automáticamente
docker compose pull
docker compose up -d
```

## Comandos de limpieza usados el 23/06

```bash
docker rm -f ollama open-webui
docker rmi ollama/ollama:latest ghcr.io/open-webui/open-webui:main
docker system prune -f
```

## Contenedores que SÍ estaban corriendo durante el incidente

```
uptime-kuma   :3002  ✅
portainer     :9000  ✅
thdora-bot          ✅
thdora API    :8000  ✅
grafana       :3000  ✅
prometheus    :9090  ✅
```

## Pendiente después del fix

- [ ] `docker compose pull` con Ollama + Open WebUI + SpiderFoot
- [ ] `docker compose up -d`
- [ ] Verificar con `docker ps`
- [ ] `ollama pull llama3:latest && ollama pull nomic-embed-text:latest`

## Ver también

- [[setup/servidor/batcueva-fase2.yml]]
- [[setup/servidor/batcueva-osint.yml]]
- [[proyectos/batcueva/]]
