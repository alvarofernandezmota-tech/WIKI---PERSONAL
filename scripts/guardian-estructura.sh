#!/usr/bin/env bash
# guardian-estructura.sh
# Doc: docs/  <- COMPLETAR ruta al doc relacionado
# Fase: <- COMPLETAR fase
# Descripción: <- COMPLETAR
# =============================================================================
# guardian-estructura.sh
# Galatea · Yggdrasil-Dew · Reorganización estructural de docs/
# -----------------------------------------------------------------------------
# USO:
#   bash scripts/guardian-estructura.sh          # ejecutar real
#   bash scripts/guardian-estructura.sh --dry-run # solo mostrar acciones
# =============================================================================
set -euo pipefail

# ── Colores ──────────────────────────────────────────────────────────────────
GREEN="\033[0;32m"; YELLOW="\033[1;33m"; RED="\033[0;31m"; CYAN="\033[0;36m"; NC="\033[0m"
ok()   { echo -e "${GREEN}✅ $*${NC}"; }
warn() { echo -e "${YELLOW}⚠️  $*${NC}"; }
err()  { echo -e "${RED}❌ $*${NC}"; }
info() { echo -e "${CYAN}ℹ️  $*${NC}"; }

# ── Modo dry-run ─────────────────────────────────────────────────────────────
DRY_RUN=false
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

mv_safe() {
  local src="$1" dst_dir="$2"
  if [[ ! -f "$src" ]]; then
    warn "No existe: $src  (saltando)"
    return 0
  fi
  mkdir -p "$dst_dir"
  if $DRY_RUN; then
    info "[dry-run] git mv $src → $dst_dir/"
  else
    git mv "$src" "$dst_dir/"
    ok "Movido: $src → $dst_dir/"
  fi
}

mv_glob() {
  # mv_glob "patrón" "destino" — itera sobre archivos que coincidan
  local pattern="$1" dst_dir="$2"
  local found=0
  for f in $pattern 2>/dev/null; do
    [[ -f "$f" ]] || continue
    found=1
    mv_safe "$f" "$dst_dir"
  done
  [[ $found -eq 0 ]] && warn "Sin coincidencias para: $pattern"
}

# ── Cabecera ─────────────────────────────────────────────────────────────────
echo -e "\n${CYAN}══════════════════════════════════════════════════════"
echo    "  guardian-estructura.sh  |  Yggdrasil-Dew"
$DRY_RUN && echo "  MODO: --dry-run (sin cambios reales)" || echo "  MODO: EJECUCIÓN REAL"
echo -e "══════════════════════════════════════════════════════${NC}\n"

# ── Verificar que estamos en la raíz del repo ────────────────────────────────
if [[ ! -d ".git" ]]; then
  err "Ejecuta desde la raíz del repo (donde está .git)"
  exit 1
fi

# =============================================================================
# 1. CREAR SUBCARPETAS EN docs/
# =============================================================================
info "Creando subcarpetas en docs/ ..."
for d in docs/ecosistema docs/copilot docs/roadmap docs/convenciones \
          docs/reportes docs/arquitectura docs/fix docs/operaciones; do
  if $DRY_RUN; then
    info "[dry-run] mkdir -p $d"
  else
    mkdir -p "$d"
  fi
done

# =============================================================================
# 2. MOVER .md DE docs/ A SUBCARPETAS
# =============================================================================
info "Clasificando archivos en docs/ ..."

# ── ecosistema ──
for f in \
  docs/CORE-ECOSISTEMA.md \
  docs/ISLAS-ECOSISTEMA.md \
  docs/MONITOREO-ECOSISTEMA.md \
  docs/NORMAS-ECOSISTEMA.md \
  docs/AUDITORIA-ECOSISTEMA.md \
  docs/BOTS-ARQUITECTURA.md \
  docs/GUIA-INVESTIGACION.md \
  docs/ORQUESTACION.md \
  docs/PLAN-MAESTRO-ECOSISTEMA.md \
  docs/REGISTRO-HERRAMIENTAS.md \
  docs/GATEWAY-MCP.md; do
  mv_safe "$f" "docs/ecosistema"
done

# ── copilot ──
for f in \
  docs/COPILOT-CONTEXT.md \
  docs/COPILOT-15-AGENTES.md \
  docs/COPILOT-MASTER-TASKLIST.md \
  docs/COPILOT-MASTER-TASKS.md \
  docs/AGENTE-AUTONOMO.md \
  docs/PLANTILLA-AGENTE.md \
  docs/OWNERS.md \
  docs/PROTOCOLO-VERIFICACION-IA.md \
  docs/DECISION-AUTOMATIZACIONES.md \
  docs/AUDITORIA-COPILOT-2026-07-04.md; do
  mv_safe "$f" "docs/copilot"
