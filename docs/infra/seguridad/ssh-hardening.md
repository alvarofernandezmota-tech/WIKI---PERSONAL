# SSH Hardening — Madre

> Estado: ✅ APLICADO — 03-jul-2026

## Configuración actual /etc/ssh/sshd_config

```
PubkeyAuthentication yes
PasswordAuthentication no
PermitRootLogin no
```

## Script aplicado

Ver `~/bootstrap-madre.sh` en Madre.

Ejecutado el 03-jul-2026. Backup en `/etc/ssh/sshd_config.bak.*`

## Claves autorizadas

Ver `docs/operativa/iphone-ssh-blink.md` para tabla completa de claves.

## Añadir nueva clave

```bash
# En Madre
echo 'ssh-ed25519 AAAA... descripcion' >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

## Verificar hardening

```bash
grep -E 'PasswordAuthentication|PubkeyAuthentication|PermitRootLogin' /etc/ssh/sshd_config
systemctl status sshd
```

## Issue relacionado

- #13 SSH hardening Madre ✅
- #23 iPhone SSH via Blink ✅

---

_Documentado por Perplexity MCP — 03-jul-2026_
