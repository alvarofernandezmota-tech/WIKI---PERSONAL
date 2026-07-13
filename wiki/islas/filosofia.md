---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-13
actualizado: 2026-07-13
ruta: wiki/islas/filosofia.md
tags: [isla, filosofia, principios, valores, cosmovision, yggdrasil]
status: vigente
---

# 🌱 Isla Filosofía

> El por qué detrás del sistema. Filosofía no tiene repo — es el marco mental que da sentido a todo lo demás.
> Cuando una decisión técnica no está clara, la respuesta está aquí.

---

## Por qué existe esta isla

Yggdrasil no es solo infraestructura. Es un sistema de pensamiento materializado en código, documentación y hábitos. Sin una filosofía explícita, las decisiones se toman por inercia. Con ella, se toman con intención.

---

## Principios fundacionales

### 1. Soberanía digital
El sistema corre en hardware propio. Los datos no salen del ecosistema salvo decisión consciente. Dependencia cero de cloud externo para funciones críticas.

### 2. Transparencia interna
Todo estado del sistema es legible. Si algo no puede expresarse en un `ESTADO-SISTEMA.md`, es que no está bien entendido. La opacidad es deuda técnica.

### 3. Un solo punto de verdad
Cada pieza de información vive en exactamente un lugar. Las copias son error. Los índices son punteros, no duplicados.

### 4. Sistemas que perduran
El sistema debe funcionar sin memoria fresca. Si desapareces 3 meses y vuelves, debe ser recuperable en 30 minutos leyendo `HOME.md` y `ESTADO-SISTEMA.md`.

### 5. Automatizar lo repetible, pensar lo único
Lo que se hace más de 3 veces se automatiza. El tiempo cognitivo se reserva para decisiones que no pueden delegarse.

### 6. Deuda visible
Los issues abiertos no son fracasos — son deuda documentada. Una deuda invisible es peor que una deuda alta. El backlog honesto es salud, no vergüenza.

---

## Cosmovisión Yggdrasil

Yggdrasil (el árbol del mundo en mitología nórdica) conecta los nueve mundos. El ecosistema homónimo conecta las "islas" de una vida: trabajo, conocimiento, infraestructura, seguridad, vida personal. No son silos — son ramas del mismo árbol.

Las **islas** son la metáfora operativa: cada dominio es autónomo pero no aislado. Las dependencias entre islas son explícitas (ver [MAPA-ISLAS-DEPENDENCIAS](../../docs/islas/MAPA-ISLAS-DEPENDENCIAS.md)).

---

## Decisiones derivadas de estos principios

| Principio | Decisión concreta |
|---|---|
| Soberanía digital | Madre en casa, no en AWS/GCP |
| Un solo punto de verdad | Índice de islas solo en WIKI, no duplicado en DEW |
| Sistemas que perduran | Canon obligatorio: ESTADO-SISTEMA.md actualizado cada sesión |
| Automatizar lo repetible | CI valida frontmatter, secretos y markdown en cada push |
| Deuda visible | Cada hallazgo = issue en GitHub, nunca en una nota suelta |

---

## Relación con ADRs

Los principios de esta isla son el "por qué". Las ADRs ([DEW docs/adr/](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/tree/main/docs/adr)) son el "cómo" — decisiones concretas derivadas de estos principios.

Cuando una ADR parezca arbitraria, la justificación está en alguno de estos seis principios.

---

## Issues relacionados

- [DEW #41](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/41) — Diagrama C4 (materializa el principio de transparencia interna)
- [DEW #18](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/18) — Gobernanza (materializa "sistemas que perduran")

---

_Creado: 2026-07-13 · Perplexity-MCP_
