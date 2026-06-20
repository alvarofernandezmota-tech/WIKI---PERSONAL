---
tags: [proyecto, activo, cerebro, obsidian, second-brain]
---

# 🧠 yggdrasil-dew — El Cerebro

> Repo: [alvarofernandezmota-tech/yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew)
> Creado: junio 2026 · Estado: **activo — fuente de verdad**

## Qué es

Second brain personal. Base de conocimiento + diario de vida + registro técnico 2026. Vault de Obsidian. Todo lo que existe está aquí.

## Filosofía

- Un solo diario por día en [[diarios/]] — todo el contexto del día va aquí
- Cada proyecto tiene su ficha en [[proyectos/]]
- Las IAs leen [[AGENT.md]] antes de actuar
- **Regla de oro:** *«Si no está en el repo, no existe.»*

## Estructura

```
yggdrasil-dew/
├── HOME.md           ← entrada principal Obsidian
├── ECOSISTEMA.md     ← mapa completo del ecosistema
├── AGENT.md          ← instrucciones para IAs
├── CONTEXT.md        ← estado actual
├── filosofia.md      ← valores y principios
├── diarios/          ← un .md por día
├── proyectos/        ← fichas de proyectos
├── formacion/        ← aprendizaje
├── agentes/          ← fichas de IAs
├── osint/            ← informes
├── setup/            ← configuración máquinas
└── yo/               ← perfil y CV
```

## Flujo de trabajo

1. Yo hablo con Perplexity → cambios en GitHub
2. `git pull` en varopc → Obsidian los ve
3. Obsidian = vista visual, GitHub = fuente de verdad

## Contexto histórico

Antes de ygg existía [[proyectos/personal]] — diarios desde enero 2026. Se mantiene como referencia.

## Pendiente

- [ ] Plugin Git en Obsidian (auto pull/push)
- [ ] Open WebUI en Madre para RAG sobre este repo
- [ ] Handler `/diario` en [[proyectos/thdora]] → escribe aquí desde Telegram

---

Volver a [[HOME]] · [[ECOSISTEMA]]
