#!/usr/bin/env bash
# ============================================================
# ARCHIVO      : copilot-mission-briefing.sh
# VERSIÓN      : 1.0.0
# FUNCIÓN ÚNICA: Genera briefing completo para Copilot con mapa
#                real de scripts, agentes y Actions del repo
#                + prompts de 3 fases para trabajo autónomo
# AUTOR        : alvarofernandezmota-tech
# REPO         : alvarofernandezmota-tech/yggdrasil-dew
# USO          : bash scripts/copilot-mission-briefing.sh
# ============================================================

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo "$HOME/yggdrasil-dew")"
OUTPUT_FILE="$REPO_ROOT/inbox/COPILOT-BRIEFING-$(date +%Y%m%d-%H%M).md"
DATE_NOW=$(date "+%Y-%m-%d %H:%M:%S")

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

echo -e "${CYAN}${BOLD}============================================${RESET}"
echo -e "${CYAN}${BOLD}  YGGDRASIL-DEW — COPILOT BRIEFING TOOL   ${RESET}"
echo -e "${CYAN}${BOLD}============================================${RESET}"
echo ""

# ──────────────────────────────────────────────────────────────
# 1. INVENTARIO REAL DE SCRIPTS
# ──────────────────────────────────────────────────────────────
echo -e "${YELLOW}[1/4] Inventariando scripts...${RESET}"

SCRIPTS_LIST=""
if [ -d "$REPO_ROOT/scripts" ]; then
  while IFS= read -r f; do
    name=$(basename "$f")
    funcion=$(grep -m1 "FUNCIÓN" "$f" 2>/dev/null | sed 's/.*FUNCIÓN[^:]*://' | xargs || echo "sin declarar")
    SCRIPTS_LIST+="| \`$name\` | $funcion |\n"
  done < <(find "$REPO_ROOT/scripts" -maxdepth 1 -name "*.sh" | sort)
fi

# ──────────────────────────────────────────────────────────────
# 2. INVENTARIO REAL DE GITHUB ACTIONS
# ──────────────────────────────────────────────────────────────
echo -e "${YELLOW}[2/4] Inventariando GitHub Actions...${RESET}"

