# Diario — 2026-06-27

> Entrada: Sábado, 27 de junio de 2026 (madrugada)

---

## 🧠 Estado del día

| Área | Valor (1-10) | Notas |
|------|-------------|-------|
| Energía | — | Sesión nocturna |
| Foco | 7 | Sesión técnica con Perplexity vía SSH a Madre |
| Ánimo | — | |

---

## ✅ Qué pasó

Sesión técnica completa de diagnóstico de red en **Madre** con objetivo de convertirla en punto de acceso WiFi (AP) propio, eliminando la dependencia del hotspot del móvil.

### Diagnóstico de red completado

- Confirmado que Madre usa **`systemd-networkd`** como gestor de red (sin NetworkManager).
- **`wpa_supplicant`** no está instalado ni activo.
- **`nmcli`** no está disponible (`command not found`).

### Interfaces identificadas

| Interfaz | Tipo | Estado | IP | Rol actual |
|----------|------|--------|----|------------|
| `enp4s0` | Ethernet integrada | DOWN (sin cable) | — | Sin uso |
| `enp0s20f0u3` | Ethernet USB | UP | `10.87.248.110/24` | **WAN — salida a internet** |
| `wlan0` | WiFi USB (YICHIP 3151:3020) | UP | `172.20.10.4/28` | Cliente WiFi (hotspot móvil) |
| `tailscale0` | VPN | UP | `100.91.112.32/32` | VPN Tailscale |
| `docker0`, `br-*` | Bridges Docker | UP | `172.17-20.x.x` | Red interna Docker |

**Tarjeta WiFi**: USB YICHIP (ID `3151:3020`) — no aparece en `lspci`, solo en `lsusb`.

### Gestor de red

```
systemd-networkd.service — Active: active (running)
  Ultima actividad relevante:
    enp0s20f0u3: DHCPv4 address 10.87.248.110/24
    wlan0: Connected WiFi access [...]
    wlan0: DHCPv4 address 172.20.10.4/28
```

### Herramientas instaladas durante la sesión

- `hostapd` 2.11-4 — instalado con `pacman -S hostapd`.
- `nano` 9.0-1 — instalado con `pacman -S nano` (no había ningún editor en consola).

### Configuración de hostapd creada

Archivo: `/etc/hostapd/hostapd.conf`  
Creado con `tee` (sin abrir editor).

```ini
# Configuración de hostapd para Madre como punto de acceso WiFi
interface=wlan0
driver=nl80211
ssid=MadreAP
hw_mode=g
channel=6
wmm_enabled=0
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=MadreClaveFuerte123
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP
```

> ⚠️ **SSID y contraseña son placeholders**. Cambiar antes de activar.

---

## 💡 Descubrimientos y Novedades

- Madre usa `systemd-networkd` puro, sin NetworkManager — esto significa que el AP no se puede crear con `nmcli hotspot`, hay que usar `hostapd` + configuración manual de `.network`.
- La tarjeta WiFi USB YICHIP `3151:3020` está funcionando como cliente. Pendiente verificar si soporta modo AP (`iw list` con capacidad `AP`).
- Docker ya ocupa rangos `172.17-20.x.x` — el AP debe usar un rango distinto (elegido `192.168.72.0/24`).
- Sin editor de texto en Madre en consola: ni `nano`, ni `vim`, ni `vi`. Solución: instalar `nano` o usar `tee + heredoc`.

---

## 🤖 IAs usadas hoy

| IA | Tarea | Output | Estado |
|----|-------|--------|--------|
| Perplexity | Diagnóstico red Madre + guía hostapd | Comandos completos, diagnóstico detallado, creación hostapd.conf | ✅ Completado |

---

## 🖥️ Servidor

### Objetivo de la sesión

Convertir `wlan0` de Madre en un **Access Point WiFi propio**, compartiendo internet desde `enp0s20f0u3` (Ethernet USB con DHCP desde router).

### Arquitectura objetivo

