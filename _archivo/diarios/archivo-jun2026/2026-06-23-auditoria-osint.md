---
tags: [auditoria, osint, estructura, homelab, docker]
fecha: 2026-06-23
estado: pendiente-ejecutar
tipo: auditoria
ruta-obsidian: inbox/2026-06-23-auditoria-osint.md
---

# Auditoría `osint/` — plan de mejora

> Generado en sesión 2026-06-23 · objetivo: escalar al nivel de `agentes/`

## Estado actual

### ✅ Lo que está bien
- `README.md` — existe
- `plantilla-informe.md` — plantilla lista
- `resultados/` — subcarpeta existe

### 🔴 Problemas
- Solo 2 investigaciones reales, ambas muy cortas (<650 bytes)
- Sin fichas por herramienta (SpiderFoot, IVRE, Kismet...)
- Sin `HERRAMIENTAS.md` ni `STACK.md`
- Sin wikilink a repo `osint-stack` (pendiente crear)
- Sin subcarpetas por tipo

## Arquitectura decidida (ADR 2026-06-23)

```
osint/ (cerebro)        ← conocimiento, herramientas, investigaciones
osint-stack/ (GitHub)   ← docker-compose SpiderFoot+IVRE+Kismet (pendiente)
setup/servidor/         ← estado en Madre, qué corre
```

## Estructura objetivo

```
osint/
  README.md                    ← índice + wikilink a repo osint-stack
  STACK.md                     ← qué herramientas, por qué este stack
  HERRAMIENTAS.md              ← comparativa herramientas OSINT
  plantilla-informe.md         ← ✅ ya existe
  herramientas/
    spiderfoot.md              ← ficha: qué es, casos uso, comandos clave
    ivre.md                    ← ficha: qué es, casos uso
    kismet.md                  ← ficha: wifi, bluetooth, casos uso
    maltego.md                 ← ficha: grafo relaciones
    shodan.md                  ← ficha: búsqueda dispositivos
    theHarvester.md            ← ficha: emails, dominios
  investigaciones/
    expansion-osint-gemini.md  ← mover desde raíz
    investigacion-grok-2026-06-20.md ← mover desde raíz
  resultados/                  ← ✅ ya existe
```

## Frontmatter YAML estándar por herramienta

```yaml
---
tags: [osint, herramienta, docker|web|cli]
nombre: SpiderFoot
tipo: reconocimiento-automatico
docker: true
repo: alvarofernandezmota-tech/osint-stack
caso-uso-principal: "Reconocimiento automático de dominios e IPs"
estado: planificado|instalado|activo
fecha: YYYY-MM-DD
---
```

## Pasos a ejecutar

- [ ] Crear `osint/STACK.md` — decisión del stack OSINT
- [ ] Crear `osint/herramientas/` con fichas: spiderfoot, ivre, kismet
- [ ] Mover investigaciones sueltas a `osint/investigaciones/`
- [ ] Actualizar `osint/README.md` con wikilink a `[[osint-stack]]`
- [ ] Crear repo `alvarofernandezmota-tech/osint-stack` cuando esté listo el docker-compose
- [ ] Añadir entrada en `setup/servidor/` con estado instalación actual

## Estado instalación en Madre (2026-06-23)

- 🔴 Pendiente — descargando docker images hoy (Ollama primero)
- SpiderFoot, IVRE, Kismet → siguiente fase tras Ollama+WebUI+Qdrant

## Wikilinks Obsidian

```
[[osint/README]] — Stack OSINT
[[osint/herramientas/spiderfoot]] — SpiderFoot
[[setup/servidor/README]] — Estado en Madre
```
