# 🗺️ WIKI---PERSONAL

> Mapa conceptual del ecosistema personal de Alvaro Fernandez Mota.
> **WIKI = QUÉ existe y POR QUÉ. Nunca CÓMO ejecutar.**

---

## ¿Qué es esto?

Este repo es la wiki personal del ecosistema Yggdrasil — un conjunto de repos, servicios y herramientas que forman una plataforma de desarrollo, seguridad y automatización personal.

La wiki contiene **mapas conceptuales, islas temáticas y relaciones** entre dominios. No contiene scripts, configuraciones ni procedimientos operativos.

---

## 🌊 Islas del ecosistema

| Isla | Descripción | Repo operativo |
|---|---|---|
| [🖥️ Infraestructura](wiki/islas/infra.md) | Servidores, red, Platform Stack | [`madre-config`](https://github.com/alvarofernandezmota-tech/madre-config) |
| [🛡️ Seguridad](wiki/islas/seguridad.md) | Capas de defensa, HAL, auditorías | [`yggdrasil-secops`](https://github.com/alvarofernandezmota-tech/yggdrasil-secops) |
| [🧠 Cerebro](wiki/islas/cerebro.md) | Automatización, conocimiento, desarrollo | [`yggdrasil-dew`](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) |
| [🤖 THDORA](wiki/islas/thdora.md) | Bot Telegram personal | [`thdora`](https://github.com/alvarofernandezmota-tech/thdora) |
| [🧪 Labs](wiki/islas/labs.md) | Pentesting, OSINT, investigación | uso puntual |
| [🤖 IA Local](wiki/islas/ia-local.md) | Ollama, modelos, inferencia local | [`madre-config`](https://github.com/alvarofernandezmota-tech/madre-config) |
| [📚 Formación](wiki/islas/formacion.md) | Aprendizaje, cursos, skills | — |

---

## 🗂️ Estructura

```
wiki/
├── CONVENCIONES.md     ← normas de este repo
├── MODELO-MENTAL.md    ← cómo funciona el sistema
├── islas/              ← una isla por dominio
├── relaciones/         ← conexiones entre islas
└── agentes/            ← mapa de agentes (conceptual)
```

---

## 🔗 Repos del ecosistema

| Repo | Propósito |
|---|---|
| [`WIKI---PERSONAL`](https://github.com/alvarofernandezmota-tech/WIKI---PERSONAL) | Este repo — mapa conceptual |
| [`yggdrasil-dew`](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) | Cerebro técnico: ADRs, canon, diarios |
| [`madre-config`](https://github.com/alvarofernandezmota-tech/madre-config) | Config y scripts del servidor Madre |
| [`yggdrasil-secops`](https://github.com/alvarofernandezmota-tech/yggdrasil-secops) | Seguridad: HAL issues, auditorías |
| [`thdora`](https://github.com/alvarofernandezmota-tech/thdora) | Bot Telegram personal |

---

## 📚 Normas

- Normas de este repo → [`wiki/CONVENCIONES.md`](wiki/CONVENCIONES.md)
- Normas globales del ecosistema → [`yggdrasil-dew/NORMAS.md`](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/NORMAS.md)
