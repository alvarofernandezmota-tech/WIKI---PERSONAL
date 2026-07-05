---
tags: [limpieza, raiz, clasificacion, pendiente]
fecha: 2026-07-05
estado: pendiente-ejecutar
---

# 🧹 Plan limpieza raíz WIKI---PERSONAL

> Clasificación generada por Gemini + Perplexity el 2026-07-05.

---

## Se quedan en raíz

```
README.md
HOME.md
CONTEXT.md
AGENT.md
ESTADO-SISTEMA.md
MASTER-PENDIENTES.md
```

---

## Comandos de ejecución en Madre

```bash
cd ~/repos/WIKI---PERSONAL
git pull

# 1. Mover a docs/
git mv CHANGELOG.md docs/
git mv CONTRIBUTING.md docs/
git mv ECOSYSTEM-ARCHITECTURE.md docs/
git mv ESTRUCTURA.md docs/
git mv ROADMAP-MASTER.md docs/

# 2. Mover a wiki/
git mv CONVENCIONES.md wiki/operaciones/
git mv HERRAMIENTAS-ECOSISTEMA.md wiki/infra/
git mv MAPA-ISLAS.md wiki/conocimiento/

# 3. Ver contenido de infra/ antes de fusionar
ls infra/
# Si solo hay .md → mover a wiki/infra/
# Si hay scripts/YAML/.env → mover a madre-config

# 4. Resolver PLAN-SEGURIDAD-Y-DESPLIEGUE.md
# Parte seguridad → yggdrasil-secops
# Parte despliegue → madre-config
cp PLAN-SEGURIDAD-Y-DESPLIEGUE.md ~/repos/yggdrasil-secops/docs/
git rm PLAN-SEGURIDAD-Y-DESPLIEGUE.md

# 5. Commit y push
git add .
git commit -m "chore: limpiar raíz — clasificación Gemini"
git push

# 6. Subir también yggdrasil-secops
cd ~/repos/yggdrasil-secops
git add . && git commit -m "docs: importar plan seguridad desde wiki" && git push
```

---

## Resultado final esperado en raíz

```
WIKI---PERSONAL/
├── README.md
├── HOME.md
├── CONTEXT.md
├── AGENT.md
├── ESTADO-SISTEMA.md
├── MASTER-PENDIENTES.md
├── wiki/
├── docs/
├── diarios/
├── hardware/
├── inbox/
└── _archivo/
```

---

## Nota sobre infra/ vs wiki/infra/

Revisar manualmente antes de ejecutar:
- Solo `.md` → fusionar en `wiki/infra/`
- Scripts / YAML / `.env` → mover a `madre-config`
