---
tipo: plan-sesion
fecha: 2026-06-24
hora: "06:51"
status: pendiente
tags: [plan, migracion, inbox, diario, automatizacion, pendientes]
priority: ALTA
---

# 📅 PLAN PROXIMA SESION — Mañana

> Leer esto primero al abrir el portátil mañana.

---

## Orden del día (en secuencia)

1. **Migración inbox** — procesar todo lo de hoy a su sitio definitivo
2. **Configurar migración automática** del inbox
3. **Revisar descargas** — ver qué modelos terminó de bajar Ollama
4. **Sesión Gemini + Grok** — investigación modelos (prompt en inbox #3)

---

## ❓ Preguntas pendientes de resolver

### 1. ¿Cada cuánto migrar el inbox?

Opciones a debatir:

| Frecuencia | Pros | Contras |
|------------|------|---------|
| Cada día (cron diario) | Inbox siempre limpio | Puede mover cosas sin terminar |
| Cada semana (lunes) | Tiempo de madurar ideas | Se acumula |
| Manual con comando | Control total | Requiere disciplina |
| Al cerrar sesión (script) | Natural | Depende de acordarse |

**Recomendación a valorar:** semanal automatico (domingo noche) + manual cuando quieras.
El inbox es zona de aterrizaje, no archivo permanente.

### 2. ¿Quién hace la migración? ¿IA con etiquetas?

Flujo propuesto:
```
inbox/ fichero nuevo
    ↓
  IA lee frontmatter (tipo, tags, fecha)
    ↓
  Detecta destino: docs/ | ollama/ | proyectos/ | diarios/ | etc.
    ↓
  Mueve + actualiza enlaces internos
    ↓
  Commit automático
```

Preguntas que quedan abiertas:
- [ ] ¿THDORA hace esto o un script Python independiente?
- [ ] ¿Qué pasa si el tipo no está claro? ¿pregunta o deja en inbox?
- [ ] ¼Reglas de naming para el fichero destino?

### 3. Diario automático con commits del día

El script `cierre-sesion.sh` ya existe en `setup/servidor/scripts/`.

Preguntas pendientes:
- [ ] ¿Ese script ya hace `git log` del día y lo mete en `diarios/`?
- [ ] Si no, añadirle este bloque:

```bash
# Al final de cierre-sesion.sh
FECHA=$(date +%Y-%m-%d)
LOG_HOY=$(git -C ~/yggdrasil-dew log --oneline --since="00:00" --until="23:59")
echo "## Commits $FECHA" >> diarios/$FECHA.md
echo "\`\`\`" >> diarios/$FECHA.md
echo "$LOG_HOY" >> diarios/$FECHA.md
echo "\`\`\`" >> diarios/$FECHA.md
git -C ~/yggdrasil-dew add diarios/$FECHA.md
git -C ~/yggdrasil-dew commit -m "diario: auto-log $FECHA"
```

- [ ] Revisar qué tiene ya `cierre-sesion.sh` antes de tocar nada

---

## Cosas que faltan para automatización completa

- [ ] Script migración inbox → destino (con o sin IA)
- [ ] Cron semanal migración
- [ ] `cierre-sesion.sh` actualizado con auto-log commits
- [ ] Definir reglas de etiquetado del frontmatter para que la IA sepa dónde va cada cosa
- [ ] Tabla tipo → destino:

| tipo (frontmatter) | Destino en repo |
|--------------------|-----------------|
| `tesis-arquitectura` | `docs/arquitectura/` |
| `debate-multi-ia` | `docs/ias/debates/` |
| `bitacora-debate` | `docs/ias/debates/` |
| `sesion-investigacion` | `docs/investigacion/` |
| `plan-sesion` | archivo o borrar |
| `resumen-sesion` | `diarios/` |
| `ficha-modelo` | `docs/ias/` o `ollama/` |
| `prompt-maestro` | `agentes/prompts/` |
| `filosofia-core` | raíz del repo |

---

## Estado descargas Ollama al cerrar sesión (revisar mañana)

```bash
ollama list
# Ver cuáles de estos terminaron:
# qwen2.5:7b  ⏳
# qwen2.5:14b ⏳ (ETA 3h43m desde 06:12 = ~10:00)
# llama3.1:8b ⏳
# mistral:7b  ⏳
# bge-m3      ⏳
# nomic-embed-text ⏳
```

> ⚠️ qwen2.5:14b probablemente listo pero NO cargarlo con stack activo.
> Ver tesis arquitectura antes de probarlo.

---

## Links rápidos para mañana

- [Prompt Gemini listo](2026-06-24-SESION-INVESTIGACION-MODELOS-COMPLETA.md)
- [Veredicto Ollama domado + config](2026-06-24-BITACORA-FINAL-OLLAMA-VS-LLAMACPP.md)
- [Tesis arquitectura](2026-06-24-TESIS-ARQUITECTURA-MINIMALISTA-OPENSOUECE.md)
- [Resumen sesión completa](2026-06-24-SESION-COMPLETA-RESUMEN.md)
- [cierre-sesion.sh](../setup/servidor/scripts/cierre-sesion.sh)
