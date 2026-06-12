# fail2ban — Protección contra intrusiones

> Última actualización: 13 junio 2026
> Host: Madre

---

## Estado

| Item | Estado |
|---|---|
| fail2ban en Madre | ⏳ Pendiente (incluido en bootstrap) |

---

## Instalar

```bash
sudo pacman -S fail2ban
sudo systemctl enable --now fail2ban
```

## Configurar para SSH

```bash
sudo tee /etc/fail2ban/jail.local > /dev/null <<EOF
[sshd]
enabled = true
port = ssh
maxretry = 5
bantime = 3600
findtime = 600
EOF
sudo systemctl restart fail2ban
```

## Comandos útiles

```bash
# Ver IPs baneadas
sudo fail2ban-client status sshd

# Desbanear una IP
sudo fail2ban-client set sshd unbanip <IP>

# Ver logs
sudo journalctl -u fail2ban -f
```

---

_Ver también: [ufw.md](ufw.md) · [rescate.md](rescate.md)_
_Volver al índice: [README.md](README.md)_
