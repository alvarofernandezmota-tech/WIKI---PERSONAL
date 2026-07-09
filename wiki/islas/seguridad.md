---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-10
actualizado: 2026-07-10
ruta: wiki/islas/seguridad.md
tags: [isla, seguridad, secops, osint, hal]
status: borrador
repos: [yggdrasil-secops, osint-stack]
---

# Isla: Seguridad

> Modelo de amenazas personal, SecOps activo y herramientas OSINT.
> Todo lo operativo vive en `yggdrasil-secops` (privado).

---

## Modelo de defensa

```
Perimetro externo
    └── Router — cerrar puertos, no FTP/Telnet abiertos
    └── Tailscale VPN — acceso remoto cifrado

Madre (servidor)
    └── SpiderFoot — OSINT y reconocimiento
    └── Kali VNC — laboratorio pentest
    └── Guardian Bot — alertas Telegram
    └── Network Radar — detección de intrusos

Código
    └── Gitleaks CI — secretos en repos
    └── Secret-scanning — IPs + emails + tokens
```

---

## Issues críticos abiertos

| Issue | Descripción | Prioridad |
|-------|-------------|----------|
| [#15](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/15) | Puerto 21 FTP abierto | 🔴 CRÍTICO |
| [#39](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/39) | Confirmar gitleaks en push | 🟡 ALTA |
| [#38](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/38) | Secret-scanning ampliar (IPs + emails) | 🟡 ALTA |
| [#37](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/37) | Auditoría secops Fase 1 | 🟡 ALTA |

---

## Links

→ [yggdrasil-secops](https://github.com/alvarofernandezmota-tech/yggdrasil-secops)
→ [osint-stack](https://github.com/alvarofernandezmota-tech/osint-stack)

_Creado: 2026-07-10 · Perplexity-MCP_
