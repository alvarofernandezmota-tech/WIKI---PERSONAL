# Acer Aspire — Servidor 24/7 y Backup

> Máquina secundaria. Corre 24/7. Rol: redundancia y servicios ligeros.
> Última actualización: 24 junio 2026

---

## Hardware

| Componente | Detalle |
|---|---|
| Modelo | Acer Aspire |
| CPU | AMD Ryzen 5 5500U |
| RAM | 8 GB |
| OS | Arch Linux (sin escritorio) |
| Hostname | `acer` / `theodora` |
| IP LAN | `10.176.119.171` |
| IP Tailscale | `100.86.119.102` |

---

## Rol en el ecosistema

- **Backup y redundancia** — si Madre peta, Acer sigue vivo
- **Servidor 24/7** — siempre encendido, siempre accesible
- **Sin GPU** — no sirve para inferencia local pesada
- **Acceso desde Madre:** `ssh acer` (clave Ed25519, sin contraseña)

> **Principio:** Madre produce. Acer resiste.

---

## Software instalado

| Software | Estado | Notas |
|---|---|---|
| Arch Linux | ✅ | Sin escritorio |
| zsh | ✅ | Shell principal |
| Starship | ✅ | Prompt `theodora` |
| Tailscale | ✅ | IP `100.86.119.102` |
| fail2ban | ✅ | jail sshd activo |
| SSH server (sshd) | ✅ | Accesible desde Madre |
| UFW | ✅ | Activo |
| TLP | ✅ **Activo** | Aplicado 24 jun — modo BAT + powersave |
| tmux | ⏳ Pendiente | |

---

## Acceso

```bash
# Desde Madre
ssh acer

# Por Tailscale desde cualquier red
ssh varopc@100.86.119.102
```

---

## 🔋 Batería y consumo — comandos

> **Estado actual (24 jun 2026):** TLP activo en modo `balanced/BAT` + CPU governor `powersave` aplicados.
> El Acer está enchufado 24/7 → `/sys/class/power_supply/BAT0/power_now` no existe (normal en AC).

### Activar ahorro máximo (ONE-LINER)

```bash
sudo tlp bat && sudo cpupower frequency-set -g powersave
# Alias: batsave
```

### Estado rápido de la batería

```bash
cat /sys/class/power_supply/BAT0/capacity       # % batería
cat /sys/class/power_supply/BAT0/status         # Charging / Discharging / Full
cat /sys/class/power_supply/BAT0/power_now      # consumo instantáneo (µW) — solo si en batería

# Resumen bonito
upower -i /org/freedesktop/UPower/devices/battery_BAT0

# Ver qué interfaces de energía hay
ls /sys/class/power_supply/
```

### TLP — gestor de energía ✅ Instalado

```bash
# Estado
sudo tlp-stat -s          # estado general
sudo tlp-stat -b          # solo batería
sudo tlp-stat -p          # perfiles CPU actuales

# Modo manual
sudo tlp bat              # forzar modo batería (mínimo consumo)
sudo tlp ac               # forzar modo corriente
```

### TLP — configuración avanzada Ryzen

```bash
sudo nano /etc/tlp.conf
```
Añadir/descomentar para consumo mínimo:
```ini
START_CHARGE_THRESH_BAT0=75
STOP_CHARGE_THRESH_BAT0=80
CPU_SCALING_GOVERNOR_ON_BAT=powersave
CPU_ENERGY_PERF_POLICY_ON_BAT=power
PLATFORM_PROFILE_ON_BAT=low-power
RUNTIME_PM_ON_BAT=auto
```
```bash
sudo systemctl restart tlp
```

### CPU Governor — powersave ✅ Aplicado

```bash
# Ver governor actual
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
# Debe decir: powersave

# Cambiar a powersave
sudo cpupower frequency-set -g powersave

# Hacer permanente — en /etc/default/cpupower:
# governor='powersave'
sudo systemctl enable cpupower
```

### Servicios — qué deshabilitar sin romper nada

> WiFi (`iwd`), SSH, Tailscale, fail2ban y netdata deben quedar **siempre activos**.

