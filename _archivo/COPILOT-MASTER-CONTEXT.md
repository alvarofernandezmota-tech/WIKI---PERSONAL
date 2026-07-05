# COPILOT-MASTER-CONTEXT.md
> Documento de contexto maestro para GitHub Copilot y cualquier agente IA.
> **Última actualización:** 2026-07-04
> **Estado:** ACTIVO — leer antes de tocar cualquier cosa

---

## 1. QUÉ ES ESTE REPO

`yggdrasil-dew` es el **cerebro operativo personal** de Álvaro Fernández Mota.
No es un proyecto de software convencional — es un ecosistema vivo que:
- Documenta sesiones de trabajo y decisiones técnicas
- Gestiona el flujo de información desde la terminal hasta los diarios
- Conecta subrepos («islas») mediante GitHub Actions
- Se autogestiona vía workflows + scripts bash

**El objetivo final:** que la documentación y estructuración del repo (y sus subrepos) ocurra sola, sin intervención manual, siguiendo el archivo desde que entra en `inbox/drop/` hasta que llega a su destino final (`diarios/`, `docs/`, `investigacion/`, etc.).

---

## 2. ARQUITECTURA — MAPA RÁPIDO

```
yggdrasil-dew/
├── inbox/                  ← ZONA DE ENTRADA (todo entra aquí)
│   ├── drop/               ← punto de aterrizaje manual desde terminal
│   ├── sesiones/           ← logs y cierres de sesión
│   └── _meta/              ← reportes de auditoría auto-generados
├── diarios/                ← destino final de sesiones y cierres
├── docs/                   ← documentación permanente del ecosistema
├── scripts/                ← scripts .sh — lógica del sistema
├── agentes/                ← definiciones de agentes IA
├── islas/                  ← subrepos conectados (cada isla = un proyecto)
├── .github/workflows/      ← automatización GitHub Actions
├── investigacion/          ← notas de investigación técnica
├── proyectos/              ← proyectos activos
├── formacion/              ← aprendizaje y cursos
├── reports/                ← reportes generados por workflows
├── logs/                   ← logs del sistema
└── [raíz]                  ← docs maestros (README, CONTEXT, ROADMAP...)
```

---

## 3. FLUJO DE TRABAJO — CÓMO VIAJA UN ARCHIVO

```
TÚ (terminal)
  └─► cp archivo.md inbox/drop/
  └─► bash scripts/inbox-commit.sh "descripción"
         │
         ▼
    git push → GitHub Actions dispara
         │
         ▼
    inbox-clasificador.yml
    └─► scripts/inbox-clasificador.sh
         │  lee nombre/extensión/contenido
         ├─► *.md de sesión       → diarios/YYYY-MM-DD-*.md
         ├─► *.md de doc          → docs/
         ├─► *.md de investigación → investigacion/
         ├─► *.sh                 → scripts/
         ├─► *.yml (workflow)     → .github/workflows/
         └─► sin clasificar       → inbox/pending/
         │
         ▼
    file-arrival-guardian.yml
    └─► valida que la estructura sea correcta
         │
         ▼
    health-check.yml
    └─► genera reporte en reports/
```

**Regla de oro:** NUNCA se modifica un archivo directamente en su destino final. Todo pasa por `inbox/drop/` → clasificación → destino.

---

## 4. WORKFLOWS REALES (los únicos que importan)

Solo estos 6 tienen lógica real. El resto son placeholders a eliminar:

| Workflow | Tamaño | Función |
|---|---|---|
| `orquestador-maestro.yml` | 4.2KB | Punto de entrada único, llama al resto |
| `galatea.yml` | 5.8KB | Agente principal de escritura/documentación |
| `file-arrival-guardian.yml` | 2.4KB | Valida estructura al hacer push |
| `inbox-dispatcher.yml` | 3.3KB | Mueve archivos de drop/ al destino |
| `gestor-estados-inbox.yml` | 2.9KB | Gestiona estados del inbox |
| `health-check.yml` | 2.9KB | Estado del ecosistema |
| `meta-deep-audit.yml` | 1.8KB | Auditoría profunda periódica |
| `inbox-clasificador.yml` | 2.3KB | Clasificador principal |
| `inbox-processor.yml` | 2.4KB | Procesador de inbox |
| `e2e-full-flow.yml` | 1.2KB | Test del flujo completo |

