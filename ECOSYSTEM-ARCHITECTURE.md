# 🌳 ARQUITECTURA DEL ECOSISTEMA YGGDRASIL

> Documento raíz. Define la estructura completa, las reglas y cómo se comunican todas las piezas.
> Cada pieza del ecosistema hereda estas reglas. Ninguna las puede contradecir.

Última actualización: 2026-07-03

---

## 1. MAPA DEL ECOSISTEMA

```
┌────────────────────────────────────────────────────────────────────────────────────┐
│  ECOSISTEMA YGGDRASIL                                                            │
│                                                                                 │
│  ┌─────────────────┐   ┌─────────────────┐   ┌─────────────────┐   │
│  │ yggdrasil-dew  │   │    thdora       │   │  investigador  │   │
│  │ (cerebro/docs) │   │  (bot+API)     │   │   -maestro    │   │
│  │ ~/yggdrasil-dew│   │~/Projects/thdo│   │~/Projects/inv │   │
│  └─────────────────┘   └─────────────────┘   └─────────────────┘   │
│       │ reglas               │ ejecuta             │ conectado      │
│       └─────────────────────► MADRE (servidor local)          │
│                                  IP: 100.91.112.32                    │
│                                  SSH: ssh madre                      │
│                                  Docker: thdora en :8000              │
│                                                                       │
│  DISPOSITIVOS:  💻 Madre (Acer)  📱 iPhone (blink)  ☁️ GitHub Actions       │
└────────────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. JERARQUÍA DE REGLAS (cascada descendente)

Las reglas fluyen de arriba hacia abajo. Las de nivel superior siempre ganan.
**Nunca contradicen. Solo concretan.**

```
NIVEL 0 — ECOSISTEMA
└─ ECOSYSTEM-ARCHITECTURE.md (este archivo) ← ley máxima
└─ CONVENCIONES.md                          ← normas de escritura/commits
└─ REGLAS-SINE.md                           ← reglas inamovibles

    NIVEL 1 — REPOS
    └─ yggdrasil-dew/README.md              ← qué es este repo
    └─ thdora/README.md                    ← qué es thdora

        NIVEL 2 — MÓDULOS
        └─ scripts/SCRIPTS.md              ← reglas de scripts
        └─ .github/workflows/README.md    ← reglas de actions
        └─ docs/thdora-guardian/LIGA.md   ← reglas del bot

            NIVEL 3 — ARCHIVOS
            └─ Cada .sh con su cabecera documentada
            └─ Cada .yml con su descripción
            └─ Cada endpoint con su docstring
```

**Regla:** Si un archivo de nivel 3 contradice a nivel 0 → el archivo está mal, no la regla.

---

## 3. ESCALADO: SCRIPT → ACTION → BOT

```
┌──────────────────────────────────────────────┐
│  NIVEL 1: SCRIPT (.sh)                  │
│  Ejecuta en Madre. Tiene estado local.  │
│  Tests: smoke-test-scripts.sh           │
│  Compatible: bash + blink               │
└──────────────────────────────────────────────┘
         ↓ escala si: necesita nube / auto / sin Madre
┌──────────────────────────────────────────────┐
│  NIVEL 2: GITHUB ACTION (.yml)          │
│  Corre en la nube. Sin estado local.    │
│  Tests: CI propio en cada workflow      │
│  Compatible: ubuntu-latest              │
└──────────────────────────────────────────────┘
         ↓ escala si: necesita inteligencia / móvil / respuesta humana
┌──────────────────────────────────────────────┐
│  NIVEL 3: BOT (thdora + Telegram)       │
│  Vive en thdora. Tiene memoria/IA.      │
│  Tests: pytest en Docker                │
│  Interfaz: Telegram + /comandos         │
└──────────────────────────────────────────────┘
```

---

## 4. REGLAS DE DOCUMENTACIÓN EN CASCADA

Cada archivo se documenta en su propio nivel y actualiza al nivel superior.

### Pequeño a grande (cómo fluye la información)

```
Script nuevo creado
  ↓ añade su entrada en scripts/SCRIPTS.md
  ↓ si escala a Action: añade en .github/workflows/README.md
  ↓ si escala a Bot: añade en docs/thdora-guardian/LIGA.md
  ↓ cambio importante: actualiza ROADMAP.md
  ↓ cambio arquitectural: actualiza ECOSYSTEM-ARCHITECTURE.md (este archivo)
