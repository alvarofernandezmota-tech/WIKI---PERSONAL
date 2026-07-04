---
tags: [inbox, nginx, proxy, https, docker, madre]
fecha: 2026-06-24
destino: setup/servidor/nginx-proxy-manager.md
estado: listo-para-ejecutar
---

# Nginx Proxy Manager — HTTPS para todos los servicios

> Reverse proxy con UI. Pone HTTPS a todos los servicios Docker.
> Sin esto todo corre en HTTP plano en la red local.

## Anadir al docker-compose

```yaml
  nginx-proxy-manager:
    image: jc21/nginx-proxy-manager:latest
    container_name: nginx-proxy-manager
    restart: always
    ports:
      - "80:80"
      - "443:443"
      - "81:81"   # Admin UI
    volumes:
      - npm_data:/data
      - npm_letsencrypt:/etc/letsencrypt
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:81"]
      interval: 30s
      timeout: 10s
      retries: 3
```

## Volume
```yaml
  npm_data:
  npm_letsencrypt:
```

## UFW — abrir puertos HTTP/HTTPS
```bash
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow from 192.168.1.0/24 to any port 81
sudo ufw allow from 100.64.0.0/10 to any port 81
```

## Post-instalacion
1. Abrir http://localhost:81
2. Login inicial: admin@example.com / changeme
3. Cambiar credenciales YA
4. Crear Proxy Hosts:
   - open-webui.local -> http://open-webui:8080
   - portainer.local -> http://portainer:9000
   - uptime.local -> http://uptime-kuma:3001

## Para HTTPS en red local (sin dominio publico)
- Usar certificados autofirmados en NPM
- O instalar mkcert en Madre para CA local:
```bash
sudo pacman -S --noconfirm mkcert
mkcert -install
mkcert madre.local *.madre.local
```

---
_Destino: setup/servidor/nginx-proxy-manager.md_
