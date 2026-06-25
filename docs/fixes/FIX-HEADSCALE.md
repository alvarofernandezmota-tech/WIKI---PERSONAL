---
tags: [fix, headscale, docker]
fecha: 2026-06-25
---

# FIX — Headscale restarting

## Síntoma
```
headscale   Restarting (1) X seconds ago
```

## Causa
Headscale necesita un fichero de configuración `config.yaml` montado.
Sin él crashea inmediatamente.

## Fix rápido — deshabilitar headscale hasta configurarlo

```bash
# Parar headscale
docker stop headscale
docker rm headscale
```

O en el docker-compose.yml añadir `profiles: ["headscale"]` para que no arranque por defecto.

## Fix completo — crear config mínimo

```bash
mkdir -p ~/headscale/config
curl -o ~/headscale/config/config.yaml \
  https://raw.githubusercontent.com/juanfont/headscale/main/config-example.yaml

# Editar server_url con tu IP Tailscale:
nano ~/headscale/config/config.yaml
# server_url: http://100.91.112.32:8080
```

Luego reiniciar el stack con el volumen montado.

## Estado
- [ ] Headscale configurado
- [ ] DNS interno funcionando
