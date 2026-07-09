---
title: Isla Vida Personal
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-09
actualizado: 2026-07-10
status: vigente
ruta: wiki/islas/vida.md
tags: [isla, vida, personal, diarios, tracking, habitos]
repo_principal: VIDAPERSONAL
depende_de: []
sirve_a: [yggdrasil-dew, yggdrasil-wiki]
---

# Isla: Vida Personal

> Mapa conceptual de la dimensión personal.
> Los registros reales viven en `VIDAPERSONAL`. Esta isla es el mapa — nunca los datos.

---

## El triángulo personal

```
        VIDAPERSONAL
        (planifica, registra,
         diarios, hábitos, tracking)
              ▲
             / \
            /   \
      DEW ◄─────► WIKI
  (ejecuta,       (mapas
   issues,         conceptuales)
   ADRs)
```

**Regla de oro:** DEW planifica → VIDAPERSONAL registra → WIKI documenta el mapa.

---

## Dónde vive cada cosa

| Tipo de información | Repo | Ruta |
|---------------------|------|------|
| Diarios diarios | `VIDAPERSONAL` | `01_traking_diario/01_diarios/2026/MM-mes/` |
| Hábitos y tracking | `VIDAPERSONAL` | `01_traking_diario/` |
| Metas del año | `VIDAPERSONAL` | `02_metas/` |
| Formación activa | `VIDAPERSONAL` | `02_formacion/` |
| Identidad y valores | `VIDAPERSONAL` | `00_yo/` |
| Canon del ecosistema | `VIDAPERSONAL` | `00_sistema/ECOSISTEMA-CANON.md` |
| Plan semanal | `VIDAPERSONAL` | `00_sistema/PLAN-DOMINGO-*.md` |
| Issues de vida | `yggdrasil-dew` | Issues con label `vida` |
| Mapa conceptual | Aquí | `wiki/islas/vida.md` |

---

## Estructura canónica VIDAPERSONAL

```
VIDAPERSONAL/
├── 00_sistema/          ← cerebro: protocolos, canon, planes
├── 00_yo/               ← identidad, valores, quién eres
├── 01_traking_diario/   ← núcleo del tracking diario
│   ├── 01_diarios/2026/07-julio/YYYY-MM-DD.md
│   ├── 02_plantillas/
│   └── 03_analisis/
├── 02_formacion/
├── 02_metas/
└── _archivo/            ← todo lo inactivo
```

---

## Áreas de vida

- **Salud** — sueño, ejercicio, agua, tabaco, alimentación
- **Trabajo / carrera técnica** — foco, productividad, ecosistema
- **Formación** — Musk, cursos, lecturas
- **Relaciones** — Thea, familia, entorno
- **Finanzas** — (pendiente de desarrollar)
- **Proyectos personales** — impresora 3D, ideas

---

## Links

→ [VIDAPERSONAL repo](https://github.com/alvarofernandezmota-tech/VIDAPERSONAL)
→ [ECOSISTEMA-CANON.md](https://github.com/alvarofernandezmota-tech/VIDAPERSONAL/blob/main/00_sistema/ECOSISTEMA-CANON.md)

_Actualizado: 2026-07-10 · Perplexity-MCP_
