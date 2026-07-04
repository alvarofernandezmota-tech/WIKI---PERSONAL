# 🔍 AUDITORÍA COMPLETA — yggdrasil-dew
**Fecha:** 2026-07-04 | **Para:** GitHub Copilot  
**Propósito:** Que Copilot lea este archivo como contexto de entrada, confirme su comprensión y ayude a resolver los problemas en orden de prioridad.

---

## 📋 INSTRUCCIONES PARA COPILOT

> Copilot: Lee este documento completo. Al terminar, responde con:
> 1. ✅ Confirmación de lo que YA existe y funciona
> 2. ❌ Confirmación de lo que FALTA o está roto
> 3. 🔧 El PRIMER problema que propones resolver (con el código)
>
> No hagas nada sin confirmar primero.

---

## 🗂️ ESTRUCTURA REAL DEL REPO (auditada 2026-07-04)

### Carpetas raíz
```
yggdrasil-dew/
├── .github/
│   └── workflows/          ← GitHub Actions
├── diarios/                ← Destino final de cierres de sesión (*.md con fecha)
├── docs/                   ← Documentación del ecosistema
├── inbox/                  ← Zona de trabajo viva (entrada de archivos)
│   ├── drop/               ← Zona de aterrizaje manual (TÚ copias aquí)
│   ├── sesiones/           ← Logs y cierres de sesión generados por scripts
│   └── _meta/              ← Reportes de auditoría automáticos
├── scripts/                ← SOLO .sh y subdirectorios de scripts
│   ├── agentes/            ← Scripts de agentes IA
│   ├── archive/            ← Scripts deprecados/archivados
│   ├── backup/             ← Scripts de backup
│   └── ci/                 ← Scripts de CI/CD
└── README.md
```

---

## ✅ LO QUE EXISTE Y ESTÁ CONFIRMADO

### Scripts operativos en `scripts/` (`.sh` válidos)

| Script | Función | Estado |
|--------|---------|--------|
| `01-fix-driver-rtl8188ftu.sh` | Fix driver WiFi USB | ✅ OK |
| `02-git-pull-rebase.sh` | Pull con rebase seguro | ✅ OK |
| `03-fase1-seguridad.sh` | Hardening Fase 1 | ✅ OK |
| `04-fase2-start-batcueva.sh` | Arranque Batcueva | ✅ OK |
| `05-fase7-ollama-pull.sh` | Pull modelos Ollama | ✅ OK |
| `06-verificacion-post-reboot.sh` | Verificación post-reinicio | ✅ OK |
| `07-fase3-restic-backup.sh` | Backup Restic | ✅ OK |
| `08-fase6-thdora-handlers.sh` | Handlers Thdora | ✅ OK |
| `09-fase8-seguridad-acer.sh` | Seguridad Acer | ✅ OK |
| `10-fase9-osint-stack.sh` | Stack OSINT | ✅ OK |
| `agent-monitor.sh` | Monitor de agentes | ✅ OK |
| `apertura-maestra.sh` | Apertura maestra sesión | ✅ OK |
| `apertura-sesion.sh` | Apertura de sesión | ✅ OK |
| `audit-and-migrate.sh` | Auditoría + migración | ✅ OK |
| `auditoria-maestra.sh` | Auditoría maestra | ✅ OK |
| `batcueva-control.sh` | Control Batcueva | ✅ OK |
| `between-sessions.sh` | Entre sesiones | ✅ OK |
| `cierre-maestro.sh` | Cierre maestro sesión | ✅ OK |
| `cierre-sesion.sh` | Cierre sesión completo | ✅ OK |
| `clasificador-maestro.sh` | Clasificador de archivos | ✅ OK |
| `code-drift-detector.sh` | Detector de drift | ✅ OK |
| `copilot-2fases.sh` | Copilot 2 fases | ⚠️ DUPLICADO (ver abajo) |
| `copilot-fases.sh` | Copilot fases | ⚠️ DUPLICADO (ver abajo) |
| `copilot-mission-briefing.sh` | Briefing misión Copilot | ✅ OK (conservar) |
| `create-issues.sh` | Crear issues GitHub | ✅ OK |
| `cross-ref-checker.sh` | Verificador referencias cruzadas | ✅ OK |
| `deploy-madre.sh` | Deploy madre | ✅ OK |
| `deploy.sh` | Deploy general | ✅ OK |
| `ecosystem-snapshot.sh` | Snapshot del ecosistema | ✅ OK |

