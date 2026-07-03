# 🔴 PROCEDIMIENTO EJECUTABLE — PRÓXIMA SESIÓN EN MADRE
#inbox #urgente #procedimiento #ejecutar

> **Creado:** 2026-06-27 04:56 CEST — Sesión Perplexity madrugada
> **Migrar a diarios/** cuando esté completado al 100%
> **LEER ESTO PRIMERO** al llegar a casa y abrir el portátil

---

## ⏰ ANTES DE TOCAR NADA — Sincronizar

```bash
cd ~/yggdrasil-dew
git pull --rebase
```

Verifica que ves los ficheros nuevos de esta madrugada:
- `scripts/infra/instalar-dependencias.sh` (zeek via AUR)
- `scripts/start-batcueva.sh`
- `osint-stack/docker-compose.kali.yml`
- `docs/infra/suricata-af-packet-wazuh.md`
- `scripts/seguridad/anonimizar-logs-suricata.py`

---

## BLOQUE 1 — Seguridad de red (FASE 1) 🔴 PRIMERO SIEMPRE

> Haz este bloque antes de levantar ningún docker.
> Mantén una sesión SSH abierta en todo momento.

### 1.1 UFW completo
```bash
sudo bash scripts/setup/servidor/ufw-reglas-completas.sh
sudo ufw status numbered
# Verifica: solo LAN + Tailscale, nada abierto al mundo
```

### 1.2 SSH Hardening (puerto 2222)
```bash
# Abre PRIMERO una segunda terminal con: ssh -p 2222 usuario@madre
# Solo cuando confirmes acceso por 2222, cierra la sesión vieja
sudo bash scripts/setup/servidor/fase1b-ssh-hardening.sh
```

### 1.3 Tailscale + anti-suspensión
```bash
sudo systemctl enable tailscaled
sudo systemctl start tailscaled
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
```

### 1.4 Reboot y verificación
```bash
sudo reboot
# Tras reboot verificar:
systemctl is-active ufw tailscaled hostapd
ssh -p 2222 usuario@<ip-madre>   # desde Acer
```

---

## BLOQUE 2 — Dependencias SOC

### 2.1 Instalar paquetes
```bash
sudo bash scripts/infra/instalar-dependencias.sh
# Si yay no está instalado, primero:
# git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```

### 2.2 Disable offload (para Suricata)
```bash
sudo cp setup/servidor/disable-offload.service.example \
     /etc/systemd/system/disable-offload.service
# Editar: cambiar 'eno1' por tu interfaz real (ip link show)
sudo systemctl enable --now disable-offload.service
```

### 2.3 Configurar Suricata
```bash
# Ver plantilla: setup/servidor/suricata-af-packet.yaml.template
# Aplicar manualmente las secciones vars, outputs y af-packet en:
sudo nano /etc/suricata/suricata.yaml

sudo suricata-update
sudo systemctl restart suricata
sudo systemctl status suricata
tail -f /var/log/suricata/eve.json   # verificar que escribe
```

### 2.4 Wazuh agent — leer eve.json
```bash
sudo nano /var/ossec/etc/ossec.conf
# Añadir dentro de <ossec_config>:
# <localfile>
#   <log_format>json</log_format>
#   <location>/var/log/suricata/eve.json</location>
# </localfile>
sudo systemctl restart wazuh-agent
```

### 2.5 Validar cadena IDS→SIEM
```bash
curl http://testmyids.com
grep "testmyids" /var/log/suricata/eve.json
# Verificar también en dashboard Wazuh (Kibana)
```

---

## BLOQUE 3 — Levantar dockers (start-batcueva)

```bash
sudo bash scripts/start-batcueva.sh
# El script verifica UFW + Tailscale antes de levantar
# Levanta en orden: monitor → IA → THDORA → OSINT/SOC
# Al final muestra tabla docker ps + URLs de acceso
```

Verificar URLs desde Acer (via Tailscale `100.91.112.32`):
- Grafana: `http://100.91.112.32:3000`
- Uptime Kuma: `http://100.91.112.32:3002`
- Open WebUI: `http://100.91.112.32:8080`
- Portainer: `http://100.91.112.32:9000`
- Kali VNC: `http://192.168.66.100:6901` (tras levantar macvlan)

---

## BLOQUE 4 — Red macvlan VLAN66 (Kali pentest)

### 4.1 Kernel + módulo
```bash
sudo modprobe 8021q
echo '8021q' | sudo tee /etc/modules-load.d/8021q.conf
```

### 4.2 Router/switch
> **Requisito:** Router debe soportar 802.1Q (OPNsense, OpenWrt, Mikrotik)
- Crear VLAN ID 66 (`VLAN_PENTEST`)
- Puerto hacia Madre: **Trunk** (LAN nativa sin etiquetar + VLAN 66 etiquetada)
- Interfaz VLAN 66: IP `192.168.66.1/24`, DHCP `192.168.66.10-50`
- Firewall: denegar `192.168.66.0/24` → `192.168.1.0/24` (LAN doméstica)

### 4.3 Levantar Kali
```bash
docker compose -f osint-stack/docker-compose.kali.yml up -d
docker exec -it kali-pentest ip a   # debe mostrar 192.168.66.100
docker exec -it kali-pentest arp-scan -l   # solo ve el gateway .1
```

---

## BLOQUE 5 — Cuentas externas (crear manualmente)

Esas cuentas no se pueden automatizar. Crearlas y guardar credenciales en `.env` (NO en git):

| Cuenta | Para qué | URL |
|---|---|---|
| **Cloudflare R2** | Backup Restic offsite | dash.cloudflare.com |
| **Shodan** | OSINT servicios expuestos | shodan.io |
| **HaveIBeenPwned** | Leaks de emails propios | haveibeenpwned.com |
| **Telegram Bot** | THDORA ya configurado | t.me/BotFather |
| **Google AI Studio** | Gemini API key | aistudio.google.com |

Una vez creadas, documentar estado en `docs/infra/cuentas-servicios.md`.

---

## BLOQUE 6 — THDORA: fix requirements.txt

```bash
echo 'httpx==0.27.0' >> thdora/requirements.txt
# Reconstruir contenedor
docker compose -f thdora/docker-compose.yml build
docker compose -f thdora/docker-compose.yml up -d
```

---

## BLOQUE 7 — Snapshot Suricata config real

Una vez Suricata esté estable, crear snapshot para la repo:
```bash
sudo grep -v "^#" /etc/suricata/suricata.yaml | grep -v "^$" \
  > setup/servidor/suricata-limpio.yaml
git add setup/servidor/suricata-limpio.yaml
git commit -m "sec: snapshot suricata.yaml productivo af-packet"
git push
```

---

## BLOQUE 8 — Al terminar: actualizar MASTER-PENDIENTES

Marcar en `MASTER-PENDIENTES.md` cada tarea completada y mover este fichero a:
```
diarios/2026-06-27-procedimiento-madre-completado.md
```

---

_Procedimiento generado: 2026-06-27 04:56 CEST — Sesión Perplexity + Gemini madrugada_
_Todo el detalle técnico en: `docs/infra/` y `docs/investigacion/`_
