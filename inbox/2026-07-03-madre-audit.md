---
tipo: doc
author: Perplexity-MCP <alvarofernandezmota@gmail.com>
creado: 2026-07-03 02:19 CEST
actualizado: 2026-07-03 02:19 CEST
ruta: inbox/2026-07-03-madre-audit.md
tags: [inbox, madre, audit, ssh, docker]
status: borrador
---

# INBOX — Audit Madre 2026-07-03

> Entrada de inbox generada automáticamente por Perplexity-MCP durante sesión nocturna.
> **Procesar antes de:** 2026-07-10
> **Destino definitivo:** `infra/madre/estado-actual.md` (ya creado) + issues GitHub

---

## Qué pasó

Sesión desde Thdora → SSH madre → audit manual del sistema a las 02:05 CEST.
Se documentó el estado completo de red, SSH y Docker en `infra/madre/estado-actual.md`.

## Hallazgos para procesar

- [ ] **2 contenedores unhealthy**: `log_guardian_bot`, `yggdrasil_watchdog` → crear issue `bug` + `fase-2`
- [ ] **ethernet DOWN**: `enp4s0` sin señal → confirmar si es normal (WiFi intencionado) o problema
- [ ] **PermitRootLogin** no declarado en sshd_config → añadir `no` explícito → issue `security`
- [ ] **6 bridges Docker** sin documentar → mapear qué stack usa cada red → issue `docs`
- [ ] **Shellfish iPhone** pendiente de configurar y probar → `mobile-ok`

## Acciones inmediatas

```bash
# Ver logs unhealthy:
docker logs log_guardian_bot
docker logs yggdrasil_watchdog

# Añadir PermitRootLogin:
echo 'PermitRootLogin no' | sudo tee -a /etc/ssh/sshd_config
sudo systemctl reload sshd
```

---
_Perplexity-MCP · inbox · procesar pronto_
