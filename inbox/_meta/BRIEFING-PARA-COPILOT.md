# 🗺️ BRIEFING PARA COPILOT — Auditoría del ecosistema yggdrasil-dew
> Generado por Perplexity el 2026-07-04 | Entregado en: `inbox/_meta/BRIEFING-PARA-COPILOT.md`

---

## 🎯 Misión de esta auditoría

Copilot: necesito que hagas una auditoría completa del repo `alvarofernandezmota-tech/yggdrasil-dew`.  
Este briefing te da el mapa real del estado actual para que no pierdas tiempo explorando.  
Tu trabajo es: **verificar, detectar anomalías y proponer correcciones**.

---

## 🧠 Contexto del sistema

Este repo es el "sistema nervioso" de un ecosistema personal de knowledge management + automatización.  
Funciona como una bandeja de entrada inteligente (`inbox/`) donde los archivos llegan, se clasifican y se archivan en su destino final, todo coordinado por GitHub Actions y scripts bash.

### Flujo acordado:
```
Terminal → inbox/drop/ → [GitHub Actions] → destino correcto (diarios/, scripts/, docs/, etc.)
```

---

## 📁 Estructura real detectada (2026-07-04)

### Carpetas raíz del repo
```
.github/workflows/   → +50 workflows (PROBLEMA: muchos son stubs vacíos de ~150 bytes)
scripts/             → +40 scripts .sh (PROBLEMA: hay .md mezclados que no deberían estar)
inbox/               → bandeja de entrada principal
diarios/             → destino final de cierres de sesión y documentos con fecha
docs/                → documentación general
```

### Subcarpetas detectadas en inbox/
```
inbox/drop/          ✅ zona de aterrizaje (correcta, tiene .gitkeep)
inbox/_meta/         ✅ reportes de auditoría y meta-docs (este archivo vive aquí)
inbox/.estados/      ✅ carpeta de estados
inbox/sesiones/      ✅ logs y cierres de sesión
inbox/agentes/       ✅ outputs de agentes
inbox/context/       ✅ contexto del sistema
inbox/archive/       ✅ archivos archivados
inbox/formacion/     ✅ material de formación
inbox/hardware/      ✅ notas de hardware
inbox/infra/         ✅ infraestructura
inbox/osint/         ✅ OSINT stack
inbox/proyectos/     ✅ proyectos activos
inbox/thdora/        ✅ proyecto Thdora
inbox/yo/            ✅ notas personales
inbox/diarios/       ⚠️  DUPLICADO — diarios ya existe en raíz
inbox/diary/         ⚠️  DUPLICADO — mismo concepto que diarios/ pero en inglés
inbox/core/          ⚠️  vacía — sin .gitkeep ni contenido
inbox/mocs/          ⚠️  vacía — sin .gitkeep ni contenido
inbox/ollama/        ⚠️  vacía — sin .gitkeep ni contenido
inbox/osint-stack/   ⚠️  DUPLICADO de inbox/osint/
inbox/tools/         ⚠️  vacía — sin .gitkeep ni contenido
inbox/cli-tools/     ⚠️  posible duplicado de inbox/tools/
inbox/alvarofernandezmota-tech/ ⚠️  nombre de usuario como carpeta — raro
```

### Archivos sueltos detectados en inbox/ (raíz)
```
inbox/2026-07-03-health-alert.md    → debería estar en inbox/_meta/ o diarios/
inbox/2026-07-04-health-alert.md    → idem
inbox/2026-07-04-reality-check.md   → idem
inbox/ALERTA-INBOX.md               → nota de alerta (50 bytes, casi vacía)
inbox/APLAZADO-template.md          → plantilla útil, correcta
inbox/PLANTILLA-INBOX.md            → plantilla útil, correcta
inbox/README.md                     → ✅ correcto
inbox/audit-2026-07-03-80.md        → debería estar en inbox/_meta/
inbox/audit-2026-07-03-81.md        → idem
inbox/audit-2026-07-03-84.md        → idem
inbox/audit-2026-07-04-89.md        → idem
```

---

## 🔴 Problemas conocidos que Copilot debe auditar

### 1. Workflows vacíos / stubs
- Hay +50 workflows en `.github/workflows/`
- Muchos tienen ~150 bytes (solo header YAML sin steps reales)
- **Tarea:** Listar cuáles tienen menos de 300 bytes y marcarlos como `STUB-SIN-IMPLEMENTAR`
- **Workflows funcionales confirmados:** `audit-on-push.yml`, `agent-monitor.yml`, `auditoria-auto.yml`

