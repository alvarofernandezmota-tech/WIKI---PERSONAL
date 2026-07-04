# 🤖 COPILOT BRIEFING COMPLETO — yggdrasil-dew
**Fecha:** 2026-07-04 | **Versión:** 2.0  
**Propósito:** Contexto total para que Copilot (GitHub Copilot IA, modo agente) ejecute todos los pasos de limpieza y creación de scripts SIN necesidad de bash externo.

---

## 📌 INSTRUCCIONES DE ENTRADA PARA COPILOT

> Lee este documento de arriba a abajo.  
> Cuando termines, **confirma cada bloque** antes de actuar.  
> Usa `git mv` / crear archivos directamente en el repo vía la API de GitHub.  
> Formato de confirmación esperado al final de este doc.

---

## 1️⃣ ESTADO REAL DEL REPO (auditado 2026-07-04)

### Árbol de carpetas clave
```
yggdrasil-dew/
├── .github/
│   └── workflows/          ← GitHub Actions (VERIFICAR cuáles existen)
├── diarios/                ← Destino final de cierres de sesión (*.md con fecha)
├── docs/                   ← Documentación del ecosistema (este archivo está aquí)
├── inbox/
│   ├── drop/               ← Zona de aterrizaje manual (tú copias aquí)
│   ├── sesiones/           ← Logs y cierres de sesión generados por scripts
│   └── _meta/              ← Reportes de auditoría automáticos
├── scripts/                ← SOLO .sh y subdirectorios de scripts
│   ├── agentes/
│   ├── archive/
│   ├── backup/
│   └── ci/
└── README.md
```

### Scripts confirmados OK (no tocar)
```
scripts/01-fix-driver-rtl8188ftu.sh
scripts/02-git-pull-rebase.sh
scripts/03-fase1-seguridad.sh
scripts/04-fase2-start-batcueva.sh
scripts/05-fase7-ollama-pull.sh
scripts/06-verificacion-post-reboot.sh
scripts/07-fase3-restic-backup.sh
scripts/08-fase6-thdora-handlers.sh
scripts/09-fase8-seguridad-acer.sh
scripts/10-fase9-osint-stack.sh
scripts/agent-monitor.sh
scripts/apertura-maestra.sh
scripts/apertura-sesion.sh
scripts/audit-and-migrate.sh
scripts/auditoria-maestra.sh
scripts/batcueva-control.sh
scripts/between-sessions.sh
scripts/cierre-maestro.sh
scripts/cierre-sesion.sh
scripts/clasificador-maestro.sh
scripts/code-drift-detector.sh
scripts/copilot-mission-briefing.sh
scripts/create-issues.sh
scripts/cross-ref-checker.sh
scripts/deploy-madre.sh
scripts/deploy.sh
scripts/ecosystem-snapshot.sh
scripts/file-arrival-guardian.sh
```

---

## 2️⃣ PROBLEMAS A RESOLVER — ORDENADOS POR PRIORIDAD

---

### 🔴 P1 — Mover archivos .md que están en scripts/ (lugar incorrecto)

`scripts/` es zona exclusiva de `.sh`. Estos `.md` deben moverse:

| Archivo actual | Destino correcto |
|----------------|-----------------|
| `scripts/2026-07-03-23-05-struct-auditor-output.md` | `inbox/_meta/` |
| `scripts/2026-07-03-cierre-sesion-completo.md` | `diarios/` |
| `scripts/2026-07-03-inbox-audit-consolidado.md` | `inbox/_meta/` |
| `scripts/2026-07-03-reality-check.md` | `diarios/` |
| `scripts/SCRIPTS-AUDITORIA.md` | `docs/` |
| `scripts/SCRIPTS.md` | `docs/` |

> ⚠️ `scripts/README.md` — DEJAR donde está.

**Copilot: ejecuta estos git mv y haz un commit con mensaje:**
```
fix(estructura): mover .md de scripts/ a sus destinos correctos [P1]
```

---

### 🔴 P2 — Resolver scripts Copilot duplicados

Existen dos scripts solapados:
- `scripts/copilot-2fases.sh` (~7.7 KB)
- `scripts/copilot-fases.sh` (~6.6 KB)

**Acción de Copilot:**
1. Leer ambos archivos
2. Detectar qué funcionalidad única tiene cada uno
3. Fusionar en `scripts/copilot-fases-unificado.sh`
4. Mover ambos originales a `scripts/archive/`
5. Commit: `fix(scripts): fusionar copilot-2fases + copilot-fases en unificado [P2]`

---

### 🟡 P3 — CREAR scripts/inbox-commit.sh (NO EXISTE)

Este script es el **comando único** para que el usuario meta archivos al ecosistema desde terminal. Crearlo con este contenido exacto:

**Ruta:** `scripts/inbox-commit.sh`
**Permisos:** chmod +x

