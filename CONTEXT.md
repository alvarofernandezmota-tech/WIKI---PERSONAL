# CONTEXT — Estado actual del sistema

> **Última actualización:** 12 junio 2026, 18:25 CEST
> **Actualizar:** al inicio y cierre de cada sesión de trabajo.

---

## 📍 Dónde estamos ahora

**`personal-v2` operativo.** Repo creado, estructura fijada, sistema de agentes documentado, Fase 1 del servidor completada.

---

## ✅ Última sesión (12 jun 2026)

| Bloque | Completado |
|---|---|
| Auditoría completa de `personal` (repo madre) | ✅ |
| Estructura definitiva `personal-v2` fijada | ✅ |
| Sistema de agentes (Perplexity + Gemini + prompts) | ✅ |
| Ecosistema Google documentado (Colab + NotebookLM) | ✅ |
| Tailscale Madre `100.91.112.32` + Acer `100.86.119.102` | ✅ |
| Input Leap server (Madre / Hyprland) + client (Acer) | ✅ |
| UFW Zero Trust en Acer | ✅ |
| Diario de sesión con timeline completo | ✅ |

---

## 🚧 Pendiente — próxima sesión

### Servidor — Fase 2 (fin de semana)
- [ ] TLS en Input Leap (openssl self-signed)
- [ ] fail2ban en Acer
- [ ] Auditoría Docker preexistente en Acer
- [ ] Headscale self-hosted (quitar dependencia Tailscale cloud)
- [ ] Sincronización dotfiles / omarchy Madre ↔ Acer
- [ ] MacBook como tercer nodo Input Leap

### Repo
- [ ] Migrar contenido de `personal` (madre) a `personal-v2`
- [ ] Poblar `yo/`, `formacion/`, `proyectos/`
- [ ] `.gitignore` con `reflexiones/`, `begona.md`, datos sensibles
- [ ] Crear `tracking/` con TRACKING-MAESTRO.md

---

## 🖥️ Infraestructura actual

| Máquina | IP Tailscale | Rol | Estado |
|---|---|---|---|
| **Madre** | `100.91.112.32` | Workstation + Input Leap server | ✅ |
| **Acer** | `100.86.119.102` | Soporte 24/7 + Input Leap client | ✅ |
| **MacBook** | pendiente | Cliente | ⏳ Fase 2 |

---

## 🤖 Agentes activos

| Agente | Rol | Doc |
|---|---|---|
| **Perplexity** | Acción sobre GitHub, estructurar, subir | `agentes/perplexity.md` |
| **Gemini** | Entrada: voz, visual, docs largos, diseño | `agentes/gemini.md` |

---

## 🎯 Objetivo 2026

**Conseguir trabajo antes de que acabe el año.**

Eje principal: empleabilidad. Todo lo demás (servidor, proyectos, formación) sirve a este objetivo.

---

## 📁 Estado del repo

```
personal-v2/
├── README.md        ✅
├── AGENT.md         ✅
├── CONTEXT.md       ✅ (este archivo)
├── CHANGELOG.md     ✅
├── filosofia.md     ✅
├── agentes/         ✅ perplexity + gemini + prompts
├── diarios/2026/    ✅ 2026-06-12.md completo
├── setup/servidor/  ✅ Fase 1 documentada
├── yo/              ⏳ pendiente migrar
├── formacion/       ⏳ pendiente migrar
├── proyectos/       ⏳ pendiente migrar
└── tracking/        ❌ no creada aún
```

---

_Diario de hoy: `diarios/2026/2026-06-12.md`_
