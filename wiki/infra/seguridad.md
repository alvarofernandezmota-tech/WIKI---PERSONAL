# 🔒 Seguridad

> Política de acceso y seguridad del ecosistema Yggdrasil.

---

## Principios

1. **Nunca** exponer servicios al exterior sin autenticación
2. **Siempre** acceder a Madre por Tailscale o SSH con clave (nunca contraseña)
3. **Rotar** claves de API cada 90 días
4. **Documentar** aquí cada acceso y credencial (referencia, nunca el valor real)

---

## Gestión de secretos

```bash
# Las claves reales viven en Madre en:
# ~/.env o /etc/yggdrasil/.env
# NUNCA en el repo

# Template de variables disponible en:
# /.env.template (raíz del repo)
```

---

## Registro de accesos configurados

| Servicio | Tipo de acceso | Dónde está la clave | Caducidad |
|---|---|---|---|
| GitHub | PAT | Madre ~/.env | _pendiente_ |
| Tailscale | Auth key | Consola Tailscale | _pendiente_ |

---

## SSH — configuración segura

```bash
# Deshabilitar login por contraseña (en Madre)
sudo nano /etc/ssh/sshd_config
# PasswordAuthentication no
# PubkeyAuthentication yes

sudo systemctl restart sshd
```
