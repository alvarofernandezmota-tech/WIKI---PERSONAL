# Diario sesión — 27 junio 2026 (macvlan + Suricata)
#diario #sesion #infra #seguridad #macvlan #suricata

**Inicio:** 04:34 CEST
**Fin:** 04:40 CEST
**Duración:** ~6 min
**Contexto:** Diseño de entorno ofensivo (Kali + macvlan) y cadena IDS→SIEM Suricata+Wazuh

---

## Qué se dejó preparado en la repo

1. **Red macvlan pentest VLAN 66**
   - Archivo `osint-stack/docker-compose.kali.yml` creado con:
     - Red `pentest_vlan` driver macvlan, `parent: eno1.66`, subnet `192.168.66.0/24`.
     - Contenedor `kali-pentest` con IP estática `192.168.66.100`, `privileged` y capacidades NET_ADMIN/NET_RAW.
   - Objetivo: que Kali se presente ante el router como máquina independiente (Capa 2), sin pasar por el NAT de Docker/Madre.

2. **Guía Suricata af-packet + Wazuh**
   - Archivo `docs/infra/suricata-af-packet-wazuh.md` creado con fases:
     - Fase 1: desactivar offloading con `disable-offload.service`.
     - Fase 2: plantilla Suricata (`vars`, `outputs`, `af-packet`).
     - Fase 3: integración Wazuh (`eve.json` como `localfile`).
     - Fase 4: validación con `curl http://testmyids.com`.
     - Fase 5: snapshot `suricata-limpio.yaml` para subir config real.

3. **Archivos de referencia**
   - `setup/servidor/disable-offload.service.example` — servicio systemd para ethtool.
   - `setup/servidor/suricata-af-packet.yaml.template` — plantilla de configuración.

4. **Ajuste script dependencias**
   - `scripts/infra/instalar-dependencias.sh` actualizado para sacar `zeek` de pacman y dejar instalación vía AUR (`yay`).

---

## Próximos pasos (en Madre)

1. `git pull --rebase` en Madre.
2. Aplicar `disable-offload.service` real en `/etc/systemd/system/`.
3. Editar `/etc/suricata/suricata.yaml` siguiendo la plantilla y guía.
4. Ejecutar `suricata-update` y reiniciar Suricata.
5. Configurar Wazuh agent con `eve.json` como `localfile`.
6. Validar cadena IDS→SIEM con `curl http://testmyids.com`.
7. Configurar router/switch con VLAN 66 trunk hacia Madre.
8. Levantar `kali-pentest` con `docker-compose -f osint-stack/docker-compose.kali.yml up -d`.
9. Verificar que Kali tiene IP `192.168.66.100` y hace ARP/Nmap contra red pentest.

---

*Sesión: 2026-06-27 — Batcueva homelab — diseño ofensivo y SOC avanzado documentado en yggdrasil-dew.*
