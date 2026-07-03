---
tags: [regla, escalado, arquitectura, inbox]
fecha: 2026-07-03
estado: pendiente-procesar
destino: docs/thdora-guardian/REGLAS-ESCALADO.md
---

# 📈 REGLA DE ESCALADO: Script → Action → Bot

> Documento en inbox. Pendiente mover a docs/thdora-guardian/ tras revisión.

---

## La regla

Cada pieza del ecosistema tiene una capa natural. Escala hacia arriba cuando se cumple el criterio:

```
NIVEL 1 — SCRIPT (bash)
    ↓ si necesita ejecutarse solo o en la nube
NIVEL 2 — GITHUB ACTION (yml)
    ↓ si necesita inteligencia, estado o comunicación
NIVEL 3 — BOT (thdora + Telegram)
```

---

## Cuándo escalar de Script a GitHub Action

| Criterio | Script → Action |
|----------|------------------|
| Se ejecuta en cada push/PR | ✅ Sí |
| No depende de Madre arriba | ✅ Sí |
| Necesita correr en la nube | ✅ Sí |
| Es un cron que no requiere estado local | ✅ Sí |
| Necesita leer el filesystem de Madre | ❌ No |
| Necesita Docker local | ❌ No |

**Ejemplos ya escalados:**
- `health-check.sh` → `repo-health-check.yml`
- `audit-scripts.sh` → `audit-on-push.yml`
- cron nocturno → `sync-estado.yml`

---

## Cuándo escalar de Action a Bot

| Criterio | Action → Bot |
|----------|---------------|
| Necesita respuesta humana (sí/no) | ✅ Sí |
| Necesita contexto de conversación | ✅ Sí |
| Necesita acceder a Madre en tiempo real | ✅ Sí |
| El resultado debe llegar al móvil | ✅ Sí |
| Es información one-shot sin interacción | ❌ No |

**Ejemplos planificados:**
- `clasificador.yml` detecta zombie → Bot envía alerta Telegram
- `sync-estado.yml` detecta inbox llena → Bot pide `/procesar`
- Docker caído → Bot alerta inmediata

---

## Las reglas se completan hacia abajo

Las reglas de nivel superior (repo) definen el marco.
Las reglas de nivel inferior (módulo) lo concretan.
Nunca contradicen a las de arriba.

```
REGLAS REPO (CONVENCIONES.md)
  └── REGLAS SCRIPTS (scripts/SCRIPTS.md)
        └── REGLAS ACTIONS (.github/workflows/)
              └── REGLAS BOT (docs/thdora-guardian/LIGA.md)
```

Cada nivel documenta sus propias reglas pero hereda todo lo de arriba.
