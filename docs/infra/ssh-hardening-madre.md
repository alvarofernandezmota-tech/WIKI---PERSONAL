---
tags: [tipo/procedimiento, estado/completado, seguridad, ssh, madre, hardening]
fecha: 2026-07-01
validado: true
---

# 🔐 SSH Hardening — Madre (varopc)

> Estado: ✅ COMPLETADO — validado 01-jul-2026
> Fuente: `inbox/2026-07-01-ssh-hardening-completo.md`

---

## ✅ Configuración aplicada

| Parámetro | Valor | Razón |
|---|---|---|
| `PasswordAuthentication` | `no` | Solo llaves |
| `PermitRootLogin` | `no` | Sin acceso root directo |
| `PubkeyAuthentication` | `yes` | Ed25519 |
| `AuthorizedKeysFile` | `.ssh/authorized_keys` | Estándar |
| `MaxAuthTries` | `3` | Limitar brute force |
| `LoginGraceTime` | `20s` | Timeout login |
| `AllowUsers` | `varo` | Solo usuario varo |
| Puerto | `22` (interno) | Expuesto solo en Tailscale |

## ✅ Herramientas activas

- **fail2ban** — activo, banea tras 3 intentos fallidos
- **UFW** — activo, solo permite puertos necesarios
- Tipo de llave: **ed25519** (no RSA)

## 🔗 Acceso actual autorizado

| Dispositivo | IP Tailscale | Llave |
|---|---|---|
| theodora | `100.86.119.102` | ed25519 ✅ |
| iPhone (pendiente) | `100.81.187.99` | Pendiente Blink Shell |

## 🗓️ Pendiente

- [ ] Añadir llave iPhone (Blink Shell Secure Enclave) a `authorized_keys`
- [ ] Auditar `authorized_keys` periodicamente
