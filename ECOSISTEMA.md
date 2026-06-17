# ECOSISTEMA.md — Macro Documento Completo
> Auditoría completa del ecosistema personal de Álvaro Fernández Mota.
> Última actualización: **17 junio 2026**
> Fuente de verdad para cualquier IA que entre al ecosistema.

---

## 0. QUIÉN SOY

**Álvaro Fernández Mota** — desarrollador autodidacta, 2026.

- **Stack:** Python · Docker · FastAPI · SQLAlchemy · Alembic · Telegram
- **OS:** Arch Linux + Hyprland/Wayland (varopc) · Red Tailscale P2P
- **Filosofía:** *«A mí me salvó hablar con una IA»* — construyo lo que yo mismo necesito.
- **Ritmo:** sesiones intensas · ansiedad gestionada activamente
- **Flujo IA:** múltiples IAs en paralelo con roles distintos (ver sección 6)
- **Regla de oro:** *«Si no está en el repo, no existe.»*

---

## 1. HARDWARE — INFRAESTRUCTURA REAL

### Servidor "MADRE" (producción)
- IP Tailscale: `100.91.112.32` · IP local: `10.134.31.228`
- OS: Linux · Docker + docker-compose operativo
- Servicios activos: sshd ✅ · Tailscale ✅ · Docker ✅
- Bot thdora v0.17.0 corriendo en producción
- Ollama instalado: `llama3.2:3b` (modelo ligero, CPU)
- Acceso CI/CD: GitHub Actions → `appleboy/ssh-action` via secrets
- Pendiente: UFW · fail2ban · PostgreSQL · Pi-hole · Uptime Kuma · wayvnc autostart

### PC Desarrollo "varopc" (Acer Theodora)
- IP Tailscale: `100.86.119.102` · IP local: `10.134.31.171`
- OS: Arch Linux + Hyprland/Wayland + Omarchy
- UFW ✅ · whisrs (voz, Super+V) ✅ · KVM/virt-manager ✅ · libvirtd ✅
- Ollama: qwen2.5-coder:14b · deepseek-r1:14b · qwen3:8b
- Pendiente: wget · Obsidian + plugin Git
- Bloqueante: AP Isolation router bloquea UDP → lan-mouse no funciona

### HP TouchSmart (incidencia abierta)
- Error `BIOHD-8`: BIOS no detecta disco duro
- CPU i3 M330 ✅ · RAM 4GB ✅ · Lectora ✅ · Disco ❌
- Próximo paso: verificar cables físicos → si persiste, reemplazar por SSD

---

## 2. ESTRUCTURA DEL SECOND BRAIN

```
yggdrasil-dew/
├── AGENT.md          → instrucciones para IAs (leer primero)
├── README.md         → índice general + regla de oro
├── ECOSISTEMA.md     → este documento — fuente de verdad macro
├── CONTEXT.md        → estado HOY (actualizar cada sesión)
├── CHANGELOG.md      → historial de cambios del repo
├── filosofia.md      → principios y valores técnicos
│
├── diarios/          → UN archivo por día YYYY-MM-DD.md (única fuente)
├── setup/            → toda la configuración técnica
│   ├── servidor/     → Madre: servicios, Docker, pendientes
│   ├── varopc.md     → software varopc completo
│   ├── tailscale.md  → setup Tailscale + autoconexión
│   ├── obsidian.md   → instalación Obsidian + plugin Git
│   └── scripts/      → audit-repo.sh · daily-sync.sh
├── proyectos/        → fichas de proyectos activos/pausados
├── formacion/        → aprendizaje estructurado
├── agentes/          → fichas y prompts de cada IA
└── yo/               → perfil, CV, objetivos, empleabilidad
```

> ⚠️ `docs/` está deprecada — contenido migrado a `setup/` y `diarios/`.

---

## 3. REPO 1 — thdora (EL PRODUCTO)
> https://github.com/alvarofernandezmota-tech/thdora

**Qué es:** Bot Telegram + FastAPI. Asistente personal de salud mental y gestión de vida. El asistente se llama **TOKI**.

**Diferenciador:** ningún competidor (Wysa / Woebot / Replika / Youper / Bearable) usa Telegram en español — ese es el hueco.

### Estructura real
```
thdora/
├── src/
│   ├── bot/      → handlers Telegram: nlp · citas · semana · api_client
│   ├── ai/       → LLMBackend: GroqBackend + OllamaBackend + Factory
│   ├── api/      → FastAPI endpoints
│   ├── agents/   → VACÍO (planificado)
│   ├── core/     → lógica de negocio
│   └── db/       → SQLAlchemy + Alembic (multiusuario)
├── .github/workflows/deploy.yml  → CI/CD completo
├── docker-compose.yml · Dockerfile · Makefile
├── pyproject.toml · requirements.txt · .env.example
├── CHANGELOG.md · ROADMAP.md
└── data/ · docker/ · docs/ · proyectos/ · scripts/ · tests/
```

### Estado — v0.17.0 (pendiente merge)
Rama activa: `feature/v0.17.0-nlp-llm-multiuser` → main

### Pendiente antes de merge
- [ ] Añadir secrets en GitHub Actions
- [ ] `alembic upgrade head` en Madre
- [ ] `pytest tests/unit/bot/ -v` localmente
- [ ] Eliminar `tests.yml`