```
ISP/Router → enp0s20f0u3 (WAN, DHCP: 10.87.248.110)
                 ↓ NAT + IP Forwarding
             Madre (192.168.72.1)
                 ↓ AP WiFi
             wlan0 → SSID: MadreAP
                 ↓ DHCP 192.168.72.11-60
             Clientes WiFi (móvil, portátil...)
```

### Piezas necesarias (stack técnico)

| Pieza | Herramienta | Estado |
|-------|-------------|--------|
| Emitir señal WiFi AP | `hostapd` | ✅ Instalado, config creada |
| IP fija en wlan0 + DHCP server + NAT | `systemd-networkd` `.network` file | ⏳ Pendiente |
| Activar hostapd como servicio | `systemctl enable/start hostapd` | ⏳ Pendiente |
| Verificar soporte AP en la tarjeta WiFi | `iw list \| grep -A 10 'Supported interface modes'` | ⏳ Pendiente |
| Desactivar conflicto wlan0 cliente actual | Modificar o reemplazar `.network` existente de wlan0 | ⏳ Pendiente |

### Archivos clave a crear/modificar

1. `/etc/hostapd/hostapd.conf` — ✅ Creado (revisar SSID/pass).
2. `/etc/systemd/network/25-wlan0-ap.network` — ⏳ Pendiente.

Contenido objetivo de `25-wlan0-ap.network`:

```ini
[Match]
Name=wlan0

[Network]
Address=192.168.72.1/24
DHCPServer=yes
IPForward=ipv4
IPMasquerade=ipv4

[DHCPServer]
PoolOffset=10
PoolSize=50
DNS=1.1.1.1
```

3. **Verificar** qué `.network` actual existe para `wlan0` en `/etc/systemd/network/` — ⏳ Pendiente.

---

## 📚 Formación

- **`systemd-networkd` como DHCP server + NAT**: usando directivas `DHCPServer=yes`, `IPForward=ipv4`, `IPMasquerade=ipv4` en el archivo `.network` — sin necesidad de `dnsmasq` ni `iptables` manuales.
- **`tee + heredoc`** para crear/sobrescribir archivos de sistema sin editor: `sudo tee /ruta/archivo > /dev/null << 'EOF'`.
- **`hostapd`** como demonio de punto de acceso WiFi en Linux: gestiona autenticación WPA2, difusión de SSID y asociación de clientes.
- **Diferencia `lspci` vs `lsusb`**: tarjetas WiFi integradas en placa aparecen en `lspci`; tarjetas USB solo en `lsusb`.

---

## 🔀 Decisiones tomadas

- **Usar `systemd-networkd` nativo para DHCP/NAT** en lugar de instalar `dnsmasq` — Madre ya usa `systemd-networkd` y tiene soporte nativo para DHCP server desde v243.
- **Rango IP del AP: `192.168.72.0/24`** — evita conflictos con Docker (`172.17-20.x.x`), Tailscale (`100.x`) y el hotspot móvil (`172.20.10.x`).
- **No activar todavía** `hostapd` ni modificar `.network` de `wlan0` — primero revisar la config existente (`ls /etc/systemd/network/`) para no perder la conexión SSH.

---

## ⏭️ Pendiente para mañana

- [ ] Verificar soporte modo AP en tarjeta YICHIP: `iw list | grep -A 10 'Supported interface modes'` (responsable: yo)
- [ ] Listar config actual de systemd-networkd: `ls /etc/systemd/network/ && cat /etc/systemd/network/*.network` (responsable: yo)
- [ ] Crear `/etc/systemd/network/25-wlan0-ap.network` con `tee` (responsable: yo + Perplexity)
- [ ] Activar y probar hostapd: `sudo systemctl enable hostapd && sudo systemctl start hostapd` (responsable: yo)
- [ ] Cambiar SSID y contraseña en `/etc/hostapd/hostapd.conf` (responsable: yo)
- [ ] Cuando AP funcione → documentar en `infra/madre-ap-wifi.md` (responsable: Perplexity)

---

_Próximo paso más importante: **verificar si la tarjeta YICHIP soporta modo AP** antes de tocar nada más._
