---
tags: [tipo/sesion, estado/activo, infra/arch, infra/wifi]
fecha: 2026-06-27
hora: 01:00-03:56
---

# 🛜 Sesión: MadreAP WiFi — RESUELTO completo — 2026-06-27

> Sesión nocturna. AP MadreAP completamente funcional y persistente tras reboot.
> Segunda parte: seguridad del Acer (rastreo antirrobo).

---

## Arquitectura de red final

```
Internet
  └── iPhone (hotspot) ──── enp0s20f0u3 (USB ethernet) ──── madre
                                                               └── wlan0 (AP: MadreAP 192.168.72.1/24)
                                                                     └── clientes WiFi (192.168.72.x)
```

- SSH a madre: siempre por **Tailscale** (`100.91.112.32`)
- Acer (theodora): conecta a MadreAP → recibe `192.168.72.26`

---

## Estado final ✅

| Componente | Estado |
|---|---|
| `hostapd` | ✅ AP-ENABLED, arranca solo tras reboot |
| `systemd-networkd` | ✅ DHCP activo, `192.168.72.1` |
| NAT / IPMasquerade | ✅ clientes tienen internet |
| UFW | ✅ reglas permanentes para `wlan0` |
| Acer conectado | ✅ `192.168.72.26`, ping OK |

---

## Problemas resueltos

### 1. `iwd` conflicto con hostapd
- `iwd` tomaba el hardware WiFi → hostapd no podía crear `wlan0`
- Fix: `sudo systemctl disable iwd --now`

### 2. `wlan0` desaparecía sin `iwd`
- `iwd` era quien creaba la interfaz al arrancar
- Fix temporal: `iw phy phy0 interface add wlan0 type __ap`
- Fix definitivo: hostapd crea la interfaz solo → servicio `create-wlan0.service` eliminado

### 3. UFW bloqueaba DHCP ← causa raíz principal
- `ss -ulnp | grep :67` confirmó que DHCP escuchaba
- `nft list ruleset` reveló que UFW hacía DROP en puerto 67
- Fix permanente:
```bash
sudo ufw allow in on wlan0 to any port 67 proto udp
sudo ufw route allow in on wlan0
sudo ufw route allow out on wlan0
sudo ufw reload
```

### 4. `iwd` en el Acer no disparaba DHCP
- `iwctl` mostraba `State: connected` pero sin IP
- Se resolvió al arreglar UFW en madre — el problema era del servidor, no del cliente

---

## Configuración final

### `/etc/systemd/network/10-wlan0-ap.network` (madre)
```ini
[Match]
Name=wlan0

[Network]
Address=192.168.72.1/24
DHCPServer=yes
IPv4Forwarding=yes
IPMasquerade=ipv4

[DHCPServer]
PoolOffset=10
PoolSize=50
DNS=1.1.1.1
EmitDNS=yes
EmitRouter=yes
```

### `/etc/hostapd/hostapd.conf` (madre)
```
interface=wlan0
driver=nl80211
ssid=MadreAP
hw_mode=g
channel=6
wpa=2
wpa_passphrase=MadreClaveFuerte123
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP
```

---

## Sesión secundaria — Seguridad Acer (theodora)

### Rastreo antirrobo
- **Prey Project** → recomendado para Linux/Android/Windows
  - `sudo apt install prey` + cuenta en preyproject.com
  - Funciones: localización, foto webcam, captura pantalla, IP
  - ⚠️ No sobrevive a formateo completo del disco
- **Computrace/Absolute** → vive en BIOS, sobrevive reinstalaciones
  - Verificar: `sudo dmidecode -t bios | grep -i computrace`
- **Cifrado LUKS** → protege datos aunque reinstalen el SO
- **FRP (Android)** → bloquea móvil si formatean, pero se salta con ROM custom si bootloader desbloqueado

### Dispositivos robados en España
- No hay base de datos pública de portátiles robados
- Consulta: **091** o comisaría Policía Nacional con número de serie
- Fabricante (Acer soporte) también puede verificar
- Número de serie Acer: `sudo dmidecode -t system | grep Serial` → **pendiente documentar**

---

## Próximos pasos

- [ ] Optimizar velocidad AP: HT40 en hostapd (`ht_capab=[HT40+]`)
- [ ] Instalar Prey en el Acer
- [ ] Verificar Computrace en BIOS del Acer
- [ ] Extraer y documentar número de serie del Acer
- [ ] Interceptación de tráfico: mitmproxy / tcpdump en `wlan0`
- [ ] DNS personalizado para clientes del AP

---
_Sesión: 2026-06-27 01:00-03:56 CEST — Perplexity vía MCP_
_Ver: [[ESTADO-SISTEMA]] · [[inbox/2026-06-27-madre-ap-wifi-debug]]_