ACTIONS_LIST=""
ACTIONS_COUNT=0
if [ -d "$REPO_ROOT/.github/workflows" ]; then
  for f in "$REPO_ROOT/.github/workflows"/*.yml; do
    name=$(basename "$f" .yml)
    trigger=$(grep -A2 '^on:' "$f" 2>/dev/null | tail -1 | xargs || echo "ver yml")
    ACTIONS_LIST+="| \`$name\` | $trigger |\n"
    ((ACTIONS_COUNT++)) || true
  done
fi

# ──────────────────────────────────────────────────────────────
# 3. INVENTARIO DE AGENTES
# ──────────────────────────────────────────────────────────────
echo -e "${YELLOW}[3/4] Inventariando agentes...${RESET}"

AGENTES_LIST=""
if [ -d "$REPO_ROOT/scripts/agentes" ]; then
  while IFS= read -r f; do
    name=$(basename "$f")
    AGENTES_LIST+="- \`$name\`\n"
  done < <(find "$REPO_ROOT/scripts/agentes" -type f | sort)
else
  AGENTES_LIST="- carpeta scripts/agentes/ pendiente de crear\n"
fi

# ──────────────────────────────────────────────────────────────
# 4. ESCRIBIR EL BRIEFING
# ──────────────────────────────────────────────────────────────
echo -e "${YELLOW}[4/4] Generando briefing en inbox/...${RESET}"
mkdir -p "$REPO_ROOT/inbox"

{
cat << 'HEADER'
# COPILOT BRIEFING — yggdrasil-dew
HEADER

echo "> Generado: ${DATE_NOW}"
echo "> Propósito: Contexto completo para que Copilot trabaje autónomamente"
echo "> Uso: pega cada PROMPT en Copilot Chat antes de cada fase"
echo ""
echo "---"
echo ""

cat << 'CONTEXT_SECTION'
## CONTEXTO DEL SISTEMA

Repo centralizado (Madre) del ecosistema yggdrasil-dew.

**Arquitectura:**
- Un solo repo: `alvarofernandezmota-tech/yggdrasil-dew`
- Scripts bash en `scripts/` — función única cada uno
- Agentes especializados en `scripts/agentes/`
- GitHub Actions en `.github/workflows/` — orquestación automática
- `inbox/` — zona de entrada/salida de información
- `diarios/` — trazabilidad de todo lo que ocurre
- Islas temáticas: `isla-proyectos/`, `isla-hardware/`, etc.

**Reglas non-negotiable:**
1. Cada script declara UNA función única: `# FUNCIÓN ÚNICA:`
2. Todo script termina documentando en `inbox/` o `diarios/`
3. Si detecta inconsistencia → abre issue con `scripts/issue-creator.sh`
4. Plantilla de cabecera obligatoria (ver scripts/PLANTILLA-BASE.sh)

---

## MAPA DE SCRIPTS

| Script | Función declarada |
|--------|------------------|
CONTEXT_SECTION

echo -e "$SCRIPTS_LIST"
echo ""
echo "---"
echo ""
echo "## MAPA DE GITHUB ACTIONS ($ACTIONS_COUNT Actions)"
echo ""
echo "| Action | Trigger |"
echo "|--------|---------|"
echo -e "$ACTIONS_LIST"
echo ""
echo "---"
echo ""
echo "## AGENTES"
echo ""
echo -e "$AGENTES_LIST"
echo ""

cat << 'PROMPTS_SECTION'
---

## PROMPTS PARA COPILOT — 3 FASES

---

### FASE 1 — AUDITORÍA Y UNIFICACIÓN DE PLANTILLAS
> Copia el bloque de abajo y pégalo en Copilot Chat

```
Eres el agente de auditoría del repo yggdrasil-dew.
Repo: alvarofernandezmota-tech/yggdrasil-dew

CONTEXTO DEL SISTEMA:
- Repo centralizado con scripts bash, Actions y agentes especializados
- Cada script debe tener cabecera con: ARCHIVO, VERSIÓN, FUNCIÓN ÚNICA, AUTOR, REPO, USO
- FUNCIÓN ÚNICA = una sola responsabilidad por script, sin excepción

TU MISIÓN:
1. Lee todos los archivos en scripts/ y scripts/agentes/
2. Para cada script SIN cabecera estándar → añádela respetando su lógica
3. Para cada FUNCIÓN ÚNICA duplicada entre scripts → abre issue:
   gh issue create --title "DUPLICADO: scriptA vs scriptB" --label "deuda-tecnica"
4. Genera scripts/INVENTARIO-VALIDADO.md con tabla:
   script | función | cabecera-ok | documenta-al-final
5. NO toques la lógica, solo cabeceras y documentación final

COMMIT por cada lote de 5 scripts: "audit(scripts): estandarizar cabeceras lote N"

VERIFICA AL FINAL:
grep -rL "FUNCIÓN ÚNICA" scripts/ → debe devolver 0 archivos
```

---

### FASE 2 — CONECTAR SCRIPTS CON ACTIONS Y CERRAR EL BUCLE
> Solo después de que Fase 1 esté commiteada

```
Eres el agente de integración de yggdrasil-dew.
Fase 1 completada: todos los scripts tienen cabecera estándar.

BUCLE CORRECTO DEL SISTEMA:
Action YML → invoca script bash → script documenta en inbox/ → si error → abre issue

TU MISIÓN:
1. Para cada Action en .github/workflows/:
   → verifica que el script que invoca EXISTE en scripts/
   → si no existe: crea script con plantilla vacía + abre issue "FALTA script para [action]"

2. Para cada script en scripts/:
   → verifica que existe una Action que lo invoca O está marcado como "script manual"
   → si no tiene Action ni documentación → añade entrada a scripts/SCRIPTS-SIN-ACTION.md

3. Verifica que estos scripts llaman a issue-creator.sh cuando fallan:
   struct-auditor.sh, ghost-file-detector.sh, cross-ref-checker.sh, isla-sync-validator.sh
   → si alguno no lo llama: añade el bloque de llamada al final

4. Verifica que diary-writer.yml e inbox-cleanup.yml no tienen conflicto horario
   → si corren a la misma hora: desplaza uno 30 minutos

COMMIT por subsistema: "integrate([subsistema]): cerrar bucle script-action"

VERIFICA AL FINAL:
bash scripts/tool-inventory-auditor.sh
→ resultado esperado: 0 scripts huérfanos, 0 Actions sin script
```

---

### FASE 3 — AUTODETECCIÓN Y AUTORREPARACIÓN
> Solo después de Fase 2 commiteada

```
Eres el agente de autonomía de yggdrasil-dew.
Fases 1 y 2 completas. El sistema ahora debe detectarse y repararse solo.

PRINCIPIO: cualquier inconsistencia >1h genera issue automático.

PASO 3A — Crear scripts/autodiagnostico-maestro.sh:
Orquesta en orden estos auditores:
  0. check-mcp-status.sh (MCP server operativo)
  1. struct-auditor.sh
  2. ghost-file-detector.sh
  3. isla-sync-validator.sh
  4. cross-ref-checker.sh
  5. tool-inventory-auditor.sh
Si cualquiera falla → issue automático con label "sistema-critico"
Al final → resumen en inbox/AUTODIAGNOSTICO-$(date +%Y%m%d).md
Cabecera estándar obligatoria + FUNCIÓN ÚNICA.

PASO 3B — Crear .github/workflows/autodiagnostico-maestro.yml:
  trigger: cron "0 */6 * * *" + workflow_dispatch
  invoca: bash scripts/autodiagnostico-maestro.sh
  si falla: issue con label "sistema-critico"
  timeout: 10min

