---
tags: [home, indice, mapa]
fecha-actualizacion: 2026-07-01
---

# 🏠 HOME — yggdrasil-dew

> Punto de entrada al ecosistema Batcueva.
> Si no sabes por dónde empezar, empieza aquí.

---

## 🚨 AHORA MISMO — 01 jul 2026

| Qué | Estado |
|---|---|
| Contenedores UP | **14/14** ✅ |
| Kali Desktop | ⏳ Descargando imagen (~35%) |
| Hallazgo abierto | ⚠️ **SEC-001** — Puerto 21 FTP router Digi |
| Fase activa | **Fase 2** — Stack pentest/OSINT |

➡️ **[Ver estado completo → ESTADO-SISTEMA.md](ESTADO-SISTEMA.md)**
➡️ **[Cómo continuar mañana → docs/ecosistema/donde-continuar.md](docs/ecosistema/donde-continuar.md)**

---

## 🗺️ Documentos principales del repo

### 🔍 Orientación y contexto
| Fichero | Para qué sirve |
|---|---|
| [README.md](README.md) | Qué es este repo y cómo está organizado |
| [ECOSISTEMA.md](ECOSISTEMA.md) | Visión general del ecosistema Batcueva |
| [CONTEXT.md](CONTEXT.md) | Contexto técnico completo para IAs y agentes |
| [AGENT.md](AGENT.md) | Instrucciones para agentes IA que trabajen en el repo |
| [filosofia.md](filosofia.md) | Por qué existe esto y cómo pensamos |

### 📊 Estado operativo (leer siempre al volver)
| Fichero | Para qué sirve |
|---|---|
| [ESTADO-SISTEMA.md](ESTADO-SISTEMA.md) | Estado REAL ahora mismo — contenedores, red, pendientes |
| [MASTER-PENDIENTES.md](MASTER-PENDIENTES.md) | Lista priorizada de todo lo pendiente |
| [CHANGELOG.md](CHANGELOG.md) | Historial de cambios importantes |
| [ROADMAP.md](ROADMAP.md) | Hoja de ruta por fases |

### 🛠️ Reglas y convenciones
| Fichero | Para qué sirve |
|---|---|
| [CONVENCIONES.md](CONVENCIONES.md) | Reglas del repo — cómo nombrar, documentar, estructurar |
| [PLAN-SEGURIDAD-Y-DESPLIEGUE.md](PLAN-SEGURIDAD-Y-DESPLIEGUE.md) | Plan de seguridad del ecosistema |

### 📖 Guías útiles (nuevas)
| Fichero | Para qué sirve |
|---|---|
| [docs/ecosistema/donde-continuar.md](docs/ecosistema/donde-continuar.md) | **🔗 LEE ESTO al volver** — dónde estamos y qué hacer |
| [docs/ecosistema/mapa-para-que-sirve-cada-cosa.md](docs/ecosistema/mapa-para-que-sirve-cada-cosa.md) | Para qué sirve cada herramienta del ecosistema |
| [docs/infra/accesos-servicios.md](docs/infra/accesos-servicios.md) | Todas las URLs, usuarios y credenciales |

---

## 📁 Estructura del repo

```
yggdrasil-dew/
├── 📋 Ficheros raíz — documentos principales (los de arriba)
├── inbox/           ← notas rápidas de sesiones, procesar periódicamente
├── diarios/         ← log diario de qué se hizo
├── docs/            ← documentación técnica permanente
│   ├── ecosistema/  ← mapas, guías de continuación
│   └── infra/       ← accesos, red, hardware
├── docker/          ← composes definitivos organizados por fase
│   └── madre/       ← compose real Fase 1 (varopc)
├── osint-stack/     ← composes pentest/OSINT (Kali, SpiderFoot)
├── thdora/          ← documentación del bot
├── proyectos/       ← proyectos activos
├── formacion/       ← aprendizaje, cursos, notas
├── scripts/         ← scripts de utilidad
├── setup/           ← guías de instalación
├── hardware/        ← fichas de hardware
├── agentes/         ← configuraciones de agentes IA
└── templates/       ← plantillas de documentos
```

---

## 📞 Accesos rápidos servicios

| Servicio | URL |
|---|---|
| Open WebUI (IA local) | `http://100.91.112.32:3001` |
| Portainer (Docker) | `http://100.91.112.32:9000` |
| SpiderFoot (OSINT) | `http://100.91.112.32:5001` |
| Kali Desktop | `https://100.91.112.32:6901` |
| Grafana | `http://100.91.112.32:3000` |
| Gitea | `http://100.91.112.32:3003` |

➡️ Lista completa: [docs/infra/accesos-servicios.md](docs/infra/accesos-servicios.md)

---
_Actualizado: 01 jul 2026 02:08 CEST — Perplexity vía MCP_
