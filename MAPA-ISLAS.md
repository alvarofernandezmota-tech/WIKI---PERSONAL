# 🗺️ Mapa de Islas — Yggdrasil

> Fuente única del estado de TODAS las islas. Actualizado automáticamente por `isla-context-sync.yml`.
> Última actualización manual: 03-Jul-2026 13:12 CEST

---

## 📊 Estado real de islas (detectado hoy)

| Isla / Carpeta | Tipo | README | ESTADO | Último commit | Acción necesaria |
|---|---|---|---|---|---|
| `yggdrasil-dew` | 🏟️ Hub central | ✅ | ✅ | 03-Jul-2026 | Ninguna |
| `thdora/` | 🤖 Bot Telegram | ❓ | ❓ | 03-Jul-2026 | README + #12 + #10 |
| `osint/` | 🔍 OSINT tools | ❌ | ❌ | desconocido | README + deduplicar |
| `osint-stack/` | 🛠️ DUPLICADO | ❌ | ❌ | desconocido | Fusionar en osint/ |
| `docker/` | 🐳 Contenedores | ❌ | ❌ | desconocido | README |
| `infra/` | ⚙️ Infraestructura | ❌ | ❌ | desconocido | README |
| `ollama/` | 🧠 local-brain | ❌ | ❌ | desconocido | README |
| `hardware/` | 🖥️ Hardware/madre | ❌ | ❌ | desconocido | README |
| `tools/` | 🛠️ CLI Tools | ❌ | ❌ | desconocido | README + deduplicar |
| `cli-tools/` | 🛠️ DUPLICADO | ❌ | ❌ | desconocido | Fusionar en tools/ |
| `secops/` | 🔒 SecOps | ❓ | ❓ | desconocido | README + 3 bots rotos |
| `agentes/` | 🤖 Agentes IA | ❓ | ❓ | desconocido | Documentar |
| `formacion/` | 📚 Formación | ❓ | ❓ | desconocido | Documentar |
| `proyectos/` | 💼 Proyectos | ❓ | ❓ | desconocido | Documentar |
| `core/` | ❤️ Núcleo ygg | ❓ | ❓ | desconocido | Documentar |
| `yo/` | 👤 Perfil personal | ❓ | ❓ | desconocido | Documentar |
| `mocs/` | 🗺️ Maps of Content | ❓ | ❓ | desconocido | Documentar |
| `setup/` | 🔧 Setup/bootstrap | ❓ | ❓ | desconocido | Documentar |
| `assets/` | 🖼️ Assets | ❓ | ❓ | desconocido | Documentar |
| `diarios/` | 📓 Diarios | ❓ | ❓ | desconocido | Unificar con diario/ |
| `alvarofernandezmota-tech/` | 🚨 ARTEFACTO | ❌ | ❌ | - | **BORRAR** |
| `batcueva` | 🤇 Backup/privado | ❌ | ❌ | NO EXISTE | Crear repo |
| `theodora` | 💻 Dotfiles | ❌ | ❌ | NO EXISTE | Crear repo |

---

## 📌 Leyenda
- ✅ Existe y está completo
- ❌ No existe
- ❓ Existe pero sin verificar
- 🚨 Artefacto / duplicado — borrar

---

## 🔗 Relaciones entre islas

```
yggdrasil-dew (hub)
├── thdora ← bot Telegram, usa ollama local
├── ollama ← local-brain, sirve modelos a thdora
├── docker ← contenedores de madre
├── infra ← red, Tailscale, servicios
├── osint ← herramientas OSINT
├── secops ← seguridad operacional
├── hardware → madre (servidor físico)
├── batcueva → backup y privacidad (PENDIENTE)
└── theodora → dotfiles y bootstrap (PENDIENTE)
```

---

## 🚫 Islas que deben separarse a su propio repo

Criteria para separar una isla a repo propio:
1. Tiene más de 20 commits propios
2. Tiene deploy independiente
3. Tiene sus propios tests o CI/CD
4. Otros proyectos la importan como dependencia

| Isla | Criterio de separación | Estado |
|---|---|---|
| `thdora` | Ya tiene repo propio | ✅ Separada |
| `batcueva` | Deploy independiente | ❌ Crear repo |
| `theodora` | Bootstrap independiente | ❌ Crear repo |
| `secops` | CI/CD propio | ❓ Evaluar |

---

*Ver `ROADMAP-MASTER.md` para el plan de cada fase.*  
*Ver `docs/MONITOREO-ECOSISTEMA.md` para cómo se monitoriza cada isla.*
