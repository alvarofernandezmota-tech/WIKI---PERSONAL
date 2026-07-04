---
tags: [auditoria, setup, servidor, homelab, equipos]
fecha: 2026-06-23
estado: pendiente-ejecutar
tipo: auditoria
ruta-obsidian: inbox/2026-06-23-auditoria-setup.md
---

# Auditoría `setup/` — plan de mejora

> Generado en sesión 2026-06-23 · objetivo: escalar al nivel de `agentes/`

## Decisión arquitectura (ADR 2026-06-23)

`setup/` = toda la infraestructura del homelab Batcueva.
Incluyendo Madre, equipos, red y scripts.

## Estructura objetivo

```
setup/
  README.md                    ← índice del homelab completo
  servidor/
    README.md                  ← Madre — specs, estado, servicios activos
    batcueva.md                ← visión global del homelab
    docker-stack.md            ← servicios Docker corriendo
    systemd.md                 ← servicios systemd
    red.md                     ← IPs, Tailscale, puertos
    scripts/
      pull-stack.sh            ← ← mover desde inbox
      README.md
  equipos/
    acer.md                    ← specs + config
    iphone.md
    mac.md
    varopc.md
  red/
    tailscale.md
    hotspot.md
    failover.md
```

## Estado Docker en Madre (2026-06-23)

| Servicio | Estado | Puerto |
|---|---|---|
| Ollama | ⏳ Descargando | 11434 |
| Open WebUI | ⏳ Descargando | 3000 |
| Qdrant | ⏳ Descargando | 6333 |
| SpiderFoot | 🔴 Pendiente | 5001 |
| IVRE | 🔴 Pendiente | — |

## Pasos a ejecutar

- [ ] Listar contenido actual de `setup/`
- [ ] Crear `setup/servidor/` — mover contenido de `proyectos/batcueva/`
- [ ] Crear `setup/servidor/docker-stack.md` con tabla servicios
- [ ] Mover `inbox/2026-06-23-pull-stack-madre.md` → `setup/servidor/scripts/`
- [ ] Mover `inbox/2026-06-23-systemd-plan.md` → `setup/servidor/systemd.md`
- [ ] Crear fichas equipos: acer, iphone, mac, varopc
- [ ] Crear `setup/red/tailscale.md`
- [ ] Actualizar README principal con wikilinks

## Wikilinks Obsidian

```
[[setup/servidor/README]] — Madre homelab
[[setup/servidor/docker-stack]] — servicios activos
[[osint/README]] — stack OSINT (parte del servidor)
[[ollama/README]] — modelos locales
```
