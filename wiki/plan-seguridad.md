---
tipo: conocimiento
tags: [seguridad, despliegue, ufw, fail2ban, ssh, docker]
estado: activo
created: 2026-07-03
actualizado: 2026-07-05
---

# 🛡️ PLAN DE SEGURIDAD Y DESPLIEGUE

> Migrado desde raíz — 2026-07-05
> Issues de seguimiento: [yggdrasil-dew issues](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues)

---

## Capas de seguridad activas

- **UFW** — deny incoming por defecto, reglas específicas por servicio y origen
- **fail2ban** — jail SSH activo en Madre y Acer (maxretry 5, bantime 24h)
- **Tailscale** — VPN mesh para acceso remoto seguro
- **SSH** — solo clave pública, PasswordAuthentication no
- **Docker** — contenedores sin privilegios, redes aisladas

## Pendientes de seguridad

- [ ] Puerto 21 FTP en router — verificar si sigue abierto
- [ ] `PermitRootLogin no` explícito en sshd_config
- [ ] CrowdSec sobre UFW
- [ ] Vaultwarden para secrets del ecosistema
- [ ] AlertManager → Telegram para alertas críticas

_Migrado desde raíz — 2026-07-05 · Perplexity-MCP_
