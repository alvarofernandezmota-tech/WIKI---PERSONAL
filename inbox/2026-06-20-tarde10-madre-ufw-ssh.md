---
fecha: 2026-06-20
hora: ~21:40
tags: [madre, seguridad, ufw, fail2ban, ssh, firewall]
estado: completado
relacionado: [[2026-06-20-tarde9-monitores-volumen]], [[setup/madre]]
---

# Sesión tarde10 — Madre: UFW + SSH + fail2ban

## Contexto

Verificación y hardening de seguridad en la madre (100.91.112.32). Acceso vía `ssh -t madre`.

## fail2ban

- Ya estaba instalado y corriendo desde las 18:23 CEST
- Versión: `fail2ban 1.1.0-8`
- Estado: `active (running)` · `enabled`
- Uptime al verificar: 3h 15min

```bash
systemctl status fail2ban
# ● fail2ban.service - Fail2Ban Service
#    Active: active (running) since Sat 2026-06-20 18:23:53 CEST
```

## UFW — estado antes

UFW ya estaba activo con reglas previas:

| Puerto | Acción | Descripción |
|--------|--------|-------------|
| 53317/udp+tcp | ALLOW | Tailscale |
| 172.17.0.1:53/udp | ALLOW | DNS Docker |

**Faltaba la regla SSH** — riesgo de perder acceso remoto tras reinicio.

## Fix aplicado

```bash
ssh -t madre "sudo ufw allow ssh && sudo ufw reload && sudo ufw status"
```

## UFW — estado final

| Puerto | Acción | Descripción |
|--------|--------|-------------|
| 53317/udp+tcp | ALLOW | Tailscale |
| 172.17.0.1:53/udp | ALLOW | DNS Docker |
| 22/tcp+udp | ✅ ALLOW | SSH — añadido esta sesión |

## Pendientes madre

- [ ] Documentar ruta repo thdora: `find ~ -name docker-compose.yml`
- [ ] `uname -a` + `cat /etc/os-release` → ficha OS
- [ ] Instalar tmux
- [ ] `df -h` + `free -h` → ficha recursos
- [ ] Crear `setup/madre.md` con todo el hardware documentado
