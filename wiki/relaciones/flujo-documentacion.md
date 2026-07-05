---
tipo: relacion
nombre: Flujo de documentación
islas: [cerebro]
obsidian_link: "[[flujo-documentacion]]"
estado: activo
---

# 🔗 Relación: Cómo fluye la documentación en el ecosistema

Esta página explica **dónde va cada tipo de información** y cómo Obsidian y GitHub se retroalimentan.

## Regla definitiva — qué va dónde

| ¿Qué es? | ¿Dónde va? | URL |
|---|---|---|
| Diario de sesión | `yggdrasil-dew/docs/diarios/` | https://github.com/alvarofernandezmota-tech/yggdrasil-dew/tree/main/docs/diarios |
| Arquitectura ecosistema | `yggdrasil-dew/ECOSYSTEM-ARCHITECTURE.md` | https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/ECOSYSTEM-ARCHITECTURE.md |
| Mapa conceptual / islas | `WIKI---PERSONAL/wiki/islas/` | https://github.com/alvarofernandezmota-tech/WIKI---PERSONAL/tree/main/wiki/islas |
| Relaciones entre islas | `WIKI---PERSONAL/wiki/relaciones/` | https://github.com/alvarofernandezmota-tech/WIKI---PERSONAL/tree/main/wiki/relaciones |
| Tarea técnica (issue) | `yggdrasil-dew/issues` | https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues |
| Backlog global | `yggdrasil-dew/MASTER-PENDIENTES.md` | https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/MASTER-PENDIENTES.md |
| Config servidor Madre | `madre-config/` | https://github.com/alvarofernandezmota-tech/madre-config |
| Hallazgo seguridad | `yggdrasil-secops/hallazgos/HAL-XXX` | https://github.com/alvarofernandezmota-tech/yggdrasil-secops/tree/main/hallazgos |
| Apunte técnico | `formacion-tech/<área>/` | https://github.com/alvarofernandezmota-tech/formacion-tech |
| Contexto personal/HW | `WIKI---PERSONAL/wiki/` | https://github.com/alvarofernandezmota-tech/WIKI---PERSONAL/tree/main/wiki |
| Proto sin repo propio | `dev-labs/` | https://github.com/alvarofernandezmota-tech/dev-labs |

## Flujo GitHub ↔ Obsidian

```
Obsidian Vault (WIKI---PERSONAL clonado)
    │
    ├── git pull origin main  ← sincroniza notas desde GitHub
    │
    ├── Editas notas en Obsidian
    │        (frontmatter con github_issues: [#N])
    │        (enlaces [[isla]] entre notas)
    │
    └── git push origin main  → sube cambios a GitHub

GitHub Issues (yggdrasil-dew)
    │
    ├── Cada issue referencia la nota de WIKI con URL
    └── Cada nota de WIKI referencia el issue con #N
```

## Cómo clonar los repos en Obsidian vault

```bash
# En el directorio de tu Obsidian vault
cd ~/ObsidianVault   # o donde tengas el vault

# Clonar WIKI como subcarpeta del vault
git clone https://github.com/alvarofernandezmota-tech/WIKI---PERSONAL ./WIKI

# O directamente usar WIKI---PERSONAL como el vault
git clone https://github.com/alvarofernandezmota-tech/WIKI---PERSONAL
cd WIKI---PERSONAL
# Abrir esta carpeta como vault en Obsidian
```

## Frontmatter estándar para notas de isla

```yaml
---
tipo: isla
nombre: [nombre]
descripcion: [descripción corta]
repo_principal: [URL GitHub]
github_issues: [#N, #N]
obsidian_link: "[[nombre]]"
depende_de: [isla1, isla2]
sirve_a: [isla1, isla2]
estado: activo | pausado | archivado
---
```

---
_Actualizado: 2026-07-05 · Perplexity-MCP_
