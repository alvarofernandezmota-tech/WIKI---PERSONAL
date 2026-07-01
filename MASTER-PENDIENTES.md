# Master Pendientes — Yggdrasil Dew

> Actualizado: 2026-07-01 06:00 CEST

---

## 🔴 Crítico — Al despertar

- [ ] Verificar que tmux `descargas` terminó: `tmux attach -t descargas`
- [ ] Confirmar imágenes descargadas: `docker images | grep -E "kasm|wazuh-dashboard|suricata"`
- [ ] **Cerrar puerto 21 FTP en router** (hallazgo crítico)

---

## 🟡 Hoy (2026-07-01 mañana)

### Stack Docker
- [ ] Levantar Pihole + SearXNG
- [ ] Levantar Wazuh Manager + Dashboard
- [ ] Levantar Kali KasmWeb
- [ ] Levantar Suricata IDS
- [ ] Verificar docker-compose completo funciona

### Seguridad
- [ ] Revisar y configurar reglas firewall (ufw/nftables)
- [ ] Wazuh: configurar agentes en theodora e iPhone
- [ ] Suricata: configurar reglas red local

---

## 🟢 Esta semana

- [ ] Pihole: configurar listas de bloqueo
- [ ] SearXNG: configurar instancia privada
- [ ] Wazuh dashboard: primeras alertas y dashboards
- [ ] Kali KasmWeb: acceso web verificado
- [ ] Documentar arquitectura de red completa en `infra/`
- [ ] Script de backup automático de configs
- [ ] Tailscale: verificar todos los nodos conectados

---

## ✅ Completado

- [x] SSH Hardening madre (ed25519, passphrase, no root, no password)
- [x] Ollama instalado y modelos descargados (llama3.2, mistral, nomic-embed)
- [x] Pentest inicial red local (nmap, nikto, hydra)
- [x] MadreAP hostapd + dnsmasq operativo
- [x] Suspensión del sistema maskeada
- [x] Imágenes Docker: pihole, searxng, wazuh-manager
- [x] ADB Redmi A5: optimización hotspot

---

## 📋 Backlog

- [ ] Migrate theodora configs to repo
- [ ] Setup monitoring alertas Telegram/email
- [ ] Documentar runbook completo madre
- [ ] CI/CD básico para el repo
- [ ] Renovar certificados si hay servicios HTTPS
