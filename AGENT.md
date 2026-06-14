# AGENT.md — Instrucciones para el Agente

> **Este es el primer archivo que debes leer.** Todo lo demás se navega desde aquí.
> Última actualización: 14 junio 2026

---

## Quién soy

Álvaro Fernández Mota — técnico en sistemas y datos, 26 años, Madrid/España.
Stack actual: Python, SQL, Linux (Arch/Omarchy), PostgreSQL, Docker.
Estoy en transición hacia roles de datos/IA con foco en construir mi propio ecosistema técnico.

**Setup de máquinas:**
- 🖥️ **Ordenador Madre** — workstation principal + servidor, Omarchy (Arch + Hyprland + Wayland), i5-8400, 16GB, GTX 1060 6GB
- 🗄️ **Acer Aspire** — servidor 24/7, Arch Linux, Ryzen 5 5500U, 8GB
- 💻 **MacBook** — portátil cliente, macOS
- 🖥️ **HP TouchSmart** — monitor secundario / dashboards (pendiente OS)

**Red:** todos en la misma LAN. IPs: Acer = 10.176.119.171 · MacBook = 10.176.119.229 · Madre = pendiente IP fija.

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

**Un ingeniero consulta su repo como consulta la documentación oficial — rápido, preciso, sin buscar entre carpetas de "cuándo lo aprendí".**

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
1. CONTEXT.md           → estado actual HOY — empieza siempre aquí
2. yo/perfil.md         → quién soy, cómo pienso, cómo trabajo
3. yo/objetivos-2026.md → qué quiero conseguir este año
4. filosofia.md         → principios técnicos — open source, control de datos
5. proyectos/README.md  → índice de proyectos activos y pausados
6. formacion/README.md  → áreas de aprendizaje activas
7. setup/README.md      → infraestructura y hardware
8. agentes/             → cómo funciona la capa IA, prompts, roles
9. diarios/2026/        → memoria episódica — entradas diarias
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

### Fechas
- Si la fecha actual no está disponible, preguntar antes de registrar nada
- Formato fechas: `DD MMM YYYY` en texto, `YYYY-MM-DD` en nombres de archivo

---

## Ecosistema IA dual — Cómo trabajan juntas las herramientas

Álvaro trabaja con **dos IAs en paralelo**. Cada una tiene un rol diferente y complementario.

### 🔵 Perplexity (este agente)
**Rol: conexión con GitHub + documentación + búsqueda**

| Capacidad | Uso concreto |
|---|---|
| MCP GitHub | Leer, crear y actualizar archivos del repo directamente |
| Búsqueda web en tiempo real | Verificar versiones, docs técnicas, noticias |
| Diarios y tracking | Crear entradas diarias en `diarios/2026/` |
| Documentación técnica | Escribir READMEs, fichas de proyecto, CONTEXT.md |
| Auditoría del repo | Revisar estructura, detectar duplicados, proponer mejoras |

### 🔴 Gemini (Google)
**Rol: diseño técnico + voz + visual + documentos largos**

| Capacidad | Uso concreto |
|---|---|
| Razonamiento técnico profundo | Diseño de infraestructura, arquitectura de sistemas |
| Integración ecosistema Google | Google Docs, Drive, Calendar, Gmail |
| Interacción por voz | Dictar notas, comandos por voz |
| Visual / multimodal | Analizar imágenes, diagramas, capturas |
| OCR y análisis de documentos | Fotos de libros, apuntes manuscritos → texto |

### 🔄 Protocolo de handoff

```
Gemini diseña → Álvaro copia resultado → Perplexity sube al repo
Perplexity audita → Álvaro lleva contexto a Gemini → Gemini desarrolla
```

**Regla:** output final en GitHub → pasa por Perplexity. Voz/visual/Google → pasa por Gemini.

---

## Roadmap servidor casa (junio 2026)

```
FASE 1 — Conectividad (AHORA)
  ├── Tailscale instalado en Madre + Acer (IPs fijas 100.x.x.x)
  ├── SSH entre máquinas
  └── Input Leap con systemd + UFW

FASE 2 — Seguridad
  ├── TLS en Input Leap
  ├── fail2ban
  └── Headscale (servidor Tailscale self-hosted)

FASE 3 — Servicios
  ├── Ollama + Open WebUI (GTX 1060)
  ├── PostgreSQL en Acer
  ├── THDORA migrado
  └── Pi-hole
```

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
| ¿Cómo funciona el servidor? | `setup/servidor/README.md` |
| ¿Qué pasó hoy/esta semana? | `diarios/2026/` |
| ¿Cómo uso cada IA? | `agentes/` |

---

_Frecuencia de actualización de este archivo: mensual o cuando cambia la estructura del sistema._