**Todos los demás (~30 workflows de ~150 bytes):** son placeholders vacíos. TAREA PENDIENTE: eliminarlos o darles contenido real.

---

## 5. SCRIPTS REALES EN `scripts/`

```bash
scripts/
├── inbox-commit.sh          # UN comando: add+commit+push desde drop/
├── inbox-clasificador.sh    # Clasifica archivos por nombre/extensión
├── session-logger.sh        # Logger de sesión de terminal
├── session-terminal-doc.sh  # Genera documento de cierre de sesión
├── orquestador-unico.sh     # Orquestador bash (phases: all/audit/inbox/health)
└── file-arrival-guardian.sh # Valida estructura del repo
```

### Comandos de uso desde terminal

```bash
# INICIO DE SESIÓN
git pull origin main
source scripts/session-logger.sh

# METER ARCHIVO AL ECOSISTEMA
cp /ruta/archivo.md inbox/drop/
bash scripts/inbox-commit.sh "descripción de lo que entra"

# AUDITORÍA RÁPIDA
bash scripts/orquestador-unico.sh audit

# CIERRE DE SESIÓN
bash scripts/session-logger.sh --close
bash scripts/session-terminal-doc.sh "descripción de la sesión"
git add inbox/sesiones/cierre-*.md
git commit -m "docs(sesion): cierre YYYY-MM-DD HH:MM — descripción"
git push origin main

# VER DRY-RUN DE CLASIFICACIÓN (sin mover nada)
bash scripts/inbox-clasificador.sh --dry-run

# AUDITORÍA COMPLETA
bash scripts/orquestador-unico.sh all
```

---

## 6. ESTADO MCP — PENDIENTE DE CONFIGURAR

**Situación actual:** MCP no está activo en Copilot para este repo.

**Qué significa esto:**
- ✅ Copilot puede leer archivos vía raw.githubusercontent.com
- ✅ Copilot puede recibir contenido pegado directamente en el chat
- ✅ Copilot puede generar código/scripts para que tú los apliques
- ❌ Copilot NO puede navegar el repo de forma autónoma
- ❌ Copilot NO puede hacer commits o push directamente

**Para leer archivos desde Copilot sin MCP, usar estas URLs raw:**
```
https://raw.githubusercontent.com/alvarofernandezmota-tech/yggdrasil-dew/main/COPILOT-MASTER-CONTEXT.md
https://raw.githubusercontent.com/alvarofernandezmota-tech/yggdrasil-dew/main/ECOSISTEMA.md
https://raw.githubusercontent.com/alvarofernandezmota-tech/yggdrasil-dew/main/docs/inbox-flujo.md
https://raw.githubusercontent.com/alvarofernandezmota-tech/yggdrasil-dew/main/.github/workflows/orquestador-maestro.yml
https://raw.githubusercontent.com/alvarofernandezmota-tech/yggdrasil-dew/main/.github/workflows/galatea.yml
https://raw.githubusercontent.com/alvarofernandezmota-tech/yggdrasil-dew/main/scripts/inbox-clasificador.sh
```

**Configuración MCP pendiente:** ver `mcp-config.json` en raíz del repo.

---

## 7. AUDITORÍA — PROBLEMAS DETECTADOS (2026-07-04)

### 🔴 Críticos
- **~30 workflows vacíos (~150 bytes):** existen pero no hacen nada. Confunden el ecosistema.
  - Lista de los que hay que eliminar o completar: `agent-monitor.yml`, `audit-on-push.yml`, `auditoria-auto.yml`, `auto-investigacion.yml`, `auto-pr.yml`, `autonomous-cron.yml`, `between-sessions.yml`, `clasificador.yml`, `clasificador-maestro.yml`, `code-drift.yml`, `context-reminder.yml`, `cross-ref-checker.yml`, `deuda-tecnica.yml`, `diary-writer.yml`, `ecosystem-guardian.yml`, `ghost-file-detector.yml`, `isla-context-sync.yml`, `isla-sync-validator.yml`, `islas-health.yml`...
