---
tags: [inbox, ssh, seguridad, hardening, madre]
fecha: 2026-06-24
destino: setup/servidor/ssh-hardening.md
estado: listo-para-ejecutar
---

# SSH Hardening — Madre

## Config /etc/ssh/sshd_config

```bash
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

sudo tee /etc/ssh/sshd_config.d/hardening.conf << 'EOF'
# Deshabilitar root login
PermitRootLogin no

# Solo autenticacion por clave, no contrasena
PasswordAuthentication no
PubkeyAuthentication yes

# Timeout sesion inactiva (5 min)
ClientAliveInterval 300
ClientAliveCountMax 2

# Limitar intentos
MaxAuthTries 3
MaxSessions 5

# Solo IPv4 si no usas IPv6
#AddressFamily inet

# Banner
Banner /etc/ssh/banner
EOF

# Banner
echo "Acceso autorizado solo. Actividad monitorizada." | sudo tee /etc/ssh/banner

# Reiniciar SSH
sudo systemctl restart sshd
sudo systemctl status sshd --no-pager
```

## ADVERTENCIA
> Antes de deshabilitar PasswordAuthentication, asegurate de que tienes
> tu clave publica en ~/.ssh/authorized_keys en Madre.
> Si no, te quedas sin acceso SSH.

```bash
# Desde varopc/Acer, copiar clave primero:
ssh-copy-id varo@100.91.112.32
# Solo entonces deshabilitar password auth
```

## Verificar
```bash
ssh -o PasswordAuthentication=no varo@100.91.112.32 echo "SSH key OK"
```

---
_Destino: setup/servidor/ssh-hardening.md_
