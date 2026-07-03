# 🛡️ Monitoreo del Ecosistema — Guía completa

> Cómo cada parte del ecosistema sabe lo que está pasando en las demás.

---

## 📊 Las 5 capas de monitoreo

### Capa 1 — En cada push (tiempo real)
| Action | Qué monitoriza | Output |
|---|---|---|
| `repo-audit.yml` | Zombies, READMEs, ficheros maestros, commits | Issue si hay problemas |
| `diary-writer.yml` | Commits del día, islas tocadas, archivos | Diary actualizado |
| `isla-context-sync.yml` | Estado README y ESTADO.md por isla | MAPA-ISLAS.md actualizado |

### Capa 2 — Nocturno (05:00–06:00 CEST)
| Action | Qué monitoriza | Output |
|---|---|---|
| `repo-health.yml` | Diary faltante, READMEs, zombies, islas sin actividad | Issue health |
| `isla-context-sync.yml` | Sincroniza mapa de islas | MAPA-ISLAS.md fresco |

### Capa 3 — Manual (cuando se necesita)
| Action | Cuándo usarla |
|---|---|
| `session-close.yml` | Al terminar una sesión de trabajo |
| `repo-health.yml` (dispatch) | Cuando quieres un check instantáneo |

### Capa 4 — Script local (en madre)
| Script | Qué hace |
|---|---|
| `scripts/maintenance/new-session.sh` | Abre sesión, git pull, estado rápido |
| Futuros scripts por isla | Arrancar/parar servicios, backups |

### Capa 5 — Bot thdora (futuro F3)
| Función | Canal |
|---|---|
| Notifica issues creados | Telegram |
| Reporta health diario | Telegram |
| Responde `/estado` con ESTADO-SISTEMA.md | Telegram |

---

## 🗺️ Ficheros maestros del ecosistema

Estos 5 ficheros son la memoria del sistema. Nunca borrar.

| Fichero | Quién lo actualiza | Frecuencia |
|---|---|---|
| `ECOSISTEMA.md` | Manual / docs | Cuando cambia la arquitectura |
| `MAPA-ISLAS.md` | `isla-context-sync.yml` | En cada push + nocturno |
| `ROADMAP-MASTER.md` | Manual al cerrar fases | Por fase |
| `ESTADO-SISTEMA.md` | Manual inicio/cierre sesión | Por sesión |
| `CONVENCIONES.md` | Manual | Cuando se acuerdan nuevas reglas |

---

## 🔗 Cómo las islas se conocen entre sí

Cada isla tiene:
```
isla/
├── README.md       ← qué es, para qué sirve, dependencias
├── ESTADO.md       ← estado actual, última acción, próximo paso
├── HERRAMIENTAS.md ← tools propias + integraciones con otras islas
├── docs/           ← documentación específica
└── scripts/        ← scripts propios
```

`isla-context-sync.yml` lee el README y ESTADO de cada isla y actualiza `MAPA-ISLAS.md`.
Así, cualquier Action o bot puede leer `MAPA-ISLAS.md` y saber el estado de todo el ecosistema.

---

## 🚨 Sistema de alertas

Cuando algo falla, el sistema crea un issue automático con:
- Título: `🔍 Audit YYYY-MM-DD — Problemas detectados` o `🛡️ Health YYYY-MM-DD`
- Labels: `audit`, `health`, `needs-attention`
- Cuerpo: listado exacto de lo que falla
- Sin duplicar si ya existe uno del mismo día

Asignación de responsabilidad:
- Issues `audit` → resolver antes del próximo push
- Issues `health` → resolver antes de la próxima sesión
- Issues `needs-attention` → revisar en las primeras horas del día

---

## ✅ Qué queda pendiente para completar el monitoreo

- [ ] Crear labels: `audit`, `health`, `needs-attention` en GitHub
- [ ] Añadir `GROQ_API_KEY` en GitHub Secrets
- [ ] Añadir README.md a cada isla (ollama, docker, infra, hardware, osint)
- [ ] Crear `ECOSISTEMA.md` y `CONVENCIONES.md` (ficheros maestros)
- [ ] Conectar thdora bot → notificaciones de issues (F3)

---

*Documentado en sesión S20260703 — 03 Jul 2026*  
*Ver también: `docs/REGLA-DIARY.md`, `ROADMAP-MASTER.md`*