PASO 3C — Verificar MCP server:
  → Crea scripts/mcp/check-mcp-status.sh
  → Si socket no responde: documenta en inbox/ y abre issue
  → Integra como paso 0 en autodiagnostico-maestro.sh

COMMIT por paso: "feat(autonomia): [descripcion]"

VERIFICA AL FINAL:
gh workflow run autodiagnostico-maestro.yml
# espera 2 min
gh run list --workflow=autodiagnostico-maestro.yml
→ resultado esperado: status=completed, conclusion=success
```

---

## CHECKLIST DE AVANCE

- [ ] FASE 1 commiteada y verificada
- [ ] FASE 2 commiteada y verificada
- [ ] FASE 3 commiteada y verificada
- [ ] MCP server operativo
- [ ] Autodiagnóstico corriendo cada 6h sin errores
- [ ] 0 scripts sin cabecera estándar
- [ ] 0 Actions sin script correspondiente
- [ ] 0 archivos fantasma detectados
PROMPTS_SECTION

} > "$OUTPUT_FILE"

echo ""
echo -e "${GREEN}${BOLD}✅ BRIEFING GENERADO:${RESET}"
echo -e "${GREEN}   $OUTPUT_FILE${RESET}"
echo ""
echo -e "${BOLD}PASOS SIGUIENTES:${RESET}"
echo -e "  1. ${CYAN}cat $OUTPUT_FILE${RESET}"
echo -e "  2. Abre Copilot Chat y pega el PROMPT FASE 1"
echo -e "  3. Mientras Copilot trabaja → tú avanzas en otra terminal"
echo -e "  4. ${CYAN}git add -A && git commit -m 'docs(copilot): briefing ejecutado'${RESET}"
echo ""
echo -e "${YELLOW}⚡ Copiar al portapapeles:${RESET}"
echo -e "  macOS : ${CYAN}cat $OUTPUT_FILE | pbcopy${RESET}"
echo -e "  Linux : ${CYAN}cat $OUTPUT_FILE | xclip -selection clipboard${RESET}"
