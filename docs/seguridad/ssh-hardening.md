# SSH Hardening — Madre
#seguridad #ssh #hardening #fase2 #madre

**Fecha:** 2026-07-01  
**Estado:** parcial — falta `PasswordAuthentication no`

---

## Configuración aplicada

Fichero: `/etc/ssh/sshd_config` en Madre

```
PermitRootLogin no
MaxAuthTries 3
AllowUsers alvaro
PasswordAuthentication yes   ← PENDIENTE cambiar a no
```

---

## Pendiente crítico

```bash
# En Madre (requiere sesión SSH activa desde Acer en Toledo):
sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Verificar desde otra terminal ANTES de cerrar la sesión:
ssh alvaro@madre -p [puerto]
```

⚠️ **NO ejecutar sin tener una segunda terminal SSH abierta.** Si falla el test, puedes perder acceso.

---

## Fail2ban

- Instalado: ✅
- Activo: ✅
- Configuración por defecto (ban tras 5 intentos fallidos)

---

## Test SSH desde Toledo

- Requiere: Tailscale activo en ambas máquinas
- Comando: `ssh alvaro@[ip-tailscale-madre] -p [puerto]`
- Estado: ⏳ pendiente verificar desde Toledo
