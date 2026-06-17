# AGENT.md — Instrucciones para el Agente

> **Este es el primer archivo que debes leer.** Todo lo demás se navega desde aquí.
> Última actualización: **17 junio 2026**

---

## Quién soy

Álvaro Fernández Mota — dev autodidacta, Madrid/España.
Stack actual: Python · FastAPI · SQLAlchemy · Alembic · Docker · Telegram · Linux (Arch).
Construyo lo que yo mismo necesito. Filosofía: *«Si no está en el repo, no existe.»*

### Hardware real (junio 2026)

| Máquina | Rol | OS | IP Tailscale | IP Local |
|---|---|---|---|---|
| **Madre** | Servidor 24/7 producción | Linux | `100.91.112.32` | `10.134.31.228` |
| **Acer Theodora (varopc)** | PC desarrollo principal | Arch Linux + Hyprland/Wayland | `100.86.119.102` | `10.134.31.171` |
| **HP TouchSmart** | Pendiente rescate | — | — | — |

> ⚠️ NO hay MacBook. El Acer Theodora es el único cliente de desarrollo.

**Red:** Tailscale P2P entre Madre y Acer. AP Isolation en router bloquea UDP LAN (lan-mouse no funciona).

---

## Ecosistema de repos

| Repo | Rol | URL |
|---|---|---|
| **yggdrasil-dew** | 🧠 Cerebro / second brain — fuente de verdad única | https://github.com/alvarofernandezmota-tech/yggdrasil-dew |
| **thdora** | 🤖 Bot Telegram (TOKI) — producto principal | https://github.com/alvarofernandezmota-tech/thdora |
| **ai-toolkit** | 🛠️ Stack herramientas dev IA | https://github.com/alvarofernandezmota-tech/ai-toolkit |
| impresion-3d | Proyecto | https://github.com/alvarofernandezmota-tech/impresion-3d |
| python-snippets | Formación | https://github.com/alvarofernandezmota-tech/python-snippets |
| unix | Formación | https://github.com/alvarofernandezmota-tech/unix |

**Regla de conexión:** cada repo referencia `yggdrasil-dew` en su README como fuente de verdad del ecosistema.

---

## ⚡ Filosofía técnica

**Todo el software del ecosistema debe ser open source. Sin excepciones.**
Ver `filosofia.md` para el detalle completo.

Al proponer herramientas, soluciones o servicios, el agente debe:
- Priorizar siempre la alternativa open source.
- Nunca sugerir software propietario sin indicar que existe alternativa libre.
- Si no hay alternativa open source, indicarlo explícitamente.

---

## 🧠 Principio fundamental — Documentación que sirve para trabajar

**Este repo NO es un archivo histórico. Es una herramienta de trabajo viva.**

Cada sección del repo sigue este principio de dos capas:

| Capa | Propósito | Ejemplo |
|---|---|---|
| **Histórico / curso** | Registro de lo aprendido o hecho — para repasar | `formacion/python/curso/m1-introduccion/` |
| **Referencia técnica** | Documentación consultable en el trabajo real | `formacion/python/referencia/poo.md` |

**Regla:** si un archivo solo sirve para recordar que algo ocurrió, va al histórico. Si sirve para tomar decisiones o consultar en producción, va a la referencia.

Esto aplica a todo el repo:
- `setup/` → no es "lo que instalé", es la **referencia técnica viva del sistema**
- `formacion/python/` → no es "el historial del curso", es **curso + referencia de trabajo**
- `proyectos/` → no es "lo que hice", es **documentación de decisiones técnicas activas**
- `diarios/` → no es un diario personal, es **registro de decisiones y aprendizajes útiles**

---

## 🗂️ El repo como base de datos en Markdown

**Este repositorio funciona como una base de datos personal estructurada.**
Cada carpeta es una tabla. Cada archivo es una fila. Cada sección (`##`) es un campo.

### Reglas del sistema

1. **Todo se documenta por secciones** — no texto libre, no bloques sin estructura.
2. **El diario es unificado** — un solo archivo por día en `diarios/2026/YYYY-MM-DD.md` con secciones por área.
3. **Siempre actualizado** — cada acción importante queda registrada en su sección correspondiente ese mismo día.
4. **Cada archivo tiene frecuencia de actualización declarada** — ver tabla abajo.
5. **Los README son los índices** — si no está en el README de la carpeta, no existe para el sistema.

### Frecuencia de actualización por archivo

| Archivo | Frecuencia | Trigger |
|---|---|---|
| `CONTEXT.md` | Semanal (domingo) | O cuando cambia algo importante |
| `diarios/2026/YYYY-MM-DD.md` | Diario | Cada sesión de trabajo |
| `proyectos/*.md` | Cuando hay avance | Cada vez que se toca el proyecto |
| `setup/servidor/*.md` | Cuando cambia config | Cada cambio de infraestructura |
| `formacion/*.md` | Quincenal | Cada bloque de aprendizaje |
| `filosofia.md` | Mensual o menos | Solo si cambia un principio |
| `AGENT.md` | Mensual o menos | Solo si cambia la estructura del sistema |
| `yo/perfil.md` | Trimestral | Cuando cambia algo importante de ti |
| `yo/objetivos-2026.md` | Mensual | Revisión de objetivos |

### Secciones estándar por tipo de archivo

**Diario** (`diarios/2026/*.md`)
```
## 🖥️ Servidor
## 💻 Proyectos
## 📚 Formación
## 🧠 Personal
```

