# Estructura del repo — Guía de navegación

> Cómo está organizado yggdrasil-dew y por qué.
> Inspirado en PARA (Projects/Areas/Resources/Archives) + homelab monorepo.

---

## Filosofía de estructura

No se organiza por fuente ("de dónde vino") sino por **accionabilidad** ("dónde lo voy a usar").
Ficheros sueltos en raíz = solo los documentos maestros que cualquier IA lee en frío.
Todo lo demás vive en su carpeta semántica. [cite:web:142]

---

## Raiz — solo documentos maestros

```
yggdrasil-dew/
├── README.md              ← entrada al repo
├── AGENT.md               ← instrucciones para agentes IA
├── CONTEXT.md             ← contexto completo del ecosistema
├── CONVENCIONES.md        ← 12 reglas del sistema
├── ECOSISTEMA.md          ← mapa arquitectura completa
├── ESTADO-SISTEMA.md      ← foto viva del stack
├── HOME.md                ← punto de entrada Obsidian
├── MASTER-PENDIENTES.md   ← TODO priorizado
├── ROADMAP.md             ← visión 7 fases
├── CHANGELOG.md           ← historial
└── filosofia.md           ← principios
```

Regla: **nada más en raíz**. Si algo nuevo va a raíz, primero preguntar si pertenece a `docs/sistema/`.

---

## Carpetas principales

```
inbox/          ← zona de aterrizaje (todo entra aquí)
agentes/        ← fichas LLM, prompts, Modelfiles
ollama/         ← configs específicas de modelos y RAG
docs/
├── sistema/    ← documentación de la arquitectura del repo
├── servicios/  ← manual de uso por servicio (Grafana, n8n, etc.)
├── obsidian/   ← setup y plugins Obsidian
└── adr/        ← Architecture Decision Records
setup/
└── servidor/   ← infraestructura ejecutable Madre
proyectos/      ← ficha privada por proyecto
formacion/
├── python/
├── linux/
├── ia/
├── pentest/
└── ingenieria/
osint/          ← herramientas y metodología
cli-tools/      ← herramientas CLI documentadas
tools/          ← scripts generales
templates/      ← plantillas Obsidian
diarios/        ← sesiones procesadas
yo/             ← perfil, CV, información personal
```

---

## Comparativa con repos de referencia

| Patrón | Repo referencia | Aplicado en yggdrasil-dew |
|---|---|---|
| PARA method | xlxs4/second-brain | `proyectos/` `agentes/` `formacion/` `diarios/` |
| Monorepo homelab | Lucioschenkel/homelab | `setup/servidor/` con composes por fase |
| AI-first vault | eugeniughelbur/obsidian-second-brain | `AGENT.md` + `agentes/` + Local REST API |
| Inbox numerado | COG vault structure | `inbox/` como `00-inbox/` conceptualmente |
| Slash commands IA | obsidian-mind | THDORA handlers (pendiente Fase 5) |

---
_Ver: [CONVENCIONES.md](../../CONVENCIONES.md) · [ESTADO-SISTEMA.md](../../ESTADO-SISTEMA.md)_