```bash
#!/usr/bin/env bash
# =============================================================
# inbox-commit.sh — UN comando para meter archivos al ecosistema
# Uso: bash scripts/inbox-commit.sh "descripción del cambio"
# Repo: alvarofernandezmota-tech/yggdrasil-dew
# =============================================================
set -euo pipefail

DESC="${1:-sin descripción}"
TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S)
BRANCH="main"

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║     📥 INBOX COMMIT — yggdrasil-dew          ║"
echo "╚══════════════════════════════════════════════╝"
echo ""
echo "📅 Timestamp: $TIMESTAMP"
echo "📝 Descripción: $DESC"
echo ""

# Verificar que estamos en la raíz del repo
if [ ! -f "README.md" ] || [ ! -d "scripts" ]; then
  echo "❌ ERROR: Ejecuta este script desde la raíz de yggdrasil-dew/"
  exit 1
fi

# Verificar rama
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$CURRENT_BRANCH" != "$BRANCH" ]; then
  echo "⚠️  Estás en rama '$CURRENT_BRANCH'. Cambiando a '$BRANCH'..."
  git checkout "$BRANCH"
fi

# Hacer pull primero para evitar conflictos
echo "🔄 Pull rebase antes de commitear..."
git pull --rebase origin "$BRANCH" || {
  echo "⚠️  Pull con conflictos. Resuelve manualmente y vuelve a ejecutar."
  exit 1
}

# Añadir zonas del inbox y todo lo demás
echo "📦 Staging de archivos..."
git add inbox/drop/ inbox/sesiones/ inbox/_meta/ 2>/dev/null || true
git add -A

# Comprobar si hay algo staged
STAGED=$(git diff --cached --name-only)
if [ -z "$STAGED" ]; then
  echo ""
  echo "⚠️  No hay cambios para commitear. El working tree está limpio."
  exit 0
fi

echo ""
echo "📋 Archivos a commitear:"
echo "$STAGED" | sed 's/^/   ✓ /'
echo ""

# Commit
git commit -m "inbox(drop): $DESC [$TIMESTAMP]"

# Push
echo "🚀 Pusheando a $BRANCH..."
git push origin "$BRANCH"

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║  ✅ LISTO — GitHub Actions tomará el relevo  ║"
echo "╚══════════════════════════════════════════════╝"
echo ""
```

**Commit:** `feat(scripts): crear inbox-commit.sh — comando único de entrada [P3]`

---

### 🟡 P4 — CREAR scripts/inbox-clasificador.sh (NO EXISTE)

Este script mueve archivos de `inbox/drop/` al destino correcto según su nombre.

**Ruta:** `scripts/inbox-clasificador.sh`
**Permisos:** chmod +x

```bash
#!/usr/bin/env bash
# =============================================================
# inbox-clasificador.sh — Clasificador automático del inbox
# Mueve archivos de inbox/drop/ al destino correcto
# Puede ejecutarse manualmente o desde GitHub Actions
# =============================================================
set -euo pipefail

DRY_RUN="${DRY_RUN:-false}"
DROP_DIR="inbox/drop"
MOVED=0
SKIPPED=0

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║   🗂️  INBOX CLASIFICADOR — yggdrasil-dew     ║"
echo "╚══════════════════════════════════════════════╝"
echo ""
[ "$DRY_RUN" = "true" ] && echo "⚠️  MODO DRY-RUN — No se moverá nada" && echo ""

# Verificar directorio drop
if [ ! -d "$DROP_DIR" ]; then
  echo "❌ No existe $DROP_DIR"
  exit 1
fi

FILES=$(find "$DROP_DIR" -maxdepth 1 -type f 2>/dev/null)

if [ -z "$FILES" ]; then
  echo "✅ inbox/drop/ está vacío. Nada que clasificar."
  exit 0
fi

clasificar_archivo() {
  local FILE="$1"
  local BASENAME
  BASENAME=$(basename "$FILE")
  local EXT="${BASENAME##*.}"
  local LOWER
  LOWER=$(echo "$BASENAME" | tr '[:upper:]' '[:lower:]')
  local DESTINO=""

  # Reglas de clasificación por nombre (orden de prioridad)
  if echo "$LOWER" | grep -qE "cierre|close|end-session|fin-sesion"; then
    DESTINO="diarios"
  elif echo "$LOWER" | grep -qE "audit|reporte|report|struct"; then
    DESTINO="inbox/_meta"
  elif echo "$LOWER" | grep -qE "sesion|session|apertura|open"; then
    DESTINO="inbox/sesiones"
  elif [ "$EXT" = "sh" ]; then
    DESTINO="scripts"
  elif [ "$EXT" = "py" ]; then
    DESTINO="scripts"
  else
    DESTINO="inbox/sesiones"  # Destino por defecto
  fi

  echo "  📄 $BASENAME"
  echo "     → $DESTINO/"

  if [ "$DRY_RUN" != "true" ]; then
    mkdir -p "$DESTINO"
    mv "$FILE" "$DESTINO/$BASENAME"
    ((MOVED++)) || true
  else
    ((SKIPPED++)) || true
  fi
}

echo "📋 Archivos encontrados en drop/:"
echo ""

while IFS= read -r FILE; do
  clasificar_archivo "$FILE"
done <<< "$FILES"

echo ""
if [ "$DRY_RUN" = "true" ]; then
  echo "🔍 Dry-run completado. $SKIPPED archivos analizados (sin mover)."
else
  echo "✅ Clasificación completada. $MOVED archivos movidos."
fi
echo ""
```

