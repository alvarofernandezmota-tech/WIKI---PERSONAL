---
tags: [infra, seguridad, ssh, madre, hardening]
fecha-creacion: 2026-07-01
ultima-actualizacion: 2026-07-02
estado: completado
---

# 🔐 SSH Hardening — madre (varopc)

## Estado: ✅ COMPLETADO (01-jul-2026)

| Parámetro | Valor | Seguridad |
|---|---|---|
| Tipo de clave | ed25519 | ✅ más seguro que RSA |
| Passphrase | Sí | ✅ protección extra |
| PermitRootLogin | No | ✅ root no puede conectar |
| PasswordAuthentication | No | ✅ solo clave pública |
| Puerto | 22 (default) | ⚠️ valorar cambiar |

## Acceso desde theodora

```bash
ssh madre
# equivalente: ssh -i ~/.ssh/id_ed25519 varopc@100.91.112.32
```

## Acceso desde iPhone (pendiente)

```
iPhone → Tailscale → Blink Shell / Termius → 100.91.112.32
```
Requisito: importar clave ed25519 privada en la app SSH del iPhone.

## Pendiente
- [ ] SSH hardening en theodora (parcial)
- [ ] Configurar acceso SSH desde iPhone (Blink/Termius)
- [ ] Valorar cambiar puerto 22

---
_Creado desde inbox 2026-07-01 — Perplexity vía MCP_
