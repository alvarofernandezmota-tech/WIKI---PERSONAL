# Sesión 2026-07-04 — Reorganización del ecosistema

> **Estado:** Para procesar y distribuir  
> **Origen:** Conversación con Perplexity AI  
> **Prioridad:** Alta — define cómo funciona todo

---

## Decisiones tomadas hoy

1. **`yggdrasil-dew` es el cerebro técnico del ecosistema** — no un repo de código, sino el índice y documentación de todo lo que existe.

2. **Todo lo personal va a un repo separado privado** — vida, rutinas, salud, finanzas no van aquí. Nombre sugerido: `alvaro-personal` (privado).

3. **33 workflows eliminados** — no había infraestructura real detrás. El repo funciona en modo manual hasta que haya algo real que automatizar.

4. **La arquitectura correcta del ecosistema:**
   - Este repo = mapa e índice de todo
   - Madre (servidor) = su propia documentación en `docs/hardware.md`
   - Cada servicio Docker importante = su propio repo cuando exista de verdad
   - Cada agente IA = su propio repo cuando tenga código real
   - Repos existentes en GitHub = documentados aquí con su propósito

5. **Regla de oro: si no existe el contenido real, no existe la carpeta.**

---

## Estado actual del repo (escaneado 2026-07-04)

### Archivos en raíz que hay que mover o decidir

| Archivo | Tamaño | Decisión |
|---|---|---|
| `AGENT.md` | 6KB | → `docs/` o `_archivo/` |
| `CHANGELOG.md` | 3KB | → `_archivo/` (no aplica a repo de docs) |
| `CONTEXT.md` | 3.5KB | → fusionar con `docs/ecosistema.md` |
| `CONTRIBUTING.md` | 2KB | → `_archivo/` (no hay equipo) |
| `CONVENCIONES.md` | 18KB | → `docs/convenciones.md` |
| `ECOSYSTEM-ARCHITECTURE.md` | 9.6KB | → `docs/ecosistema.md` |
| `ESTADO-SISTEMA.md` | 2KB | → `docs/estado.md` o `_archivo/` |
| `HERRAMIENTAS-ECOSISTEMA.md` | 14KB | → `docs/herramientas.md` |
| `HOME.md` | 3.9KB | → `_archivo/` (lo reemplaza README) |
| `MAPA-ISLAS.md` | 3.4KB | → `_archivo/` (concepto obsoleto) |
| `MASTER-PENDIENTES.md` | 5KB | → `inbox/` o issues de GitHub |
| `PLAN-SEGURIDAD-Y-DESPLIEGUE.md` | 10KB | → `docs/seguridad.md` |
| `ROADMAP-MASTER.md` | 3.9KB | → se queda en raíz |
| `mcp-config.json` | 1.9KB | → `infra/` o `_archivo/` |
| `package.json` | 667B | → `_archivo/` (no hay Node aqui) |
| `server.js` | 12.7KB | → `_archivo/` (no pertenece aquí) |
| `.env.template` | 1KB | → `infra/` |

### Carpetas vacías a eliminar

Estas carpetas existen pero no tienen contenido real:
- `assets/` `cli-tools/` `core/` `formacion/` `hardware/`
- `investigacion/` `islas/` `mcp/` `ollama/` `osint-stack/`
- `proyectos/` `setup/` `templates/` `tests/` `tools/`

### Carpetas que se quedan
- `diarios/` `sesiones/` `inbox/` `docs/` `agentes/` `infra/` `scripts/` `_archivo/` `docker/`

---

## Contexto del ecosistema (lo que existe en la vida real)

### Hardware
- **Madre** — servidor casero, siempre encendido
- **Acer** — portátil de trabajo (donde se hace todo)
- **iPhone** — móvil personal

### Infraestructura en Madre
- Acceso desde Acer vía SSH o interfaz web
- Docker corriendo servicios (documentar cuáles exactamente)
- Es la base de todo el ecosistema local

### GitHub — repos existentes
- `yggdrasil-dew` — este repo (cerebro técnico)
- [otros repos por documentar — hacer inventario]

### Herramientas IA activas
- Claude (Anthropic) — agente principal de desarrollo
- Perplexity — búsqueda + organización
- GitHub Copilot — coding
- ChatGPT / Gemini / Grok — consultas
- Ollama local — cuando esté configurado en Madre

---

## Próximos pasos (en orden)

- [ ] **1. Inventario de repos GitHub** — listar todos los repos existentes y documentar su propósito aquí
- [ ] **2. Mover archivos de raíz** según tabla de arriba
- [ ] **3. Borrar carpetas vacías** (15 carpetas)
- [ ] **4. Crear `docs/ecosistema.md`** — fusionar ECOSYSTEM-ARCHITECTURE + CONTEXT + HOME
- [ ] **5. Crear `docs/hardware.md`** — documentar Madre, Acer, iPhone y cómo se conectan
- [ ] **6. Crear repo `alvaro-personal`** (privado) — para separar lo personal de lo técnico
- [ ] **7. Documentar servicios Docker activos en Madre**

---

*Generado automáticamente desde sesión con Perplexity AI — 2026-07-04 23:58 CEST*