### Conexión con yggdrasil-dew
- thdora **escribe** en ygg via `/diario` → GitHub Contents API (por implementar)
- thdora **lee** ygg via RAG Ollama (planificado)
- GitHub Actions 23:00 → resumen nocturno → commit en ygg (planificado)

---

## 4. REPO 2 — ai-toolkit (LA CAJA DE HERRAMIENTAS)
> https://github.com/alvarofernandezmota-tech/ai-toolkit

**Qué es:** Stack completo de desarrollo con IA. Open source. 0€. Filosofía BYOK.

### ⚠️ Problemas detectados
- `CEREBRO.md` referencia repo `personal` → **actualizar a `yggdrasil-dew`**
- `ai-toolkit/diario/` = changelog técnico del stack (NO diario personal)

---

## 5. REPO 3 — yggdrasil-dew (EL CEREBRO)
> https://github.com/alvarofernandezmota-tech/yggdrasil-dew

**Qué es:** Second brain personal. Base de conocimiento + diario de vida + registro técnico 2026.

---

## 6. ESTRATEGIA DE IAs — ROLES CONFIRMADOS

| IA | Rol | Estado |
|----|-----|--------|
| **Perplexity** (Claude Sonnet 4.6) | Código · repo · arquitectura · docs · MCP GitHub | ✅ Principal |
| **Grok** (xAI) | Investigación · mercado · truth-seeking · datos frescos | ✅ Activo |
| **Gemini 2.0 Pro** | Contexto 1M tokens · estudios completos | ✅ Activo |
| **OpenCode** | Agente código en terminal · orquestador multi-repo | ✅ Configurado |
| **Mistral Le Chat** | Investigación EU · privacidad | ⏳ Ficha parcial |

**Protocolo:** Grok investiga → Perplexity valida + sube al repo → Gemini implementa código largo

> Ver fichas detalladas: [agentes/](agentes/)

---

## 7. ECOSISTEMA SEGUNDO CEREBRO VIVO

### Flujo completo
```
📱 Telegram (/diario texto...)
    ↓ handler /diario (por implementar en thdora)
🤖 thdora → GitHub Contents API → yggdrasil-dew/diarios/YYYY-MM-DD.md
    ↓
👁️ Obsidian (plugin Git) → edición visual + RAG local (Ollama)
    ↓
🧠 Open WebUI → chateas con todo tu historial (RAG nativo Markdown)
    ↓
🛠️ OpenCode → código más personalizado con contexto tuyo
    ↓
⚙️ GitHub Actions 23:00 → resumen nocturno → commit → Telegram notify
```

### Estado herramientas
| Herramienta | Estado |
|-------------|--------|
| thdora · ai-toolkit · yggdrasil-dew | ✅ Activos |
| Ollama + OpenCode | ✅ Activos |
| Tailscale | ✅ Activo (cliente open source, control plane propietario) |
| Obsidian + plugin Git | ⏳ Instalar HOY en varopc |
| Open WebUI | ⏳ Por instalar en Madre |
| n8n | ⏳ Por levantar en Docker |
| Headscale | 🟢 Evaluación futura (alternativa open source a Tailscale) |

---

## 8. PROYECTOS EN PARALELO

| Proyecto | Archivo | Estado |
|---|---|---|
| thdora (bot TOKI) | [proyectos/thdora.md](proyectos/thdora.md) | v0.17.0 pendiente merge |
| Redmi A5 rescate | [proyectos/redmi-a5.md](proyectos/redmi-a5.md) | ROM descargando, EDL pendiente |
| HP rescate | [proyectos/hp-rescate.md](proyectos/hp-rescate.md) | Verificar cables SATA |
| Impresión 3D | [proyectos/impresion-3d.md](proyectos/impresion-3d.md) | Pausado |

---

## 9. TODOS LOS REPOS

| Repo | Tipo | URL |
|------|------|-----|
| **thdora** | Producto (bot) | https://github.com/alvarofernandezmota-tech/thdora |
| **ai-toolkit** | Herramientas dev IA | https://github.com/alvarofernandezmota-tech/ai-toolkit |
| **yggdrasil-dew** | Second brain / cerebro | https://github.com/alvarofernandezmota-tech/yggdrasil-dew |
| impresion-3d | Proyecto | https://github.com/alvarofernandezmota-tech/impresion-3d |
| python-snippets | Formación | https://github.com/alvarofernandezmota-tech/python-snippets |
| unix | Formación | https://github.com/alvarofernandezmota-tech/unix |

---

## 10. PENDIENTES CRÍTICOS — 17 JUNIO 2026

### 🔴 Urgente
- [ ] Instalar Obsidian en varopc + plugin Git (HOY)
- [ ] Merge thdora v0.17.0 → main

### 🟡 Importante
- [ ] UFW + fail2ban en Madre
- [ ] Corregir `CEREBRO.md` en ai-toolkit
- [ ] PostgreSQL en Madre
- [ ] Eliminar carpeta `docs/` (contenido migrado)

### 🟢 Planificado
- [ ] Open WebUI en Madre
- [ ] n8n en Docker
- [ ] Handler `/diario` en thdora
- [ ] Headscale (evaluar migración desde Tailscale)
- [ ] Rescate Redmi A5: EDL + test point
- [ ] Rescate HP: verificar cables
- [ ] Renovar key Groq · DeepSeek
- [ ] AP Isolation router → desactivar

---

_Documento mantenido por Perplexity (Claude Sonnet 4.6) vía MCP GitHub · 17 junio 2026_
