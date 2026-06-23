# Acer Aspire — Servidor 24/7 y Backup

> Máquina secundaria. Corre 24/7. Rol: redundancia y servicios ligeros.
> Última actualización: 23 junio 2026

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
| tmux | ⏳ Pendiente | |
| TLP | ⏳ Pendiente instalar | Ahorro batería |

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

### Estado rápido de la batería

```bash
# Estado actual (nivel, carga, estado)
cat /sys/class/power_supply/BAT0/capacity       # % batería
cat /sys/class/power_supply/BAT0/status         # Charging / Discharging / Full
cat /sys/class/power_supply/BAT0/energy_now     # energía actual (µWh)
cat /sys/class/power_supply/BAT0/energy_full    # capacidad máxima (µWh)
cat /sys/class/power_supply/BAT0/power_now      # consumo instantáneo (µW)

# Resumen bonito
upower -i /org/freedesktop/UPower/devices/battery_BAT0
# Si no está: sudo pacman -S upower
```

### Consumo en tiempo real

```bash
# Ver consumo actual en vatios
cat /sys/class/power_supply/BAT0/power_now | awk '{printf "%.2f W\n", $1/1000000}'

# powertop — análisis detallado de consumo por proceso
sudo powertop
# Si no está: sudo pacman -S powertop

# powertop modo auto-tune (aplica optimizaciones de consumo)
sudo powertop --auto-tune

# Ver consumo resumido sin modo interactivo
sudo powertop --time=5 --csv=/tmp/powertop.csv
```

### TLP — gestor de energía (recomendado para Ryzen)

```bash
# Instalar TLP
sudo pacman -S tlp tlp-rdw

# Activar e iniciar
sudo systemctl enable tlp
sudo systemctl start tlp

# Estado de TLP
sudo tlp-stat -s          # estado general
sudo tlp-stat -b          # solo batería
sudo tlp-stat -p          # perfiles CPU actuales
sudo tlp-stat             # todo completo

# Modo manual
sudo tlp bat              # forzar modo batería
sudo tlp ac               # forzar modo corriente
```

### Límite de carga de batería (salud a largo plazo)

```bash
# Ver límites actuales de carga
cat /sys/class/power_supply/BAT0/charge_control_start_threshold
cat /sys/class/power_supply/BAT0/charge_control_end_threshold

# Configurar en /etc/tlp.conf:
# START_CHARGE_THRESH_BAT0=75
# STOP_CHARGE_THRESH_BAT0=80
# (carga entre 75-80% — ideal para batería siempre enchufada)

sudo nano /etc/tlp.conf
sudo systemctl restart tlp
```

### Reducir consumo CPU (AMD Ryzen 5500U)

```bash
# Ver governor CPU actual
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Cambiar a powersave
sudo cpupower frequency-set -g powersave
# Si no está: sudo pacman -S cpupower

# Ver frecuencias actuales
sudo cpupower frequency-info

# Governors disponibles en Ryzen:
# powersave   → mínimo consumo (recomendado batería)
# schedutil   → balance automático (recomendado siempre conectado)
# performance → máximo rendimiento (mayor consumo)

# Hacer permanente con systemd
sudo systemctl enable cpupower
# Configurar en /etc/default/cpupower:
# governor='powersave'
```

### Script rápido — resumen batería

```bash
#!/bin/bash
# bat-status.sh — resumen de batería en una línea
BAT=/sys/class/power_supply/BAT0
echo "🔋 Batería: $(cat $BAT/capacity)%  |  Estado: $(cat $BAT/status)  |  Consumo: $(awk '{printf "%.1f W", $1/1000000}' $BAT/power_now)"
```

```bash
# Uso rápido desde terminal
bash -c 'B=/sys/class/power_supply/BAT0; echo "🔋 $(cat $B/capacity)% | $(cat $B/status) | $(awk "{printf \"%.1f W\", \$1/1000000}" $B/power_now)"'
```

