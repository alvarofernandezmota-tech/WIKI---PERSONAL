# Tailscale — Red P2P privada

> Última actualización: 13 junio 2026

---

## Nodos activos

| Máquina | Usuario | IP Tailscale | Rol |
|---|---|---|---|
| Madre | `varopc` | `100.91.112.32` | Servidor |
| Acer | `varo` | `100.86.119.102` | Cliente |

---

## Estado

```bash
tailscale status        # ver todos los nodos
tailscale ping 100.91.112.32   # verificar conexión a Madre
```

---

## Comandos esenciales

```bash
# Activar
sudo systemctl enable --now tailscaled
tailscale up

# Ver IPs
tailscale ip

# Ver estado de red
tailscale status

# Desconectar (sin desinstalar)
tailscale down
```

---

## Flujo de trabajo diario: Acer → Madre

```bash
# 1. Verificar que Madre está online
tailscale ping 100.91.112.32

# 2. Conectar por SSH
ssh varopc@100.91.112.32
# o con atajo (si tienes ~/.ssh/config configurado):
ssh madre

# 3. Ejecutar comandos remotos sin entrar
ssh varopc@100.91.112.32 'uptime && df -h'

# 4. Copiar archivos Acer → Madre
scp archivo.txt varopc@100.91.112.32:~/

# 5. Copiar archivos Madre → Acer
scp varopc@100.91.112.32:~/archivo.txt ~/
```

---

## Atajo SSH recomendado

Añadir en Acer `~/.ssh/config`:

```
Host madre
    HostName 100.91.112.32
    User varopc
    IdentityFile ~/.ssh/id_ed25519
```

Despues: `ssh madre` en lugar del comando largo.

---

## Concepto clave

```
tailscale ping OK  ≠  ssh funciona

Tailscale = red (capa 3) — garantiza que los paquetes llegan
SSH = servicio (capa 7) — necesita sshd activo en destino
```

---

## Instalación (Arch Linux)

```bash
sudo pacman -S tailscale
sudo systemctl enable --now tailscaled
tailscale up
# Abre el enlace en el navegador para autenticar
```

---

_Ver: [ssh.md](ssh.md) · [rescate.md](rescate.md) · [arquitectura.md](arquitectura.md)_
