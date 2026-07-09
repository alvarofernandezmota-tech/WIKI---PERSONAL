---
tipo: infra
author: Alvaro Fernandez Mota
creado: 2026-07-09
actualizado: 2026-07-09 15:37 CEST
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
| `~/Projects/` | Proyectos activos con Docker (excepción documentada — ver THDORA) |
| `/home/varopc/yggdrasil-secops/` | Stack de seguridad (excepción documentada — ver secops) |
| `/srv/` | Servicios del sistema (yggdrasil-dew stack) |

> ⚠️ **Regla de oro**: No asumir nunca que un repo vive en `~/repos`. Verificar SIEMPRE con:
> ```bash
> docker inspect <contenedor> --format '{{.Config.Labels}}' | tr ',' '\n' | grep -i compose
> ```

---

## Repos en ~/repos (estado 2026-07-09)

| Repo local | Repo GitHub | Notas |
|---|---|---|
| `~/repos/WIKI---PERSONAL` | alvarofernandezmota-tech/WIKI---PERSONAL | Este mismo repo |
| `~/repos/dev-labs` | alvarofernandezmota-tech/dev-labs | |
| `~/repos/formacion-tech` | alvarofernandezmota-tech/formacion-tech | |
| `~/repos/investigacion-ia` | alvarofernandezmota-tech/investigacion-ia | |
| `~/repos/madre-config` | alvarofernandezmota-tech/madre-config | Config específica de Madre |
| `~/repos/acer-config` | alvarofernandezmota-tech/acer-config | Config específica del Acer |
| `~/repos/VIDAPERSONAL` | alvarofernandezmota-tech/VIDAPERSONAL | Privado |
| `~/repos/yggdrasil-secops` ⚠️ | → symlink a `/home/varopc/yggdrasil-secops` | Symlink creado 2026-07-09 |
| `~/repos/thdora` ⚠️ | → symlink a `/home/varopc/Projects/thdora` | Symlink creado 2026-07-09 |

---

## THDORA-PERSONAL

| Campo | Valor |
|---|---|
| **GitHub** | `alvarofernandezmota-tech/thdora-personal` |
| **Ruta física en Madre** | `/home/varopc/Projects/thdora` |
| **Symlink operativo** | `~/repos/thdora` → `/home/varopc/Projects/thdora` |
| **Compose file activo** | `/home/varopc/Projects/thdora/docker-compose.yml` |
| **Compose project** | `thdora` |
| **Branch activo** | `main` (último commit: `fd5e8a2`) |
| **Verificado** | `git remote -v` confirmado el 2026-07-09 |

**Contenedores del stack:**

| Contenedor | Estado (2026-07-09) |
|---|---|
| `thdora` | Healthy |
| `thdora-bot` | Started |
| `prometheus` | Started |
| `grafana` | Started |

> ⚠️ La carpeta física **NO vive en `~/repos`**; vive en `~/Projects` y se expone por symlink.
> Excepción a la convención estándar. Motivo: proyecto preexistente antes de adoptar `~/repos` como estándar.

---

## yggdrasil-secops

| Campo | Valor |
|---|---|
| **GitHub** | `alvarofernandezmota-tech/yggdrasil-secops` |
| **Ruta física real en Madre** | `/home/varopc/yggdrasil-secops` |
| **Symlink operativo** | `~/repos/yggdrasil-secops` → `/home/varopc/yggdrasil-secops` |
| **Compose file activo** | `/home/varopc/yggdrasil-secops/docker-compose.maestro.yml` |
| **Compose file blue-team** | `/home/varopc/yggdrasil-secops/docker-compose.blue-team.yml` |
| **Compose project** | `yggdrasil-secops` |
| **Branch activo** | `main` (último commit: `c887ee4`) |
| **Archivo de entorno** | `/home/varopc/yggdrasil-secops/.env` (permisos `600`, no en repo — correcto) |
| **Verificado** | `docker inspect` + `git remote -v` confirmados el 2026-07-09 |

**Contenedores del stack (todos desde `docker-compose.maestro.yml`):**

| Contenedor | Servicio | `yggdrasil.layer` | `yggdrasil.role` |
|---|---|---|---|
| `yggdrasil_watchdog` | yggdrasil_watchdog | watchdog | watchdog |
| `tailscale_monitor` | tailscale_monitor | network-vpn | monitor |
| `log_guardian_bot` | log_guardian | firewall | monitor |
| `guardian_bot` | guardian_bot | command | control |
| `local_tripwire` | local_tripwire | filesystem | monitor |
| `network_radar` | network_radar | network-local | monitor |
| `radar_backup` | radar_backup | data | backup |

> ⚠️ La carpeta física **NO vive en `~/repos`**; vive directamente en `/home/varopc/yggdrasil-secops`.
> Excepción a la convención estándar. Motivo: proyecto preexistente antes de adoptar `~/repos` como estándar.
>
> 🔴 **Incidente 2026-07-09**: Se encontró un segundo clon huérfano en `~/repos/yggdrasil-secops` (commit `672e3e5`, sin `.env`, sin carpeta `osint`). Al eliminar el clon viejo para crear el symlink, se perdieron `docs/pentesting/` y `docs/seguridad/` que existían como untracked files nunca commiteados. Ver diario: [2026-07-09.md](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/diarios/2026-07-09.md)

---

## Otros servicios en Madre (sin repo propio)

| Contenedor | Ruta compose | Estado (2026-07-09) |
|---|---|---|
| `kali-pentest` | `/home/varopc/docker-compose.yml` ⚠️ por verificar | Up |
| `spiderfoot` | `/home/varopc/docker-compose.yml` ⚠️ por verificar | Up |
| `code-server` | `/home/varopc/docker-compose.yml` ⚠️ por verificar | Up |
| `n8n` | `/home/varopc/docker-compose.yml` ⚠️ por verificar | Up |
| `gitea` | `/home/varopc/docker-compose.yml` ⚠️ por verificar | Up |
| `uptime-kuma` | `/home/varopc/docker-compose.yml` ⚠️ por verificar | Up |
| `portainer` | `/home/varopc/docker-compose.yml` ⚠️ por verificar | Up |

> ⚠️ Pendiente confirmar si estos servicios tienen repo propio o si viven todos en `/home/varopc/docker-compose.yml` raíz. Ver tarea 9 del dashboard.

---

## Regla operativa — antes de cualquier rm -rf sobre un repo

```bash
git status          # revisar untracked files y cambios pendientes
git stash list      # revisar stashes no pusheados
# Solo si ambos están limpios → proceder con rm
```

**Lección aprendida 2026-07-09:** El `git status` de `~/repos/yggdrasil-secops` mostró `Untracked files: docs/pentesting/ docs/seguridad/` y se procedió al `rm -rf` sin evaluarlos. Esos directorios se perdieron de forma irrecuperable.

---

## Cómo actualizar este documento

```bash
docker inspect <contenedor> --format '{{.Config.Labels}}' | tr ',' '\n' | grep -i compose
find ~/repos -maxdepth 1 -type d
find ~/Projects -maxdepth 1 -type d
find / -maxdepth 6 -iname "docker-compose*.yml" 2>/dev/null
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"
```

_Última actualización: 2026-07-09 15:37 CEST · Perplexity MCP_