```

### Regla INBOX
Todo lo que no tiene destino claro → va a `inbox/` con frontmatter.
El clasificador.yml lo procesa automáticamente.
**Nada se queda en la raíz sin clasificar.**

### Regla RAIZ-LIMPIA
La raíz del repo solo puede contener:
- Archivos `.md` de gobernanza (README, ROADMAP, CONVENCIONES, ECOSYSTEM-ARCHITECTURE)
- Carpetas estructurales: `.github/`, `docs/`, `scripts/`, `inbox/`
- `.gitignore`, `.env.template`

**Ningún `.sh` vive en raíz. Jamás.**

---

## 5. REGLA DE TESTING (cada capa tiene su test)

| Capa | Test | Quién lo ejecuta | Cuándo |
|------|------|-------------------|--------|
| Scripts `.sh` | `smoke-test-scripts.sh` | Humano + CI | Antes de cada sesión |
| GitHub Actions | `test-scripts.yml` + syntax check | GitHub automático | En cada push a `scripts/` |
| Bot (thdora) | `pytest tests/` | Docker en Madre | En cada commit a thdora |
| Endpoints API | `/health` + `/test` | thdora self-check | En arranque de Docker |

**Regla:** Nada llega a `main` sin pasar su test correspondiente.

---

## 6. REGLA DE COMPATIBILIDAD DE DISPOSITIVOS

Madre (Acer) y iPhone (blink) tienen capacidades distintas:

| Capacidad | Madre | iPhone/blink |
|-----------|-------|---------------|
| Docker | ✅ | ❌ |
| `set -euo pipefail` | ✅ | ❌ (rompe scripts) |
| Arrays bash `()` | ✅ | ⚠️ (limitado) |
| `ssh` a Madre | N/A | ✅ via Tailscale |
| git push | ✅ | ✅ |
| MCP (Perplexity) | ✅ | ✅ |

**Regla COMPAT-BLINK:** Todo script de sesión (new-session, close-session) debe
funcionar en blink. No usar `set -euo pipefail`. No usar arrays avanzados.
Documentar en cabecera: `# Compatible: bash, zsh, blink`.

---

## 7. PROBLEMA CRÍTICO DETECTADO HOY

### El repo NO está clonado en Madre

```
bash: /home/varopc/yggdrasil-dew/...: No such file or directory
```

Esto explica TODOS los errores de hoy. **La ruta `~/yggdrasil-dew` no existe en Madre.**
El repo existe en GitHub pero no en el disco de Madre.

**Fix en una línea (ejecutar en Madre):**
```bash
cd ~ && git clone https://github.com/alvarofernandezmota-tech/yggdrasil-dew.git
```

Despues de eso, todos los scripts funcionan.

---

## 8. ARCHIVOS DIARIOS Y ESTRUCTURA

Todo archivo tiene su lugar. Los diarios son efimeros, la arquitectura es permanente.

```
yggdrasil-dew/
├── README.md                    ← entrada al repo
├── ROADMAP.md                   ← fases y plan
├── CONVENCIONES.md              ← normas de commits y naming
├── ECOSYSTEM-ARCHITECTURE.md   ← este archivo (ley máxima)
├── ESTADO-SISTEMA.md           ← estado actual (actualizar cada sesión)
├── MASTER-PENDIENTES.md        ← backlog priorizado
├── .github/
│   └── workflows/               ← GitHub Actions
├── docs/
│   ├── diarios/YYYY-MM-DD.md    ← sesiones de trabajo
│   ├── thdora-guardian/         ← docs del bot
│   ├── audits/                  ← resultados de auditorías
│   └── infra/                   ← infraestructura y Docker
├── scripts/
│   ├── SCRIPTS.md               ← indice de scripts
│   ├── maintenance/             ← sesion, health, crons
│   ├── setup/                   ← bootstrap, permisos
│   ├── thdora/                  ← scripts especificos de thdora
│   └── tests/                   ← smoke tests
└── inbox/                       ← entrada temporal (se procesa y vacia)
    └── YYYY-MM-DD-tema.md       ← formato obligatorio
```

---

## 9. DEUDA TÉCNICA DE SCRIPTS (detectada hoy)

Scripts duplicados que hay que consolidar:

| Script | Problema | Acción |
|--------|---------|--------|
| `close-session.sh` | ✅ Correcto, compat blink | Mantener |
| `session-close.sh` | Duplicado del anterior | Borrar o redirigir |

**Comando para limpiar (en Madre tras clonar):**
```bash
cd ~/yggdrasil-dew
git rm scripts/maintenance/session-close.sh
git commit -m "refactor(scripts): eliminar session-close.sh duplicado"
git push
```

---

_Generado: 2026-07-03 — Perplexity MCP_
_Próxima revisión: al cerrar el Sprint 6_
