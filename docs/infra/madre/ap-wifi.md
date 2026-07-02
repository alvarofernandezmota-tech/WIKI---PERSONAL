# MadreAP WiFi — Debug y configuración final
#infra #red #wifi #hostapd #madre

**Fecha:** 2026-06-27
**Estado:** ✅ RESUELTO — AP funciona completo, persistente tras reboot
**Máquina:** `madre` (varpc, Arch Linux)
**Adaptador WiFi:** RTL8188FTV (rtl8xxxu) — USB, 2.4GHz only

---

## Arquitectura de red final

```
Internet
  └── iPhone (hotspot) ──── enp0s20f0u3 (USB ethernet) ──── madre
                                                               └── wlan0 (AP: MadreAP 192.168.72.1/24)
                                                                     └── clientes WiFi (192.168.72.x)
```

- SSH a madre: siempre por **Tailscale** (`100.91.112.32`) → no se corta aunque cambie el WiFi
- El Acer (theodora) usa iPhone hotspot para hablar con Perplexity mientras se debuggea el AP

---

## Estado final ✅

- `hostapd` arranca automáticamente y emite `MadreAP` tras cada reboot
- Clientes reciben IP `192.168.72.x` vía DHCP de `systemd-networkd`
- NAT funciona — clientes tienen internet a través de madre
- UFW configurado con reglas permanentes para `wlan0`
- Acer (theodora) conecta a MadreAP y recibe `192.168.72.26`
- Ping a `192.168.72.1` y a `1.1.1.1` OK desde el Acer

---

## Problemas encontrados y soluciones

### 1. `iwd` conflicto con hostapd en madre
**Síntoma:** `No default interface for wiphy 0` — `iwd` tomaba el hardware WiFi e impedía que hostapd creara `wlan0`
**Solución:**
```bash
sudo systemctl stop iwd
sudo systemctl disable iwd
```

### 2. `wlan0` desaparecía tras deshabilitar `iwd`
**Síntoma:** `Device "wlan0" does not exist`
**Solución:** Crear la interfaz manualmente:
```bash
sudo iw phy phy0 interface add wlan0 type __ap
sudo ip link set wlan0 up
sudo systemctl restart systemd-networkd
sudo systemctl start hostapd
```

### 3. UFW bloqueaba DHCP
**Síntoma:** Acer se asociaba pero no recibía IP
**Diagnóstico:** `ss -ulnp | grep :67` confirmó DHCP escuchando pero UFW lo descartaba
**Solución:**
```bash
sudo ufw allow in on wlan0 to any port 67 proto udp
sudo ufw route allow in on wlan0
sudo ufw route allow out on wlan0
sudo ufw reload
```

---

## Ficheros de configuración finales

### `/etc/systemd/network/10-wlan0-ap.network`
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

### `/etc/hostapd/hostapd.conf`
```
interface=wlan0
driver=nl80211
ssid=MadreAP
hw_mode=g
channel=6
wpa=2
wpa_passphrase=<CLAVE_FUERTE>
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP
```

---

## Verificación post-reboot

```
hostapd:           AP-ENABLED ✅
systemd-networkd:  wlan0 routable, 192.168.72.1 ✅
DHCP leases:       192.168.72.26 (Acer/theodora) ✅
UFW:               Firewall reloaded, reglas activas ✅
```

---

## Sesión secundaria — Seguridad del Acer (theodora)

- **Prey Project** — rastreo antirrobo Linux: `sudo apt install prey` o preyproject.com
- **Computrace/Absolute** — verificar si está en BIOS: `sudo dmidecode -t bios | grep -i computrace`
- **LUKS** — cifrado disco completo
- **Número de serie Acer** — pendiente: `sudo dmidecode -t system | grep Serial`

---

## Próximos pasos

- [ ] Optimizar velocidad AP: activar HT40 en hostapd (`ht_capab=[HT40+]`)
- [ ] Instalar Prey en el Acer
- [ ] Extraer y documentar número de serie del Acer
- [ ] DNS personalizado para clientes del AP
- [ ] Interceptación tráfico: mitmproxy / tcpdump en wlan0
