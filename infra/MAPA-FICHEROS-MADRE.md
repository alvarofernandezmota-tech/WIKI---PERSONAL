# 🗺️ MAPA DE FICHEROS — MADRE

> Rutas absolutas de todo lo relevante en Madre (Acer, 100.91.112.32)
> Actualizar cuando se muevan ficheros o se creen nuevos proyectos.
> Esta es la fuente de verdad de la estructura de Madre.

---

## Usuarios y home

```
/home/varopc/                    ← home principal
  yggdrasil-dew/                 ← repo ecosistema (git)
  Projects/
    thdora/                      ← bot principal (git)
    investigador-maestro/        ← PENDIENTE crear
  .ssh/
    id_ed25519_github            ← clave SSH para GitHub
    id_ed25519_github.pub
```

---

## Docker — rutas de datos persistentes

```
/home/varopc/Projects/thdora/
  docker-compose.yml             ← compose principal de thdora
  .env                           ← variables de entorno (NO en git)

# Buscar docker-compose raíz:
# find /home/varopc -name 'docker-compose.yml' 2>/dev/null
# find / -name 'docker-compose.yml' -not -path '*/proc/*' 2>/dev/null
```

### Volúmenes Docker conocidos
```
docker volume ls                 ← listar todos
docker volume inspect <nombre>   ← ver ruta real en Madre
```

---

## Scripts activos en Madre

```
~/yggdrasil-dew/scripts/
  maintenance/
    new-session.sh               ← inicio de sesión
    close-session.sh             ← cierre de sesión
    fix-unhealthy.sh             ← arregla containers unhealthy
    notify-on-change.py          ← watchdog inteligente
  thdora/
    bot-session-report.sh        ← reporte de sesión al bot
```

---

## Crontabs activos

```bash
# Ver crontabs en Madre:
crontab -l
sudo crontab -l
ls /etc/cron.d/
ls /etc/cron.daily/
```

---

## Servicios systemd relevantes

```bash
# Ver servicios activos:
systemctl list-units --type=service --state=running

# Docker arranca automáticamente:
systemctl is-enabled docker
```

---

## Red

```
IP local Madre:    100.91.112.32 (Tailscale)
Red Docker:        172.x.x.x (bridge interno)

# Ver IPs:
ip addr show
docker network ls
docker network inspect bridge
```

---

## Puertos expuestos (contenedores)

| Servicio | Puerto | Contenedor |
|---|---|---|
| thdora API | 8000 | thdora |
| code-server | 8080 | code-server |
| n8n | 5678 | n8n |
| gitea | 3000 | gitea |
| uptime-kuma | 3001 | uptime-kuma |
| portainer | 9000 | portainer |
| grafana | 3030 | grafana |
| prometheus | 9090 | prometheus |
| spiderfoot | 5001 | spiderfoot |
| investigador | 8091 | investigador-maestro |
| palma-pentest | 8092 | palma-pentester |

> ⚠️ Verificar con: `docker ps --format 'table {{.Names}}\t{{.Ports}}'`

---

## Comando de diagnóstico completo

```bash
# Pegar en Madre para obtener estado completo del sistema:
echo '=== RUTAS REPOS ===' && \
ls ~/yggdrasil-dew/ && \
ls ~/Projects/ && \
echo '=== DOCKER COMPOSE FILES ===' && \
find /home -name 'docker-compose.yml' 2>/dev/null && \
echo '=== CRONTAB ===' && \
crontab -l 2>/dev/null || echo 'sin crontab' && \
echo '=== PUERTOS DOCKER ===' && \
docker ps --format 'table {{.Names}}\t{{.Ports}}' 2>/dev/null
```

_Actualizado: 2026-07-03 — verificar con el comando de diagnóstico al inicio de cada sprint_
