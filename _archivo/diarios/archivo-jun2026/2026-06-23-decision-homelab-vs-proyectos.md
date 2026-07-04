---
tags: [arquitectura, decision, homelab, proyectos, ingenieria-software]
fecha: 2026-06-23
estado: decision-tomada
tipo: adr
ruta-obsidian: inbox/2026-06-23-decision-homelab-vs-proyectos.md
---

# ADR — Homelab vs Proyectos

> Architecture Decision Record · Sesión 2026-06-23

## Contexto

Hasta ahora `proyectos/batcueva/` existía como si fuera un proyecto de software. Pero batcueva es el nombre del homelab — la infraestructura completa de Madre. Mezclar infraestructura con proyectos es un anti-patrón de ingeniería.

## Decisión

**Separar radicalmente homelab de proyectos**, igual que en ingeniería de software se separa infraestructura de producto.

## Definiciones

### 🏠 Homelab (infraestructura)
> *Cómo tienes montado tu mundo técnico personal.*
- Es el ecosistema, no un producto
- No tiene releases ni versiones de negocio
- Evoluciona continuamente
- Nombre: **Batcueva** — el homelab completo
- Documentación vive en: `setup/servidor/`

### 🚀 Proyectos (productos)
> *Cosas que construyes, que tienen objetivo, código y valor entregable.*
- Tienen repo propia en GitHub
- Tienen README, releases, objetivos claros
- Se pueden pausar, terminar, publicar
- Documentación vive en: `proyectos/`

## Estructura resultante

```
yggdrasil-dew/
  setup/
    servidor/          ← Madre, Docker, Ollama, OSINT, RAG, Qdrant
    equipos/           ← Acer, iPhone, Mac, Varopc
    red/               ← Tailscale, hotspot, red local
    scripts/           ← pull-stack.sh, automatizaciones infra
  ollama/              ← modelos locales + RAG (doc técnica)
  agentes/             ← IAs externas con API
  osint/               ← stack OSINT del servidor (parte del homelab)
  proyectos/
    thdora/            ← bot Telegram + FastAPI ✔️ repo propia
    local-brain/       ← cerebro IA local ✔️ pendiente repo
    chatbot-control/   ← chatbot control ✔️ pendiente repo
    terminal-ia/       ← terminal IA ✔️ pendiente repo
    image-calculator/  ← ✔️ repo propia
    impresion-3d/      ← ✔️ repo propia
```

## Cambios a ejecutar

- [ ] Mover contenido `proyectos/batcueva/` → `setup/servidor/batcueva/`
- [ ] `osint/` referenciada desde `setup/servidor/` con wikilink
- [ ] `setup/scripts/` ← mover `pull-stack.sh` y scripts de infra
- [ ] Crear repos GitHub para: `local-brain`, `chatbot-control`, `terminal-ia`
- [ ] `proyectos/` solo contiene productos con repo propia

## Principio ingeniería de software aplicado

> **Infraestructura ≠ Producto**
> Un servidor no es un proyecto. Un proyecto corre sobre el servidor.
> Confundirlos genera deuda técnica documental.

## Referencias
- [[setup/servidor/README]] — Madre homelab
- [[proyectos/README]] — Proyectos activos
- [[ECOSISTEMA]] — Visión global
