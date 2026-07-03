# 🗺️ ISLAS DEL ECOSISTEMA

> Cada carpeta de la repo es una **isla**: tiene su propia responsabilidad,
> su propia estructura mínima y su TTL de actualización.
> Si una isla no se toca en X días y hay actividad en la repo, algo falla.

---

## ¿Qué es una isla?

Una isla es cualquier carpeta de primer nivel en yggdrasil-dew que tiene un
role definido dentro del ecosistema. Cada isla debe cumplir la **estructura mínima**
independientemente de cuántos ficheros tenga dentro.

### Estructura mínima de cualquier isla
```
carpeta/
  README.md          ← OBLIGATORIO: qué es, cómo se usa, a qué sprint pertenece
  .isla-config       ← RECOMENDADO: metadata de la isla (ver plantilla)
```

### Estructura mínima de isla-bot
```
docker/bots/<nombre>/
  Dockerfile         ← OBLIGATORIO
  requirements.txt   ← OBLIGATORIO
  main.py            ← OBLIGATORIO
  README.md          ← OBLIGATORIO
  healthcheck.sh     ← RECOMENDADO
```

---

## Mapa de islas actuales

| Isla | Rol | TTL (días) | Sprint | Estado |
|---|---|---|---|---|
| `docker/` | Bots dockerizados, compose | 14 | 5-7 | 🟡 En construcción |
| `docs/` | Documentación del ecosistema | 14 | continuo | 🟢 Activa |
| `scripts/` | Scripts de sesión y mantenimiento | 7 | continuo | 🟢 Activa |
| `infra/` | Mapa de Madre, configuraciones | 14 | continuo | 🟢 Activa |
| `inbox/` | Items pendientes de procesar | 3 | continuo | 🟢 Activa |
| `templates/` | Plantillas del ecosistema | 30 | continuo | 🟢 Activa |
| `agentes/` | Definición de agentes IA | 14 | 6-7 | 🟡 Pendiente |
| `core/` | Núcleo del ecosistema | 30 | 1-3 | 🟡 Revisar |
| `osint/` | Investigación OSINT | 14 | 8+ | 🔵 Planificada |
| `osint-stack/` | Stack OSINT | 14 | 8+ | 🔵 Planificada |
| `hardware/` | Configuración de hardware | 60 | 1-2 | 🔵 Estática |
| `formacion/` | Aprendizaje y cursos | 30 | paralelo | 🔵 Paralela |
| `diarios/` | Logs de sesión | 7 | continuo | 🟢 Activa |
| `proyectos/` | Proyectos externos | 30 | paralelo | 🔵 Paralela |
| `setup/` | Scripts de instalación | 60 | 1-2 | 🔵 Estática |
| `tools/` | Herramientas auxiliares | 30 | continuo | 🟢 Activa |
| `ollama/` | Modelos LLM locales | 14 | 6-7 | 🟡 Pendiente |
| `cli-tools/` | Herramientas CLI | 30 | continuo | 🟢 Activa |
| `thdora/` | Referencia a repo thdora | 7 | continuo | 🟢 Activa |
| `mocs/` | Maps of Content (Obsidian) | 14 | continuo | 🟢 Activa |
| `yo/` | Perfil personal | 60 | 1 | 🔵 Estática |

### Estados
```
🟢 Activa       → Se toca regularmente, TTL estricto
🟡 En construcción → Sprint activo, cambios frecuentes
🔵 Planificada   → Sprint futuro, no se toca ahora
🔵 Estática      → Rara vez cambia, TTL largo
🔴 Abandonada    → Nadie la toca, hay que migrar o eliminar
```

---

## Islas que necesitan acción inmediata

| Isla | Problema | Acción |
|---|---|---|
| `agentes/` | Sin README, sin estructura | Definir en Sprint 7 |
| `core/` | No se toca desde Sprint 3 | Auditar contenido |
| `osint/` + `osint-stack/` | Duplicadas? | Fusionar o definir roles distintos |
| `docker/bots/*/` | Faltan `main.py` y `healthcheck.sh` | Sprint 7 |

---

_Actualizado: 2026-07-03 — TTL: 14 días_
