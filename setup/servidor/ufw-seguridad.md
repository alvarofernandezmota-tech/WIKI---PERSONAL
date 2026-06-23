---
tags: [ufw, seguridad, firewall, arch, docker]
fecha: 2026-06-24
maquina: madre
---

# UFW Seguridad Mínima — Stack IA Madre

## Reglas

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22                                       # SSH
sudo ufw allow from 192.168.1.0/24 to any port 3001   # Open WebUI — LAN
sudo ufw allow from 100.64.0.0/10 to any port 3001    # Open WebUI — Tailscale
sudo ufw allow from 192.168.1.0/24 to any port 11434  # Ollama — LAN
sudo ufw allow from 100.64.0.0/10 to any port 11434   # Ollama — Tailscale
sudo ufw enable
sudo ufw status
```

## ⚠️ Puertos NUNCA exponer a internet

| Puerto | Servicio | Motivo |
|---|---|---|
| 11434 | Ollama | API sin auth |
| 6333 | Qdrant | DB sin auth |
| 3001 | Open WebUI | UI admin |

Usa **Tailscale** para acceso remoto. No abrir en el router.

## Verificación

```bash
sudo ufw status verbose
nmap -p 3001,11434,6333 localhost
```
