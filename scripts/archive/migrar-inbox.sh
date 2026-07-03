#!/usr/bin/env bash
# migrar-inbox.sh — script semi-automático de migración inbox
# Uso: bash scripts/migrar-inbox.sh
# Requiere: estar en la raíz del repo yggdrasil-dew

set -e

REPO_ROOT="$(git rev-parse --show-toplevel)"
INBOX="$REPO_ROOT/inbox"
PROCESADO="$REPO_ROOT/inbox/procesado"
LOG="$REPO_ROOT/docs/operativa/migraciones-inbox.md"

echo ""
echo "═══════════════════════════════════════"
echo "  📥 MIGRAR INBOX — yggdrasil-dew"
echo "═══════════════════════════════════════"
echo ""

# Crear procesado/ si no existe
mkdir -p "$PROCESADO"

# Listar ficheros pendientes
PENDIENTES=$(find "$INBOX" -maxdepth 1 -name "*.md" -not -name ".gitkeep" | sort)

if [ -z "$PENDIENTES" ]; then
  echo "✅ Inbox limpia. No hay ficheros pendientes."
  exit 0
fi

echo "Ficheros pendientes:"
echo ""

COUNT=0
while IFS= read -r fichero; do
  NOMBRE=$(basename "$fichero")
  COUNT=$((COUNT + 1))
  echo "  $COUNT. $NOMBRE"
done <<< "$PENDIENTES"

echo ""
echo "Total: $COUNT ficheros"
echo ""
echo "────────────────────────────────────────"
echo "Para cada fichero, indica el destino en docs/"
echo "Pulsa ENTER para saltar (procesar manualmente)"
echo "────────────────────────────────────────"
echo ""

FECHA_HOY=$(date +%Y-%m-%d)
MIGRACIONES=""

while IFS= read -r fichero; do
  NOMBRE=$(basename "$fichero")
  echo "📄 $NOMBRE"
  echo "   Primeras líneas:"
  head -5 "$fichero" | sed 's/^/   /'
  echo ""
  read -p "   Destino (ej: docs/diarios/$FECHA_HOY.md) o ENTER para saltar: " DESTINO

  if [ -z "$DESTINO" ]; then
    echo "   ⏭️  Saltado"
    echo ""
    continue
  fi

  # Crear directorio destino si no existe
  DEST_DIR=$(dirname "$REPO_ROOT/$DESTINO")
  mkdir -p "$DEST_DIR"

  # Si el destino no existe, copiar el fichero
  if [ ! -f "$REPO_ROOT/$DESTINO" ]; then
    cp "$fichero" "$REPO_ROOT/$DESTINO"
    echo "   ✅ Copiado a $DESTINO"
  else
    echo "   ⚠️  El destino ya existe. Abriendo para revisión manual."
  fi

  # Crear stub en procesado/
  STUB="$PROCESADO/$NOMBRE"
  cat > "$STUB" << EOF
---
archivado: $FECHA_HOY
migrado_a: $DESTINO
---

# → ARCHIVADO

Contenido migrado a [$DESTINO](../../$DESTINO)
EOF

  # Eliminar original de inbox
  rm "$fichero"
  echo "   📦 Archivado en inbox/procesado/$NOMBRE"
  echo ""

  MIGRACIONES="$MIGRACIONES\n| \`inbox/$NOMBRE\` | \`$DESTINO\` | ✅ migrado |"
done <<< "$PENDIENTES"

# Mostrar resumen
echo ""
echo "════════════════════════════════════════"
echo "✅ Migración completada."
echo ""
echo "Próximos pasos:"
echo "  1. Actualizar docs/operativa/migraciones-inbox.md"
echo "  2. git add -A"
echo "  3. git commit -m \"migration(inbox): [descripción]\""
echo "  4. git push"
echo "════════════════════════════════════════"
