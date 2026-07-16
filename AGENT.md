---
tipo: agent-context
author: Alvaro Fernandez Mota
actualizado: 2026-07-16
ruta: AGENT.md
tags: [agent, contexto, canon]
---

# AGENT.md — yggdrasil-wiki

> Fichero de arranque para cualquier agente IA que opere en este repo.  
> Leer COMPLETO antes de ejecutar cualquier acción.

---

## 🧭 Identidad del repo

- **Nombre canónico:** `yggdrasil-wiki`
- **Propósito:** Wiki central del ecosistema Yggdrasil. Contiene el conocimiento documentado de todos los dominios de vida y tecnología de Álvaro Fernández Mota.
- **Tipo:** Wiki de conocimiento — NO es un repo de código ejecutable.
- **Dueño:** Álvaro Fernández Mota (`alvarofernandezmota-tech`)

---

## 🗺️ Estructura

```
yggdrasil-wiki/
├── AGENT.md              ← estás aquí
├── CONTEXT.md            ← contexto del ecosistema completo
├── wiki/
│   ├── 00-mapa.md        ← mapa general del ecosistema
│   ├── mapa-islas.md     ← mapa visual de islas
│   ├── plantillas/       ← plantillas canónicas instanciables
│   │   ├── README.md
│   │   ├── AGENT-template.md
│   │   └── CONTEXT-template.md
│   └── islas/            ← 21 islas de conocimiento
│       └── INDEX.md      ← índice completo con estados
```

---

## 📋 Normas de operación

### Antes de crear cualquier archivo
1. Consultar `wiki/islas/INDEX.md` — verificar que no existe ya
2. Usar la plantilla en `wiki/plantillas/` si aplica
3. Añadir la isla al `INDEX.md` y `mapa-islas.md` en el **mismo commit**

### Antes de modificar cualquier isla
1. Leer el archivo completo antes de editar
2. Respetar el frontmatter YAML existente
3. Actualizar `actualizado:` con fecha ISO

### Nunca
- Borrar islas sin deprecar primero (añadir `status: deprecado` + redirect)
- Crear archivos fuera de `wiki/islas/` sin consultar
- Modificar `INDEX.md` sin actualizar `mapa-islas.md`

---

## 🔗 Referencias clave

- Normas del ecosistema: [NORMAS.md](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/NORMAS.md)
- Protocolo de inicio de sesión: [PROTOCOLO-INICIO-SESION.md](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/canon/PROTOCOLO-INICIO-SESION.md)
- Estado del sistema: [ESTADO-SISTEMA.md](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/ESTADO-SISTEMA.md)
- Índice de islas: [wiki/islas/INDEX.md](wiki/islas/INDEX.md)

---

_Instanciado desde `AGENT-template.md` · 2026-07-16 · Perplexity MCP_
