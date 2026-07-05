---
tipo: relacion
nombre: Servicios en Madre
islas: [infra, ia-local, thdora, seguridad]
obsidian_link: "[[servicios-madre]]"
estado: activo
---

# 🔗 Relación: Todos los servicios que corren en Madre

Madre (`varpc`, `100.91.112.32`) es el servidor central del ecosistema. Esta página es el inventario completo de todo lo que corre en él.

## Inventario de servicios

| Servicio | Puerto | Repo | Verificar |
|---|---|---|---|
| SSH | 22 | `madre-config` | `systemctl is-active sshd` |
| Ollama | 11434 | `ollama-stack` | `systemctl is-active ollama` |
| THDORA bot | 8000 | `THDORA-PERSONAL` | `docker ps \| grep thdora` |
| Netdata | 19999 | — | `systemctl is-active netdata` |
| Docker daemon | — | — | `systemctl is-active docker` |
| Tailscale | — | — | `tailscale status` |
| UFW | — | `madre-config` | `ufw status` |
| fail2ban | — | `madre-config` | `fail2ban-client status` |

## Script de verificación global

```bash
#!/bin/bash
# health-check-madre.sh
echo "=== MADRE HEALTH CHECK ==="
for svc in sshd ollama netdata docker tailscaled ufw fail2ban; do
    status=$(systemctl is-active $svc 2>/dev/null)
    echo "[$status] $svc"
done
echo ""
echo "=== DOCKER CONTAINERS ==="
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo ""
echo "=== OLLAMA MODELS ==="
ollama list
```

## Acceso desde Acer

```bash
# SSH
ssh varopc@100.91.112.32

# Ollama API
curl http://100.91.112.32:11434/api/tags

# Netdata dashboard
# Abrir en navegador: http://100.91.112.32:19999
```

## Repos relacionados

- `madre-config` → https://github.com/alvarofernandezmota-tech/madre-config
- `ollama-stack` → https://github.com/alvarofernandezmota-tech/ollama-stack
- `THDORA-PERSONAL` → https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL

---
_Actualizado: 2026-07-05 · Perplexity-MCP_
