#!/usr/bin/env bash
# ============================================================
# inbox-audit-cleanup.sh
# Audita inbox/, consolida micro-ficheros, mueve procesados
# Genera: inbox/YYYY-MM-DD-inbox-audit-consolidado.md
# Alerta si inbox/ supera ALERT_THRESHOLD ficheros
# ============================================================
set -euo pipefail

REPO_DIR="${REPO_DIR:-$(git -C "$(dirname "$0")" rev-parse --show-toplevel 2>/dev/null || pwd)}"
INBOX_DIR="$REPO_DIR/inbox"
ARCHIVE_DIR="$REPO_DIR/inbox/archive"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M)
ALERT_THRESHOLD=10
OUTPUT="$INBOX_DIR/${DATE}-inbox-audit-consolidado.md"

mkdir -p "$ARCHIVE_DIR"

echo "╔══════════════════════════════════════════╗"
echo "║   INBOX AUDIT & CLEANUP                  ║"
echo "╚══════════════════════════════════════════╝"
echo "[→] Repo: $REPO_DIR"
echo "[→] Inbox: $INBOX_DIR"
echo ""

# ── Contar ficheros (excluir README, .gitkeep, templates, archive) ──
TOTAL=$(find "$INBOX_DIR" -maxdepth 1 -name '*.md' \
  ! -name 'README.md' ! -name 'PLANTILLA*.md' \
  ! -name 'APLAZADO*.md' ! -name 'SIGUIENTE*.md' \
  ! -name 'PENDIENTES*.md' ! -name 'PLAN-*.md' \
  | wc -l | tr -d ' ')

echo "[→] Ficheros en inbox/: $TOTAL"

if [ "$TOTAL" -gt "$ALERT_THRESHOLD" ]; then
  echo "[⚠] ALERTA: inbox supera $ALERT_THRESHOLD ficheros ($TOTAL) — limpiando"
fi

# ── Clasificar ficheros ──
MICRO_AUDITS=$(find "$INBOX_DIR" -maxdepth 1 -name 'audit-*.md' | sort)
CLASIFICADOS=$(find "$INBOX_DIR" -maxdepth 1 -name 'clasificado-*.md' | sort)
SESION_DOCS=$(find "$INBOX_DIR" -maxdepth 1 -name "${DATE}-*.md" \
  ! -name '*audit-consolidado*' | sort)
OLD_DOCS=$(find "$INBOX_DIR" -maxdepth 1 -name '*.md' \
  ! -name "${DATE}-*" ! -name 'README.md' ! -name 'PLANTILLA*.md' \
  ! -name 'APLAZADO*.md' ! -name 'SIGUIENTE*.md' \
  ! -name 'PENDIENTES*.md' ! -name 'PLAN-*.md' \
  ! -name 'audit-*.md' ! -name 'clasificado-*.md' | sort)

MICRO_COUNT=$(echo "$MICRO_AUDITS" | grep -c '.md' 2>/dev/null || echo 0)
CLASI_COUNT=$(echo "$CLASIFICADOS" | grep -c '.md' 2>/dev/null || echo 0)
SESION_COUNT=$(echo "$SESION_DOCS" | grep -c '.md' 2>/dev/null || echo 0)
OLD_COUNT=$(echo "$OLD_DOCS" | grep -c '.md' 2>/dev/null || echo 0)

echo "[→] Micro-audits atomizados: $MICRO_COUNT (se consolidan)"
echo "[→] Clasificados: $CLASI_COUNT (se archivan)"
echo "[→] Docs sesión hoy: $SESION_COUNT (se mantienen)"
echo "[→] Docs antiguos: $OLD_COUNT (se archivan)"
echo ""

# ── Generar fichero consolidado ──
cat > "$OUTPUT" << HEADER
---
type: report
date: ${DATE}
hora: ${TIME}
source: inbox-audit-cleanup.sh
priority: medium
status: pending
processed_by: pending
title: Inbox audit consolidado ${DATE} ${TIME}
---

# Inbox Audit Consolidado — ${DATE} ${TIME}

**Total ficheros antes de limpieza**: ${TOTAL}  
**Umbral de alerta**: ${ALERT_THRESHOLD}  
**Estado**: $( [ "$TOTAL" -gt "$ALERT_THRESHOLD" ] && echo '⚠ SUPERA UMBRAL' || echo '✅ OK' )

---

