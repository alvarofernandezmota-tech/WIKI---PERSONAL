---
tags: [infra, madre, procedimiento, produccion]
fecha-actualizacion: 2026-07-02
estado: parcialmente-completado
---

# 🔴 Procedimiento — Sesión en Madre

> Creado: 27-jun-2026 04:56 CEST
> Estado: Bloques 1.1, 1.3 completados. Resto pendiente.

---

## ANTES DE TOCAR NADA — Sincronizar

```bash
cd ~/yggdrasil-dew && git pull --rebase
```

---

## BLOQUE 1 — Seguridad de red (FASE 1) 🟡 PARCIAL

| Sub-tarea | Estado |
|---|---|
| 1.1 UFW completo | ✅ Completado |
| 1.2 SSH Hardening puerto 2222 | ❌ **PENDIENTE** → ver `fase1-seguridad.md` |
| 1.3 Tailscale + anti-suspensión | ✅ Completado (01-jul) |
| 1.4 Reboot y verificación | ✅ Completado |

---

## BLOQUE 2 — Dependencias SOC 🔴 PENDIENTE

```bash
# 2.1 Instalar paquetes
sudo bash scripts/infra/instalar-dependencias.sh

# 2.2 Disable offload (para Suricata)
sudo cp setup/servidor/disable-offload.service.example \
     /etc/systemd/system/disable-offload.service
# Editar: cambiar 'eno1' por interfaz real (ip link show)
sudo systemctl enable --now disable-offload.service

# 2.3 Configurar Suricata
sudo suricata-update
sudo systemctl restart suricata
tail -f /var/log/suricata/eve.json

# 2.4 Wazuh agent — leer eve.json
# Añadir a /var/ossec/etc/ossec.conf:
# <localfile><log_format>json</log_format><location>/var/log/suricata/eve.json</location></localfile>
sudo systemctl restart wazuh-agent

# 2.5 Validar IDS→SIEM
curl http://testmyids.com
grep "testmyids" /var/log/suricata/eve.json
```

---

## BLOQUE 3 — Levantar dockers 🔴 PENDIENTE

```bash
sudo bash scripts/start-batcueva.sh
```

URLs a verificar desde Acer (Tailscale `100.91.112.32`):
- Grafana: `http://100.91.112.32:3000`
- Uptime Kuma: `http://100.91.112.32:3002`
- Open WebUI: `http://100.91.112.32:8080`
- Portainer: `http://100.91.112.32:9000`
- Kali VNC: `http://192.168.66.100:6901`

---

## BLOQUE 4 — Red macvlan VLAN66 (Kali pentest) 🔴 PENDIENTE

Requisito previo: router con soporte 802.1Q (OPNsense/OpenWrt/Mikrotik).

```bash
sudo modprobe 8021q
echo '8021q' | sudo tee /etc/modules-load.d/8021q.conf
docker compose -f osint-stack/docker-compose.kali.yml up -d
```

---

## BLOQUE 5 — Cuentas externas 🔴 PENDIENTE

| Cuenta | Para qué |
|---|---|
| Cloudflare R2 | Backup Restic offsite |
| Shodan | OSINT servicios expuestos |
| HaveIBeenPwned | Leaks emails propios |
| Google AI Studio | Gemini API key |

---

## BLOQUE 6 — THDORA fix 🔴 PENDIENTE

```bash
echo 'httpx==0.27.0' >> thdora/requirements.txt
docker compose -f thdora/docker-compose.yml build
docker compose -f thdora/docker-compose.yml up -d
```

---

## BLOQUE 7 — Snapshot Suricata config 🔴 PENDIENTE

```bash
sudo grep -v "^#" /etc/suricata/suricata.yaml | grep -v "^$" \
  > setup/servidor/suricata-limpio.yaml
git add setup/servidor/suricata-limpio.yaml
git commit -m "sec: snapshot suricata.yaml productivo af-packet"
```

---
_Procedimiento original: 27-jun-2026 / Actualizado: 02-jul-2026 — Perplexity vía MCP_