**Commit:** `feat(scripts): crear inbox-clasificador.sh — clasificador automático [P4]`

---

### 🟡 P5 — VERIFICAR/CREAR workflows de GitHub Actions

**Copilot: lista los archivos en `.github/workflows/` y confirma cuáles de estos existen:**

| Workflow esperado | Disparo | Función |
|-------------------|---------|---------|
| `file-arrival-guardian.yml` | push a `inbox/drop/**` | Valida estructura, genera reporte en `inbox/_meta/` |
| `inbox-clasificador.yml` | push a `inbox/drop/**` | Ejecuta `inbox-clasificador.sh` |
| `session-close.yml` | push a `inbox/sesiones/cierre-*.md` | Mueve cierre a `diarios/` |

**Si alguno no existe, créalo con esta plantilla base:**

```yaml
# .github/workflows/inbox-clasificador.yml
name: Inbox Clasificador
on:
  push:
    paths:
      - 'inbox/drop/**'
permissions:
  contents: write
jobs:
  clasificar:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
      - name: Ejecutar clasificador
        run: |
          chmod +x scripts/inbox-clasificador.sh
          bash scripts/inbox-clasificador.sh
      - name: Commit cambios
        run: |
          git config user.name "github-actions[bot]"
          git config user.email "github-actions[bot]@users.noreply.github.com"
          git add -A
          git diff --staged --quiet || git commit -m "auto(inbox): clasificar archivos drop/ [workflow]"
          git push
```

---

### 🟢 P6 — Revisar solapamiento de scripts maestros

Los siguientes scripts pueden solaparse con `orquestador-unico.sh`:
- `apertura-maestra.sh`
- `cierre-maestro.sh`
- `auditoria-maestra.sh`
- `clasificador-maestro.sh`

**Copilot: lee cada uno y confirma si `orquestador-unico.sh` los invoca o si son independientes. No hagas cambios hasta confirmar.**

---

## 3️⃣ FLUJO COMPLETO ACORDADO (referencia)

```
USUARIO (terminal)
    │
    ├─► cp archivo.md ~/yggdrasil-dew/inbox/drop/
    │
    └─► bash scripts/inbox-commit.sh "descripción"
             │
             ├─► git add + commit + push → main
             │
             └─► GitHub Actions dispara automáticamente
                      │
                      ├─► inbox-clasificador.yml
                      │     └─► scripts/inbox-clasificador.sh
                      │              └─► mueve a diarios/ | inbox/_meta/ | inbox/sesiones/
                      │
                      ├─► file-arrival-guardian.yml
                      │     └─► valida estructura + genera reporte en inbox/_meta/
                      │
                      └─► session-close.yml (si hay cierre-*.md)
                               └─► mueve a diarios/
```

---

## 4️⃣ FORMATO DE CONFIRMACIÓN QUE ESPERO DE COPILOT

Antes de hacer CUALQUIER cambio, Copilot debe responder con este bloque exacto:

```
CONFIRMACIÓN DE LECTURA — COPILOT
──────────────────────────────────────────────
✅ He leído COPILOT-BRIEFING-COMPLETO.md completo: SÍ

📁 Archivos .md mal ubicados en scripts/ que detecto:
  - [lista]

🔀 Scripts duplicados identificados:
  - copilot-2fases.sh vs copilot-fases.sh

📋 Workflows que existen en .github/workflows/:
  - [lista de lo que encuentro]

📋 Workflows que FALTAN:
  - [lista]

🎯 Orden de ejecución propuesto:
  1. P1: git mv de .md a destinos correctos
  2. P2: fusionar scripts Copilot duplicados
  3. P3: crear inbox-commit.sh
  4. P4: crear inbox-clasificador.sh
  5. P5: crear/verificar workflows
  6. P6: revisar maestros (solo lectura primero)

❓ ¿Procedo con P1? Esperando confirmación del usuario.
──────────────────────────────────────────────
```

---

*Briefing generado por Perplexity + MCP GitHub — 2026-07-04 22:45 CEST*  
*Para usar: abre este archivo en GitHub Copilot (modo agente) y pide que confirme lectura.*