---

## ❌ PROBLEMAS DETECTADOS — ORDENADOS POR PRIORIDAD

### 🔴 CRÍTICO — P1: Archivos `.md` sueltos en `scripts/`

`scripts/` es zona exclusiva de scripts `.sh`. Los siguientes archivos `.md` están en el lugar INCORRECTO y deben moverse:

```
scripts/2026-07-03-23-05-struct-auditor-output.md  → mover a inbox/_meta/
scripts/2026-07-03-cierre-sesion-completo.md       → mover a diarios/
scripts/2026-07-03-inbox-audit-consolidado.md      → mover a inbox/_meta/
scripts/2026-07-03-reality-check.md                → mover a diarios/
scripts/README.md                                  → ✅ ESTE SÍ puede quedarse
scripts/SCRIPTS-AUDITORIA.md                       → mover a docs/
scripts/SCRIPTS.md                                 → mover a docs/
```

**Acción requerida de Copilot:**
```bash
# Copilot debe proponer el script de migración o hacerlo directamente con git mv
git mv scripts/2026-07-03-23-05-struct-auditor-output.md inbox/_meta/
git mv scripts/2026-07-03-cierre-sesion-completo.md diarios/
git mv scripts/2026-07-03-inbox-audit-consolidado.md inbox/_meta/
git mv scripts/2026-07-03-reality-check.md diarios/
git mv scripts/SCRIPTS-AUDITORIA.md docs/
git mv scripts/SCRIPTS.md docs/
git commit -m "fix(estructura): mover .md de scripts/ a sus destinos correctos"
```

---

### 🔴 CRÍTICO — P2: Scripts duplicados de Copilot

Existen DOS scripts con función solapada:
- `scripts/copilot-2fases.sh` (7.7 KB)
- `scripts/copilot-fases.sh` (6.6 KB)

**Acción requerida de Copilot:**
1. Leer ambos archivos y confirmar qué hace cada uno
2. Fusionarlos en `copilot-fases-unificado.sh` o decidir cuál eliminar
3. Mover el deprecado a `scripts/archive/`

---

### 🟡 IMPORTANTE — P3: `inbox-commit.sh` no existe en la rama main

Se acordó que `scripts/inbox-commit.sh` sería el comando único para commitear desde terminal. **No está en el repo.** Debe crearse con este comportamiento:

```bash
#!/usr/bin/env bash
# inbox-commit.sh — UN comando para meter archivos al ecosistema
# Uso: bash scripts/inbox-commit.sh "descripción"
set -euo pipefail

DESC="${1:-sin descripción}"
TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S)

echo "📥 Añadiendo archivos de inbox/drop/ al staging..."
git add inbox/drop/ inbox/sesiones/ inbox/_meta/ 2>/dev/null || true
git add -A

STAGED=$(git diff --cached --name-only)
if [ -z "$STAGED" ]; then
  echo "⚠️  No hay cambios staged. Nada que commitear."
  exit 0
fi

echo "📝 Commiteando: $DESC"
git commit -m "inbox(drop): $DESC [$TIMESTAMP]"

echo "🚀 Pusheando a main..."
git push origin main

echo "✅ Listo. GitHub Actions tomará el relevo."
```

---

### 🟡 IMPORTANTE — P4: `inbox-clasificador.sh` no existe

Se acordó que este script mueve archivos de `inbox/drop/` al destino correcto según su nombre/extensión. **No está en el repo.** Reglas de clasificación:

```
inbox/drop/*.md con "cierre" en el nombre   → diarios/
inbox/drop/*.md con "audit" en el nombre    → inbox/_meta/
inbox/drop/*.md con "sesion" en el nombre   → inbox/sesiones/
inbox/drop/*.sh                             → scripts/ (con confirmación)
inbox/drop/*.py                             → [carpeta destino según contexto]
inbox/drop/* (resto)                        → inbox/sesiones/ por defecto
```

---

### 🟡 IMPORTANTE — P5: `file-arrival-guardian.sh` necesita validación

`file-arrival-guardian.sh` existe pero no se ha verificado que el `--dry-run` funcione correctamente con la estructura actual. **Copilot debe ejecutarlo en dry-run y reportar el resultado.**

---

### 🟢 MEJORA — P6: `orquestador-unico.sh` vs scripts maestros duplicados

Existen varios "maestros":
- `apertura-maestra.sh`
- `cierre-maestro.sh`
- `auditoria-maestra.sh`
- `clasificador-maestro.sh`

Y también existe o debe existir `orquestador-unico.sh`. **Se debe revisar si estos maestros están correctamente invocados desde el orquestador o si son independientes.**

---

## 🔄 FLUJO ACORDADO (referencia para Copilot)

```
TERMINAL (tú)
    │
    ├─► cp archivo.md ~/yggdrasil-dew/inbox/drop/
    │
    └─► bash scripts/inbox-commit.sh "descripción"
             │
             ├─► git add + commit + push
             │
             └─► GitHub Actions dispara
                      │
                      ├─► inbox-clasificador.sh → mueve al destino
                      ├─► file-arrival-guardian.sh → valida estructura
                      └─► [según tipo] → diarios/ o inbox/_meta/ o docs/
```

---

## 📁 WORKFLOWS DE GITHUB ACTIONS (`.github/workflows/`)

**Copilot: verifica que estos workflows existen y funcionan:**

| Workflow | Disparo | Función esperada |
|----------|---------|-----------------|
| `session-close.yml` | push a `inbox/sesiones/cierre-*.md` | Mueve cierre a `diarios/` |
| `file-arrival-guardian.yml` | push a `inbox/drop/` | Valida estructura, genera reporte en `inbox/_meta/` |
| `inbox-clasificador.yml` | push a `inbox/drop/` | Clasifica y mueve archivos al destino |

Si alguno no existe → **crearlo es P1 junto con el P2 de scripts duplicados**.

---

## 📊 RESUMEN ESTADO DEL ECOSISTEMA

| Área | Estado | Acción |
|------|--------|--------|
| Scripts de sistema (01-10) | ✅ OK | Ninguna |
| Scripts de sesión (apertura/cierre) | ✅ OK | Ninguna |
| `.md` en `scripts/` | ❌ MAL | Mover (P1) |
| Scripts Copilot duplicados | ⚠️ Revisar | Fusionar (P2) |
| `inbox-commit.sh` | ❌ No existe | Crear (P3) |
| `inbox-clasificador.sh` | ❌ No existe | Crear (P4) |
| `file-arrival-guardian.sh` | ⚠️ Sin verificar | Testear (P5) |
| Workflows Actions | ⚠️ Sin verificar | Verificar (P5b) |
| Orquestador único vs maestros | ⚠️ Solapamiento | Revisar (P6) |

---

## 🎯 PRIMER PASO — LO QUE COPILOT DEBE HACER PRIMERO

**Antes de cualquier código, Copilot debe responder:**

```
CONFIRMACIÓN DE CONTEXTO:
- He leído la auditoría completa: [SÍ/NO]
- Archivos .md mal ubicados en scripts/ que he detectado: [LISTA]
- Scripts duplicados que he identificado: [LISTA]
- Workflows que existen en .github/workflows/: [LISTA]
- Mi propuesta para P1 es: [PROPUESTA]
- ¿Procedo con P1 (mover .md)? Esperando confirmación.
```

---

*Auditoría generada por Perplexity + revisión manual — 2026-07-04 10:44 CEST*
