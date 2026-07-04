# 🖥 Madre — Servidor Principal

> Madre es el corazón del ecosistema Yggdrasil. Todo corre aquí.

---

## Hardware

| Campo | Valor |
|---|---|
| Nombre | Madre |
| Tipo | Servidor físico / mini PC |
| IP local | _pendiente documentar_ |
| IP Tailscale | 100.91.112.32 |
| SO | _pendiente documentar_ |
| RAM | _pendiente documentar_ |
| Almacenamiento | _pendiente documentar_ |

---

## Acceso SSH

```bash
# Conectar por Tailscale (desde cualquier red)
ssh alvaro@100.91.112.32

# Conectar por red local
ssh alvaro@<IP-LOCAL>

# Ver IP local de Madre (ejecutar EN Madre)
ip addr show | grep 'inet '

# Guardar en tu ~/.ssh/config (en el Acer):
# Host madre
#   HostName 100.91.112.32
#   User alvaro
#   IdentityFile ~/.ssh/id_ed25519
```

---

## Servicios activos

| Servicio | Puerto | URL local | Estado |
|---|---|---|---|
| _pendiente_ | — | — | — |

→ Ver detalle en [`servicios.md`](./servicios.md)

---

## Comandos de mantenimiento

```bash
# Ver uso de disco
df -h

# Ver memoria RAM
free -h

# Ver contenedores Docker activos
docker ps

# Ver logs de un servicio
docker logs <nombre-contenedor> --tail 50 -f

# Temperatura CPU (si está instalado lm-sensors)
sensors
```

---

## Notas

_Documenta aquí cualquier incidencia, cambio de hardware o configuración especial._
