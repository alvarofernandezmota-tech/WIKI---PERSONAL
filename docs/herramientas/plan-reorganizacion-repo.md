---
tags: [repo, estructura, reorganizacion, pendientes]
fecha: 2026-07-02
estado: en-proceso
---

# 🗂️ Plan de reorganización del repositorio

> Documentado en sesión nocturna 02-jul-2026 desde iPhone 11 vía Perplexity + MCP.
> Seguir convenciones de `CONVENCIONES.md`.

---

## Diagnóstico de la estructura actual

### 🔴 Problemas serios detectados

| Fichero/Carpeta | Problema | Acción |
|---|---|---|
| `tailscale-full.apk` | Binario commiteado en la raíz | Borrar con `git rm` + limpiar historial |
| `ly` | Fichero vacío sin extensión | `git rm ly` |
| `.obsidian/` | Config local de Obsidian commiteada | `git rm -r --cached .obsidian/` |
| `osint/` y `osint-stack/` | Duplicidad de propósito | Revisar contenido y fusionar |
| `tools/` y `cli-tools/` | Duplicidad de propósito | Revisar contenido y fusionar en `scripts/` |
| `diarios/` en raíz | Documentación narrativa fuera de `docs/` | Mover a `docs/diarios/` |
| `mocs/` en raíz | Documentación fuera de `docs/` | Mover a `docs/mocs/` |
| `filosofia.md` en raíz | Documento narrativo en raíz | Mover a `docs/filosofia.md` |
| MDs grandes en raíz | `ECOSISTEMA`, `PLAN-SEGURIDAD`, `MASTER-PENDIENTES`... | Evaluar si van a `docs/` |

### 🟡 Estructura mejorable

- Raíz saturada de `.md` operativos
- Sin jerarquía clara entre carpetas técnicas y documentación
- `inbox/` sin convención definida

### ✅ Lo que está bien

- `.github/` con workflows
- `scripts/`, `docker/`, `setup/`, `infra/` con estructura estándar
- `.env.template` presente
- `agentes/`, `ollama/` coherentes con el caso de uso

---

## Estructura objetivo

```
yggdrasil-dew/
├── README.md
├── CHANGELOG.md
├── ROADMAP.md
├── CONVENCIONES.md
├── .env.template
├── .gitignore
├── .github/
├── infra/
├── docker/
├── scripts/          ← fusiona cli-tools/ y tools/ aquí
├── setup/
├── ollama/
├── osint/            ← fusiona osint-stack/ aquí
├── agentes/
├── thdora/
├── proyectos/
├── formacion/
├── hardware/
├── yo/
└── docs/
    ├── herramientas/
    ├── infra/
    ├── diarios/          ← mover desde diarios/
    ├── mocs/             ← mover desde mocs/
    └── filosofia.md      ← mover desde raíz
```

---

## Tareas pendientes

### ✅ Sin terminal (hechas o hacibles desde Perplexity + MCP)

- [x] `.gitignore` actualizado con `.obsidian/`, `*.apk`, `ly`
- [x] `CONVENCIONES.md` con estructura objetivo documentada
- [x] Este plan documentado
- [ ] Profile README del perfil GitHub (`alvarofernandezmota-tech`)
- [ ] Reorganizar docs de la raíz a `docs/`
- [ ] Revisar contenido de `osint-stack/` y `cli-tools/`
- [ ] Actualizar `HOME.md` con estructura real

### ❌ Necesita terminal (hacer cuando estés en Acer)

```bash
# 1. Borrar fichero basura ly
git rm ly

# 2. Borrar APK del tracking (ya está en .gitignore, pero sigue trackeado)
git rm --cached tailscale-full.apk

# 3. Dejar de trackear .obsidian/
git rm -r --cached .obsidian/

# 4. Mover carpetas (git mv preserva historial)
git mv diarios docs/diarios
git mv mocs docs/mocs
git mv filosofia.md docs/filosofia.md

# 5. Revisar y fusionar duplicados
# Ver contenido de osint-stack/ y cli-tools/ antes de decidir
ls osint-stack/ cli-tools/ tools/

# 6. Commit de limpieza
git add -A
git commit -m "refactor: reorganizar estructura repo segun CONVENCIONES.md"
git push
```

> ⚠️ Para limpiar `tailscale-full.apk` del historial git completo (no solo del tracking):
> ```bash
> # Opción recomendada: BFG Repo Cleaner
> # https://rtyley.github.io/bfg-repo-cleaner/
> bfg --delete-files tailscale-full.apk
> git reflog expire --expire=now --all && git gc --prune=now --aggressive
> git push --force
> ```

---
_Creado: 02-jul-2026 — iPhone 11 — Perplexity vía MCP_
