---
tags: [infra, seguridad, ssh, madre, hardening]
fecha-creacion: 2026-07-01
ultima-actualizacion: 2026-07-02
estado: completado
---

# 🔐 SSH Hardening — madre (varopc)

## Estado: ✅ COMPLETADO (01-jul-2026)

## Configuración aplicada

| Parámetro | Valor | Seguridad |
|---|---|---|
| Tipo de clave | ed25519 | ✅ más seguro que RSA |
| Passphrase | Sí | ✅ protección extra |
| PermitRootLogin | No | ✅ root no puede conectar |
| PasswordAuthentication | No | ✅ solo clave pública |
| Puerto | 22 (default) | ⚠️ valorar cambiar |

## Acceso desde theodora

```bash
# Desde theodora — alias configurado
ssh madre

# Equivalente completo
ssh -i ~/.ssh/id_ed25519 varopc@100.91.112.32
```

## Pendiente
- [ ] SSH hardening en theodora (parcial)
- [ ] Clave pública de theodora subida a madre
- [ ] Valorar cambiar puerto 22 por seguridad por oscuridad

## Ver también
- [[docs/seguridad/hallazgos/SEC-001-ftp-puerto21]]
- [[ECOSISTEMA]]

---
_Creado desde inbox 2026-07-01 — Perplexity vía MCP_