**Proyecto** (`proyectos/*.md`)
```
## Qué es
## Estado actual
## Decisiones tomadas
## TODO próximo
## Historial
```

**Formación** (`formacion/*.md`)
```
## Qué estoy aprendiendo
## Recursos
## Notas clave
## Ejercicios / práctica
## Dudas abiertas
```

**Setup técnico** (`setup/servidor/*.md`)
```
## Arquitectura / Objetivo
## Configuración / Código
## Estado
## Próximo paso
```

---

## Cómo navegar este repo

```
1. CONTEXT.md              → estado actual HOY — empieza siempre aquí
2. yo/perfil.md            → quién soy, cómo pienso, cómo trabajo
3. yo/objetivos-2026.md    → qué quiero conseguir este año
4. filosofia.md            → principios técnicos — open source, control de datos
5. proyectos/README.md     → índice de proyectos activos y pausados
6. formacion/README.md     → áreas de aprendizaje activas
7. setup/README.md         → infraestructura y hardware
8. setup/servidor/README.md → servidor Madre — estado real y servicios
9. agentes/                → cómo funciona la capa IA, prompts, roles
10. diarios/2026/          → memoria episódica — entradas diarias
```

---

## Reglas de comportamiento para el agente

### Siempre
- Leer `CONTEXT.md` antes de responder cualquier cosa sobre estado actual
- Usar español informal — tuteo, directo, sin relleno
- Confirmar antes de modificar cualquier archivo
- Indicar qué archivo hay que actualizar si algo cambia
- Priorizar lo que dice `CONTEXT.md` sobre cualquier otro archivo
- **Proponer solo herramientas open source** — ver `filosofia.md`
- **Respetar las secciones estándar** — no inventar estructura nueva
- **Avisar cuándo toca actualizar** un archivo según su frecuencia
- **Distinguir siempre entre capa histórica y capa de referencia** — no mezclarlas

### Nunca
- Asumir que un archivo no actualizado en >4 semanas está vigente
- Mezclar proyectos activos con proyectos archivados
- Inventar datos — si no están en el repo, preguntar
- Actualizar `CONTEXT.md` sin confirmación explícita
- **Sugerir software propietario sin advertirlo explícitamente**
- **Crear secciones nuevas** sin justificación — usar las estándar
- **Tratar el histórico como referencia** — son capas distintas
- **Referirse a `personal` o `personal-v2`** — el repo se llama `yggdrasil-dew`

### Fechas
- Si la fecha actual no está disponible, preguntar antes de registrar nada
- Formato fechas: `DD MMM YYYY` en texto, `YYYY-MM-DD` en nombres de archivo

---

## Ecosistema IA dual — Cómo trabajan juntas las herramientas

Álvaro trabaja con **múltiples IAs en paralelo**. Cada una tiene un rol diferente y complementario.

| IA | Rol | Estado |
|----|-----|--------|
| **Perplexity** (Claude Sonnet 4.6) | 🔵 Código · repos · arquitectura · docs · MCP GitHub | ✅ Principal |
| **Grok** (xAI) | 🔴 Investigación · mercado · datos frescos · X/Twitter | ✅ Activo |
| **Gemini 2.0 Pro** | 🟡 Contexto 1M tokens · código completo · estudios | ✅ Activo |
| **OpenCode** | ⚙️ Agente código en terminal · orquestador multi-repo | ✅ Configurado |
| **Mistral Le Chat** | 🟢 Investigación EU · privacidad | ⏳ Ficha parcial |

### Protocolo de handoff

```
Grok (investiga) → Perplexity (valida + sube al repo)
Gemini (diseña / código largo) → Perplexity (sube al repo)
Perplexity (audita repo) → output al resto de IAs como contexto
```

**Regla:** output final en GitHub → pasa por Perplexity (tiene MCP GitHub).

---

## Roadmap servidor Madre (junio 2026)

```
FASE 1 — Acceso (COMPLETADO ✅)
  ├── Tailscale instalado (Madre + Acer)
  ├── SSH operativo
  └── Docker operativo + thdora en producción

FASE 2 — Seguridad (PENDIENTE ⏳)
  ├── UFW en Madre
  ├── fail2ban
  └── wayvnc autostart

FASE 3 — Servicios (PLANIFICADO 🟢)
  ├── PostgreSQL
  ├── Open WebUI (RAG sobre yggdrasil-dew)
  ├── Uptime Kuma
  ├── Pi-hole
  └── n8n (diario nocturno automático)
```

> Ver detalle: [setup/servidor/README.md](setup/servidor/README.md)

---

## Mapa de archivos por intención

| Pregunta | Archivo |
|---|---|
| ¿Qué está pasando ahora? | `CONTEXT.md` |
| ¿Quién es Álvaro? | `yo/perfil.md` |
| ¿Qué quiere este año? | `yo/objetivos-2026.md` |
| ¿Cuál es su filosofía técnica? | `filosofia.md` |
| ¿En qué proyectos trabaja? | `proyectos/README.md` |
| ¿Qué está aprendiendo? | `formacion/README.md` |
| ¿Cómo está montado el setup técnico? | `setup/README.md` |
| ¿Cómo está el servidor Madre? | `setup/servidor/README.md` |
| ¿Qué pasó hoy/esta semana? | `diarios/2026/` |
| ¿Cómo uso cada IA? | `agentes/` |
| ¿Qué repos hay y para qué? | `ECOSISTEMA.md` |

---

_Frecuencia de actualización de este archivo: mensual o cuando cambia la estructura del sistema._
_Última actualización: 17 junio 2026_
