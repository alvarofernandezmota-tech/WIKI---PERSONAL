---
tipo: doc
author: Perplexity-MCP <alvarofernandezmota@gmail.com>
creado: 2026-07-03 01:10 CEST
actualizado: 2026-07-03 01:10 CEST
ruta: docs/operativa/iphone-terminal.md
tags: [iphone, ssh, tailscale, operativa, setup]
status: vigente
---

# Guía: SSH desde iPhone a Madre

> Objetivo: operar Madre desde iPhone sin necesitar el Acer.
> Requiere Tailscale activo en ambos.

---

## Requisitos previos

- [ ] Tailscale instalado en Madre (`tailscaled` corriendo)
- [ ] Tailscale instalado en iPhone (App Store, gratuito)
- [ ] Ambos en la misma Tailnet
- [ ] SSH en Madre escuchando en `0.0.0.0` o IP Tailscale
- [ ] Tu clave pública en `~/.ssh/authorized_keys` de Madre

---

## Paso 1: Instalar Tailscale en iPhone

1. App Store → buscar "Tailscale"
2. Iniciar sesión con tu cuenta Tailscale
3. Verificar que Madre aparece en la lista de dispositivos
4. Anotar la IP Tailscale de Madre (100.x.x.x)

---

## Paso 2: Instalar Secure ShellFish

1. App Store → buscar "SSH Files – Secure ShellFish"
2. Abrir app → "+" para nueva conexión
3. Configurar:
   ```
   Hostname: 100.x.x.x   (IP Tailscale de Madre)
   Port:     22           (o el que uses)
   Username: alvaro
   Auth:     clave privada (importar desde Files.app)
   ```

### Importar clave SSH en iPhone

Opción A (AirDrop desde Mac):
```bash
# En Mac:
airdrop ~/.ssh/id_ed25519  # a iPhone
# En iPhone: Secure ShellFish → Keys → Importar
```

Opción B (Generar nueva clave en ShellFish):
```
ShellFish → Keys → "+" → Generate Ed25519
Copiar clave pública
```
Luego en Madre añadir la clave pública:
```bash
echo "clave-publica-iphone" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

---

## Paso 3: Primera conexión

```bash
# Desde ShellFish, conectar a Madre
# Verificar que funciona:
uname -a
whoami
tailscale status
```

---

## Paso 4: Configurar tmux para sesiones persistentes

```bash
# En Madre, instalar tmux si no está:
sudo pacman -S tmux  # Arch

# Crear alias en ~/.bashrc de Madre:
alias tm='tmux new-session -A -s main'
```

Desde iPhone, conectar siempre con:
```bash
tmux new-session -A -s main
# Si el iPhone bloquea pantalla, al reconectar:
tmux attach -t main  # la sesión sigue viva
```

---

## Scripts lanzables desde iPhone

Una vez conectado a Madre via SSH + tmux, puedes lanzar:

```bash
# Health check general
~/scripts/maintenance/health-check.sh

# Estado de Docker
docker ps

# Logs de servicios
docker logs -f toki-guardian --tail=50

# Firewall status
sudo nft list ruleset | head -50
```

---

## Los 3 cambios P1 desde iPhone

### Cambio 1: Deshabilitar PasswordAuthentication en SSH

⚠️ **Tener DOS sesiones SSH abiertas antes de hacer esto.**

```bash
# Sesión 1 (tmux ventana 1) - la que editas:
sudo nano /etc/ssh/sshd_config
# Cambiar: PasswordAuthentication no
# Guardar: Ctrl+O, Enter, Ctrl+X

# Sesión 1 - recargar sin cerrar:
sudo systemctl reload sshd

# Sesión 2 (tmux ventana 2) - verificar que sigues conectado:
ssh alvaro@100.x.x.x  # nueva conexión de prueba
# Si funciona: todo OK
# Si no funciona: en sesión 1 revertir el cambio
```

### Cambio 2: Cerrar puerto 21 FTP

```bash
# Verificar si está abierto:
sudo nft list ruleset | grep 21
nmap -p 21 localhost

# Si está abierto, añadir regla drop:
sudo nft add rule inet filter input tcp dport 21 drop

# Hacer persistente (editar nftables.conf):
sudo nano /etc/nftables.conf
# Añadir antes de la regla de accept:
# tcp dport 21 drop
sudo systemctl reload nftables
```

### Cambio 3: Labels y milestones GitHub

Esto **no requiere terminal** — se hace desde Safari iPhone:
- `github.com/alvarofernandezmota-tech/yggdrasil-dew/labels`
- `github.com/alvarofernandezmota-tech/yggdrasil-dew/milestones`

O cuando tengamos REPO-GUARDIAN con GitHub Actions los creará automáticamente.

---

## Teclado en ShellFish — atajos útiles

| Gesto / Boton | Acción |
|---|---|
| Barra extra superior | ESC, Tab, Ctrl, flechas |
| Swipe izquierda | Tab (autocompletar) |
| Swipe derecha | ESC |
| `Ctrl+C` | Matar proceso |
| `Ctrl+A` | Inicio de línea |
| `Ctrl+D` | Salir de sesión |

---

_Ref: issue #23 — docs/operativa/iphone-terminal-comparativa.md_
