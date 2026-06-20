# Proyecto: Dashboard Ecosistema

> Estado: 🟡 En construcción · Reto de aprendizaje Varo + Perplexity
> Tags: `#dashboard` `#html` `#css` `#js` `#ecosistema` `#varopc` `#madre` `#tailscale` `#monitoreo`
> Repo: `yggdrasil-dew`
> Carpeta destino: `tools/dashboard/`

---

## 🎯 Objetivo

Construir un dashboard HTML/CSS/JS completo del ecosistema paso a paso:
- **Aprender** cada bloque: estructura HTML, estilos CSS, datos JS, actualización en tiempo real
- **Monitorizar** varopc + Madre + Tailscale + bot + servidor desde una sola pantalla
- **Alertas** al repo: cuando algo falle, notificar a yggdrasil-dew via script
- **Guardado** en repo para versionar cada mejora

---

## 📐 Arquitectura del sistema

```
yggdrasil-dew/
└── tools/
    └── dashboard/
        ├── index.html          ← el dashboard principal
        ├── style.css           ← estilos separados (iremos aquí)
        ├── app.js              ← lógica JS (fetch datos, render)
        ├── data/
        │   ├── varopc.json         ← snapshot estado varopc
        │   └── madre.json          ← snapshot estado Madre
        └── scripts/
            ├── snapshot-varopc.sh  ← genera varopc.json
            └── snapshot-madre.sh   ← genera madre.json (via SSH)
```

---

## 📍 Fases del proyecto (roadmap)

### Fase 1 — HTML estático (empezamos aquí)
- [ ] Estructura HTML base con cards
- [ ] Datos hardcodeados (lo que ya sabemos: hostnames, IPs, batería)
- [ ] CSS propio: dark theme, grid, colores de estado
- [ ] Resultado: abrir index.html en el navegador y ver el ecosistema

### Fase 2 — Datos reales via JSON
- [ ] Script bash en varopc que genera `varopc.json` con:
  - bateria %, status, salud
  - CPU %, RAM %, disco %
  - uptime
  - tailscale status
  - servicios corriendo (docker, bot, etc)
- [ ] El HTML lee el JSON con fetch() y pinta datos reales
- [ ] Resultado: datos actuales cada vez que abres el dashboard

### Fase 3 — Auto-refresco
- [ ] setInterval() en JS para refrescar datos cada X segundos
- [ ] Indicador visual de última actualización
- [ ] Resultado: dashboard vivo sin recargar página

### Fase 4 — Alertas al repo
- [ ] Script que compara estado actual vs umbrales:
  - Batería < 20% → alerta
  - Madre offline > 10min → alerta
  - Disco > 90% → alerta
- [ ] Crea issue en yggdrasil-dew via GitHub API si hay alerta
- [ ] Resultado: ygg recibe notificaciones automáticas del ecosistema

### Fase 5 — Madre + servicios
- [ ] SSH a Madre para traer snapshot remoto
- [ ] Mostrar estado Docker containers en Madre
- [ ] Estado del bot (si hay endpoint o log)
- [ ] Resultado: ecosistema completo en una pantalla

---

## 🧠 Lo que ya sabemos (datos reales para hardcodear en Fase 1)

### varopc (varo12f)
- Hostname: `varo12f`
- IP Tailscale: `100.86.119.102`
- Usuario: `varo` / Home: `/home/varo`
- OS: Arch Linux + Hyprland + zsh
- Batería: BAT1 / LGC AP18C8K / Salud 67.8% / Sin control de carga
- TLP 1.10.0 instalado (conflicto con power-profiles-daemon pendiente)
- Editor: nvim (nano NO instalado)

### Madre (varpc)
- Hostname: `varpc`
- IP Tailscale: `100.91.112.32`
- Estado: Offline (last seen 1h ago en sesión 20jun)
- Servicios: Docker + thdora + bot (pendiente verificar)

---

## 📚 Conceptos que aprenderemos por fase

| Fase | Concepto |
|---|---|
| 1 | HTML semántico, CSS grid, flexbox, variables CSS, dark theme |
| 2 | Bash scripting, JSON, fetch() API, async/await JS |
| 3 | setInterval, DOM manipulation, eventos JS |
| 4 | GitHub API REST, curl, bash condicionales, cron |
| 5 | SSH programatico, jq, pipes bash avanzados |

---

## ⚡ Siguiente acción

**Fase 1 — Paso 1:** Crear `tools/dashboard/index.html` con estructura base
- 3 cards: varopc | Madre | Tailscale
- Datos hardcodeados con lo que ya sabemos
- CSS en `<style>` por ahora (luego lo separamos)

_Varo construye cada bloque, Perplexity explica cómo y por qué_

---

_Tags: `#dashboard` `#html` `#css` `#js` `#aprendizaje` `#monitoreo` `#ecosistema`_
_Procesar a: `projects/dashboard-ecosistema.md`_