## Micro-audits consolidados (${MICRO_COUNT} ficheros → 1)

HEADER

# Consolidar contenido de micro-audits
if [ -n "$MICRO_AUDITS" ] && [ "$MICRO_COUNT" -gt 0 ]; then
  for f in $MICRO_AUDITS; do
    [ ! -f "$f" ] && continue
    FNAME=$(basename "$f")
    echo "### $FNAME" >> "$OUTPUT"
    # Extraer contenido sin frontmatter
    awk '/^---$/{n++; if(n==2){found=1; next}} found{print}' "$f" >> "$OUTPUT" 2>/dev/null || cat "$f" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    # Mover a archive
    mv "$f" "$ARCHIVE_DIR/" 2>/dev/null && echo "[✓] Archivado: $FNAME" || true
  done
else
  echo "_Sin micro-audits pendientes._" >> "$OUTPUT"
fi

# Sección clasificados
cat >> "$OUTPUT" << SECTION

---

## Clasificados archivados (${CLASI_COUNT} ficheros)

SECTION

if [ -n "$CLASIFICADOS" ] && [ "$CLASI_COUNT" -gt 0 ]; then
  for f in $CLASIFICADOS; do
    [ ! -f "$f" ] && continue
    FNAME=$(basename "$f")
    echo "- $FNAME" >> "$OUTPUT"
    mv "$f" "$ARCHIVE_DIR/" 2>/dev/null && echo "[✓] Archivado: $FNAME" || true
  done
else
  echo "_Sin clasificados pendientes._" >> "$OUTPUT"
fi

# Sección docs antiguos
cat >> "$OUTPUT" << SECTION2

---

## Docs antiguos archivados (${OLD_COUNT} ficheros)

SECTION2

if [ -n "$OLD_DOCS" ] && [ "$OLD_COUNT" -gt 0 ]; then
  for f in $OLD_DOCS; do
    [ ! -f "$f" ] && continue
    FNAME=$(basename "$f")
    echo "- $FNAME" >> "$OUTPUT"
    mv "$f" "$ARCHIVE_DIR/" 2>/dev/null && echo "[✓] Archivado: $FNAME" || true
  done
else
  echo "_Sin docs antiguos._" >> "$OUTPUT"
fi

# Sección docs sesión (se mantienen, solo se listan)
cat >> "$OUTPUT" << SECTION3

---

## Docs de sesión activos (${SESION_COUNT} ficheros — se mantienen)

SECTION3

if [ -n "$SESION_DOCS" ] && [ "$SESION_COUNT" -gt 0 ]; then
  for f in $SESION_DOCS; do
    [ ! -f "$f" ] && continue
    FNAME=$(basename "$f")
    TITLE=$(grep '^title:' "$f" 2>/dev/null | head -1 | sed 's/^title: //' | tr -d '"' || echo "$FNAME")
    echo "- **$FNAME** — $TITLE" >> "$OUTPUT"
  done
fi

cat >> "$OUTPUT" << FOOTER

---

*Generado por inbox-audit-cleanup.sh [AUTO] · ${DATE} ${TIME}*
FOOTER

# Contar resultado final
FINAL=$(find "$INBOX_DIR" -maxdepth 1 -name '*.md' \
  ! -name 'README.md' ! -name 'PLANTILLA*.md' \
  ! -name 'APLAZADO*.md' ! -name 'SIGUIENTE*.md' \
  ! -name 'PENDIENTES*.md' ! -name 'PLAN-*.md' \
  | wc -l | tr -d ' ')

echo ""
echo "╔══════════════════════════════╗"
echo "║  RESULTADO LIMPIEZA          ║"
echo "╠══════════════════════════════╣"
echo "║  Antes : $TOTAL ficheros"
echo "║  Ahora : $FINAL ficheros"
echo "║  Informe: $(basename $OUTPUT)"
echo "╚══════════════════════════════╝"

# Commit automático si hay cambios
if command -v git &>/dev/null; then
  cd "$REPO_DIR"
  if ! git diff --quiet || ! git diff --staged --quiet; then
    git add inbox/ 2>/dev/null || true
    git commit -m "chore(inbox): limpieza automatica ${DATE} — ${TOTAL}→${FINAL} ficheros [AUTO]" 2>/dev/null || true
    git push 2>/dev/null && echo "[✓] Push completado" || echo "[⚠] Push manual necesario"
  fi
fi
