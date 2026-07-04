---
tags: [inbox, kernel, sysctl, seguridad, hardening, arch]
fecha: 2026-06-24
destino: setup/servidor/kernel-sysctl.md
estado: listo-para-ejecutar
---

# Kernel Hardening (sysctl) — Madre

## Aplicar configuracion

```bash
sudo tee /etc/sysctl.d/99-hardening.conf << 'EOF'
# Proteccion SYN flood
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_max_syn_backlog = 2048

# No aceptar ICMP redirects
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0

# No reenviar paquetes (no es router)
net.ipv4.ip_forward = 0

# Proteccion IP spoofing
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1

# Deshabilitar ping (opcional)
# net.ipv4.icmp_echo_ignore_all = 1

# Proteccion core dumps
fs.suid_dumpable = 0
kernel.core_uses_pid = 1

# Randomizacion memoria
kernel.randomize_va_space = 2
EOF

# Aplicar sin reiniciar
sudo sysctl -p /etc/sysctl.d/99-hardening.conf
sudo sysctl --system
echo "Kernel hardening OK"
```

## ADVERTENCIA Docker
> net.ipv4.ip_forward = 0 puede romper Docker networking.
> Si Docker falla despues, cambia a:
> net.ipv4.ip_forward = 1

---
_Destino: setup/servidor/kernel-sysctl.md_
