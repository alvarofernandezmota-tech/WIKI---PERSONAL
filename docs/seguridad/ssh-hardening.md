# SSH Hardening — Acer→Madre
#seguridad #ssh #hardening #clave-publica

**Fecha:** 2026-07-01 00:53–00:57 CEST
**Estado:** ✅ Completado (salvo PasswordAuth pendiente)

---

## Pasos ejecutados

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

### 4. SSH Agent permanente en Acer (~/.zshrc)
```bash
echo 'eval $(ssh-agent) && ssh-add ~/.ssh/id_ed25519_madre 2>/dev/null' >> ~/.zshrc
```

### 5. Pendiente — desactivar password auth en Madre
```bash
# Ejecutar en Madre SOLO después de confirmar que la clave funciona
sudo sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd
grep PasswordAuthentication /etc/ssh/sshd_config
```
