# Diario — 2026-07-01 Madrugada

**Fecha:** 2026-07-01  
**Hora:** 02:00 – 06:00 CEST  
**Nodo activo:** madre (via SSH desde theodora)  
**Conectividad:** Redmi A5 hotspot 4G DIGI ES (Carrier Aggregation activo)

---

## Resumen de sesión

Sesión de madrugada centrada en completar la infraestructura de seguridad de madre. Se arrancó el stack OSINT/pentest completo y se dejó descargando overnight.

---

## Completado esta sesión

### Fase 1 — SSH Hardening ✅
- `sshd_config` endurecido: solo ed25519, sin password auth, sin root login
- Passphrase en `id_ed25519_madre` confirmada y funcionando
- Acceso desde theodora y iPhone (via Tailscale) verificado

### Fase 2 — Ollama Modelos ✅
- `llama3.2:3b` descargado y operativo
- `nomic-embed-text` descargado y operativo
- `mistral:7b` completado
- Ollama corriendo como servicio systemd en madre

### Fase 3 — Pentest Inicial ✅
- Escaneo nmap red local 192.168.1.0/24 completado
- **HALLAZGO CRÍTICO:** Puerto 21 FTP abierto en router — documentado en `infra/hallazgos/`
- Nikto scan completado
- hydra test SSH (propio) — bloqueado correctamente ✅

### Fase 4 — MadreAP WiFi ✅
- hostapd configurado y operativo en wlan0
- dnsmasq dando IPs en 192.168.72.0/24
- iPhone conectado a MadreAP verificado
- Suspensión del sistema maskeada: `sleep.target suspend.target hibernate.target`

### Fase 5 — Docker Stack OSINT (EN PROGRESO 🔄)
- `pihole/pihole:latest` — descargado ✅ (150MB)
- `searxng/searxng:latest` — descargado ✅ (376MB)
- `wazuh/wazuh-manager:4.7.0` — descargado ✅ (1.2GB)
- `kasmweb/kali-rolling-desktop:1.16.0` — **descargando overnight** (2.58GB)
- `wazuh/wazuh-dashboard:4.7.0` — en cola
- `jasonish/suricata:latest` — en cola

---

## Decisiones técnicas

- Redmi A5 NO soporta 5G (gama baja) — máximo LTE CA ya activo
- DIGI ES operador activo (no Movistar — Movistar aparece como roaming)
- tmux sesión `descargas` corriendo en background overnight
- `systemctl mask sleep.target` para evitar suspensión durante descarga

---

## Próximo arranque (al despertar)

```bash
ssh madre
tmux attach -t descargas
# Verificar que todo descargó
docker images | grep -E "kasm|wazuh|suricata"
# Levantar stack completo
docker compose -f ~/yggdrasil-dew/osint-stack/docker-compose.yml up -d
```

---

## Estado hardware

| Nodo | Estado | Nota |
|------|--------|------|
| madre (Acer) | ✅ ON | SSH activo, docker descargando |
| theodora | ✅ ON | SSH client |
| Redmi A5 | ✅ Hotspot | Enchufado al cargador, 91% batería |
| iPhone | ✅ ON | En Tailscale + MadreAP |

---

*Sesión cerrada: 2026-07-01 ~06:00 CEST — sistema dejado descargando overnight*
