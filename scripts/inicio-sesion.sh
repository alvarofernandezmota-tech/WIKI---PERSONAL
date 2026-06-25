#!/bin/bash
set -e
shopt -s nullglob

echo "=========================================================="
echo "        Iniciando Entorno: Yggdrasil-Dew & Madre"
echo "=========================================================="
echo ""

# 1. Sincronización de repositorios (Asumiendo que están en ~/repos)
REPOS_DIR="$HOME/repos"
REPOS=("yggdrasil-dew" "thdora" "batcueva" "huginn")

echo "[*] Sincronizando repositorios desde GitHub..."
for repo in "${REPOS[@]}"; do
    if [ -d "$REPOS_DIR/$repo" ]; then
        echo "  -> Haciendo pull en $repo..."
        git -C "$REPOS_DIR/$repo" pull origin main -q || echo "     [!] Aviso: No se pudo hacer pull en $repo"
    fi
done
echo ""

# 2. Resumen del ESTADO-SISTEMA
echo "[*] ESTADO ACTUAL DEL SISTEMA (Últimas 5 líneas):"
tail -n 5 "$REPOS_DIR/yggdrasil-dew/ESTADO-SISTEMA.md" | sed 's/^/    /'
echo ""

# 3. Mostrar las 3 primeras tareas de MASTER-PENDIENTES
echo "[*] MASTER-PENDIENTES (Top 3 prioridades):"
# Extrae líneas con checkboxes vacíos [ ]
grep -E "^\s*- \[ \]" "$REPOS_DIR/yggdrasil-dew/MASTER-PENDIENTES.md" | head -n 3 | sed 's/^/    /'
echo ""

# 4. Cálculo de deuda en Inbox
INBOX_COUNT=$(ls -1 "$REPOS_DIR/yggdrasil-dew/inbox/"*.md 2>/dev/null | wc -l)
echo "[*] DEUDA DE INBOX: Tienes $INBOX_COUNT ficheros sin procesar."
if [ "$INBOX_COUNT" -gt 10 ]; then
    echo "    [!] ALERTA: Inbox sobrecargada. Prioriza migración."
fi
echo ""

# 5. Creación automática del fichero de sesión en Inbox
TODAY=$(date +"%Y-%m-%d")
TIME=$(date +"%H:%M")
SESION_FILE="$REPOS_DIR/yggdrasil-dew/inbox/${TODAY}-sesion-inicio.md"

if [ ! -f "$SESION_FILE" ]; then
    echo "---" > "$SESION_FILE"
    echo "tags: [tipo/sesion, estado/borrador]" >> "$SESION_FILE"
    echo "fecha: $TODAY" >> "$SESION_FILE"
    echo "hora_inicio: $TIME" >> "$SESION_FILE"
    echo "---" >> "$SESION_FILE"
    echo "# Sesión: $TODAY" >> "$SESION_FILE"
    echo "" >> "$SESION_FILE"
    echo "## Objetivo de la Sesión" >> "$SESION_FILE"
    echo "" >> "$SESION_FILE"
    echo "[*] Fichero de sesión creado: inbox/${TODAY}-sesion-inicio.md"
else
    echo "[*] El fichero de sesión de hoy ya existe."
fi

shopt -u nullglob
echo "=========================================================="
echo "    Entorno listo. Que el rocío de Yggdrasil te guíe."
echo "=========================================================="
