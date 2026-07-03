# Sesión debug: MadreAP WiFi — 2026-06-27

**Estado:** ✅ RESUELTO — AP funciona completo, persistente tras reboot  
**Máquina:** `madre` (varpc, Arch Linux)  
**Adaptador WiFi:** RTL8188FTV (rtl8xxxu) — USB, 2.4GHz only  
**Objetivo:** madre emite AP `MadreAP`, da internet por NAT a clientes WiFi

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
`iwd` no hace falta en madre — madre es AP, no cliente WiFi.

### 2. `wlan0` desaparecía tras deshabilitar `iwd`
**Síntoma:** `Device "wlan0" does not exist` — `iwd` era quien creaba la interfaz  
**Solución:** Crear la interfaz manualmente y luego dejar que hostapd la gestione:
```bash
sudo iw phy phy0 interface add wlan0 type __ap
sudo ip link set wlan0 up
sudo systemctl restart systemd-networkd
sudo systemctl start hostapd
```
Tras verificar que hostapd crea `wlan0` solo, el servicio `create-wlan0.service` fue eliminado — no necesario.

### 3. UFW bloqueaba DHCP
**Síntoma:** El Acer se asociaba a MadreAP (`State: connected`, `ConnectedBss: 04:0c:73:16:05:46`) pero no recibía IP — `Offered DHCP leases: none` en madre  
**Diagnóstico:** `ss -ulnp | grep :67` confirmó que el servidor DHCP escuchaba, pero UFW tenía:
```
udp dport 67 counter packets 53 bytes 17139 jump ufw-skip-to-policy-input → DROP
```
**Solución:**
```bash
sudo iptables -I INPUT -i wlan0 -p udp --dport 67 -j ACCEPT
sudo iptables -I FORWARD -i wlan0 -j ACCEPT
sudo iptables -I FORWARD -o wlan0 -j ACCEPT

# Permanente con UFW
sudo ufw allow in on wlan0 to any port 67 proto udp
sudo ufw route allow in on wlan0
sudo ufw route allow out on wlan0
sudo ufw reload
```

### 4. `iwd` en el Acer no disparaba DHCP
**Síntoma:** `iwctl station wlan0 show` mostraba `State: connected / Connected network: MadreAP` pero sin IP (`No IP addresses — Is DHCP client configured?`)  
**Causa:** `iwd` en el Acer gestionaba la conexión WiFi pero no cedía el control DHCP a `systemd-networkd`  
**Solución final:** El problema se resolvió al arreglar el UFW en madre — una vez que madre respondía DHCP, el Acer recibía IP correctamente.

---

## Ficheros de configuración finales

### `/etc/systemd/network/10-wlan0-ap.network` (en madre)
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

### `/etc/hostapd/hostapd.conf` (en madre)
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

### UFW rules añadidas (permanentes)
```bash
ufw allow in on wlan0 to any port 67 proto udp
ufw route allow in on wlan0
ufw route allow out on wlan0
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

### Rastreo y protección antirrobo
- **Prey Project** — herramienta recomendada para rastreo en Linux/Windows/Android
  - Instalar: `sudo apt install prey` o desde preyproject.com
  - Funciones: localización, foto webcam, captura pantalla, IP pública
  - Limitación: no sobrevive a formateo completo del disco
- **Computrace/Absolute** — si está en BIOS sobrevive a reinstalaciones
  - Verificar: `sudo dmidecode -t bios | grep -i computrace`
- **Cifrado LUKS** — protege datos aunque reinstalen el SO
- **Contraseña BIOS + Secure Boot** — impide boot desde USB

### Sobre dispositivos robados
- No existe base de datos pública de portátiles robados en España
- Consulta policial: **091** o comisaría con el número de serie (`sudo dmidecode -t system | grep Serial`)
- Fabricante (Acer soporte) también puede verificar si fue reportado

### Número de serie del Acer
- Pendiente de extraer: `sudo dmidecode -t system | grep Serial`
- No encontrado en el repo yggdrasil-dew

---

## Próximos pasos

- [ ] Optimizar velocidad AP: activar HT40 en hostapd (`ht_capab=[HT40+]`)
- [ ] Instalar Prey en el Acer para rastreo antirrobo
- [ ] Verificar Computrace en BIOS del Acer
- [ ] Extraer y documentar número de serie del Acer
- [ ] Interceptación de tráfico: mitmproxy / tcpdump en wlan0
- [ ] DNS personalizado para clientes del AP
