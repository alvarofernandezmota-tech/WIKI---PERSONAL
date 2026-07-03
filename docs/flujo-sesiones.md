# Flujo de sesiones — yggdrasil-dew

> **Regla de oro:** Todo entra por `inbox/drop/`. Los Actions lo clasifican solos.

---

## El flujo completo

```
Terminal
   │
   ├─ bash scripts/apertura-maestra.sh "objetivo"   ← abre sesión
   │
   │  [trabajas normalmente...]
   │
   ├─ cp archivo.md inbox/drop/                     ← metes un archivo
   ├─ bash scripts/inbox-commit.sh "descripción"   ← commitea todo drop/
   │         │
   │         └──→ GitHub Actions: inbox-clasificador.yml
   │                     │
   │                     ├─ cierre-*.md  → diarios/
   │                     ├─ *.sh         → scripts/
   │                     ├─ *.py         → scripts/agentes/
   │                     ├─ audit-*      → inbox/_meta/
   │                     ├─ doc-*        → docs/
   │                     └─ *.md genérico → diarios/FECHA-nombre.md
   │
   └─ bash scripts/cierre-maestro.sh "descripción" ← cierra sesión
              │
              ├─ Genera inbox/sesiones/cierre-FECHA.md
              ├─ Auditoría rápida de estructura
              └─ git push → Action mueve cierre a diarios/
```

---

## Comandos de uso diario

### Abrir sesión
```bash
bash scripts/apertura-maestra.sh "objetivo de hoy"
```

### Meter un archivo al ecosistema
```bash
cp /ruta/de/mi/archivo.md inbox/drop/
bash scripts/inbox-commit.sh "breve descripción"
```

### Auditoría manual
```bash
# Solo ver qué hay mal (no toca nada)
bash scripts/auditoria-maestra.sh --dry-run

# Ver y corregir automáticamente
bash scripts/auditoria-maestra.sh --fix
```

### Cerrar sesión
```bash
bash scripts/cierre-maestro.sh "qué hice hoy"
```

---

## Reglas de clasificación (inbox-clasificador.yml)

| Nombre del archivo | Destino |
|---|---|
| `cierre-*` | `diarios/` |
| `apertura-*` | `inbox/sesiones/` |
| `audit-*` | `inbox/_meta/` |
| `*.sh` | `scripts/` |
| `*.py` | `scripts/agentes/` |
| `diario-*` / `journal-*` | `diarios/` |
| `doc-*` / `docs-*` | `docs/` |
| `*.yml` / `*.yaml` | `.github/workflows/` |
| cualquier `.md` genérico | `diarios/FECHA-nombre.md` |
| cualquier otro | `inbox/sesiones/` |

---

## Scripts maestros

| Script | Cuándo ejecutarlo |
|---|---|
| `apertura-maestra.sh` | Al empezar a trabajar |
| `cierre-maestro.sh` | Al terminar la sesión |
| `auditoria-maestra.sh` | Cuando quieras revisar estado |
| `inbox-commit.sh` | Cada vez que metes algo a drop/ |

---

## Actions automáticos

| Action | Cuándo se ejecuta | Qué hace |
|---|---|---|
| `inbox-clasificador.yml` | Push en `inbox/drop/**` | Mueve archivos a su destino correcto |
| `auditoria-auto.yml` | Cada push a main + 6:00 UTC diario | Genera reporte en `inbox/_meta/` |
