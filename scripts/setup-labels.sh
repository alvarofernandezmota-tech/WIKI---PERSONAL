#!/usr/bin/env bash
# ==============================================================
# SETUP LABELS GitHub — yggdrasil-dew
# Requiere: gh autenticado
# Uso: bash scripts/setup-labels.sh
# Arch Linux: yay -S github-cli  (NO apt)
# ==============================================================

REPO="alvarofernandezmota-tech/yggdrasil-dew"

if ! command -v gh &>/dev/null; then
  echo "❌ gh no instalado."
  echo "   Arch Linux: yay -S github-cli"
  echo "   Luego: gh auth login"
  exit 1
fi

echo "🏷️  Creando labels en $REPO..."
echo ""

create_label() {
  local name="$1" color="$2" desc="$3"
  gh label create "$name" --color "$color" --description "$desc" --repo "$REPO" --force 2>/dev/null \
    && echo "  ✅ $name" \
    || echo "  ⚠️  $name (ya existe o error)"
}

# FASES
create_label "fase-0-base"        "0075ca" "Fase 0: Estructura base repo"
create_label "fase-1-seguridad"   "d93f0b" "Fase 1: Hardening y seguridad Madre"
create_label "fase-2-batcueva"    "e4e669" "Fase 2: Servicios Batcueva"
create_label "fase-3-backup"      "0e8a16" "Fase 3: Restic backups"
create_label "fase-4-red"         "5319e7" "Fase 4: Red y VPN"
create_label "fase-5-docker"      "1d76db" "Fase 5: Docker stack"
create_label "fase-6-thdora"      "e99695" "Fase 6: Bot Telegram thdora"
create_label "fase-7-ollama"      "f9d0c4" "Fase 7: Ollama IA local"
create_label "fase-8-agentes"     "bfd4f2" "Fase 8: Agentes IA"
create_label "fase-9-osint"       "c2e0c6" "Fase 9: OSINT stack"

# PRIORIDAD
create_label "prioridad-critica"  "b60205" "🔴 Bloquea el progreso"
create_label "prioridad-alta"     "e11d48" "🟠 Esta semana"
create_label "prioridad-media"    "f59e0b" "🟡 Este mes"
create_label "prioridad-baja"     "84cc16" "🟢 Backlog"

# TIPO
create_label "bug"                "d73a4a" "Algo no funciona"
create_label "feature"            "a2eeef" "Nueva funcionalidad"
create_label "docs"               "0075ca" "Documentación"
create_label "infra"              "e4e669" "Infraestructura"
create_label "deuda-tecnica"      "cc317c" "Refactor / deuda técnica"
create_label "auditoria"          "fef2c0" "Revisión y alineación"
create_label "sesion"             "ededed" "Registro de sesión"
create_label "agente-pendiente"   "0052cc" "Esperando al agente IA"

echo ""
echo "✅ Labels configurados. Ver en:"
echo "   https://github.com/$REPO/labels"
