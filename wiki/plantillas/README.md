# Plantillas canónicas del ecosistema Yggdrasil

> **Estas plantillas son la base de todo.** Sin ellas, cada repo queda desconectado del ecosistema y los protocolos de sesión no funcionan.

---

## Plantillas disponibles

| Plantilla | Uso | Destino |
|---|---|---|
| [`AGENT-template.md`](AGENT-template.md) | `AGENT.md` de **cualquier repo** del ecosistema | Raíz del repo |
| [`isla-template.md`](isla-template.md) | Ficha de cada isla en la wiki | `wiki/islas/nombre-isla.md` |
| [`issue-dew-template.md`](issue-dew-template.md) | Issue del DEW (`yggdrasil-dew`) | `yggdrasil-dew/.github/ISSUE_TEMPLATE/` |

---

## Cómo usar AGENT-template.md

1. Copiar el archivo al repo destino como `AGENT.md`
2. Sustituir todas las variables `{{VARIABLE}}` con los valores reales
3. Borrar las secciones marcadas como opcionales si no aplican
4. El `AGENT.md` vive **siempre en la raíz** del repo
5. Actualizar al inicio y cierre de cada sesión

**Variables a sustituir:**

| Variable | Ejemplo |
|---|---|
| `{{REPO_NAME}}` | `THDORA-PERSONAL` |
| `{{REPO_ROL}}` | `Bot Telegram + FastAPI` |
| `{{REPO_VISIBILIDAD}}` | `Privado` |
| `{{ISLA_WIKI_URL}}` | `wiki/islas/thdora.md` |
| `{{DEW_ISSUES_RELACIONADAS}}` | `#36, #44, #45, #49` |
| `{{STACK_PRINCIPAL}}` | `Python · FastAPI · Docker` |
| `{{ESTADO_ACTUAL}}` | `🔴 Caído — HAL-007 + HAL-008` |
| `{{FECHA}}` | `2026-07-16` |

---

## Cómo usar isla-template.md

1. Copiar a `wiki/islas/nombre-isla.md`
2. Sustituir variables `{{VARIABLE}}`
3. La sección `## 🔗 DEW` es **obligatoria** — siempre enlaza issues reales del DEW
4. La sección `## 📊 Estado` refleja el estado operativo real, no aspiracional

---

## Principio de enlace bidireccional

El ecosistema funciona porque cada pieza apunta a las demás:

```
yggdrasil-wiki/wiki/islas/XX.md
  └── ## 🔗 DEW → issues DEW relevantes

yggdrasil-dew/issues/XX
  └── ## Isla asociada → wiki/islas/XX.md

Cualquier-repo/AGENT.md
  └── ## 🗺️ Isla wiki → wiki/islas/XX.md
  └── ## 🐛 Issues activas → DEW #XX, #XX
```

Sin este enlace, un agente nuevo no puede orientarse en el ecosistema.

---

_Creado: 2026-07-16 · Perplexity-MCP_
