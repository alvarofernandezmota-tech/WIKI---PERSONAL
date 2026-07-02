---
tags: [infra, fase1, seguridad, madre, arch]
fecha-actualizacion: 2026-07-02
---

# 🔐 Fase 1 — Seguridad base Madre

> Máquina objetivo: Madre (Arch Linux servidor doméstico)
> Tailscale IP: `100.91.112.32`

## Estado general
🟡 **EN PROCESO** — falta SSH hardening

## Checklist

| Tarea | Estado | Fecha |
|---|---|---|
| UFW activo y limpio | ✅ | sesiones anteriores |
| fail2ban jail sshd | ✅ | 28-jun-2026 |
| Tailscale instalado | ✅ | sesiones anteriores |
| Tailscale autoarranque (`systemctl enable tailscaled`) | ✅ | 01-jul-2026 |
| Suspensión desactivada (4 targets masked) | ✅ | 01-jul-2026 |
| SSH hardening (clave pública + deshabilitar password) | ❌ | **PENDIENTE** |

## SSH Hardening — pendiente

Ejecutar desde **Acer (Theodora)**:
```bash
# Generar llave ed25519
ssh-keygen -t ed25519 -C "theodora-to-madre" -f ~/.ssh/id_ed25519_madre

# Copiar llave pública a Madre
ssh-copy-id -i ~/.ssh/id_ed25519_madre.pub varopc@100.91.112.32

# Verificar login con llave (sin password)
ssh -i ~/.ssh/id_ed25519_madre varopc@100.91.112.32
```

Tras verificar, en **Madre** deshabilitar password auth:
```bash
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
# Verificar la línea quedó bien:
grep PasswordAuthentication /etc/ssh/sshd_config
sudo systemctl restart sshd
# IMPORTANTE: mantener sesión SSH activa antes de hacer restart
```

## Suspensión — comandos ejecutados
```bash
sudo systemctl enable tailscaled          # ✅ enabled
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target  # ✅ 4 targets masked
```

## Siguiente tras Fase 1
Fase 5 técnica: Wazuh prereq → levantar stack batcueva
```bash
echo 'vm.max_map_count=262144' | sudo tee -a /etc/sysctl.d/99-wazuh.conf
sudo sysctl -w vm.max_map_count=262144
```

---
_Actualizado: 02-jul-2026 — Perplexity vía MCP_
