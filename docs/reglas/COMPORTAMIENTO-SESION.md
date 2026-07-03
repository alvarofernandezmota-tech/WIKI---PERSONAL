---
fecha_creacion: "2026-07-03"
tags: ["regla", "sesion", "comportamiento", "patron", "hiperfoco"]
version: "1.0"
---

# Reglas de comportamiento en sesión

Derivadas de observación real de sesiones. No son teoría — son patrones detectados.

---

## PATRÓN DETECTADO: Hiperfoco de madrugada

**Síntomas:**
- Cambio de objetivo cada 2-5 minutos
- Pegar texto de instrucciones en la terminal como comandos
- Querer hacer todo a la vez (bots + Docker + fases + scripts + reglas)
- Energía subjetiva alta, ejecución real baja
- Commits a medias, ideas sin terminar

**Cuándo ocurre:** Sesiones después de las 02:00 AM

**Regla:** Si son más de las 02:00 AM y llevas más de 2h en sesión → solo UNA cosa o cerrar.

---

## REGLA 1 — Una cosa a la vez

Si tienes energía para 10 cosas, elige 1 y ciérrala.
Una cosa cerrada > diez cosas a medias.

---

## REGLA 2 — No pegar en terminal

Lo que te manda el AI es para LEER, no para pegar.
Los comandos van en bloques ``` separados. Solo eso se pega.

---

## REGLA 3 — Deuda antes que features

No se abre repo nueva mientras haya bug activo en producción.
Orden: bug crítico → deuda técnica → feature → repo nueva → bot nuevo.

---

## REGLA 4 — El cambio de tema es una señal

Si llevas 3 temas distintos en 10 minutos → para.
O cierras sesión o eliges UNO y lo terminas.

---

## REGLA 5 — Cursor y terminal son herramientas distintas

`cursor .` se ejecuta en terminal del sistema, no en bash de repo.
thdora no está en `~/thdora` — buscar ruta real con `find ~ -name 'thdora' -type d 2>/dev/null`

---

## Lo que SÍ funciona

- Sesiones con objetivo único definido antes de empezar
- `new-session.sh` muestra el foco del día
- `session-close.sh` al terminar aunque sea a medias
- Documentar en inbox si surge idea nueva en mitad de fix — NO ejecutarla
