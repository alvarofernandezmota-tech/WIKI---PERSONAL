# 🌳 ROADMAP MASTER — Yggdrasil Ecosystem

> Fuente única de verdad para el estado y plan de TODAS las islas.
> Actualizado automáticamente por `mapa-islas-sync.yml`.

**Última actualización:** 03-Jul-2026  
**Sesión activa:** S20260703  
**Estado global:** 🟡 En construcción — ~55% completo

---

## 📊 Estado global de islas

| Isla | Repo | Estado | Bloqueante | Fase |
|---|---|---|---|---|
| yggdrasil-dew | [yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) | 🟢 Activa | SSH key madre | F0 |
| thdora | [thdora](https://github.com/alvarofernandezmota-tech/thdora) | 🟡 Gaps | #12 zombie, #10 timeout | F1 |
| secops | repo-secops | 🟡 Gaps | 3 bots rotos | F2 |
| local-brain | en ygg/ollama | 🟡 Parcial | sin documentar | F4 |
| osint | en ygg/osint + osint-stack | ⚪ Duplicado | deduplicar carpetas | F2 |
| batcueva | 🔜 NO EXISTE | ❌ Sin backup | crear repo | F2 |
| theodora | dotfiles | 🟡 Gaps | sin dotfiles repo | F5 |
| moviles | config | 🟡 Parcial | Termius, Tailscale | cuando necesite |

---

## 🚦 FASE 0 — Fixes bloqueantes

> Sin estos, todo falla silenciosamente.

**Estado:** 🔴 EN CURSO  
**Sesión:** S21 (hoy)

| # | Tarea | Tiempo | Comando |
|---|---|---|---|
| 0.1 | SSH key madre → GitHub | 5 min | `cat ~/.ssh/id_ed25519.pub` → pegar en github.com/settings/keys |
| 0.2 | gh auth login en madre | 2 min | `gh auth login` |
| 0.3 | Blink keepalive config | 2 min | editar `~/.ssh/config` en iPhone |
| 0.4 | Verificar carpeta artefacto | 1 min | `ls ~/yggdrasil-dew/alvarofernandezmota-tech/` |
| 0.5 | Deduplicar osint/ + osint-stack/ | 5 min | mover contenido y borrar duplicado |
| 0.6 | Deduplicar tools/ + cli-tools/ | 5 min | mover contenido y borrar duplicado |

**Definición de hecho:** `git pull` funciona en madre sin errores.

---

## 🚦 FASE 1 — Deuda técnica thdora

**Estado:** ⏳ Bloqueada por F0  
**Sesión:** S21

| # | Issue | Tarea | Impacto |
|---|---|---|---|
| 1.1 | [#12](https://github.com/alvarofernandezmota-tech/thdora/issues/12) | Eliminar código zombie | Bot inestable |
| 1.2 | [#10](https://github.com/alvarofernandezmota-tech/thdora/issues/10) | Fix /config timeout (3 líneas) | Comando roto |
| 1.3 | — | PR + merge + tests | Cerrar deuda |

**Definición de hecho:** thdora sin issues abiertos de deuda técnica.

---

## 🚦 FASE 2 — Estructura ygg + batcueva

**Estado:** 🔴 Pendiente  
**Sesión:** S22

| # | Tarea | Isla afectada |
|---|---|---|
| 2.1 | Añadir README.md a cada isla (plantilla) | todas |
| 2.2 | Fusionar osint/ + osint-stack/ | osint |
| 2.3 | Fusionar tools/ + cli-tools/ | ygg |
| 2.4 | Crear repo batcueva | batcueva |
| 2.5 | docker-compose de madre documentado | batcueva |
| 2.6 | Script backup nocturno madre → batcueva | batcueva |
| 2.7 | Añadir GROQ_API_KEY a GitHub Secrets | ygg |
| 2.8 | Action: verifica README.md en cada isla | ygg |
| 2.9 | Resolver secops — 3 bots rotos | secops |

**Definición de hecho:** todas las islas con README.md, batcueva operativo.

---

## 🚦 FASE 3 — Automatizaciones reales

**Estado:** 🔴 Pendiente  
**Sesión:** S23

| # | Tarea | Herramienta |
|---|---|---|
| 3.1 | thdora daily-report → Telegram | thdora bot |
| 3.2 | Sync bidireccional ygg ↔ thdora via webhook | GitHub Actions |
| 3.3 | Backup nocturno madre → batcueva | cron + rsync |
| 3.4 | Dashboard ESTADO-ISLAS.md autogenerado | Action |
| 3.5 | Cursor MCP config en madre | MCP |
| 3.6 | Action: verifica diario del día existe | ygg |

**Definición de hecho:** el ecosistema se monitoriza y reporta solo.

---

## 🚦 FASE 4 — local-brain + ollama

**Estado:** 🔴 Pendiente  
**Sesión:** S24

| # | Tarea |
|---|---|
| 4.1 | Documentar modelos ollama activos en madre |
| 4.2 | README.md isla local-brain con plantilla |
| 4.3 | Conectar ollama con thdora (endpoint local) |
| 4.4 | Script de arranque/parada modelos |

**Definición de hecho:** local-brain documentado y conectado a thdora.

---

## 🚦 FASE 5 — theodora + dotfiles + móviles

**Estado:** 🔴 Pendiente  
**Sesión:** S25+

| # | Tarea |
|---|---|
| 5.1 | Crear repo dotfiles |
| 5.2 | Sincronizar .zshrc, .tmux.conf, .gitconfig, neovim |
| 5.3 | Script de bootstrap en máquina nueva |
| 5.4 | Termius config con todos los hosts del ecosistema |
| 5.5 | Redmi con Tailscale funcional |

**Definición de hecho:** máquina nueva lista en <15 min con bootstrap.

---

## 📁 Cómo están conectadas las fases

```
F0 (SSH fix)
  └─── desbloquea ───► F1 (thdora deuda)
                          └─── desbloquea ───► F2 (estructura + batcueva)
                                                  └─── desbloquea ───► F3 (automatizaciones)
                                                                          ├─── paralelo ───► F4 (local-brain)
                                                                          └─── paralelo ───► F5 (theodora)
```

---

## 📜 Normas del ecosistema (resumen ejecutivo)

1. **Cada isla tiene su propio README.md** con la plantilla de `templates/isla-README.md`
2. **Cada commit sigue Conventional Commits** (`feat:`, `fix:`, `docs:`, `chore:`)
3. **Cada sesión genera un resumen** en `sesiones/SYYYYMMDD-RESUMEN.md`
4. **Cada idea va a inbox/** primero, luego se procesa
5. **Nada se mueve a main sin pasar por una Action** que lo verifique
6. **Los ficheros maestros son 5** y no se pueden borrar: `ECOSISTEMA.md`, `MAPA-ISLAS.md`, `HERRAMIENTAS-ECOSISTEMA.md`, `CONVENCIONES.md`, `ESTADO-SISTEMA.md`
7. **Las Actions son el sistema inmune** — si una falla, se crea un issue automáticamente
8. **El ROADMAP-MASTER.md es la fuente de verdad** — se actualiza al cerrar cada fase

---

## 🔑 Secrets necesarios en GitHub

| Secret | Para qué | Estado |
|---|---|---|
| `GROQ_API_KEY` | AI reviewer en PRs | ❌ Pendiente |
| `TELEGRAM_BOT_TOKEN` | Notificaciones thdora | ❓ Verificar |
| `TELEGRAM_CHAT_ID` | Canal de notificaciones | ❓ Verificar |

---

*Documento vivo — última edición manual: 03-Jul-2026*  
*Próxima actualización automática: cuando se cierre próximo issue o PR*
