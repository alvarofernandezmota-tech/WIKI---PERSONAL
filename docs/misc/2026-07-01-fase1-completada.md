---
tags: [infra/arch, estado/draft]
fecha: 2026-07-01
hora: 00:52
---

# 📥 INBOX — FASE 1 Seguridad completada

> Migrar a `docs/infra/fase1-seguridad.md`

## ✅ Completado 01-jul 00:52

```bash
# Tailscale autoarranque
sudo systemctl enable tailscaled
# → enabled ✅

# Suspensión desactivada permanente
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
# → los 4 targets masked ✅
```

## Estado FASE 1

| Tarea | Estado |
|---|---|
| UFW activo y limpio | ✅ (sesiones anteriores) |
| fail2ban jail sshd | ✅ (28-jun) |
| Tailscale autoarranque | ✅ 01-jul |
| Suspensión desactivada | ✅ 01-jul |
| SSH hardening clave pública | ❌ pendiente |

## 👉 Siguiente: SSH hardening

Desde **Acer** ejecutar:
```bash
ssh-keygen -t ed25519 -C "varo12f-to-madre" -f ~/.ssh/id_ed25519_madre
ssh-copy-id -i ~/.ssh/id_ed25519_madre.pub varopc@100.91.112.32
```

Después en **Madre** desactivar login por contraseña:
```bash
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd
```

Tras SSH hardening → **FASE 2: Wazuh prereq + Kali Desktop**
```bash
# Wazuh prereq
echo 'vm.max_map_count=262144' | sudo tee -a /etc/sysctl.d/99-wazuh.conf
sudo sysctl -w vm.max_map_count=262144

# Verificar Kali Desktop
curl -s http://100.91.112.32:6901
```
