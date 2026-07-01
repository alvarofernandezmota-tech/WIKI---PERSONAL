# Estado del Sistema — Yggdrasil Dew

> Última actualización: 2026-07-01 06:00 CEST

---

## Nodos activos

| Nodo | Rol | Estado | IP Tailscale | Conectividad |
|------|-----|--------|--------------|--------------|
| **madre** | Servidor principal / AP | ✅ ON | 100.x.x.x | LAN + MadreAP + Tailscale |
| **theodora** | Workstation dev | ✅ ON | 100.x.x.x | Hotspot Redmi A5 |
| **Redmi A5** | Hotspot 4G | ✅ ON | — | DIGI ES LTE CA |
| **iPhone** | Cliente móvil | ✅ ON | 100.x.x.x | MadreAP + Tailscale |

---

## Servicios en madre

### Corriendo ✅
- **Ollama** — systemd service activo
  - `llama3.2:3b` ✅
  - `mistral:7b` ✅
  - `nomic-embed-text` ✅
- **hostapd** — MadreAP en wlan0 (192.168.72.0/24) ✅
- **dnsmasq** — DHCP para MadreAP ✅
- **Tailscale** — nodo activo ✅
- **SSH** — hardened (ed25519 only, no password) ✅

### Descargando 🔄 (overnight 2026-07-01)
- `kasmweb/kali-rolling-desktop:1.16.0` — 2.58GB, tmux `descargas`
- `wazuh/wazuh-dashboard:4.7.0` — en cola
- `jasonish/suricata:latest` — en cola

### Imágenes Docker disponibles ✅
- `pihole/pihole:latest` (150MB)
- `searxng/searxng:latest` (376MB)
- `wazuh/wazuh-manager:4.7.0` (1.2GB)

### Pendiente de levantar (mañana)
- Pihole + SearXNG
- Wazuh Manager + Dashboard
- Kali KasmWeb
- Suricata IDS

---

## Seguridad

### Hardening completado ✅
- SSH: solo ed25519, passphrase, sin root login, sin password auth
- `sleep.target suspend.target hibernate.target` — maskeados
- Firewall: pendiente de revisar reglas

### Hallazgos pendientes 🔴
- **Puerto 21 FTP abierto en router** — ver `infra/hallazgos/2026-07-01-ftp-puerto21.md`

---

## Fases del plan

| Fase | Descripción | Estado |
|------|-------------|--------|
| 1 | SSH Hardening madre | ✅ Completada |
| 2 | Ollama + modelos | ✅ Completada |
| 3 | Pentest inicial red local | ✅ Completada |
| 4 | MadreAP WiFi | ✅ Completada |
| 5 | Docker OSINT Stack | 🔄 Descargando |
| 6 | Wazuh + Suricata IDS | ⏳ Pendiente |
| 7 | Pihole + SearXNG | ⏳ Pendiente |
| 8 | Kali KasmWeb | ⏳ Pendiente |

---

## Tmux sessions en madre

```
fase5: 1 windows
kali:  1 windows (attached)
wazuh: 1 windows
descargas: 1 windows (overnight)
```

---

## Red

- **LAN:** 192.168.1.0/24 (router doméstico)
- **MadreAP:** 192.168.72.0/24 (hostapd en madre)
- **Tailscale:** 100.x.x.x (red privada)
- **Hotspot Redmi:** 4G DIGI ES, LTE Carrier Aggregation, canal 2850