### Alias útiles (añadir a ~/.zshrc)

```bash
alias bat='cat /sys/class/power_supply/BAT0/capacity && cat /sys/class/power_supply/BAT0/status'
alias batw='cat /sys/class/power_supply/BAT0/power_now | awk "{printf \"%.2f W consumo\n\", \$1/1000000}"'
alias batsave='sudo cpupower frequency-set -g powersave && sudo tlp bat'
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

# DNS — ver configuración
cat /etc/resolv.conf

# Reiniciar red (NetworkManager)
sudo systemctl restart NetworkManager

# Estado NetworkManager
nmcli device status
nmcli connection show
```

---

## 🦷 Bluetooth — comandos

```bash
# Estado del servicio
sudo systemctl status bluetooth

# Activar bluetooth
sudo systemctl start bluetooth
sudo systemctl enable bluetooth

# Entrar al gestor interactivo
bluetoothctl

# Dentro de bluetoothctl:
power on              # encender
scan on               # buscar dispositivos
devices               # ver los encontrados
pair XX:XX:XX:XX      # emparejar por MAC
connect XX:XX:XX:XX   # conectar
trust XX:XX:XX:XX     # confiar (auto-conecta al arrancar)
disconnect XX:XX:XX   # desconectar
remove XX:XX:XX:XX    # olvidar dispositivo
quit                  # salir
```

---

## 📊 Monitorización — comandos

```bash
# CPU, RAM, procesos en tiempo real
htop

# Uso de disco
df -h

# Uso de RAM
free -h

# Temperatura CPU (AMD)
sensors
# Si no está: sudo pacman -S lm_sensors && sudo sensors-detect

# Carga del sistema (últimos 1, 5, 15 min)
uptime

# Procesos más pesados
ps aux --sort=-%cpu | head -10
ps aux --sort=-%mem | head -10

# Red — tráfico en tiempo real
nload wlan0
# Si no está: sudo pacman -S nload

# Conexiones activas
ss -tuln

# Ver logs del sistema
journalctl -f                        # en tiempo real
journalctl -u sshd -f                # solo SSH
journalctl --since "1 hour ago"      # última hora

# Espacio por carpeta
du -sh ~/*
du -sh /var/log/*
```

---

## 🔒 Seguridad — comandos

```bash
# Estado UFW
sudo ufw status verbose

# Estado fail2ban
sudo fail2ban-client status
sudo fail2ban-client status sshd

# IPs baneadas por fail2ban
sudo fail2ban-client status sshd | grep "Banned IP"

# Ver intentos de login fallidos
sudo journalctl -u sshd | grep "Failed"

# Tailscale estado
tailscale status
tailscale ping 100.91.112.32    # ping a Madre
```

---

## ⚙️ Sistema — comandos útiles

```bash
# Información hardware completa
inxi -F

# Versión OS y kernel
uname -a
cat /etc/os-release

# Servicios activos
systemctl list-units --type=service --state=running

# Reiniciar servicio
sudo systemctl restart <servicio>

# Ver puertos abiertos
sudo ss -tlnp

# Actualizar sistema
sudo pacman -Syu

# Limpiar caché pacman
sudo pacman -Sc

# Ver uso de swap
swapon --show
```

---

## Pendiente

- [ ] tmux instalado y configurado
- [ ] Alias `acer` en `~/.zshrc` de Madre
- [ ] TLP instalado y configurado con límite de carga 75-80%
- [ ] Aliases de batería añadidos a `~/.zshrc`
- [ ] PostgreSQL (base de datos centralizada)
- [ ] Pi-hole
- [ ] Headscale (Tailscale self-hosted)
- [ ] Script monitorización automática (cron + log)
- [ ] Obsidian vault sincronizado por git

---

_Ver también: [[setup/madre]] · [[setup/red]] · [[setup/tailscale]] · [[HOME]]_
