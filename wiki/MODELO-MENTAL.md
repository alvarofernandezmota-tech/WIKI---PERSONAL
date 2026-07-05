---
tipo: modelo-mental
author: Alvaro Fernandez Mota
creado: 2026-07-05
actualizado: 2026-07-05 21:56 CEST
ruta: wiki/MODELO-MENTAL.md
tags: [modelo-mental, ecosistema, wiki, navegacion, cognitivo, canon]
status: vigente
---

# 🧠 MODELO MENTAL DEL ECOSISTEMA

> Este documento te ayuda a pensar el ecosistema, no a operar en él.
> Para procedimientos técnicos → [`yggdrasil-dew`](https://github.com/alvarofernandezmota-tech/yggdrasil-dew).

---

## 📚 Cómo pensar DEW

**Dew es el cerebro técnico.** Si algo hace funcionar el sistema — diarios, decisiones, backlog, arquitectura, scripts, canon — vive en Dew. No en WIKI.

> ¿Hace funcionar el sistema? → **Dew**.

Dew es la única fuente de verdad técnica. WIKI consulta a Dew, nunca al revés.

---

## 🖥️ Cómo pensar MADRE

**Madre es el servidor físico.** Madre ejecuta. Madre no documenta. Todo lo que ocurre en Madre se registra en Dew (diarios) o en `madre-config` (scripts/configs).

Si un servicio falla en Madre, el hallazgo va a SecOps (`HAL-XXX`). La decisión técnica va a Dew. La acción operativa va a `madre-config`.

---

## 🛡️ Cómo pensar SECOPS

**SecOps es la capa defensiva.** Cada amenaza es un hallazgo `HAL-XXX`. Cada hallazgo es un issue con evidencia, impacto, plan y cierre. SecOps no improvisa — audita, clasifica y planifica.

SecOps es reactivo (hallazgos) y periódico (auditorías mensuales). No es una lista de tareas — es un proceso continuo.

---

## 🌊 Cómo pensar WIKI

**WIKI es el mapa conceptual.** Si algo te ayuda a pensar o navegar el ecosistema — islas, relaciones, modelo mental — vive en WIKI. WIKI no tiene procedimientos técnicos, ni scripts, ni diarios.

> ¿Te ayuda a pensar o navegar? → **WIKI**.

WIKI es la brujúla. Dew es el motor.

---

## 🏝️ Cómo pensar LAS ISLAS

**Las islas son unidades conceptuales**, no manuales técnicos. Cada isla mapea un área del ecosistema (infra, IA local, seguridad, formación, THDORA...) y enlaza a Dew o al repo técnico correspondiente. Una isla nunca contiene código ni procedimientos paso a paso.

---

## 🤖 Cómo pensar LOS AGENTES

**Los agentes son futuros.** No se implementan hasta que el mapa esté limpio. Su arquitectura está en [`yggdrasil-dew/docs/canon/ARBOL-AGENTES.md`](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/canon/ARBOL-AGENTES.md) como borrador.

Cuando el ecosistema esté ordenado (C + D + E completos), los agentes se diseñan primero en papel, luego en Dew como issues, luego se implementan en Madre.

---

## ⚙️ Cómo pensar LOS WORKFLOWS

**Los workflows se definen en Dew, se ejecutan en Madre.** Un workflow es una secuencia de pasos automatizables. Su diseño (cuándo, por qué, qué hace) vive en Dew. Su código y configuración Docker vive en `madre-config` o en el repo correspondiente.

---

## 🔍 Cómo pensar LA AUDITORÍA

**La auditoría es un proceso continuo, no un evento puntual.** Cada semana se revisan servicios Docker y logs SSH. Cada mes se auditan puertos, credenciales y backups. Cada hallazgo genera un `HAL-XXX` y un plan de remediación. El objetivo no es encontrar problemas — es saber que no los hay.

---

## 📚 Cómo pensar LA FORMACIÓN

**Todo aprendizaje produce un artefacto.** Leer sobre Python async no es formación hasta que hay un apunte en `formacion-tech/`, un ejercicio, o una mejora aplicada en THDORA o Dew. La formación que no produce nada no existe en el ecosistema.

---

## ✅ La regla de oro

> **¿Hace funcionar el sistema?** → [`yggdrasil-dew`](https://github.com/alvarofernandezmota-tech/yggdrasil-dew)
>
> **¿Te ayuda a pensar o navegar?** → [`WIKI---PERSONAL`](https://github.com/alvarofernandezmota-tech/WIKI---PERSONAL) (aquí)
>
> **¿No sabes dónde va?** → Abre un issue en Dew. Siempre.

---

## 🗺️ Mapa rápido del ecosistema

| Repo | Capa | ¿Qué vive aquí? |
|---|---|---|
| `yggdrasil-dew` | Cerebro | Diarios, decisiones, backlog, canon, arquitectura |
| `WIKI---PERSONAL` | Mapa conceptual | Islas, relaciones, modelo mental |
| `madre-config` | Operaciones | Scripts, Docker composes, configs |
| `yggdrasil-secops` | Seguridad | Hallazgos HAL-XXX, auditorías, plan seguridad |
| `THDORA-PERSONAL` | Bot | Código del bot Telegram personal |
| `ollama-stack` | IA local | Stack Ollama + Open WebUI + Qdrant |
| `formacion-tech` | Aprendizaje | Apuntes, ejercicios, proyectos formativos |
| `VIDAPERSONAL` | Personal | Todo lo no técnico |
| `osint-stack` | Red team | OSINT, pentesting, herramientas ofensivas |

---

## 🔗 Conexiones

- → [`yggdrasil-dew/docs/canon/DICCIONARIO.md`](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/canon/DICCIONARIO.md) (vocabulario del ecosistema)
- → [`yggdrasil-dew/docs/canon/MAPA-SYNC.md`](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/canon/MAPA-SYNC.md) (reglas de sincronización)
- → [`yggdrasil-secops/docs/PLAN-SEGURIDAD-ECOSISTEMA.md`](https://github.com/alvarofernandezmota-tech/yggdrasil-secops/blob/main/docs/PLAN-SEGURIDAD-ECOSISTEMA.md)
- → [[islas/INDEX]] (todas las islas del ecosistema)
- → [[relaciones/flujo-documentacion]] (cómo fluye la información)

---

_Creado: 2026-07-05 21:56 CEST · Copilot + Perplexity MCP_
