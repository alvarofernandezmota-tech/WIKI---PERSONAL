---
tags: [tipo/debug, estado/resuelto, madre, wifi, ap, red]
fecha: 2026-06-27
validado: true
---

# 📡 MadreAP WiFi — Debug completo

> Estado: ✅ RESUELTO — AP funcionando estable
> Fuente: `inbox/2026-06-27-madre-ap-wifi-debug.md`

## Configuración final

| Parámetro | Valor |
|---|---|
| Interfaz | `wlan0` (RTL8188FTV USB dongle) |
| SSID | `MadreAP` |
| IP gateway | `192.168.72.1/24` |
| DHCP rango | `192.168.72.100 - 200` |
| Driver | `rtl8188fu` (DKMS compilado) |
| Modo | hostapd + dnsmasq |

## Problemas encontrados y resueltos

1. **Driver no cargaba al boot** — Fix: `echo 'rtl8188fu' >> /etc/modules`
2. **IP no se asignaba** — Fix: orden correcto en `network-up.sh` (ip link up antes de hostapd)
3. **Clientes se conectaban pero sin internet** — Fix: `ip_forward=1` + iptables MASQUERADE desde `wlan0` hacia `enp0s20f0u3`

## Script de inicio (resumen)

```bash
# /home/varo/scripts/network-up.sh
ip link set wlan0 up
hostapd -B /etc/hostapd/hostapd.conf
dnsmasq --conf-file=/etc/dnsmasq.conf
iptables -t nat -A POSTROUTING -o enp0s20f0u3 -j MASQUERADE
echo 1 > /proc/sys/net/ipv4/ip_forward
```

## Estado actual

- ✅ Redmi A5 conectado a MadreAP como hotspot 4G → internet llega a madre
- ✅ Tailscale opera sobre esta conexión
- ⚠️ Verificar que network-up.sh arranca al boot (systemd service)
