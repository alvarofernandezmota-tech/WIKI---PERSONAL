---
id: 202406242235
fecha: 2026-06-24
hora: 22:35
tipo: deep-research
repo: yggdrasil-dew
status: activo
diario: "[[diarios/2026-06-24]]"
destino: docs/adr/
tags: [inbox, deep-research, obsidian, ssot, git, dataview, alineacion, automatizacion]
---

# Deep Research — SSOT yggdrasil-dew: Obsidian + Git + automatizacion

> Investigacion realizada por Gemini Advanced con Deep Research.
> Fuentes: repos GitHub (kepano-obsidian, obsidian-git), r/ObsidianMD, r/PKM,
> documentacion plugins, n8n community, ejemplos reales Zettelkasten.
> Fecha: 24 jun 2026

---

## Conclusion principal

**La mejor practica es local-first con Git como backbone, Obsidian como interfaz,
y automatizaciones open-source ligeras.**

Evita desincronizacion manual de archivos maestros mediante:
- Vistas dinamicas (Dataview en lugar de archivos estaticos)
- Frontmatter como metadatos SSOT
- Pipelines de entrada/salida automatizados
- Sin servicios cloud de pago

---

## 1. Workflow real: Ciclo Inbox -> Process -> Commit -> Sync

### Plugin estrella: Obsidian Git
- Repo: `Vinzent03/obsidian-git` (~11k stars) — estandar absoluto
- Auto-commit + push cada X minutos
- Auto-pull al abrir vault
- Source control view, history, diff
- Conventional commits con Templater

Configuracion recomendada (`.obsidian/plugins/obsidian-git/data.json`):
```json
{
  "autoCommitMessage": "chore({{vaultName}}): {{date}} {{time}}",
  "autoPushAfterCommit": true,
  "autoPullOnStartup": true,
  "pullBeforeCommit": true,
  "commitAndSyncInterval": 2
}
```

### Stack de plugins recomendado

| Plugin | Funcion | Prioridad |
|---|---|---|
| **Obsidian Git** | Auto-commit + push/pull | 🔴 PRIMERO |
| **Dataview** | Vistas dinamicas, reemplaza estaticos | 🔴 PRIMERO |
| **Templater** | Plantillas JS, frontmatter, scripts | 🔴 PRIMERO |
| **Auto Note Mover** | Mueve inbox/ automaticamente por tags | 🟡 SEGUNDO |
| **MetaEdit** | Edicion masiva de YAML/frontmatter | 🟡 SEGUNDO |
| **Calendar** | Navegacion diarios | 🟢 TERCERO |

### Patron Git para second brains
- `.gitignore` ignora: `.obsidian/workspace.json`, caches, temporales
- Incluir `.obsidian/` para plugins/config (replicabilidad)
- Conventional commits desde Obsidian Git
- Pre-commit hook ligero: validar frontmatter YAML (con `yq` o Python)

---

## 2. Frontmatter estandar SSOT — NUESTRO SISTEMA

Aplicar a TODOS los archivos del repo desde ahora:

```yaml
---
id: {{date:YYYYMMDDHHmm}}           # unico, generado por Templater
fecha: {{date:YYYY-MM-DD}}
tipo: technical-doc | journal | map | pending | deep-research | adr | proyecto
status: draft | activo | archivado
repo: yggdrasil-dew                  # o thdora, local-brain, etc.
diario: "[[diarios/YYYY-MM-DD]]"
destino: docs/adr/                   # ruta destino al migrar desde inbox
tags: [inbox, git, automatizacion]
sync: true
---
```

**Regla**: cada archivo en inbox DEBE tener `destino:` para saber donde va.

---

## 3. Simplificar archivos maestros — De estaticos a dinamicos

### El problema actual
5 archivos estaticos (CONTEXT, ECOSISTEMA, ESTADO-SISTEMA, HOME, MASTER-PENDIENTES)
que se dessincronizan porque se editan a mano.

### La solucion: Dataview dashboards

Ejemplo query para HOME.md (reemplaza lista estatica de pendientes):
```dataview
TABLE file.link AS "Nota", status, file.mtime AS "Ultima modif", tipo
FROM "inbox" OR #proyecto/activo OR "diarios"
WHERE status != "archivado" AND sync = true
SORT file.mtime DESC
LIMIT 10
```

