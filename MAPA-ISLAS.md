---
tipo: mapa
author: Alvaro Fernandez Mota <alvarofernandezmota@gmail.com>
creado: 2026-06-12 00:00 CEST
actualizado: 2026-07-05 13:27 CEST
ruta: MAPA-ISLAS.md
tags: [mapa, ecosistema, islas, repos, organizacion]
status: vigente
---

# 🗺️ Mapa de Islas — Ecosistema Yggdrasil

> Mapa conceptual completo del ecosistema.
> Para las reglas técnicas y jerarquía de repos → ver `yggdrasil-dew/ECOSYSTEM-ARCHITECTURE.md`

Última actualización: 2026-07-05

---

## 🧠 CEREBRO

> El centro de mando. De aquí nacen todas las reglas y toda la documentación.

| Repo | Qué es | Visibilidad |
|---|---|---|
| [`yggdrasil-dew`](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) | Ley máxima del ecosistema. Diarios, arquitectura, roadmap, convenciones, pendientes. | 🌐 Público |
| [`alvarofernandezmota-tech`](https://github.com/alvarofernandezmota-tech/alvarofernandezmota-tech) | Profile README público de GitHub. Presentación profesional. | 🌐 Público |

---

## 🗺️ CONOCIMIENTO PERSONAL

> Lo que eres, lo que tienes, cómo vives. No es técnico — es personal.

| Repo | Qué es | Visibilidad |
|---|---|---|
| [`WIKI---PERSONAL`](https://github.com/alvarofernandezmota-tech/WIKI---PERSONAL) | Mapa conceptual del ecosistema. Hardware, contexto personal, base de conocimiento. Este repo. | 🔒 Privado |
| [`VIDAPERSONAL`](https://github.com/alvarofernandezmota-tech/VIDAPERSONAL) | Vida personal. Finanzas, gym, salud, diario personal, ideas, escritura. | 🔒 Privado |

---

## 📚 FORMACIÓN & I+D

> Lo que estás aprendiendo y explorando. Dónde estás en cada área.

| Repo | Qué es | Visibilidad |
|---|---|---|
| [`formacion-tech`](https://github.com/alvarofernandezmota-tech/formacion-tech) | Apuntes técnicos organizados por área: terminal, git, docker, linux, seguridad, IA, redes, python. Estado de aprendizaje en cada punto. | 🔒 Privado |
| [`investigacion-ia`](https://github.com/alvarofernandezmota-tech/investigacion-ia) | PoCs de IA, experimentos, arquitecturas de agentes, flujos experimentales. Banco de pruebas antes de pasar a producción. | 🔒 Privado |

---

## 🖥️ INFRAESTRUCTURA — MADRE

> Los dos equipos del ecosistema y toda su configuración.
> Los Dockers son parte de cada proyecto — cada repo gestiona los suyos.

| Repo | Qué es | Visibilidad |
|---|---|---|
| [`madre-config`](https://github.com/alvarofernandezmota-tech/madre-config) | Servidor HP Ubuntu. Docker Compose de todos los servicios, configs SSH, scripts de sesión, seguridad del servidor, monitoreo. | 🔒 Privado |
| [`acer-config`](https://github.com/alvarofernandezmota-tech/acer-config) | Dotfiles del Acer. Arch Linux, Hyprland, zsh, Neovim, herramientas CLI. | 🔒 Privado |

**Madre:** IP Tailscale `100.91.112.32` · SSH: `ssh madre` · Docker en puertos definidos por servicio.

---

## 🤖 IA LOCAL

> Los modelos corriendo y la memoria del ecosistema. Base de todo lo que usa IA.

| Repo | Qué es | Visibilidad |
|---|---|---|
| [`ollama-stack`](https://github.com/alvarofernandezmota-tech/ollama-stack) | Modelos LLM locales corriendo en Madre. Ollama, Open WebUI, LiteLLM gateway. Sirve modelos a THDORA y a todo el ecosistema. | 🔒 Privado |
| [`local-brain`](https://github.com/alvarofernandezmota-tech/local-brain) | Memoria y conocimiento del ecosistema. RAG, embeddings, Qdrant vectorial, pgvector. Base cognitiva para los agentes. | 🔒 Privado |

---

## 🦾 THDORA

> El bot personal. Interfaz de voz y texto con el ecosistema desde Telegram.

| Repo | Qué es | Visibilidad |
|---|---|---|
| [`THDORA-PERSONAL`](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL) | Bot Telegram personal. FastAPI + Ollama local + memoria. Gestiona citas, recordatorios, consultas. Evoluciona hacia agente autónomo. | 🌐 Público |

---

## 🛡️ SEGURIDAD

> Dos capas distintas: defender el ecosistema y atacar/investigar lo externo.

| Repo | Qué es | Visibilidad |
|---|---|---|
| [`yggdrasil-secops`](https://github.com/alvarofernandezmota-tech/yggdrasil-secops) | **Defensivo.** Seguridad del ecosistema propio. Hallazgos (HAL-XXX), blue team, auditorías, canary tokens, tripwires. | 🔒 Privado |
| [`osint-stack`](https://github.com/alvarofernandezmota-tech/osint-stack) | **Ofensivo/Investigador.** Herramientas OSINT: Spiderfoot, pipelines de investigación, reconocimiento. Para pentesting y auto-OSINT. | 🔒 Privado |

---

## 🧪 LABS

> Zona libre. Aquí se prueba antes de crear un repo propio.

| Repo | Qué es | Visibilidad |
|---|---|---|
| [`dev-labs`](https://github.com/alvarofernandezmota-tech/dev-labs) | Sandbox de desarrollo. Prototipos web, scripts sueltos, utilidades CLI, experimentos de código. Si algo crece, pasa a su propio repo. | 🔒 Privado |

**Criterio para salir de dev-labs** → repo propio cuando: +20 commits, deploy independiente, o lo usa otro proyecto.

---

## 📦 ARCHIVADOS

> Repos que cumplieron su función. Se mantienen en lectura por valor histórico o de código.

| Repo | Motivo archivo | Sucesor |
|---|---|---|
| [`thea-ia`](https://github.com/alvarofernandezmota-tech/thea-ia) | Proyecto original de IA personal. Evolucionó y fue delegado. | `THDORA-PERSONAL` |
| [`ai-toolkit`](https://github.com/alvarofernandezmota-tech/ai-toolkit) | Intento de stack IA local. Reemplazado por stack más maduro. | `ollama-stack` |
| [`image-calculator`](https://github.com/alvarofernandezmota-tech/image-calculator) | Proyecto Python OCR cerrado. | — |
| [`impresion-3d`](https://github.com/alvarofernandezmota-tech/impresion-3d) | Proyecto Anycubic Photon cerrado. | — |

---

## 🔗 Relaciones entre islas

```
yggdrasil-dew (ley máxima)
├── → madre-config       (el servidor que ejecuta todo)
├── → yggdrasil-secops   (audita el ecosistema)
├── → THDORA-PERSONAL    (interfaz humana)
└── → WIKI---PERSONAL    (mapa conceptual — este archivo)

madre-config
├── ejecuta → ollama-stack
├── ejecuta → local-brain
└── ejecuta → THDORA-PERSONAL

THDORA-PERSONAL
├── usa → ollama-stack (modelos)
└── usa → local-brain (memoria RAG)

osint-stack
└── alimenta → yggdrasil-secops (hallazgos OSINT)
```

---

## 🏷️ Sistema de etiquetas

Para Issues y PRs en todos los repos:

```
capa:cerebro      capa:conocimiento   capa:formacion
capa:infra        capa:ia-local       capa:thdora
capa:seguridad    capa:labs

tipo:bug          tipo:feature        tipo:doc
tipo:deuda        tipo:config         tipo:hallazgo

prioridad:alta    prioridad:media     prioridad:baja
```

---

_Actualizado: 2026-07-05 13:27 CEST · Perplexity-MCP_
