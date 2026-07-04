# Arch Linux — Optimización Completa para IA y Servidor
**Fecha:** 2026-06-24  
**Fuente:** Investigación real — ArchWiki, localaimaster, inksnip, dev.to  
**Aplicable a:** varopc (i5-8400, 16GB DDR4, SSD SATA)

---

## 1. CPU — Governor Performance

```bash
# Instalar y activar cpupower
sudo pacman -S cpupower
sudo systemctl enable --now cpupower.service

# Setear governor performance permanente
sudo sed -i "s/^#governor=.*/governor='performance'/" /etc/default/cpupower

# O via tmpfiles (más limpio en Arch)
sudo nano /usr/lib/tmpfiles.d/cpu-governor.conf
# Pegar:
w /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor - - - - performance
w /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference - - - - performance
```

**i5-8400 tiene 6 cores físicos** — por defecto solo usa 1-2 en modo powersave.

---

## 2. Kernel — sysctl Optimizado para IA

```bash
sudo nano /etc/sysctl.d/99-optimizacion-ia.conf
```

```ini
# RAM — evitar swap agresivo
vm.swappiness = 10
vm.vfs_cache_pressure = 50

# Huge Pages para LLMs (5-10% speedup en inferencia)
vm.nr_hugepages = 512

# Mapas de memoria — crítico para modelos Ollama
vm.max_map_count = 16777216

# Network (para servicios Docker)
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_fastopen = 3

# Scheduler
kernel.sched_autogroup_enabled = 1
```

Aplicar sin reiniciar:
```bash
sudo sysctl --system
```

---

## 3. ZRAM — Swap en RAM Comprimida

Perfecto para 16GB cuando Ollama come mucho:

```bash
sudo pacman -S zram-generator
sudo nano /etc/systemd/zram-generator.conf
```

```ini
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
swap-priority = 100
```

```bash
sudo systemctl daemon-reload
sudo systemctl start systemd-zram-setup@zram0.service
swapon --show  # verificar
```

---

## 4. SSD SATA — I/O Scheduler Óptimo

```bash
# Para SATA SSD: scheduler BFQ
# Para NVMe: kyber o none

# Ver tipo de disco
cat /sys/block/sda/queue/rotational  # 0 = SSD

# Crear regla udev
sudo nano /etc/udev/rules.d/60-ioschedulers.rules
```

```
# NVMe
ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="kyber"
# SATA SSD
ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="bfq"
# HDD
ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
```

---

## 5. fstab — Montaje Optimizado SSD

```bash
sudo nano /etc/fstab
```

Añadir opciones al mount raíz:
```
/dev/sda1  /  ext4  rw,noatime,commit=60,errors=remount-ro  0 1
```

- `noatime` — no escribir access time en cada lectura (brutal reducción de writes)
- `commit=60` — flush a disco cada 60s en vez de 5s

---

## 6. fstrim — Salud SSD

```bash
sudo systemctl enable --now fstrim.timer
# Ejecuta TRIM semanal automático
```

---

## 7. Kernel Zen/Liquorix — Opcional pero potente

Para cargas IA intensas, el kernel stock es conservador:

```bash
# Kernel Zen (mejor latencia, más responsive bajo carga)
yay -S linux-zen linux-zen-headers

# Actualizar grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Reiniciar y seleccionar linux-zen en GRUB
```

El kernel Zen tiene mejor scheduler y Transparent Huge Pages más agresivo.

---

## 8. Paquetes Performance Arch

```bash
yay -S ananicy-cpp irqbalance memavaild nohang preload

sudo systemctl enable --now ananicy-cpp  # prioridades auto procesos
sudo systemctl enable --now irqbalance   # balancear IRQ entre cores
sudo systemctl enable --now nohang       # evitar OOM killer salvaje
```

---

## 9. makepkg — Compilaciones Rápidas AUR

```bash
sudo nano /etc/makepkg.conf
```

```bash
MAKEFLAGS="-j$(nproc)"     # usar todos los cores al compilar AUR
BUILDDIR=/tmp/makepkg       # compilar en RAM (tmpfs)
```

---

## 10. Desactivar lo que no se usa

```bash
# Ver qué servicios arrancan
systemd-analyze blame

# Deshabilitar bluetooth si no se usa
sudo systemctl disable bluetooth.service

# Tracker GNOME (come CPU indexando)
gsettings set org.freedesktop.Tracker3.Miner.Files enable-monitors false
```

---

## Resultado esperado en varopc (i5-8400)

| Métrica | Sin optimizar | Con optimizar |
|---|---|---|  
| CPU governor | powersave (1.8GHz) | performance (3.6GHz boost) |
| Ollama startup | 8-15s | 2-4s (keep_alive=-1) |
| Token/s Qwen2.5-3B | ~8 t/s | ~15-20 t/s |
| Swap usage | disco swap | ZRAM comprimido |
| SSD write pressure | alto | -60% con noatime |

---

## Checklist de aplicación

- [ ] `cpupower` governor performance
- [ ] sysctl `99-optimizacion-ia.conf`
- [ ] ZRAM configurado
- [ ] I/O scheduler udev rule
- [ ] fstab `noatime,commit=60`
- [ ] fstrim timer activo
- [ ] `ananicy-cpp` + `irqbalance` activos
- [ ] makepkg paralelo
- [ ] Servicios inútiles desactivados