Ejemplo query inbox pendientes de migrar:
```dataviewjs
dv.list(
  dv.pages('"inbox"')
    .where(p => !p.file.etags.includes("#archivado"))
    .sort(p => p.file.mtime, 'desc')
    .map(p => `${p.file.link} → ${p.destino || 'SIN DESTINO'}`)
);
```

### Plan de simplificacion
- `HOME.md` → dashboard Dataview puro (no texto estatico)
- `ESTADO-SISTEMA.md` → fusionar en `CONTEXT.md`
- `ECOSISTEMA.md` → mantener pero con tabla Dataview de repos
- `MASTER-PENDIENTES.md` → unica lista de tareas (ya lo es)
- `CONTEXT.md` → unica fuente para agentes (ya corregido)

### Repos publicos de referencia
- `kepano/kepano-obsidian` — bottom-up, MOCs, Categories
- `CyanVoxel/Obsidian-Vault-Template` — habits, progress
- Buscar topic `obsidian-vault` en GitHub para ejemplos

---

## 4. Pipeline automatizacion — thdora + n8n + Ollama

### Pipeline recomendado (todo local/open-source)

```
thdora (Telegram)
    ↓ webhook
n8n (self-hosted)
    ↓ Code node
Ollama local (qwen2.5 o mistral)
    ↓ "extrae tema, prioridad, tags, genera YAML frontmatter"
GitHub API o FS montado
    ↓ crea nota en inbox/
Obsidian Git
    ↓ detecta cambio → Auto Note Mover + commit automatico
yggdrasil-dew actualizado
```

### thdora handler `/cierre` (a implementar)
```python
# Pseudocodigo handler /cierre en thdora
async def cmd_cierre(update, context):
    # 1. Leer inbox/ via GitHub API
    # 2. Generar resumen con Ollama
    # 3. Actualizar CONTEXT.md + diario del dia via MCP
    # 4. git push automatico
    # 5. Responder en Telegram con resumen
    pass
```

### n8n community nodes utiles
- `n8n-nodes-obsidian` — lectura/escritura directa vault
- GitHub node nativo — crear/actualizar archivos via API
- Ollama node — llamadas a modelos locales

---

## 5. Conectar repos entre si

### NO usar submódulos Git (fragiles en Obsidian)

### SI usar:
- **Obsidian URIs**: `obsidian://open?vault=yggdrasil-dew&file=Path/Note.md`
- **Tags con prefijos de repo**: `#repo/thdora`, `#repo/osint-stack`, `#repo/local-brain`
- **Wikilinks con ruta explicita**: `[[proyectos/thdora/README]]`
- **ripgrep / VS Code multi-root** para busqueda cross-repo

### Estructura escalable recomendada
```
yggdrasil-dew/
├── inbox/          ← zona de paso, max 10 archivos
├── diarios/        ← un .md por dia
├── maps/           ← MOCs (Maps of Content) - NUEVO
├── docs/
│   ├── adr/
│   └── arquitectura/
├── proyectos/      ← fichas de cada repo externo
├── setup/
├── agentes/
├── formacion/
├── osint/
└── .obsidian/      ← incluir en Git para replicabilidad
```

---

## Acciones inmediatas (orden de implementacion)

- [ ] **1. Obsidian Git** → instalar y configurar auto-commit 2min
- [ ] **2. Dataview** → instalar + query inbox pendientes en README.md
- [ ] **3. Templater** → plantilla diario + plantilla inbox con frontmatter estandar
- [ ] **4. Auto Note Mover** → regla: `destino: docs/adr/` → mover automatico
- [ ] **5. MetaEdit** → para editar frontmatter en bulk
- [ ] **6. HOME.md** → convertir a dashboard Dataview
- [ ] **7. Pipeline thdora → n8n → Ollama** → cuando n8n este levantado
- [ ] **8. handler `/cierre`** en thdora

---
_Fuente: Gemini Advanced Deep Research — 24 jun 2026_
_Documentado por Perplexity via MCP_
_Ver: [[diarios/2026-06-24]] · [[CONTEXT]] · [[CONVENCIONES]]_
