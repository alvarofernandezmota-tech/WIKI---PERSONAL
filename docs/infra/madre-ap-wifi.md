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

## Estado

⚠️ Driver RTL8188FTV inestable — puede necesitar reinicio ocasional.
Estable durante sesiones largas (27-jun: sin caídas en sesión completa).

## Comandos útiles

```bash
# Ver estado del AP
systemctl status hostapd

# Ver clientes conectados
cat /var/lib/misc/dnsmasq.leases

# Reiniciar el AP si cae
systemctl restart hostapd
systemctl restart dnsmasq

# Ver interfaz wlan0
ip addr show wlan0
```

## Pendiente
- [ ] Fix driver RTL8188FTV para mayor estabilidad
- [ ] Evaluar reemplazar con adaptador WiFi más estable

## Ver también
- [[docs/infra/procedimientos/madre-arranque]]
- [[ESTADO-SISTEMA]]

---
_Creado desde inbox 2026-06-27 — Perplexity vía MCP_
