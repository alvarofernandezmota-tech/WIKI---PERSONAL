---
tags: [inbox, vaultwarden, bitwarden, contrasenas, docker, seguridad]
fecha: 2026-06-24
destino: setup/servidor/vaultwarden.md
estado: planificado-fase3
---

# Vaultwarden — Gestor Contraseñas Self-Hosted

> Bitwarden open source. Gestiona todas tus contrasenas desde Madre.
> Requiere HTTPS para funcionar (usar con Nginx Proxy Manager).

## Anadir al docker-compose

```yaml
  vaultwarden:
    image: vaultwarden/server:latest
    container_name: vaultwarden
    restart: always
    ports:
      - "8200:80"
    environment:
      - WEBSOCKET_ENABLED=true
      - SIGNUPS_ALLOWED=false   # solo tu cuenta
      - DOMAIN=https://vault.madre.local
    volumes:
      - vaultwarden_data:/data
```

## Volume
```yaml
  vaultwarden_data:
```

## UFW
```bash
sudo ufw allow from 192.168.1.0/24 to any port 8200
sudo ufw allow from 100.64.0.0/10 to any port 8200
```

## Post-instalacion
1. Abrir http://localhost:8200
2. Crear cuenta admin
3. SIGNUPS_ALLOWED=false para cerrar registro
4. Instalar extension Bitwarden en browser -> apuntar a http://100.91.112.32:8200
5. App movil Bitwarden -> servidor personalizado -> http://100.91.112.32:8200

## IMPORTANTE
> Vaultwarden requiere HTTPS en produccion.
> En red local con Tailscale es aceptable HTTP, pero configura NPM + cert autofirmado.

---
_Destino: setup/servidor/vaultwarden.md | Fase 3_
