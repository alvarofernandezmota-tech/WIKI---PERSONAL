---
tags: [filosofia, sistema, principios, identidad, ingenieria, python, ia-local]
fecha-creacion: 2026-06-20
fecha-actualizacion: 2026-06-23
migrado-de: personal/00_sistema/sistema-filosofia.md
version: 3.0
---

# 🧭 Filosofía del Sistema

> *"Áquí se evoluciona. Se aprende. Se reflexiona. Se crece. Se hace caos. Se ordena. Se derrumba todo. Y se vuelve a empezar — pero desde un piso más arriba que antes."

---

## El Ciclo — La ley fundamental

```
Se evoluciona → Se aprende → Se reflexiona → Se crece
      ↑                                            ↓
Se vuelve a empezar                       Se hace caos
  (un piso más arriba)                          ↓
      ↑                                    Se ordena
Se derrumba todo ←────────────── Se derrumba todo
```

**El caos no es un fallo del sistema. Es parte del sistema.**

---

## Los 5 principios del sistema

### 1. Las cosas se hacen haciendo
La planificación es una herramienta, no un fin.
> *"Producción primero, perfección después."

### 2. Todo es un proceso
No hay saltos. No hay atajos. El ritmo es más importante que el sprint.
> *"Un commit imperfecto que existe vale más que una arquitectura perfecta que no existe todavía."

### 3. El foco está en uno mismo
Analizarse. Evaluarse honestamente. Compararse con quien se era ayer, no con otros.

### 4. Energía limpia
Este proyecto no compite con nadie. Construir sin destruir. Avanzar sin pisar.

### 5. Tres pilares de cada día

| Pilar | Qué significa |
|---|---|
| 🔎 Curiosidad | Algo que no sabías antes de ese día |
| 🪟 Introspección | Algo honesto sobre cómo estás |
| 🏗️ Avance | Aunque sea pequeño — un commit, una idea |

---

## Principios de Ingeniería — Antes de hacer cualquier cosa

> Aplica a todo: crear un agente, escribir un script, documentar un archivo,
> refactorizar código, instalar una herramienta, añadir una ficha al repo.
> **Si no puedes responder las 4 preguntas — no se hace.**

### Las 4 preguntas obligatorias

```
1. ¿QUÉ problema concreto existe ahora mismo?
   (específico y real — no teórico)

2. ¿POR QUÉ hay que resolverlo ahora y no después?
   (si no tiene urgencia real, va al backlog)

3. ¿CÓMO se resuelve de la forma más simple posible?
   (la solución más sencilla que funcione — no la más elegante)

4. ¿CÓMO se verifica que está resuelto?
   (criterio de éxito concreto y medible)
```

### Anti-patrones del sistema

> Cosas que parecen productivas pero no lo son:

- **Documentar por documentar** — crear fichas sin información real o útil
- **Construir herramientas que nadie usa** — automatizar algo que no duele
- **Arquitectura prematura** — diseñar sistemas complejos antes de tener el problema
- **Mover sin leer** — reorganizar archivos sin verificar su contenido
- **Irse por las ramas** — explorar posibilidades en lugar de resolver lo concreto
- **Perfeccionar antes de funcionar** — pulir algo que aún no hace lo básico

### El criterio de un agente o herramienta Python

Antes de escribir una línea de código:

```
¿Lo hago a mano ahora mismo y duele?
  Sí → tiene sentido automatizar
  No → no hace falta el agente

¿El resultado mejora algo concreto del ecosistema?
  Sí → adelante
  No → es un juguete — va al backlog o se descarta

¿Puedo construirlo en menos de 100 líneas de Python?
  Sí → ésa es la versión 1.0
  No → estás complicando algo simple
```

### Principio de IA local

> La IA local no es un juguete — es infraestructura.
> Cada agente que corre en Madre resuelve una necesidad real del ecosistema.
> Un agente que nadie usa es peor que no tenerlo: es deuda técnica.

```
Primer criterio:  ¿Hay una necesidad real y concreta?
Segundo criterio: ¿El LLM local añade valor que no tiene un script puro?
Tercer criterio:  ¿Cabe en el ecosistema actual sin romper nada?
```

---

## Regla de oro — Repos y documentación

> Añadida en v3.0 · 2026-06-23 — Ingeniero de software bien organizado

### Separación de responsabilidades documental

```
Repo técnica (GitHub)     ← Código, docker-compose, README técnico
Cerebro (yggdrasil-dew)   ← Conocimiento, decisiones, estado, wikilinks
```

### Las 3 leyes de las repos

**Ley 1 — Nunca duplicar, siempre enlazar**
> Si algo está en la repo técnica, el cerebro lo referencia con wikilink.
> No se copia el contenido — se enlaza.

**Ley 2 — Todo nuevo entra por inbox**
> Cualquier idea, decisión, conocimiento o tarea entra primero en `inbox/`.
> Desde inbox se procesa y se mueve a su lugar definitivo.
> El inbox es la puerta de entrada de todo el sistema.

**Ley 3 — Infraestructura ≠ Producto**
> Un servidor no es un proyecto. Un proyecto corre sobre el servidor.
> Homelab vive en `setup/servidor/`.
> Productos viven en `proyectos/` con su repo GitHub propia.

### Patrón de enlace repo técnica ↔ cerebro

Cada proyecto con Docker tiene:
```
GitHub repo propia:
  README.md          ← instalación, uso rápido
  docker-compose.yml ← despliegue
  docs/              ← docs técnicas internas

yggdrasil-dew:
  proyectos/NOMBRE/README.md   ← estado + [[enlace-repo-github]]
  ollama/ o agentes/ o osint/  ← conocimiento transversal
  setup/servidor/              ← qué corre en Madre y cómo
```

---

## Frases fundacionales

- *"El orden no se construye en un día, pero sí se decide en uno."
- *"El ritmo es más importante que el sprint."
- *"Producción primero, perfección después."
- *"El caos es necesario para que haya orden."
- *"Cimientos en abril. Construcción en mayo. Sistema en junio."
- *"Si no puedes responder las 4 preguntas — no se hace."
- *"La solución más simple que funcione siempre gana."
- *"Un agente que nadie usa es peor que no tenerlo."
- *"Nunca duplicar — siempre enlazar."
- *"Todo nuevo entra por inbox."
- *"Infraestructura ≠ Producto."

---

## Changelog

| Versión | Fecha | Cambios |
|---|---|---|
| 1.0 | 2026-06-20 | Filosofía base — 5 principios, el ciclo, frases fundacionales |
| 2.0 | 2026-06-22 | Añadidos principios de ingeniería: 4 preguntas, anti-patrones, criterio agentes Python, principio IA local |
| 3.0 | 2026-06-23 | Regla de oro repos: 3 leyes, patrón enlace técnico-cerebro, Infraestructura ≠ Producto |

---
_Ver también: [[yo/perfil]] · [[HOME]] · [[inbox/README]] · [[inbox/MASTER-PENDIENTES]]_
