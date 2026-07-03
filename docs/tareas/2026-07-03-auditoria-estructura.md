---
tags: [auditoria, estructura, inbox, zombies]
fecha: 2026-07-03
estado: pendiente-procesar
destino: docs/audits/
---

# 🔍 AUDITORÍA DE ESTRUCTURA — 2026-07-03

> Generado en sesión. Pendiente de procesar y ejecutar acciones.

---

## Archivos fuera de estructura (raíz)

| Archivo | Problema | Acción |
|---------|---------|--------|
| `macro-noche.sh` | Script suelto en raíz | Mover a `scripts/maintenance/` |
| `bootstrap.sh` | Script suelto en raíz | Mover a `scripts/setup/` |

**Comando para ejecutar en Madre:**
```bash
cd ~/yggdrasil-dew
mv macro-noche.sh scripts/maintenance/
mv bootstrap.sh scripts/setup/
git add -A
git commit -m "refactor(scripts): mover scripts sueltos de raíz a subdirectorios"
git push
```

---

## Carpetas duplicadas o sin definir

| Carpeta | Problema | Decisión pendiente |
|---------|---------|--------------------|
| `diarios/` (raíz) | Duplica `docs/diarios/` | Consolidar en `docs/diarios/` |
| `osint/` + `osint-stack/` | Dos carpetas del mismo tema | Unificar en `docs/infra/osint/` |
| `mocs/` | Sin definición clara | Auditar contenido y mover a `docs/mocs/` |
| `yo/` | Carpeta personal sin estructura | Mover a `docs/personal/` o borrar |
| `alvarofernandezmota-tech/` | Perfil GitHub dentro del repo | Mover a `docs/profile/` |
| `thdora/` en yggdrasil-dew | Solo debe tener docs de thdora, no código | Limpiar, código vive en `~/Projects/thdora/` |

---

## Archivos diarios fuera de estructura

Los diarios van en `docs/diarios/YYYY-MM-DD.md`.
Si hay archivos en `diarios/` (raíz), son duplicados o viejos.

**Verificar:**
```bash
ls ~/yggdrasil-dew/diarios/
ls ~/yggdrasil-dew/docs/diarios/
# Si son los mismos -> borrar la carpeta raiz
# Si hay distintos -> migrar y borrar
```

---

## Regla derivada de esta auditoría

> **Regla RAIZ-LIMPIA**: La raíz del repo solo puede contener:
> `.md` de gobernanza (README, ROADMAP, CONVENCIONES...),
> `.github/`, `docs/`, `scripts/`, `diarios/` (temporal, migrar),
> `.gitignore`, `.env.template`.
> **Ningún script `.sh` vive en raíz. Jamás.**

Esta regla debe añadirse a `CONVENCIONES.md`.

---

## Estado de acción

- [ ] Mover `macro-noche.sh` y `bootstrap.sh` — needs-terminal en Madre
- [ ] Decidir carpetas duplicadas — próxima sesión
- [ ] Añadir regla RAIZ-LIMPIA a CONVENCIONES.md — vía MCP ✅

_Creado: 2026-07-03 06:55 CEST — Perplexity MCP_