```bash
# SDDM — display manager gráfico innecesario en servidor headless → DESHABILITAR
sudo systemctl disable --now sddm.service

# rtkit — solo necesario para audio en tiempo real
sudo systemctl disable --now rtkit-daemon.service

# smartd — monitorización SMART, opcional
sudo systemctl disable --now smartd.service

# bluetooth — si no se usa
sudo systemctl disable --now bluetooth.service
```

| Servicio | Acción | Por qué |
|---|---|---|
| `iwd` | ✅ Mantener | WiFi |
| `tailscaled` | ✅ Mantener | Acceso remoto |
| `sshd` | ✅ Mantener | SSH |
| `fail2ban` | ✅ Mantener | Seguridad |
| `netdata` | ✅ Mantener | Monitorización |
| `tlp` | ✅ Mantener | Ahorro energía |
| `sddm` | ❌ Deshabilitar | Gráfico innecesario |
| `rtkit-daemon` | ❌ Deshabilitar | Solo para audio |
| `smartd` | ❌ Deshabilitar | Opcional |
| `bluetooth` | ❌ Deshabilitar | No se usa |

### Alias útiles (añadir a ~/.zshrc)

```bash
alias bat='cat /sys/class/power_supply/BAT0/capacity && cat /sys/class/power_supply/BAT0/status'
alias batw='cat /sys/class/power_supply/BAT0/power_now | awk "{printf \"%.2f W consumo\n\", \$1/1000000}"'
alias batsave='sudo tlp bat && sudo cpupower frequency-set -g powersave'
alias batmax='sudo cpupower frequency-set -g schedutil && sudo tlp ac'
```

---

## 📡 WiFi — comandos

```bash
# Ver interfaces de red
ip link show

# Ver WiFi conectado y señal
iwctl station wlan0 show

# Listar redes disponibles
iwctl station wlan0 scan
iwctl station wlan0 get-networks

# Conectar a red
iwctl station wlan0 connect "NOMBRE_RED"

# Ver IP asignada
ip addr show wlan0

# Ver gateway y rutas
ip route

# Test de conectividad
ping -c 3 8.8.8.8

# DNS
cat /etc/resolv.conf

# Estado NetworkManager
nmcli device status
nmcli connection show
```

---

## 🦷 Bluetooth — comandos

```bash
sudo systemctl status bluetooth
bluetoothctl
# power on / scan on / pair XX:XX / connect XX:XX / trust XX:XX / quit
```

---

## 📊 Monitorización — comandos

```bash
htop
df -h
free -h
sensors                          # temperatura CPU AMD
uptime                           # carga 1/5/15 min
ps aux --sort=-%cpu | head -10
ps aux --sort=-%mem | head -10
ss -tuln                         # conexiones activas
journalctl -f                    # logs en tiempo real
journalctl -u sshd -f
journalctl --since "1 hour ago"
```

---

## 🔒 Seguridad — comandos

```bash
sudo ufw status verbose
sudo fail2ban-client status
sudo fail2ban-client status sshd
sudo journalctl -u sshd | grep "Failed"
tailscale status
tailscale ping 100.91.112.32    # ping a Madre
```

---

## ⚙️ Sistema — comandos útiles

```bash
inxi -F
uname -a
systemctl list-units --type=service --state=running
sudo pacman -Syu
sudo pacman -Sc
swapon --show
```

---

## Pendiente

- [ ] `sudo systemctl disable --now sddm rtkit-daemon smartd bluetooth` — deshabilitar servicios innecesarios
- [ ] TLP config avanzada en `/etc/tlp.conf` — límite carga 75-80% + CPU power policy
- [ ] Aliases de batería añadidos a `~/.zshrc`
- [ ] tmux instalado y configurado
- [ ] Alias `acer` en `~/.zshrc` de Madre
- [ ] PostgreSQL (base de datos centralizada)
- [ ] Pi-hole
- [ ] Headscale (Tailscale self-hosted)
- [ ] Script monitorización automática (cron + log)

---

_Ver también: [[setup/madre]] · [[setup/red]] · [[setup/tailscale]] · [[HOME]]_
