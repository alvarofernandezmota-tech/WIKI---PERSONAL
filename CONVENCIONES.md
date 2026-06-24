# CONVENCIONES — Reglas del ecosistema

> Estas reglas existen para que cualquier IA, cualquier persona, o tú mismo
> en 6 meses entienda el sistema sin preguntar nada.
> **Si no está aquí documentado, no existe.**

---

## Regla 1 — Todo entra por inbox primero

Cualquier idea, sesión, script, decisión, investigación → `inbox/YYYY-MM-DD-nombre.md`.
Nunca directamente a su destino final si no está revisado.

---

## Regla 2 — Sincronización obligatoria al mover de inbox a repo

**Cuando un fichero del inbox se procesa y mueve a su destino final,
obligatoriamente hay que actualizar TODOS estos sitios:**

### Checklist de sincronización

```
☐ 1. El fichero va a su destino (setup/, docs/, diarios/, proyectos/...)
☐ 2. MASTER-PENDIENTES.md — marcar tarea como ✅ si aplica
☐ 3. ESTADO-SISTEMA.md — actualizar estado si cambia algo en el stack
☐ 4. ROADMAP.md — marcar fase como completa si aplica
☐ 5. README.md del directorio destino — añadir enlace al nuevo fichero
☐ 6. inbox/ — eliminar o marcar el fichero original como procesado
☐ 7. cierre-sesion.sh — ejecutar para commitear todo junto
```

### Ejemplo práctico

Tienes `inbox/2026-06-24-script-batcueva-fase4.md` y lo conviertes en
`setup/servidor/batcueva-fase4.yml`:

1. Creas `setup/servidor/batcueva-fase4.yml` ✅
2. En `MASTER-PENDIENTES.md` marcas "Crear batcueva-fase4.yml" como ✅ ✅
3. En `ESTADO-SISTEMA.md` actualizas estado Fase 4 a "✅ lista" ✅
4. En `ROADMAP.md` marcas Fase 4 como completa ✅
5. En `setup/servidor/README.md` añades enlace al nuevo compose ✅
6. Borras o archivas el fichero inbox original ✅
7. `bash scripts/cierre-sesion.sh "fase4 implementada"` ✅

---

## Regla 3 — Los 4 ficheros maestros siempre sincronizados

Estos 4 ficheros son la fuente de verdad. Si se desincroniza uno, el sistema miente:

| Fichero | Qué contiene | Cuándo actualizar |
|---|---|---|
| `ESTADO-SISTEMA.md` | Estado real del stack ahora mismo | Cada vez que un servicio cambia de estado |
| `MASTER-PENDIENTES.md` | TODO lo pendiente priorizado | Cada sesión de trabajo |
| `ROADMAP.md` | Visión a largo plazo + fases | Cuando se completa una fase |
| `CONVENCIONES.md` | Reglas del sistema | Cuando se decide algo nuevo |

---

## Regla 4 — Nomenclatura de ficheros

```
inbox/     → YYYY-MM-DD-tema-subtema.md         (siempre fecha al inicio)
docs/      → nombre-descriptivo.md               (sin fecha, es documento vivo)
diarios/   → YYYY-MM-DD.md                       (solo fecha)
setup/     → nombre-tecnologia-proposito.yml/.sh  (sin fecha, es infraestructura)
proyectos/ → nombre-proyecto/README.md            (carpeta por proyecto)
```

---

## Regla 5 — Commits

```
Formato: <tipo>: <descripción> — <contexto opcional>

Tipos:
  inbox:    añadir fichero al inbox
  docs:     documentación nueva o actualizada
  setup:    infraestructura (composes, scripts)
  fix:      corrección de algo roto
  refactor: reorganización sin cambio funcional
  cierre:   commit automático de fin de sesión

Ejemplos:
  inbox: sesión madrugada 24 jun — auditoría setup/servidor
  docs: obsidian-setup.md — plugins + Dataview queries
  setup: batcueva-fase3.yml — n8n + Paperless + Vaultwarden
  cierre: 2026-06-24 02:53 — CONVENCIONES + docs/
```

---

## Regla 6 — Un README por directorio

Cada carpeta principal tiene su `README.md` que explica:
- Para qué sirve la carpeta
- Qué hay dentro
- Cómo se usa

Directorios que necesitan README:
- [x] `inbox/README.md` ✅
- [x] `docs/README.md` — pendiente crear
- [x] `setup/servidor/README.md` — ya existe
- [ ] `diarios/README.md` — pendiente
- [ ] `proyectos/README.md` — pendiente

---

## Regla 7 — Cierre de sesión obligatorio

Al terminar cualquier sesión de trabajo:

```bash
bash ~/Projects/yggdrasil-dew/setup/servidor/scripts/cierre-sesion.sh "descripción breve"
```

Esto hace:
1. `git add -A` — todo lo nuevo y modificado
2. `git commit` con fecha + descripción
3. `git push` a GitHub

Sin esto, el trabajo de la sesión existe solo en local — si Madre muere, se pierde.

---

## Regla 8 — Sincronización entre repos

Actualmente hay 2 repos principales:

| Repo | Propósito | URL |
|---|---|---|
| `yggdrasil-dew` | Cerebro central — todo el ecosistema | este repo |
| `personal-v2` | Repo anterior — en deprecación | github.com/alvarofernandezmota-tech/personal-v2 |

**Regla:** Todo lo nuevo va en `yggdrasil-dew`. `personal-v2` no se actualiza más.

Cuando se creen repos públicos de proyectos (`ollama-stack`, `osint-stack`, etc.):
- El repo del proyecto tiene su propio README
- `yggdrasil-dew/proyectos/nombre/` tiene el contexto privado y decisiones
- `ESTADO-SISTEMA.md` enlaza ambos

---
_Actualizado: 24 jun 2026 02:53 CEST_
_Ver: [ESTADO-SISTEMA.md](ESTADO-SISTEMA.md) · [MASTER-PENDIENTES.md](MASTER-PENDIENTES.md) · [ROADMAP.md](ROADMAP.md)_