- **MCP no configurado:** Copilot no puede actuar de forma autónoma hasta que esté activo.

### 🟡 Importantes
- **Raíz con demasiados .md maestros:** `AUDITORIA-COMPLETA-YGG.md`, `AUDITORIA-MAESTRA-COPILOT.md`, `COPILOT-AUDIT-PLAN.md`, `COPILOT-CONTEXT.md`, `ECOSISTEMA.md`, `ECOSYSTEM-ARCHITECTURE.md`, `HERRAMIENTAS-ECOSISTEMA.md`... muchos archivos similares en raíz. Deberían consolidarse o moverse a `docs/`.
- **Carpeta `alvarofernandezmota-tech/` en raíz:** nombre de usuario como carpeta dentro del repo — es estructuralmente raro.
- **Symlink `yggdrasil-dew` en raíz:** symlink que apunta al propio repo — puede causar problemas.

### 🟢 Bien
- `inbox/drop/` existe y está lista
- Scripts principales están creados
- `galatea.yml` y `orquestador-maestro.yml` tienen lógica real
- `file-arrival-guardian.yml` está funcional

---

## 8. PLAN DE ACCIÓN — PRÓXIMAS SESIONES

### FASE 1 — Limpiar (sin MCP)
- [ ] Eliminar los ~30 workflows placeholder vacíos
- [ ] Consolidar docs maestros de raíz → mover a `docs/`
- [ ] Resolver symlink `yggdrasil-dew` en raíz
- [ ] Resolver carpeta `alvarofernandezmota-tech/` en raíz

### FASE 2 — Conectar scripts reales a workflows
- [ ] Cada workflow superviviente debe tener un script `.sh` real que ejecute
- [ ] Patrón estándar de todos los workflows: checkout → run script → commit si hay cambios → push
- [ ] `inbox-clasificador.yml` debe llamar a `scripts/inbox-clasificador.sh` con lógica completa

### FASE 3 — Configurar MCP para Copilot
- [ ] Activar el servidor MCP de GitHub en VS Code / Copilot
- [ ] Usar `mcp-config.json` del repo como base
- [ ] Una vez activo: Copilot podrá navegar, editar y commitear de forma autónoma

### FASE 4 — Autogestión completa
- [ ] El flujo `drop/ → clasificación → destino` funciona end-to-end sin intervención
- [ ] Los diarios se generan solos al final de cada sesión
- [ ] Health check diario reporta el estado del ecosistema en `reports/`

---

## 9. CÓMO USAR ESTE DOCUMENTO CON COPILOT (sin MCP)

Pega esto al inicio de cada chat con Copilot:

```
Lee este archivo para entender el contexto completo:
https://raw.githubusercontent.com/alvarofernandezmota-tech/yggdrasil-dew/main/COPILOT-MASTER-CONTEXT.md

Eres el agente de documentación y estructuración de este repo.
Tu trabajo es gestionar el flujo de archivos desde inbox/drop/ hasta su destino final.
Si te pido que generes algo, dámelo en formato listo para pegar en terminal o en el repo.
No hagas suposiciones sobre archivos que no hayas leído.
```

---

## 10. CONVENCIONES CLAVE

- **Commits:** `tipo(scope): descripción` — ej: `docs(sesion): cierre 2026-07-04`
- **Tipos:** `docs`, `feat`, `fix`, `refactor`, `chore`, `auto`, `audit`
- **Archivos de sesión:** siempre con timestamp `YYYYMMDDTHHMMSS` en el nombre
- **Workflows:** solo en `.github/workflows/`, nombre en kebab-case
- **Scripts:** solo en `scripts/`, extensión `.sh`, ejecutables
- **Nada se escribe directamente en `diarios/`** — siempre pasa por `inbox/`

---

*Generado por Perplexity + MCP GitHub — 2026-07-04*
*Actualizar este archivo al inicio de cada sesión si hay cambios estructurales.*
