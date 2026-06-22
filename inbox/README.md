---
tags: [inbox, procedimiento, sistema]
fecha-actualizacion: 2026-06-22
---

# 📥 Inbox — El baúl

> Todo entra aquí primero. Nada se sobreescribe directamente.
> El inbox es el primer filtro de todo el sistema.

---

## 📐 Procedimiento oficial

```
1. CAPTURA
   Cualquier idea / dato / tarea / cambio
           ↓
   → Nueva nota en inbox/ con fecha y tags
   → Nunca sobreescribir un archivo directamente

2. ORGANIZA
   Abrir la nota de inbox
           ↓
   → ¿Ya existe un archivo definitivo para esto?
       Sí → mover el contenido allí + borrar inbox
       No  → crear el archivo definitivo + mover + borrar inbox

3. ACTUALIZA
   Siempre al final de cada sesión:
           ↓
   → CONTEXT.md — estado actual del ecosistema
   → AGENT.md   — solo si cambia algo estructural
   → HOME.md    — solo si se añade sección nueva
```

---

## 🔍 Procedimiento de Auditoría de Inbox

> ⚠️ **Regla de oro: nunca mover sin leer.**
> Mover archivos por nombre sin verificar el contenido = basura organizada.
> Una inbox ordenada con info incorrecta es peor que una inbox caótica con info real.

### Cuándo hacer auditoría
- **Cada domingo** — revisión semanal completa
- **Cuando haya más de 15 archivos acumulados**
- **Al inicio de un bloque de trabajo nuevo** — antes de empezar algo grande
- **Nunca con prisa** — la auditoría requiere atención real

### Proceso paso a paso (1 archivo a la vez)

```
Para CADA archivo en inbox/:

  1. ABRIR y leer el contenido completo
         ↓
  2. EVALUAR:
     a) ¿La información sigue siendo correcta y actual?
     b) ¿Está duplicada o superada por algo que hicimos después?
     c) ¿Tiene partes válidas y partes obsoletas?
         ↓
  3. DECIDIR una de estas acciones:
     ✅ MOVER    → Info correcta, tiene destino claro → crear/actualizar archivo destino
     ✏️ ACTUALIZAR → Info parcialmente correcta → editar primero, luego mover
     🔀 FUSIONAR  → Info válida pero ya existe un archivo mejor para ello
     📦 ARCHIVAR  → Info histórica, ya no activa → mover a archivados/ o diario/
     🗑️ DESCARTAR → Info obsoleta o ya superada → borrar
         ↓
  4. EJECUTAR la acción
         ↓
  5. SIGUIENTE archivo
```

### Cómo hacer auditoría con Perplexity

Cuando hagas la sesión de auditoría con ayuda de IA:

```
1. Decirle: "Vamos a auditar inbox, archivo a archivo"
2. Perplexity abre cada archivo y resume en 2-3 líneas el contenido real
3. Tú decides: ✅ mover / ✏️ actualizar / 🔀 fusionar / 📦 archivar / 🗑️ descartar
4. Perplexity ejecuta la acción en el repo
5. Se repite hasta vaciar la inbox
```

### Señales de que info está obsoleta
- Hace referencia a una configuración que ya cambiamos
- Es un "pendiente" que ya está resuelto
- Es una investigación que ya se integró en `agentes/` o en otro archivo formal
- Es un plan de algo que ya no vamos a hacer
- Tiene fecha anterior a un cambio estructural del sistema

### Señales de que info sigue siendo válida
- Configuración activa que no hemos cambiado
- Pendiente real que no aparece en ningún otro sitio
- Referencia técnica que aún no tiene archivo destino
- Decisión de diseño que explica por qué algo es como es

---

## 🗏 ¿Cuándo usar inbox?

| Situación | Acción |
|---|---|
| Idea rápida que no sabes dónde va | Inbox → decidir después |
| Dato nuevo sobre un archivo que ya existe | Inbox → revisar → mover |
| Tarea pendiente sin contexto claro | Inbox → MASTER-PENDIENTES |
| Cambio de estado de un proyecto | Inbox → actualizar proyectos/ |
| Algo que TOKI captura desde Telegram | Inbox automático vía handler |
| Cada mañana al empezar el día | Abrir MASTER-PENDIENTES → elegir 3 tareas |
| Cada noche al cerrar el día | Abrir diario del día → marcar completadas |
| Cada domingo | Auditoría inbox completo → limpiar → reordenar |

---

## 📂 Notas actuales en inbox (22 Jun 2026)

| Nota | Contenido | Estado |
|---|---|---|
| `MASTER-PENDIENTES.md` | Master de todos los pendientes del sistema | 🟢 activo — revisar vigencia |
| `PENDIENTE-git-pull-y-obsidian.md` | Setup git pull + Obsidian | ⚠️ auditar — ¿resuelto? |
| `2026-06-22-tarde-netdata-agentes-llm.md` | Sesión hoy: Netdata + fichas LLM + prompt v2 | 🔴 activa — NO mover hasta completar ronda 2 |
| `2026-06-22-plan-dia.md` | Plan del día 22 Jun | 📦 archivar en diario/ |
| `2026-06-20-tarde*.md` (x11) | Sesiones técnicas del 20 Jun | 🟡 auditar 1 a 1 |
| `auditoria-ecosistema-2026-06-20.md` | Auditoría estado ecosistema | 🟡 auditar |
| `auditoria-personal-repo.md` | Auditoría estructura repo | 🟡 auditar |
| `decisiones-sesion-2026-06-20.md` | Decisiones tomadas el 20 Jun | 🟡 auditar |
| `grok-2026-06-20-investigacion-completa.md` | Investigación Grok sobre el ecosistema | 🟡 auditar — ¿integrado ya? |
| `grok-2026-06-20-segundo-cerebro-pro.md` | Estructura segundo cerebro pro | 🟡 auditar |
| `modelos-ollama-hardware-madre.md` | Hardware Madre + modelos Ollama | 🔀 fusionar — fichas agentes/ ya creadas |
| `proyecto-dashboard-ecosistema.md` | Plan dashboard visual | 🟡 auditar |
| `madre-servidor-pendientes.md` | Pendientes infraestructura Madre | 🟡 auditar |
| `thdora-estado-stack.md` | Estado stack Acer/Thdora | 🟡 auditar |
| `obsidian-configuracion.md` | Config Obsidian | 🟡 auditar |
| `segundo-cerebro-fix-gordo.md` | Fix estructura segundo cerebro | 🟡 auditar |
| `formacion-python-osint.md` | Plan formación Python + OSINT | 🟢 activo |

---

_El inbox limpio = mente limpia. Auditoría semanal: domingo._
_Ver: [[HOME]] · [[CONTEXT]] · [[inbox/MASTER-PENDIENTES]]_
