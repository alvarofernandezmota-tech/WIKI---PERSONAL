---
title: Isla Madre
tipo: isla
creado: 2026-07-09
actualizado: 2026-07-09
status: borrador
ruta: wiki/islas/madre.md
tags: [isla, madre, infra, servidor]
repo_principal: https://github.com/alvarofernandezmota-tech/yggdrasil-secops
depende_de: []
sirve_a: [seguridad, thdora, agentes]
---

# Isla: Madre

> Servidor principal del ecosistema. Todo lo demás corre sobre él.
> Detalles técnicos → `yggdrasil-dew/docs/infra/`

---

## Qué es Madre

Ordenador de sobremesa que actúa como servidor 24/7.
Acceso remoto via **Tailscale** desde cualquier dispositivo.
Todos los bots, servicios Docker y scripts operan desde aquí.

## Estado a 2026-07-09

- HDD: 28.000+ horas 🔴 riesgo de fallo — pendiente smartctl
- Contenedores activos: 7 (watchdog, tailscale_monitor, bots guardiana, tripwire, radar...)
- Acceso: `ssh madre` desde Acer via Tailscale

---

> ⚠️ Isla en borrador — pendiente de desarrollar en AUDIT-002

_2026-07-09 · Perplexity-MCP_
