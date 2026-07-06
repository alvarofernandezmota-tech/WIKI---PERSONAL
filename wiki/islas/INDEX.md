---
tipo: indice
author: Alvaro Fernandez Mota
creado: 2026-07-05
actualizado: 2026-07-06
ruta: wiki/islas/INDEX.md
tags: [islas, indice, mapa, ecosistema]
status: vigente
---

# 🗺️ Índice de Islas — Ecosistema Yggdrasil

> **Fuente de verdad única** de todas las islas del ecosistema.  
> Una isla = un área de vida o trabajo con identidad propia.  
> El conocimiento conceptual vive aquí. Los procedimientos técnicos viven en el repo correspondiente.  
> Las decisiones de arquitectura viven en [yggdrasil-dew/docs/canon/INDICE-ADR.md](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/canon/INDICE-ADR.md).

> **¿Por qué existe este archivo?**  
> Para que en cualquier momento — yo, un agente IA, o un reclutador — pueda entender de un vistazo qué áreas componen este ecosistema, en qué estado está cada una, y a dónde ir para profundizar. Sin este índice, las islas son archivos sueltos sin conexión visible.

---

## Regla de oro

```
¿Me ayuda a pensar / navegar mi vida y mi conocimiento?  → WIKI / isla
¿Hace que el sistema funcione mejor?                      → Dew / repo técnico

Si una isla empieza a tener procedimientos técnicos
→ esos se van al repo técnico. La isla se queda como mapa que enlaza.
```

---

## Islas activas

| Isla | Archivo | Tipo | Madurez | Repo técnico principal | Última actualización |
|---|---|---|---|---|---|
| 🧠 Cerebro | [cerebro.md](./cerebro.md) | meta | estable | [yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) | 2026-07-05 |
| 🗺️ Conocimiento | [conocimiento.md](./conocimiento.md) | personal | estable | [WIKI---PERSONAL](https://github.com/alvarofernandezmota-tech/WIKI---PERSONAL) | 2026-07-05 |
| 📚 Formación | [formacion.md](./formacion.md) | técnica | estable | [formacion-tech](https://github.com/alvarofernandezmota-tech/formacion-tech) | 2026-07-05 |
| 🖥️ Infra | [infra.md](./infra.md) | técnica | estable | [madre-config](https://github.com/alvarofernandezmota-tech/madre-config) | 2026-07-06 |
| 🤖 IA Local | [ia-local.md](./ia-local.md) | técnica | estable | [ollama-stack](https://github.com/alvarofernandezmota-tech/ollama-stack) | 2026-07-05 |
| 🦷 Thdora | [thdora.md](./thdora.md) | técnica | activo-con-deuda | [THDORA-PERSONAL](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL) | 2026-07-06 |
| 🛡️ Seguridad | [seguridad.md](./seguridad.md) | técnica | estable | [yggdrasil-secops](https://github.com/alvarofernandezmota-tech/yggdrasil-secops) | 2026-07-05 |
| 🧪 Labs | [labs.md](./labs.md) | técnica | borrador | [dev-labs](https://github.com/alvarofernandezmota-tech/dev-labs) | 2026-07-05 |

---

## Relaciones entre islas

```
Cerebro (meta — lo gobierna todo)
  ├── ← Infra        (la base física: Madre, Acer, iPhone, Docker, Tailscale)
  ├── ← IA Local     (modelos Ollama corriendo en Madre)
  ├── ← Thdora       (interfaz Telegram que reporta al cerebro)
  ├── ← Seguridad    (protege todo el ecosistema)
  ├── ← Formación    (conocimiento técnico que alimenta decisiones)
  ├── ← Conocimiento (contexto personal y vital)
  └── ← Labs         (experimentos que pueden convertirse en islas)

Infra → sirve a: IA Local, Thdora, Seguridad, Cerebro, Labs
Seguridad → protege a: todas las islas
Thdora → depende de: Infra, IA Local
```

---

## Tipos de isla

| Tipo | Descripción |
|---|---|
| `meta` | Gobierna o da contexto a todo el ecosistema |
| `técnica` | Área con repos, código y operaciones propias |
| `personal` | Contexto humano: vida, conocimiento, identidad |

## Niveles de madurez

| Nivel | Descripción |
|---|---|
| `estable` | Documentada, activa, sin deuda estructural conocida |
| `activo-con-deuda` | Funciona pero tiene deuda técnica registrada en secops o issues |
| `borrador` | Esqueleto listo, contenido pendiente de desarrollar |
| `legacy` | Archivado, ya no se desarrolla activamente |

---

## Cómo añadir una isla nueva

1. Crear `wiki/islas/<nombre>.md` siguiendo el frontmatter de cualquier isla existente
2. Añadir fila en la tabla de “Islas activas” de este archivo
3. Enlazar desde `HOME.md`
4. Si tiene repo propio → enlazar en la tabla “Acceso rápido a repos” de `HOME.md`
5. Si implica una decisión de arquitectura → crear ADR en [yggdrasil-dew/docs/canon/](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/canon/INDICE-ADR.md)

---

_Actualizado: 2026-07-06 · Perplexity-MCP · Añadidas relaciones entre islas, columna fecha, instrucciones para isla nueva_
