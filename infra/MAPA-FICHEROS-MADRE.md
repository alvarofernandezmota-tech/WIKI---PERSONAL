# 🗺️ MAPA DE FICHEROS — MADRE

> Rutas absolutas de todo lo relevante en Madre (Acer, 100.91.112.32)  
> **Última verificación**: 2026-07-03 (confirmado con `find` en Madre)  
> TTL: 14 días — actualizar con el diagnóstico al inicio de cada sprint

---

## Usuarios y home

```
/home/varopc/                            ← home principal de Madre
  yggdrasil-dew/                         ← repo ecosistema (git) ✅
  Projects/
    thdora/                              ← bot principal (git) ✅
      docker-compose.yml                 ← compose PRINCIPAL de thdora ✅
      docker/
        docker-compose.yml               ← compose alternativo/modular
  spiderfoot/
    docker-compose.yml                   ← compose de SpiderFoot ✅
  docker/
    batcueva-nueva/
      docker-compose.yml                 ← compose batcueva ✅
  Obsidian/
    cerebro/
      tecnico/setup/servidor/
        docker-compose.yml               ← compose setup servidor
  .ssh/
    id_ed25519_github                    ← clave SSH para GitHub
```

---

## Docker — compose files confirmados en Madre

```bash
# Confirmado con: find / -name 'docker-compose.yml' -not -path '*/proc/*' 2>/dev/null

/home/varopc/Projects/thdora/docker-compose.yml         ← PRINCIPAL
/home/varopc/Projects/thdora/docker/docker-compose.yml  ← modular
/home/varopc/spiderfoot/docker-compose.yml
/home/varopc/docker/batcueva-nueva/docker-compose.yml
/home/varopc/Obsidian/cerebro/tecnico/setup/servidor/docker-compose.yml
```

---

## local_tripwire — estado actual

```
Estado:  crash-loop (reiniciando en bucle)
Mensaje: [*] Baseline loaded — 87918 files. [*] Local Tripwire starting...
Causa:   Loop infinito, nunca termina de arrancar
Fix:     Pendiente Sprint 7 — ver issue #12 (thdora)
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

## Puertos expuestos (verificar con docker ps)

| Servicio | Puerto | Contenedor | Estado |
|---|---|---|---|
| thdora API | 8000 | thdora | ❓ Verificar |
| code-server | 8080 | code-server | ❓ Verificar |
| n8n | 5678 | n8n | ❓ Verificar |
| spiderfoot | 5001 | spiderfoot | ❓ Verificar |
| portainer | 9000 | portainer | ❓ Verificar |
| grafana | 3030 | grafana | ❓ Verificar |
| prometheus | 9090 | prometheus | ❓ Verificar |
| uptime-kuma | 3001 | uptime-kuma | ❓ Verificar |

```bash
# Verificar en Madre:
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
```

---

## Comando diagnóstico completo (pegar al inicio de sesión)

```bash
echo '=== REPOS ===' && ls ~/yggdrasil-dew/ | head -5 && ls ~/Projects/ && \
echo '=== DOCKER COMPOSE ===' && \
find /home -name 'docker-compose.yml' 2>/dev/null && \
echo '=== CONTAINERS ===' && \
docker ps --format 'table {{.Names}}\t{{.Status}}' 2>/dev/null && \
echo '=== CRONTAB ===' && \
crontab -l 2>/dev/null || echo 'sin crontab'
```

---

_Actualizado: 2026-07-03 (rutas confirmadas) — TTL: 14 días_
