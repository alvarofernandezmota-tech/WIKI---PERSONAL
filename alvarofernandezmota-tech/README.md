<!-- Profile README — alvarofernandezmota-tech -->
<!-- Actualizado: 02-jul-2026 -->

<h1 align="center">
  Álvaro Fernández Mota
  <img src="https://media.giphy.com/media/hvRJCLFzcasrR4ia7z/giphy.gif" width="28">
</h1>

<p align="center">
  <b>Systems Engineer · Homelab Architect · OSINT & Security Researcher</b><br/>
  <sub>Linux · Self-hosted · AI-augmented workflows · Arch Linux</sub>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/OS-Arch%20Linux-1793D1?style=flat-square&logo=archlinux&logoColor=white"/>
  <img src="https://img.shields.io/badge/VPN-Tailscale-242424?style=flat-square&logo=tailscale&logoColor=white"/>
  <img src="https://img.shields.io/badge/Containers-Docker-2496ED?style=flat-square&logo=docker&logoColor=white"/>
  <img src="https://img.shields.io/badge/Monitoring-Wazuh%20%2B%20Grafana-FF6600?style=flat-square"/>
  <img src="https://img.shields.io/badge/AI-Ollama%20%2B%20Local%20LLMs-000000?style=flat-square"/>
  <img src="https://img.shields.io/badge/OSINT-Active-red?style=flat-square"/>
</p>

---

## 🏗️ Ecosistema Yggdrasil-Dew

Infraestructura personal de producción y laboratorio de seguridad, operada 24/7 desde casa.
Diseñada para ser **auditada, reproducible y completamente documentada**.

```
Yggdrasil-Dew Ecosystem
════════════════════════════════════════════════════════════════

  ┌──────────────────┐   ┌──────────────────┐
  │  MADRE (Server)  │   │  THDORA (Acer)   │
  │ Arch Linux 24/7  │   │  Arch Linux      │
  │ AMD Ryzen        │   │  Workstation     │
  │ 32GB RAM         │   │  Dev / OSINT     │
  └────┬────────────┘   └──────┬───────────┘
       │                        │
       └─────── Tailscale VPN ───────┘
              (Zero-trust mesh)

Madre stack:
  ├─ Docker: Batcueva (20+ servicios)
  ├─ Wazuh SIEM + Suricata IDS
  ├─ Grafana + Prometheus monitoring
  ├─ Ollama (local LLMs: Llama3, Mistral, Phi3)
  ├─ Nextcloud + Vaultwarden
  ├─ Nginx reverse proxy + Let's Encrypt
  ├─ Pi-hole DNS + Unbound resolver
  └─ hostapd WiFi AP (r8852be)
```

---

## 🛡️ Stack de Seguridad

| Capa | Herramienta | Estado |
|---|---|---|
| **VPN / acceso remoto** | Tailscale (WireGuard) | ✅ Activo |
| **SIEM** | Wazuh 4.x | 🚧 Desplegando |
| **IDS/IPS** | Suricata | 🚧 Desplegando |
| **SSH hardening** | ed25519 keys only / no password auth | 🚧 Pendiente |
| **DNS** | Pi-hole + Unbound (DoT) | ✅ Activo |
| **Firewall** | nftables | ✅ Activo |
| **Monitoring** | Grafana + Prometheus + Alertmanager | ✅ Activo |
| **Secrets** | Vaultwarden (Bitwarden self-hosted) | ✅ Activo |

---

## 🤖 IA Local

Todo corre en Madre, sin datos fuera del hogar:

```
Ollama → Llama 3.1 8B / Mistral 7B / Phi-3 Mini
Open WebUI → interfaz web para LLMs locales
Agent Framework → agentes con acceso al ecosistema
Perplexity + MCP GitHub → gestión del repo vía IA
Cursor + MCP → (pendiente Acer) dev + IA + terminal
```

---

## 🔍 OSINT & Research

- Infraestructura dedicada de OSINT con stack Docker aislado
- Herramientas: Maltego, SpiderFoot, Shodan, theHarvester
- Metodología documentada en el repo
- Red separada de producción por VLAN / macvlan

---

## 📊 Tecnologías

<p>
  <img src="https://img.shields.io/badge/Linux-Arch-1793D1?style=flat-square&logo=archlinux"/>
  <img src="https://img.shields.io/badge/Shell-Bash%20%2F%20Zsh-4EAA25?style=flat-square&logo=gnubash"/>
  <img src="https://img.shields.io/badge/Python-3.x-3776AB?style=flat-square&logo=python"/>
  <img src="https://img.shields.io/badge/Docker-Compose-2496ED?style=flat-square&logo=docker"/>
  <img src="https://img.shields.io/badge/Git-GitHub-181717?style=flat-square&logo=github"/>
  <img src="https://img.shields.io/badge/Ansible-EE0000?style=flat-square&logo=ansible"/>
  <img src="https://img.shields.io/badge/Grafana-F46800?style=flat-square&logo=grafana"/>
  <img src="https://img.shields.io/badge/Nginx-009639?style=flat-square&logo=nginx"/>
  <img src="https://img.shields.io/badge/WireGuard-88171A?style=flat-square&logo=wireguard"/>
</p>

---

## 📁 Repositorio principal

**[`yggdrasil-dew`](https://github.com/alvarofernandezmota-tech/yggdrasil-dew)** — Toda la infraestructura, documentación, scripts, diarios de trabajo y configuraciones del ecosistema. Gestionado con IA vía MCP GitHub.

---

<p align="center">
  <sub>Operado desde España · Arch Linux · Self-hosted since 2024</sub>
</p>
