# Incidencia: Sin acceso remoto a Madre

> **Tipo:** Post-mortem de incidencia
> **Fecha:** 12–13 junio 2026
> **Estado:** ⚠️ Resolución pendiente — requiere acceso físico
> **Redactado por:** Álvaro + Perplexity

---

## 1. Descripción del problema

Madre (torre, `100.91.112.32`) es accesible por Tailscale (ping OK) pero no acepta
conexiones SSH ni VNC. El equipo es potencialmente gestionable de forma remota
pero los servicios necesarios no están activos ni configurados para arrancar
automáticamente.

---

## 2. Diagnóstico técnico

### Cronología de la investigación

| Hora | Prueba | Resultado | Conclusión |
|---|---|---|---|
| 22:00 | `ping 100.91.112.32` | ✅ OK | Tailscale funciona |
| 22:10 | `ssh varo@100.91.112.32` | ❌ `Connection refused` | `sshd` no escucha |
| 22:20 | `nc -zv 100.91.112.32 5900` | ❌ `Connection timed out` | `wayvnc` no corre |
| 22:40 | Input Leap (KVM) | ❌ Bloqueado por Wayland | Descartado definitivamente |
| 23:00 | Intento VNC por LAN | ❌ Sin respuesta | Confirma: servicio no activo |

### Causa raíz

```
IP alcanzable != servicio disponible
```

Tailscale garantiza conectividad de red (capa 3). No garantiza que ningún
servicio esté escuchando (capa 7). `sshd` y `wayvnc` nunca se activaron con
`systemctl enable`, por lo que no arrancan tras cada reinicio.

### Superficie de ataque entendida

```
[Acer] ── Tailscale ──► [Madre: IP accesible]
                               │
                        ❌ sin sshd
                        ❌ sin wayvnc
                        └──► sin entrada posible
```

**Lecciones aprendidas:**
1. Un servicio sin `systemctl enable` no existe tras un reinicio
2. La IP no es acceso — la puerta abierta es el servicio
3. Sin SSH de emergencia, cualquier máquina remota es un riesgo operativo
4. Seguridad máxima = mínimos servicios expuestos y controlados

---

## 3. Plan de resolución profesional

> Como lo haría un sysadmin/developer de producción.

### Fase 0 — Acceso físico (obligatorio, una sola vez)

```bash
# En Madre, teclado físico
sudo systemctl enable --now sshd
systemctl status sshd  # verificar que escucha
ss -tlnp | grep 22     # confirmar puerto abierto
```

Este es el único momento que requiere presencia física. A partir de aquí
todo es remoto.

### Fase 1 — Acceso remoto garantizado (desde Acer)

```bash
# 1. Copiar clave SSH (sin contraseña para siempre)
ssh-copy-id -i ~/.ssh/id_ed25519.pub varo@100.91.112.32

# 2. Verificar conexión
ssh varo@100.91.112.32 'echo "Madre online" && uptime'

# 3. Comprobar que sshd persiste tras reinicio
ssh varo@100.91.112.32 'sudo reboot'
# esperar 60s
ssh varo@100.91.112.32 'echo "Reinicio OK"'
```

### Fase 2 — Bootstrap completo (script automatizado)

```bash
# Ejecutar desde Acer vía SSH
ssh varo@100.91.112.32 'bash <(curl -s https://raw.githubusercontent.com/alvarofernandezmota-tech/personal-v2/main/setup/servidor/scripts/bootstrap-madre.sh)'
```

El script cubre en orden:
- UFW (solo Acer puede conectar a SSH y VNC)
- fail2ban (banea IPs tras 5 intentos fallidos)
- Docker + NVIDIA Container Toolkit
- PostgreSQL, Pi-hole, Ollama, Uptime Kuma
- lynis (auditoría inicial de seguridad)
- wayvnc autostart en hyprland.conf

### Fase 3 — Verificación post-bootstrap

```bash
# Desde Acer: checklist de verificación
ssh varo@100.91.112.32 << 'EOF'
echo "=== ESTADO MADRE ==="
echo "SSH:"        && systemctl is-active sshd
echo "UFW:"        && systemctl is-active ufw
echo "fail2ban:"   && systemctl is-active fail2ban
echo "Docker:"     && systemctl is-active docker
echo "PostgreSQL:" && systemctl is-active postgresql
echo "Puertos:"
ss -tlnp | grep -E '22|5900|5432|11434|3000|3001'
echo "Contenedores:"
docker ps --format 'table {{.Names}}\t{{.Status}}'
echo "UFW status:"
sudo ufw status verbose
EOF
```

### Fase 4 — Monitorización continua

Uptime Kuma disponible en `http://100.91.112.32:3001` monitoriza que todos
los servicios siguen vivos y alerta por Telegram (THDORA) si algo cae.

---

## 4. Reglas de oro aprendidas

> Estas reglas nacen de esta incidencia. No son teoría.

```
Regla 1: Nunca dejar una máquina remota sin sshd activo y persistente.
Regla 2: enable != start. Siempre: systemctl enable --now.
Regla 3: Verificar con ss -tlnp, no asumir que el servicio escucha.
Regla 4: La IP no es acceso. El servicio es la puerta.
Regla 5: Un sistema que no auditas es un sistema que no controlas.
```

---

## 5. Por qué esto te hace mejor developer/sysadmin

La mayoría instala `ufw` o `docker` siguiendo un tutorial sin entender por qué.
Tú ahora sabes:

| Herramienta | Por qué la instalas (de verdad) |
|---|---|
| `sshd` | Porque sin él cualquier corte físico deja el servidor inaccesible |
| `ufw` | Porque necesitas una puerta controlada, no una pared sin ventanas |
| `fail2ban` | Porque los bots atacan SSH 24/7 y necesitas un centinela |
| `Docker` | Porque separar servicios del sistema base es la diferencia entre un reinicio y una catastrofe |
| `lynis` | Porque no puedes proteger lo que no mides |
| `Uptime Kuma` | Porque enterarte de que algo cayó antes de intentar conectar te ahorra pánico |

---

## 6. Estado actual

| Item | Estado |
|---|---|
| Tailscale Madre ↔ Acer | ✅ Operativo |
| sshd en Madre | 🔴 Pendiente — acceso físico mañana |
| wayvnc autostart | ⏳ Pendiente bootstrap |
| UFW en Madre | ⏳ Pendiente bootstrap |
| fail2ban | ⏳ Pendiente bootstrap |
| Docker + servicios | ⏳ Pendiente bootstrap |
| Uptime Kuma | ⏳ Pendiente bootstrap |

---

_Ver: [rescate.md](rescate.md) · [scripts/bootstrap-madre.sh](scripts/bootstrap-madre.sh) · [arquitectura.md](arquitectura.md)_
_Volver al índice: [README.md](README.md)_
