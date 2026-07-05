---
title: Convenciones WIKI---PERSONAL
tipo: normas
creado: 2026-07-05
actualizado: 2026-07-05
status: vigente
ruta: wiki/CONVENCIONES.md
tags: [convenciones, normas, wiki]
---

# Convenciones WIKI---PERSONAL

> Normas canónicas para este repo. Si hay duda sobre dónde poner algo, aquí está la respuesta.
> Normas globales del ecosistema → [`yggdrasil-dew/NORMAS.md`](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/NORMAS.md)

---

## Regla de oro

**WIKI = QUÉ existe y POR QUÉ. Nunca CÓMO ejecutar.**

Si tienes dudas con un archivo:
- ¿Tiene comandos bash, scripts o IPs operativas? → NO es WIKI → va a `madre-config` o `yggdrasil-dew`
- ¿Explica un concepto, relación o decisión de diseño? → SÍ es WIKI

---

## Estructura canónica

```
wiki/
├── CONVENCIONES.md        ← este archivo
├── MODELO-MENTAL.md       ← cómo piensas el sistema
├── 00-mapa.md             ← mapa general de islas
├── mapa-islas.md          ← tabla de islas y repos
├── islas/
│   ├── INDEX.md             ← índice canónico de todas las islas
│   ├── infra.md             ← isla: infraestructura
│   ├── cerebro.md           ← isla: cerebro técnico
│   ├── seguridad.md         ← isla: seguridad
│   ├── ia-local.md          ← isla: IA local
│   ├── thdora.md            ← isla: bot Telegram
│   ├── formacion.md         ← isla: formación
│   ├── conocimiento.md      ← isla: conocimiento
│   ├── labs.md              ← isla: laboratorio
│   └── [isla-nueva].md      ← nueva isla sigue este patrón
├── relaciones/            ← docs transversales entre islas
├── agentes/               ← mapa conceptual de agentes (no implementación)
├── conocimiento/          ← conocimiento general del ecosistema
├── operaciones/           ← solo mapa de qué operaciones existen (NO cómo)
├── vida/                  ← isla personal/vida
├── infra/                 ← subsección infra si crece
└── vida/
```

**Archivos que NO deben existir en `wiki/` raíz:**
- Documentos operativos sin redirect
- Duplicados de docs que ya existen en otro repo
- Scripts, playbooks, Dockerfiles

---

## Frontmatter obligatorio

Todo `.md` debe empezar con:

```yaml
---
title: Título legible
tipo: isla | mapa | modelo | redirect | normas | indice
creado: YYYY-MM-DD
actualizado: YYYY-MM-DD
status: vigente | borrador | deprecado
ruta: wiki/ruta/archivo.md
tags: [tag1, tag2]
---
```

Islas añaden además:
```yaml
repo_principal: URL del repo operativo
depende_de: [otras-islas]
sirve_a: [otras-islas]
```

Redirects añaden:
```yaml
canonic_link: URL del documento canónico
```

---

## Nomenclatura

- **Archivos:** `kebab-case.md` siempre
- **Islas:** nombre corto en singular (`infra.md`, `seguridad.md`, `thdora.md`)
- **No:** `CamelCase.md`, `archivo con espacios.md`, `MAYUSCULAS.md` (excepto archivos especiales: `INDEX.md`, `CONVENCIONES.md`, `MODELO-MENTAL.md`)

---

## Regla de duplicados

1. Cada documento vive en **un único repo canónico**.
2. Si WIKI necesita referenciar algo que está en otro repo → **stub de redirect**:

```markdown
---
title: Plan de Seguridad (redirect)
tipo: redirect
status: deprecado
canonic_link: https://github.com/alvarofernandezmota-tech/yggdrasil-secops/blob/main/docs/PLAN-SEGURIDAD-ECOSISTEMA.md
---

⚠️ Este doc vive en SecOps → [PLAN-SEGURIDAD-ECOSISTEMA.md](link)
```

3. **Nunca** dos archivos con el mismo contenido en repos distintos sin que uno sea redirect.

---

## Lo que NUNCA va en WIKI

- `#!/bin/bash` o cualquier shebang
- Tokens, contraseñas, claves privadas, API keys
- Comandos de instalación paso a paso
- Configuraciones de servicios (nginx, docker-compose, etc.)
- Playbooks de remediación (van en `yggdrasil-secops/docs/runbooks/`)

---

## Proceso para añadir una nueva isla

1. Crear `wiki/islas/[nombre-isla].md` con frontmatter completo
2. Añadir entrada en `wiki/islas/INDEX.md`
3. Añadir entrada en `wiki/mapa-islas.md`
4. Añadir backlinks en islas relacionadas (`sirve_a` / `depende_de`)
5. Commit con mensaje: `docs(wiki): nueva isla [nombre]`

---

_Última actualización: 2026-07-05 · Perplexity-MCP_
