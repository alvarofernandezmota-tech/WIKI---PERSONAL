---
tags: [infra/seguridad, ssh, estado/draft]
fecha: 2026-07-01
hora: 00:57
---

# 📥 INBOX — SSH Hardening Acer→Madre completado

> Migrar a `docs/infra/ssh-hardening.md`

---

## ✅ Ejecutado 01-jul 00:53–00:57

### 1. Generar clave ed25519 en Acer (theodora)
```bash
ssh-keygen -t ed25519 -C "varo12f-to-madre" -f ~/.ssh/id_ed25519_madre
# Passphrase configurada (no vacía)
# Fingerprint: SHA256:bybYsiSBpjT9Tpur+R8HZajdr7v1nP1Wxoylkgj9s4E
```

### 2. Copiar clave pública a Madre
```bash
ssh-copy-id -i ~/.ssh/id_ed25519_madre.pub varopc@100.91.112.32
# → 1 key(s) added ✅
```

### 3. Verificar conexión
```bash
ssh -i ~/.ssh/id_ed25519_madre varopc@100.91.112.32 "echo OK"
# → OK ✅
```

### 4. SSH Agent (sesión sin passphrase)
```bash
eval $(ssh-agent)
ssh-add ~/.ssh/id_ed25519_madre
# → Identity added: varo12f-to-madre ✅
```

### 5. Hacer permanente en Acer (~/.zshrc)
```bash
echo 'eval $(ssh-agent) && ssh-add ~/.ssh/id_ed25519_madre 2>/dev/null' >> ~/.zshrc
```

---

## ❌ Pendiente — desactivar login por contraseña en Madre

```bash
# En Madre — ejecutar cuando estés conectado con clave
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Verificar
grep PasswordAuthentication /etc/ssh/sshd_config
```

> ⚠️ Hacer esto SOLO después de confirmar que la clave funciona 100%.
> Haz `ssh varopc@100.91.112.32` y entra sin pedir contraseña antes de deshabilitar password auth.

---

## Estado FASE 1 — Seguridad completa

| Tarea | Estado |
|---|---|
| UFW activo y limpio | ✅ |
| fail2ban jail sshd | ✅ |
| Tailscale autoarranque (`systemctl enable tailscaled`) | ✅ 01-jul |
| Suspensión desactivada (sleep/suspend/hibernate/hybrid masked) | ✅ 01-jul |
| Wazuh prereq (`vm.max_map_count=262144`) | ✅ 01-jul |
| SSH clave ed25519 Acer→Madre | ✅ 01-jul |
| SSH deshabilitar PasswordAuthentication | ❌ pendiente |

**FASE 1 prácticamente completa.** Solo queda deshabilitar password auth.

---

## 👉 Siguiente: FASE 2 — Kali Desktop + OSINT

```bash
# Verificar Kali desde Madre
docker ps -a | grep kali

# Si está Exited, levantar
docker start kali-desktop  # o el nombre real del contenedor

# Acceder
# http://100.91.112.32:6901
# Password por defecto: abc123
```

```bash
# Wazuh prereq ya aplicado ✅
# Siguiente: levantar Wazuh
docker compose -f ~/docker/docker-compose.yml up -d wazuh
```
