---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-09
actualizado: 2026-07-10
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
        VIDAPERSONAL
        (vida personal,
         planifica la semana,
         diarios, hábitos)
              ▲
             / \
            /   \
      DEW ◄─────► WIKI (yggdrasil-wiki)
  (ejecuta,       (mapas conceptuales,
   issues,         cómo enlaza todo,
   ADRs, CI)       estructura repos)
```

**Nunca duplicar — siempre enlazar.**

---

## Las 18 repos del ecosistema

### Núcleo (triángulo)

| Repo | Rol | Visibilidad |
|------|-----|-------------|
| `VIDAPERSONAL` | Vida personal, diarios, tracking | 🔒 Privado |
| `yggdrasil-dew` | Cerebro técnico, issues, ADRs, CI | Público |
| `yggdrasil-wiki` | Mapas conceptuales del ecosistema | 🔒 Privado |

### Infra

| Repo | Rol | Isla WIKI |
|------|-----|-----------|
| `madre-config` | Servidor Madre — HP Ubuntu, 16 servicios Docker | [madre.md](madre.md) |
| `acer-config` | Dotfiles Acer — Arch Linux, Hyprland, Neovim | [acer.md](acer.md) |
| `ollama-stack` | LLMs locales, Open WebUI, LiteLLM, Qdrant | [ia-local.md](ia-local.md) |
| `local-brain` | Ollama + pgvector + RAG + embeddings | [ia-local.md](ia-local.md) |
| `osint-stack` | SpiderFoot, pipelines OSINT | [seguridad.md](seguridad.md) |

### Seguridad

| Repo | Rol | Isla WIKI |
|------|-----|-----------|
| `yggdrasil-secops` | SecOps, canary tokens, tripwires | [seguridad.md](seguridad.md) |

### Proyectos activos

| Repo | Rol | Isla WIKI |
|------|-----|-----------|
| `THDORA-PERSONAL` | Bot Telegram + FastAPI + Ollama | [thdora.md](thdora.md) |
| `thea-ia` | Thea IA core (Python) | [thea.md](thea.md) |
| `formacion-tech` | Apuntes, cursos, laboratorios | [formacion.md](formacion.md) |
| `ai-toolkit` | Stack AI open source (público) | [ia-local.md](ia-local.md) |
| `investigacion-ia` | PoCs IA, arquitecturas agentes | [labs.md](labs.md) |
| `dev-labs` | Sandbox desarrollo web/CLI | [labs.md](labs.md) |

### Menores

| Repo | Rol |
|------|-----|
| `image-calculator` | App Python OCR — proyecto terminado |
| `impresion-3d` | Anycubic Photon V1 — diarios de sesión |
| `alvarofernandezmota-tech` | Profile README público |

---

## Estado a 2026-07-10

- ✅ Canon del ecosistema creado — `VIDAPERSONAL/00_sistema/ECOSISTEMA-CANON.md`
- ✅ Triángulo definido y documentado
- ✅ 18 repos auditadas
- ✅ WIKI renombrada a `yggdrasil-wiki`
- ✅ Islas conceptuales completas
- 🔴 HDD Madre 28k+ horas — Issue #31 DEW
- 🔴 Puerto 21 FTP abierto — Issue #15 DEW
- 🔴 IaC Docker madre sin versionar — Issue pendiente DEW

---

## Links

→ [yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew)
→ [ECOSISTEMA-CANON.md](https://github.com/alvarofernandezmota-tech/VIDAPERSONAL/blob/main/00_sistema/ECOSISTEMA-CANON.md)
→ [Issues DEW abiertos](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues)

_Actualizado: 2026-07-10 · Perplexity-MCP_
