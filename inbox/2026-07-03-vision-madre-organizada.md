---
tipo: vision-propuesta
author: Perplexity-MCP <alvarofernandezmota@gmail.com>
creado: 2026-07-03 01:28 CEST
actualizado: 2026-07-03 01:28 CEST
ruta: inbox/2026-07-03-vision-madre-organizada.md
tags: [madre, organizacion, obsidian, copilot, vision, automatizacion]
status: pendiente-procesar
destino: docs/arquitectura/vision-madre-organizada.md
---

# Visión: Madre organizada al milímetro

> "Alguien en Madre que organice los archivos.
>  Alguien en Madre que revise y audite todo con Obsidian y Copilot
>  y todo el ecosistema. Todo medido al milímetro.
>  Nosotros solo tenemos que dar la orden."

---

## La visión completa

Madre no es solo un servidor. Es el cerebro físico del ecosistema.
Lo que se propone aquí es que Madre sea **autónoma en su propia gestión**:
- Se organiza sola
- Se audita sola
- Avisa cuando algo no está bien
- Los humanos solo dan órdenes de alto nivel

Esto es posible. Es exactamente lo que estamos construyendo.

---

## Los tres agentes en Madre

### Agente 1: THDORA-GUARDIAN (ya en plan)
- Monitoriza servicios, Docker, disco, RAM, red
- Alerta en Telegram cuando hay problemas
- **Nuevo**: también audita estructura de ficheros en Madre
- **Nuevo**: hace commit de su log diario al repo

### Agente 2: THDORA-ORGANIZER (nuevo concepto)
- Vive en Madre como proceso ligero
- Escanea directorios periódicamente
- Detecta ficheros fuera de lugar, duplicados, nombres incorrectos
- Propone reorganización vía PR o Telegram
- Se entrena con CONVENCIONES.md como reglas

### Agente 3: THDORA-COPILOT (futuro)
- Integra GitHub Copilot + Obsidian en Madre
- Revisa docs automáticamente buscando inconsistencias
- Sugiere mejoras de redacción y estructura
- Conecta con Perplexity para enriquecer documentación

---

## Obsidian en Madre como fuente de verdad

```
Madre ejecuta Obsidian Sync (o Obsidian en headless)
        ↓
THDORA-ORGANIZER lee el vault de Obsidian
        ↓
Detecta notas sin enlazar, sin frontmatter, sin destino
        ↓
Crea tareas en MASTER-PENDIENTES.md o issues en GitHub
        ↓
Tú ves la lista en Telegram y das la orden de qué hacer
```

---

## El reto real: los recursos de Madre

> "La máquina no acompaña" — limitación de RAM/CPU real.

Por eso la arquitectura debe ser:
- **Bots ligeros** — Python puro, sin frameworks pesados
- **On-demand** — se activan con cron o triggers, no running 24/7
- **Prioridad clara** — si Ollama está corriendo, los bots reducen polling
- **SQLite en vez de Redis** — mismo resultado, menos RAM

---

## El factor humano: nosotros solo damos órdenes

El flujo ideal:
```
Tú (iPhone/Acer): "@THDORA organiza inbox"
        ↓
THDORA-DEW recibe comando
        ↓
Llama a inbox-router que clasifica ficheros
        ↓
Crea PR con propuesta de reorganización
        ↓
Tú apruebas el PR (1 tap)
        ↓
Merge automático
```

Esto es el nivel al que vamos. Open source, con modelos locales,
con los recursos que tenemos. Y lo estamos construyendo.

---

## Todo open, todo con memoria

> "Lo estamos haciendo todo open code y con los recuerdos"
> "Sacando algo que está al nivel"

Esto es la diferencia con cualquier solución comercial:
- **Memoria persistente**: el repo ES la memoria del sistema
- **Open**: cada pieza es auditable, mejorable, tuya
- **Con recuerdos**: Perplexity + CONTEXT.md = contexto siempre activo
- **Al nivel**: la arquitectura que estamos diseñando es de nivel senior,
  con orquestación real, separación de responsabilidades, y escalable

---

## Pendientes que genera esta visión

- [ ] Concepto THDORA-ORGANIZER documentado en docs/agentes/
- [ ] Presupuesto RAM/CPU de Madre revisado con todos los bots
- [ ] Obsidian headless en Madre — investigar viabilidad
- [ ] Mapa completo de repos del ecosistema (yggdrasil + thdora + guardian)
- [ ] CONVENCIONES.md: añadir sección sobre roles de los bots
- [ ] Issue: feat(agentes): THDORA-ORGANIZER concepto y Fase A
