---
tags: [infra, wifi, hostapd, dnsmasq, madre]
fecha-creacion: 2026-06-27
ultima-actualizacion: 2026-07-02
---

# 📶 MadreAP — WiFi en madre (RTL8188FTV)

## Hardware

| Parámetro | Valor |
|---|---|
| Adaptador | RTL8188FTV (USB) |
| Interfaz | `wlan0` |
| Driver | `rtl8188fu` ⚠️ inestable |
| SSID | `MadreAP` |
| Seguridad | WPA2-PSK / CCMP |
| Canal | 6 (2.4GHz) |
| Gateway | `192.168.72.1` |
| DHCP pool | `192.168.72.50 – 192.168.72.150` |

## Servicios

- **hostapd** — crea el AP
- **dnsmasq** — DHCP + DNS para clientes WiFi

## Comandos útiles

```bash
systemctl status hostapd
cat /var/lib/misc/dnsmasq.leases
systemctl restart hostapd && systemctl restart dnsmasq
ip addr show wlan0
```

## Pendiente
- [ ] Fix driver RTL8188FTV para mayor estabilidad
- [ ] Evaluar reemplazar con adaptador WiFi más estable

---
_Creado desde inbox 2026-06-27 — Perplexity vía MCP_
