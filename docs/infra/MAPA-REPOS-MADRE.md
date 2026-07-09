---
tipo: infra
author: Alvaro Fernandez Mota
creado: 2026-07-09
actualizado: 2026-07-09
ruta: docs/infra/MAPA-REPOS-MADRE.md
tags: [infra, madre, repos, docker, mapa]
status: activo
---

# Mapa de Repos y Servicios — Madre

> Inventario físico verificado en vivo el 2026-07-09.
> Fuente de verdad para rutas, symlinks y contenedores en Madre.
> Para gobernanza y referencias cruzadas ver: [yggdrasil-dew/docs/canon/ownership-matrix.md](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/canon/ownership-matrix.md)

---

## Estructura de carpetas en Madre

| Carpeta | Uso |
|---|---|
| `~/repos/` | Repos clonados de GitHub (convención estándar) |
| `~/Projects/` | Proyectos activos con Docker (excepción documentada) |
| `/srv/` | Servicios del sistema (yggdrasil-dew stack) |

> ⚠️ **Nota crítica**: No todos los proyectos viven en `~/repos`. Verificar siempre con `docker inspect <contenedor> --format '{{.Config.Labels}}'` para localizar la ruta real del compose.

---

## Repos en ~/repos

| Repo local | Repo GitHub | Notas |
|---|---|---|
| `~/repos/WIKI---PERSONAL` | alvarofernandezmota-tech/WIKI---PERSONAL | Este mismo repo |
| `~/repos/dev-labs` | alvarofernandezmota-tech/dev-labs | |
| `~/repos/formacion-tech` | alvarofernandezmota-tech/formacion-tech | |
| `~/repos/investigacion-ia` | alvarofernandezmota-tech/investigacion-ia | |
| `~/repos/madre-config` | alvarofernandezmota-tech/madre-config | Config específica de Madre |
| `~/repos/acer-config` | alvarofernandezmota-tech/acer-config | Config específica del Acer |
| `~/repos/VIDAPERSONAL` | alvarofernandezmota-tech/VIDAPERSONAL | Privado |
| `~/repos/yggdrasil-secops` | alvarofernandezmota-tech/yggdrasil-secops | Stack de seguridad |
| `~/repos/thdora` ⚠️ | → symlink a `/home/varopc/Projects/thdora` | Symlink creado 2026-07-09 |

---

## THDORA-PERSONAL

| Campo | Valor |
|---|---|
| **GitHub** | `alvarofernandezmota-tech/thdora-personal` |
| **Ruta física en Madre** | `/home/varopc/Projects/thdora` |
| **Symlink operativo** | `~/repos/thdora` → `/home/varopc/Projects/thdora` |
| **Compose file** | `/home/varopc/Projects/thdora/docker-compose.yml` |
| **Compose project** | `thdora` |
| **Contenedores asociados** | `thdora`, `thdora-bot` |
| **Archivo de entorno** | `/home/varopc/Projects/thdora/.env` |
| **Branch activo** | `main` (último commit: `fd5e8a2`) |
| **Verificado** | `git remote -v` confirmado el 2026-07-09 |

> ⚠️ La carpeta física **NO vive en `~/repos`**; vive en `~/Projects` y se expone por symlink para unificar acceso.
> Esto es una excepción a la convención estándar. Motivo: proyecto preexistente antes de adoptar `~/repos` como estándar.

---

## yggdrasil-secops

| Campo | Valor |
|---|---|
| **GitHub** | `alvarofernandezmota-tech/yggdrasil-secops` |
| **Ruta física en Madre** | `/home/varopc/repos/yggdrasil-secops` |
| **Compose files** | `docker-compose.blue-team.yml`, `docker-compose.maestro.yml` |
| **Contenedores asociados** | `yggdrasil_watchdog`, `tailscale_monitor`, `log_guardian_bot`, `radar_backup`, `guardian_bot`, `local_tripwire`, `network_radar` |
| **Archivo de entorno** | `.env.template` (el `.env` real no está en repo — correcto) |

---

## Otros servicios en Madre (sin repo en ~/repos)

| Contenedor | Imagen | Ruta compose probable | Estado |
|---|---|---|---|
| `kali-pentest` | kasmweb/kali-rolling-desktop:1.16.0 | `/home/varopc/docker-compose.yml` | Up 7 days |
| `spiderfoot` | spiderfoot | `/home/varopc/docker-compose.yml` | Up 7 days |
| `code-server` | linuxserver/code-server | `/home/varopc/docker-compose.yml` | Up 7 days |
| `n8n` | n8nio/n8n | `/home/varopc/docker-compose.yml` | Up 7 days |
| `gitea` | gitea/gitea | `/home/varopc/docker-compose.yml` | Up 7 days |
| `uptime-kuma` | louislam/uptime-kuma | `/home/varopc/docker-compose.yml` | Up 7 days |
| `portainer` | portainer/portainer-ce | `/home/varopc/docker-compose.yml` | Up 7 days |
| `grafana` | grafana/grafana | Monitoring stack | Up 7 days |
| `prometheus` | prom/prometheus | Monitoring stack | Up 7 days |

> ⚠️ Estos servicios tienen un `/home/varopc/docker-compose.yml` raíz detectado en el inventario.
> Pendiente: verificar si todos están definidos ahí o hay composes separados.

---

## Cómo actualizar este documento

Ejecutar en Madre y pegar la salida aquí:

```bash
find ~/repos -maxdepth 1 -type d
find ~/Projects -maxdepth 1 -type d
find / -maxdepth 6 -iname "docker-compose*.yml" 2>/dev/null
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"
```

_Última actualización: 2026-07-09 · Perplexity MCP_
