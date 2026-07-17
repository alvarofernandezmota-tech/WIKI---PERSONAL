---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-09
actualizado: 2026-07-18 01:50 CEST
ruta: wiki/islas/ecosistema.md
tags: [isla, ecosistema, repos, gobernanza, yggdrasil, triangulo]
status: vigente
---

# Isla: Ecosistema Yggdrasil

> Mapa conceptual del ecosistema completo.
> Los detalles técnicos y los issues viven en DEW.

---

## El triángulo del ecosistema

```
        yggdrasil-tracking
        (diarios personales,
         tracking semanal,
         hábitos, vida)
              ▲
             / \
            /   \
      DEW ◄─────► WIKI (WIKI---PERSONAL)
  (ejecuta,       (mapas conceptuales,
   issues,         cómo enlaza todo,
   ADRs, CI)       islas del ecosistema)
```

**Nunca duplicar — siempre enlazar.**

---

## Repos del ecosistema — Estado F27 (2026-07-18)

### Núcleo

| Repo | Rol | Isla WIKI |
|---|---|---|
| `yggdrasil-dew` | Canon técnico, issues, ADRs, protocolos | — |
| `WIKI---PERSONAL` | Mapas conceptuales, islas del ecosistema | — |
| `yggdrasil-tracking` | Diarios personales, tracking, hábitos | [tracking.md](tracking.md) |
| `yggdrasil-orquestador` | Contexto cross-repo para agentes IA | [orquestador.md](orquestador.md) |

### Infraestructura

| Repo | Rol | Isla WIKI |
|---|---|---|
| `madre-config` | Servidor Madre — Arch Linux, 23 contenedores Docker | [infra.md](infra.md) |
| `acer-config` | Dotfiles Acer — Arch Linux + Hyprland | [acer.md](acer.md) |
| `ollama-stack` | Ollama + Open WebUI + LiteLLM + Qdrant | [ia-local.md](ia-local.md) |
| `local-brain` | RAG pipeline + Qdrant vector DB | [ia-local.md](ia-local.md) |

### Seguridad

| Repo | Rol | Isla WIKI |
|---|---|---|
| `yggdrasil-secops` | SecOps, canary tokens, Wazuh, Suricata | [seguridad.md](seguridad.md) |

### Proyectos activos

| Repo | Rol | Isla WIKI |
|---|---|---|
| `THDORA-PERSONAL` | Bot Telegram personal | [thdora.md](thdora.md) |
| `yggdrasil-formacion` | Apuntes, cursos, laboratorios | [formacion.md](formacion.md) |
| `yggdrasil-scripts` | Scripts de automatización del ecosistema | [scripts.md](scripts.md) |

### Laboratorios / investigación

| Repo | Rol | Isla WIKI |
|---|---|---|
| `investigacion-ia` | PoCs IA, arquitecturas agentes | [ia-local.md](ia-local.md) |
| `dev-labs` | Sandbox desarrollo web/CLI | [dev-labs.md](dev-labs.md) |

### Menores / archivados

| Repo | Rol |
|---|---|
| `image-calculator` | App Python OCR — proyecto terminado |
| `impresion-3d` | Anycubic Photon V1 — diarios de sesión |
| `alvarofernandezmota-tech` | Profile README público |

---

## Islas de la WIKI — Estado F27

| Isla | Status | Última actualización |
|---|---|---|
| [ecosistema.md](ecosistema.md) | ✅ Vigente | 2026-07-18 |
| [infra.md](infra.md) | ✅ Auditado | 2026-07-18 |
| [ia-local.md](ia-local.md) | ✅ Auditado | 2026-07-18 |
| [orquestador.md](orquestador.md) | ✅ Auditado | 2026-07-18 |
| [thdora.md](thdora.md) | ✅ Creada F24b | 2026-07-18 |
| [seguridad.md](seguridad.md) | ✅ Auditado | 2026-07-18 |
| [mcp.md](mcp.md) | ✅ Completo | 2026-07-18 |
| [tracking.md](tracking.md) | ✅ Completo | 2026-07-18 |
| [acer.md](acer.md) | ✅ Completo | — |
| [formacion.md](formacion.md) | 🟡 Parcial | — |
| [filosofia.md](filosofia.md) | 🟡 Parcial | — |
| [impresion3d.md](impresion3d.md) | 🟡 Parcial | — |
| [conocimiento.md](conocimiento.md) | 🟡 Parcial | — |
| [dev-labs.md](dev-labs.md) | 🟡 Parcial | — |
| [scripts.md](scripts.md) | 🟡 Parcial | — |
| [vida.md](vida.md) | 🟡 Parcial | — |
| [agentes-personales.md](agentes-personales.md) | ✅ Redirect → thdora.md | 2026-07-18 |
| [madre.md](madre.md) | ✅ Redirect → infra.md | 2026-07-18 |
| [investigacion-ia.md](investigacion-ia.md) | ✅ Redirect → ia-local.md | 2026-07-18 |
| [ollama-stack.md](ollama-stack.md) | ✅ Redirect → ia-local.md | 2026-07-18 |
| [osint.md](osint.md) | ✅ Redirect → seguridad.md | 2026-07-18 |
| [thea.md](thea.md) | ✅ Redirect → thdora.md | 2026-07-18 |

---

## Alertas activas del ecosistema

| Prioridad | Alerta | Issue |
|---|---|---|
| 🔴 P0 | FTP puerto 21 EXPUESTO router Digi | [#15](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/15) |
| 🔴 P1 | THDORA caído — token caducado | [#74](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/74) |
| 🔴 P2 | yggdrasil-mcp caído puerto 3000 | [#75](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/75) |
| ⚠️ | HDD Madre 28k+ horas | [#31](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/31) |

---

## Links clave

→ [yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew)
→ [MASTER-PENDIENTES.md](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/MASTER-PENDIENTES.md)
→ [ESTADO-SISTEMA.md](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/ESTADO-SISTEMA.md)
→ [Issues DEW abiertos](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues)

---

_Actualizado: 2026-07-18 01:50 CEST · F27 auditoría completa · Perplexity-MCP_
