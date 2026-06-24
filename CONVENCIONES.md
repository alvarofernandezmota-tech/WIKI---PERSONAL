# CONVENCIONES — Reglas del ecosistema

> Estas reglas existen para que cualquier IA, cualquier persona, o tú mismo
> en 6 meses entienda el sistema sin preguntar nada.
> **Si no está aquí documentado, no existe.**
> Este fichero es vivo — se añaden reglas cuando se toman decisiones nuevas.

---

## Regla 1 — Todo entra por inbox primero

Cualquier idea, sesión, script, decisión, investigación → `inbox/YYYY-MM-DD-nombre.md`.
Nunca directamente a su destino final si no está revisado.

---

## Regla 2 — Sincronización obligatoria al mover de inbox al repo

Cuando un fichero del inbox se procesa y mueve a su destino, **actualizar obligatoriamente**:

```
☐ 1. Fichero al destino correcto
☐ 2. MASTER-PENDIENTES.md — marcar tarea como ✅ si aplica
☐ 3. ESTADO-SISTEMA.md — si cambia algo en el stack
☐ 4. ROADMAP.md — si se completa una fase
☐ 5. ECOSISTEMA.md — si cambia la arquitectura
☐ 6. README.md del directorio destino
☐ 7. inbox/ — eliminar o archivar el fichero procesado
☐ 8. cierre-sesion.sh — ejecutar para commitear todo
```

---

## Regla 3 — Los 5 ficheros maestros siempre sincronizados

| Fichero | Qué contiene | Cuándo actualizar |
|---|---|---|
| `ESTADO-SISTEMA.md` | Estado real del stack ahora mismo | Cada vez que un servicio cambia |
| `MASTER-PENDIENTES.md` | TODO lo pendiente priorizado | Cada sesión |
| `ROADMAP.md` | Visión + fases | Al completar una fase |
| `CONVENCIONES.md` | Reglas del sistema | Al tomar decisiones nuevas |
| `ECOSISTEMA.md` | Mapa completo arquitectura | Al añadir servicios o repos |

---

## Regla 4 — Nomenclatura de ficheros

```
inbox/     → YYYY-MM-DD-tema-subtema.md
docs/      → nombre-descriptivo.md
diarios/   → YYYY-MM-DD.md
setup/     → nombre-tecnologia.yml/.sh
agentes/   → nombre-modelo-proposito.md
ollama/    → Modelfile.nombre o nombre.md
proyectos/ → nombre-proyecto/README.md
```

---

## Regla 5 — Commits

```
Formato: <tipo>: <descripción> — <contexto opcional>

Tipos:
  inbox:    añadir al inbox
  docs:     documentación
  setup:    infraestructura
  agentes:  fichas o prompts de agentes
  fix:      corrección
  refactor: reorganización
  cierre:   commit automático fin de sesión
```

---

## Regla 6 — Un README por directorio

Cada carpeta principal tiene `README.md` con: para qué sirve, qué hay, cómo se usa.

---

## Regla 7 — Cierre de sesión obligatorio

```bash
bash ~/Projects/yggdrasil-dew/setup/servidor/scripts/cierre-sesion.sh "descripción"
```

Sin esto, el trabajo existe solo en local. Si Madre muere → se pierde.

---

## Regla 8 — Sincronización entre repos

- Todo lo nuevo → `yggdrasil-dew` (hasta que batcueva exista)
- `personal-v2` → deprecado, no actualizar
- Repos públicos de proyectos: su README propio + contexto privado en `proyectos/nombre/`

---

## Regla 9 — Escalamiento de proyectos

```
Nivel 1 — Idea → inbox/
Nivel 2 — Ficha activa → proyectos/nombre/
Nivel 3 — Repo propio → github.com/alvarofernandezmota-tech/nombre
Nivel 4 — Servicio en Madre → setup/servidor/nombre.yml
```

Regla: **nunca saltar niveles**.

---

## Regla 10 — Sprints semanales

```
Domingo → elegir 3 objetivos máximo
Diario  → ejecutar desde MASTER-PENDIENTES
Viernes → anotar en diarios/YYYY-MM-DD.md
```

Máximo 3 objetivos por semana.

---

## Regla 11 — Formación documentada

```
formacion/python/
formacion/linux/
formacion/ia/
formacion/pentest/
formacion/ingenieria/
```

Si lo estudias y no lo documentas, no lo sabrás en 3 meses.

---

## Regla 12 — Diseño antes de código

Antes de escribir cualquier script:
1. ¿Qué problema resuelve?
2. ¿Qué entra y qué sale?
3. ¿Cómo falla y cómo se recupera?
4. ¿Dónde vive en el repo?

Si no puedes responder las 4 → va al inbox, no se implementa.

---

## Regla 13 — Arquitectura multi-repo profesional

Cada repo tiene **una sola responsabilidad**. Así lo hacen los ingenieros senior.

```
personal          ← VIDA: diarios, metas, reflexiones (siempre privado)
yggdrasil-dew     ← CONOCIMIENTO: docs, formación, referencias, agentes
batcueva          ← INFRAESTRUCTURA: scripts, composes, setup Madre
thdora            ← PROYECTO: código agente IA (público)
local-brain       ← PROYECTO: código cerebro local (público)
[futuros]         ← cada proyecto nuevo = repo propio si llega a Nivel 3
```

Todo conectado por:
- Wikilinks en Obsidian: `[[tecnico/ESTADO-SISTEMA]]`
- `ECOSISTEMA.md` como mapa central
- Etiquetas Obsidian: `#infra` `#proyecto` `#formacion` `#personal`

**Regla:** nada personal en repos técnicos. Nada técnico en personal.
Si un fichero no encaja claramente en un repo → va al inbox y se decide.

---

## Regla 14 — Infraestructura de red (situación actual)

```
iPhone (hotspot) → Madre torre (WiFi)
Acer varopc      → Madre torre (SSH vía Tailscale o red local)
Móvil            → pendiente Obsidian + Tailscale
```

- Descargas grandes: móvil enchufado + pantalla apagada
- Sin router fijo — alternativas documentadas en `docs/sistema/red-alternativas.md`
- Cuando haya red fija: Tailscale gestiona todo, hotspot innecesario
- Regla: **nada crítico depende del hotspot** — todo debe poder pausarse y reanudarse

---

_Actualizado: 24 jun 2026 03:39 CEST_
_Ver: [ESTADO-SISTEMA.md](ESTADO-SISTEMA.md) · [MASTER-PENDIENTES.md](MASTER-PENDIENTES.md) · [ROADMAP.md](ROADMAP.md) · [ECOSISTEMA.md](ECOSISTEMA.md)_
