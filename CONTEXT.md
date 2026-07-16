---
tipo: context
author: Alvaro Fernandez Mota
creado: 2026-07-16
actualizado: 2026-07-16
ruta: CONTEXT.md
tags: [context, ecosistema, wiki]
status: vigente
version: 1
---

# CONTEXT.md — WIKI---PERSONAL

> Contexto del ecosistema Yggdrasil para agentes IA.  
> Leer junto con `AGENT.md` al inicio de cada sesión.

---

## El ecosistema Yggdrasil

Yggdrasil es el sistema operativo personal de Álvaro Fernández Mota.  
No es solo código — es la infraestructura completa de vida técnica y personal.

### Repos canónicos (nombres exactos — no usar aliases nunca)

| Repo | Propósito | Tipo |
|---|---|---|
| `yggdrasil-dew` | Canon técnico, ADRs, decisiones, issues, protocolos | Canon |
| `WIKI---PERSONAL` | Conocimiento estático, mapas, islas del ecosistema | Wiki |
| `yggdrasil-tracking` | Vida personal, diarios, metas, hábitos | Personal |
| `yggdrasil-formacion` | Formación técnica, apuntes, recursos | Formación |
| `madre-config` | IaC de Madre, docker-compose, scripts | Config |
| `THDORA-PERSONAL` | Bot Telegram + agente IA personal | Operativo |
| `yggdrasil-secops` | Seguridad, SecOps, blue team | Operativo |
| `local-brain` | RAG local, Qdrant, embeddings | IA |
| `acer-config` | Dotfiles Arch/Hyprland del laptop secundario | Config |
| `dev-labs` | Sandbox, experimentos, prototipos | Labs |
| `yggdrasil-scripts` | Scripts bash, GitHub Actions, CI | Scripts |

### Hardware del ecosistema

| Nodo | Nombre | Rol |
|---|---|---|
| Servidor principal | Madre | Docker, servicios, RAG, n8n |
| Laptop principal | Theodora | Desarrollo, NixOS |
| Laptop secundario | Acer | Secundario, Arch/Hyprland |
| Móvil | Thea | iPhone — apps, Tailscale |

---

## Este repo en el ecosistema

**Repo:** `WIKI---PERSONAL`  
**Propósito:** Mapa estático del ecosistema — islas, convenciones, conocimiento  
**Posición en el Tridente:** WIKI (vértice de conocimiento y mapa)

### Dependencias directas

| Repo | Tipo de dependencia |
|---|---|
| `yggdrasil-dew` | Canon: todos los protocolos viven en DEW |
| Todos los repos | Cada repo tiene isla en `wiki/islas/` |

---

## Principios del ecosistema

1. **Soberanía digital** — todo en repos propios, nada en SaaS sin alternativa
2. **Transparencia interna** — toda decisión tiene ADR, toda tarea tiene issue
3. **Un solo punto de verdad** — DEW es el canon, wiki es el mapa
4. **Sistemas que perduran** — si no está documentado, no existe
5. **Automatizar lo repetible** — lo manual se ejecuta una vez y se automatiza
6. **Deuda visible** — toda deuda técnica tiene issue abierto en DEW

---

## Convenciones de nombres

| Tipo | Formato | Ejemplo |
|---|---|---|
| Archivos isla | `kebab-case.md` | `ia-local.md`, `dev-labs.md` |
| Archivos canon | `MAYUSCULAS.md` | `AGENT.md`, `INDEX.md` |
| Commits | `tipo(scope): descripción — closes #N` | `feat(wiki): isla orquestador` |

---

_Instanciado desde: `yggdrasil-dew/docs/canon/CONTEXT-template.md`_  
_Última actualización: 2026-07-16_