done

# ── roadmap ──
for f in \
  docs/AUDIT-LOG.md \
  docs/AUDITORIA-COMPLETA.md \
  docs/ESTADO-REAL-VS-ESPERADO.md \
  docs/FICHEROS-CRITICOS.md \
  docs/MAPA-REPO.md \
  docs/DIARIO.md \
  docs/REGLA-DIARY.md \
  docs/GITHUB-ACTIONS.md; do
  mv_safe "$f" "docs/roadmap"
done

# ── convenciones ──
for f in \
  docs/NORMAS-ECOSISTEMA.md \
  docs/OPERATIONAL-PLAYBOOK.md \
  docs/PLAYBOOK-DEPLOY.md \
  docs/PROCESSOS.md; do
  mv_safe "$f" "docs/convenciones"
done

# ── fix / setup ──
for f in \
  docs/FIX-SSH-BLINK.md \
  docs/FIX-SSH-MADRE.md \
  docs/BLINK-COMANDOS-SEGUROS.md \
  docs/INSTALACION-MADRE.md; do
  mv_safe "$f" "docs/fix"
done

# ── reportes (fechados) ──
mv_glob "docs/2026-*.md" "docs/reportes"
mv_glob "docs/AUDIT-SCRIPTS-*.md" "docs/reportes"

# =============================================================================
# 3. MOVER .md SUELTOS DE scripts/ → docs/reportes/
# =============================================================================
info "Moviendo .md sueltos de scripts/ a docs/reportes/ ..."
mv_glob "scripts/2026-*.md"           "docs/reportes"
mv_safe  "scripts/gemini-brief.md"    "docs/reportes"
mv_safe  "scripts/SCRIPTS-AUDITORIA.md" "docs/reportes"
# scripts/README.md y scripts/SCRIPTS.md se quedan (son documentación del propio directorio)

# =============================================================================
# 4. VERIFICACIÓN FINAL
# =============================================================================
echo ""
info "Archivos .md que quedan en docs/ raíz (deberían ser 0):"
REMAINING=$(find docs -maxdepth 1 -name "*.md" 2>/dev/null | wc -l)
if [[ $REMAINING -eq 0 ]]; then
  ok "docs/ raíz limpia — todos los .md están en subcarpetas"
else
  warn "Quedan $REMAINING archivos .md en docs/ raíz — revisar manualmente:"
  find docs -maxdepth 1 -name "*.md" | sed 's/^/    /'
fi

info "Archivos .md que quedan en scripts/ raíz (permitidos: README.md, SCRIPTS.md):"
find scripts -maxdepth 1 -name "*.md" | grep -v -E "(README|SCRIPTS)\.md" | while read f; do
  warn "Inesperado en scripts/: $f"
done || true

# =============================================================================
# 5. COMMIT (solo en modo real)
# =============================================================================
if ! $DRY_RUN; then
  echo ""
  info "Preparando commit ..."
  git add -A
  CHANGES=$(git status --porcelain | wc -l)
  if [[ $CHANGES -gt 0 ]]; then
    git commit -m "refactor(estructura): reorganizar docs/ en subcarpetas y limpiar scripts/

- docs/ecosistema/: CORE, ISLAS, MONITOREO, NORMAS, ORQUESTACION, etc.
- docs/copilot/: COPILOT-CONTEXT, AGENTE-AUTONOMO, PLANTILLA, etc.
- docs/roadmap/: AUDIT-LOG, MAPA-REPO, DIARIO, GITHUB-ACTIONS, etc.
- docs/convenciones/: PLAYBOOK, PROCESSOS, OPERATIONAL-PLAYBOOK
- docs/fix/: FIX-SSH-*, BLINK-*, INSTALACION-MADRE
- docs/reportes/: todos los 2026-*.md fechados + auditorías
- scripts/: eliminados .md sueltos (gemini-brief, 2026-*, SCRIPTS-AUDITORIA)"
    ok "Commit realizado: $CHANGES cambios"
  else
    info "Nada que commitear (todo ya estaba en su sitio)"
  fi
fi

# ── Resumen final ─────────────────────────────────────────────────────────────
echo -e "\n${CYAN}══════════════════════════════════════════════════════"
if $DRY_RUN; then
  echo "  DRY-RUN completado. Para ejecutar de verdad:"
  echo "  bash scripts/guardian-estructura.sh"
else
  echo "  ✅ guardian-estructura.sh completado."
  echo "  Siguiente paso: git push origin main"
fi
echo -e "══════════════════════════════════════════════════════${NC}\n"