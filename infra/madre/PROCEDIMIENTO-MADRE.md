# Procedimiento Madre — Infraestructura

> Migrado desde inbox/PROCEDIMIENTO-MADRE-HOY.md — 2026-07-01

Este documento describe los procedimientos operativos para el nodo madre.

---

## Arranque del sistema

```bash
# 1. Verificar servicios base
systemctl status ollama
systemctl status hostapd

# 2. Ver sesiones tmux
tmux ls

# 3. Ver contenedores Docker
docker ps -a

# 4. Estado de red
ip addr show
tailscale status
```

## Docker Stack — Levantar todo

```bash
# OSINT + Seguridad stack completo
docker compose -f ~/yggdrasil-dew/osint-stack/docker-compose.yml up -d

# Solo Wazuh
docker compose -f ~/yggdrasil-dew/osint-stack/docker-compose.wazuh.yml up -d

# Solo Kali
docker compose -f ~/yggdrasil-dew/osint-stack/docker-compose.kali.yml up -d
```

## SSH desde exterior

```bash
# Desde theodora
ssh madre

# Desde iPhone (Tailscale)
ssh -i ~/.ssh/id_ed25519 varo@100.x.x.x
```

## MadreAP — WiFi AP

```bash
# Ver clientes conectados
cat /var/lib/misc/dnsmasq.leases
ip neigh show dev wlan0

# Reiniciar AP
sudo systemctl restart hostapd dnsmasq
```

## Ollama

```bash
# Ver modelos disponibles
ollama list

# Chat rápido
ollama run llama3.2:3b

# API
curl http://localhost:11434/api/generate -d '{"model":"llama3.2:3b","prompt":"hola"}'
```