### 2. Scripts .md en carpeta scripts/
- Hay archivos `.md` dentro de `scripts/` que NO deberían estar ahí
- Archivos identificados: `SCRIPTS.md`, `SCRIPTS-AUDITORIA.md`, `README.md`, `2026-07-03-*.md`
- **Tarea:** Listarlos y proponer moverlos a `docs/` o `diarios/`

### 3. Carpetas duplicadas en inbox/
- `inbox/diarios/` vs `diarios/` (raíz) → solo debe existir `diarios/` en raíz
- `inbox/diary/` → duplicado en inglés, consolidar con `diarios/`
- `inbox/osint/` vs `inbox/osint-stack/` → consolidar en uno
- `inbox/tools/` vs `inbox/cli-tools/` → consolidar en uno

### 4. Archivos de auditoría fuera de su sitio
- `inbox/audit-*.md` → deberían estar en `inbox/_meta/`
- `inbox/2026-07-*.md` → deberían estar en `diarios/`

### 5. Scripts clave que pueden no existir o estar incompletos
Verificar que estos scripts existen Y tienen contenido funcional (>500 bytes):
```
scripts/inbox-commit.sh
scripts/inbox-clasificador.sh
scripts/session-logger.sh
scripts/session-terminal-doc.sh
scripts/orquestador-unico.sh
scripts/file-arrival-guardian.sh
scripts/cierre-sesion.sh
```

---

## ✅ Lo que Perplexity ya hizo (no repetir)

- [x] Creó `inbox/drop/` con `.gitkeep`
- [x] Creó `docs/inbox-flujo.md` con documentación del flujo
- [x] Creó `scripts/inbox-commit.sh` (script de commit desde terminal)
- [x] Creó `scripts/inbox-clasificador.sh` (clasificador automático)
- [x] Creó este briefing en `inbox/_meta/BRIEFING-PARA-COPILOT.md`

---

## 📋 Tareas concretas para Copilot

### TAREA 1 — Auditoría de workflows
```
Listar todos los workflows en .github/workflows/
Para cada uno: nombre, tamaño en bytes, si tiene steps reales o es stub
Generar reporte en: inbox/_meta/audit-workflows-FECHA.md
```

### TAREA 2 — Auditoría de scripts/
```
Listar todos los archivos en scripts/
Marcar: .sh funcionales (>500b) | .sh stubs (<500b) | .md mal colocados
Generar reporte en: inbox/_meta/audit-scripts-FECHA.md
```

### TAREA 3 — Limpiar inbox/ raíz
```
Mover inbox/audit-*.md → inbox/_meta/
Mover inbox/2026-07-*.md → diarios/
Verificar que APLAZADO-template.md y PLANTILLA-INBOX.md se quedan donde están
```

### TAREA 4 — Consolidar carpetas duplicadas
```
Proponer plan de consolidación para:
  inbox/diarios/ + inbox/diary/ → diarios/ (raíz)
  inbox/osint/ + inbox/osint-stack/ → inbox/osint/
  inbox/tools/ + inbox/cli-tools/ → inbox/tools/
Ejecutar si tienes permisos, o dejar PR con los cambios
```

### TAREA 5 — Verificar scripts clave
```
Para cada script de la lista de "scripts clave" arriba:
  - ¿Existe? ¿Tiene contenido real?
  - Si no existe o es stub: generarlo con lógica funcional completa
  - Si existe pero está roto: proponer corrección en PR
```

---

## 🏁 Output esperado de Copilot

Al terminar la auditoría, crear estos archivos:

```
inbox/_meta/audit-workflows-2026-07-04.md   → estado de los 50+ workflows
inbox/_meta/audit-scripts-2026-07-04.md     → estado de los 40+ scripts
inbox/_meta/audit-estructura-2026-07-04.md  → duplicados + archivos mal ubicados
inbox/_meta/audit-resumen-2026-07-04.md     → resumen ejecutivo con score de salud
```

---

## 🔧 Reglas del ecosistema (para que las respetes)

1. `inbox/drop/` es la única zona de aterrizaje — nada se crea directamente en otro sitio
2. Los `.md` de auditoría van a `inbox/_meta/`
3. Los cierres de sesión van a `diarios/` con nombre `YYYY-MM-DD-*.md`
4. Los scripts van a `scripts/` solo si son `.sh` ejecutables
5. La documentación va a `docs/`
6. Nada en la raíz del repo excepto: `README.md`, `.gitignore`, `LICENSE`

---

*Creado por Perplexity · Entregado a Copilot para auditoría · 2026-07-04 22:18 CEST*
