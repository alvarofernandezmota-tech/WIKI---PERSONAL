# ECOSISTEMA.md — Fuente de Verdad
> Auditoría completa del ecosistema personal de Álvaro Fernández Mota.
> Última actualización: **20 junio 2026**
> Fuente de verdad para cualquier IA que entre al ecosistema.
> **Regla de oro:** *«Si no está en el repo, no existe.»*

---

## 0. QUIÉN SOY

**Álvaro Fernández Mota** — desarrollador autodidacta, 2026.

- **Stack:** Python · Docker · FastAPI · SQLAlchemy · Alembic · Telegram
- **OS:** Arch Linux + Hyprland/Wayland (varopc) · Red Tailscale P2P
- **Filosofía:** *«A mí me salvó hablar con una IA»* — construyo lo que yo mismo necesito.
- **Flujo IA:** múltiples IAs en paralelo con roles distintos (ver [[#6. ESTRATEGIA DE IAs]])
- Ver perfil completo: [[yo/perfil]]

---

## 1. HARDWARE — INFRAESTRUCTURA REAL

> Ver detalle completo: [[setup/servidor]] · [[setup/varopc]]

### Servidor "MADRE" (producción)
- IP Tailscale: `100.91.112.32` · IP local: `10.134.31.228`
- OS: Linux · Docker + docker-compose operativo
- Servicios activos: sshd ✅ · Tailscale ✅ · Docker ✅
- Stack corriendo: thdora API + bot + Prometheus + Grafana ✅ (desde hoy 20/06)
- Ollama instalado: `llama3.2:3b` (modelo ligero, CPU)
- Acceso CI/CD: GitHub Actions → `appleboy/ssh-action` via secrets
- Pendiente: UFW · fail2ban · PostgreSQL · Pi-hole · Uptime Kuma

### PC Desarrollo "varopc" (Acer Theodora)
- IP Tailscale: `100.86.119.102` · IP local: `10.134.31.171`
- OS: Arch Linux + Hyprland/Wayland + Omarchy
- UFW ✅ · whisrs (voz, Super+V) ✅ · KVM/virt-manager ✅
- Ollama: qwen2.5-coder:14b · deepseek-r1:14b · qwen3:8b
- Obsidian v1.12.7 ✅ (instalado hoy)
- Bloqueante: AP Isolation router bloquea UDP → lan-mouse no funciona

### HP TouchSmart (incidencia abierta)
- Error `BIOHD-8`: BIOS no detecta disco duro
- Ver: [[proyectos/hp-rescate]]

---

## 2. ESTRUCTURA DEL SECOND BRAIN

```
yggdrasil-dew/          ← vault Obsidian + repo cerebro
├── AGENT.md            → instrucciones para IAs (leer primero)
├── README.md           → índice general
├── ECOSISTEMA.md       → este documento
├── CONTEXT.md          → estado HOY
├── filosofia.md        → [[filosofia]]
├── diarios/            → UN archivo por día YYYY-MM-DD.md
├── proyectos/          → fichas de proyectos
├── formacion/          → aprendizaje estructurado
├── agentes/            → fichas y prompts de cada IA
├── osint/              → informes y resultados
├── setup/              → configuración técnica de máquinas
└── yo/                 → perfil, CV, objetivos
```

---

## 3. REPOS DEL ECOSISTEMA

| Repo | Rol | Estado | Enlace |
|------|-----|--------|--------|
| [[proyectos/thdora\|thdora]] | 🤖 Bot + API producción | ✅ v0.17.2 healthy | [GitHub](https://github.com/alvarofernandezmota-tech/thdora) |
| [[proyectos/yggdrasil-dew\|yggdrasil-dew]] | 🧠 Cerebro / second brain | ✅ Activo | [GitHub](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) |
| [[proyectos/personal\|personal]] | 📔 Diarios y vida personal (contexto histórico) | ✅ Referencia | [GitHub](https://github.com/alvarofernandezmota-tech/personal) |
| [[proyectos/thea-ia\|thea-ia]] | 🗂️ Predecesor de THDORA (archivo) | 💤 Archivado | [GitHub](https://github.com/alvarofernandezmota-tech/thea-ia) |
| [[proyectos/ai-toolkit\|ai-toolkit]] | 🛠️ Stack IA open source | ✅ Activo | [GitHub](https://github.com/alvarofernandezmota-tech/ai-toolkit) |
| [[proyectos/impresion-3d\|impresion-3d]] | 🖨️ Hobby / Anycubic Photon V1 | ⏸️ Pausado | [GitHub](https://github.com/alvarofernandezmota-tech/impresion-3d) |
| [[proyectos/image-calculator\|image-calculator]] | 🐍 Proyecto Python menor | 💤 Estable | [GitHub](https://github.com/alvarofernandezmota-tech/image-calculator) |

---

## 4. DIARIOS

> Un archivo por día en `diarios/`. Todo lo que ocurre va aquí.

- [[diarios/2026-06-20]] — Fix healthcheck thdora-bot · Obsidian configurado
- [[diarios/2026-06-19]]
- [[diarios/2026-06-18]]
- [[diarios/2026-06-17]]

> Ver todos: [diarios/](diarios/)

---

## 5. PROYECTOS ACTIVOS

| Proyecto | Ficha | Estado |
|---|---|---|
| thdora (bot TOKI) | [[proyectos/thdora]] | ✅ v0.17.2 en producción |
| Obsidian second brain | [[proyectos/yggdrasil-dew]] | ✅ Configurado hoy |
| Redmi A5 rescate | [[proyectos/redmi-a5]] | ROM descargando, EDL pendiente |
| HP rescate | [[proyectos/hp-rescate]] | Verificar cables SATA |
| Impresión 3D | [[proyectos/impresion-3d]] | Pausado |

---

## 6. ESTRATEGIA DE IAs — ROLES CONFIRMADOS

> Ver fichas detalladas: [[agentes/]]

| IA | Rol | Estado |
|----|-----|--------|
| **Perplexity** (Claude Sonnet 4.6) | Código · repo · arquitectura · docs · MCP GitHub | ✅ Principal |
| **Grok** (xAI) | Investigación · mercado · datos frescos | ✅ Activo |
| **Gemini 2.0 Pro** | Contexto 1M tokens · estudios completos | ✅ Activo |
| **OpenCode** | Agente código en terminal · orquestador multi-repo | ✅ Configurado |
| **Mistral Le Chat** | Investigación EU · privacidad | ⏳ Ficha parcial |

**Protocolo:** Grok investiga → Perplexity valida + sube al repo → Gemini implementa código largo

---

## 7. FLUJO DEL ECOSISTEMA VIVO

```
📱 Telegram (/diario texto...)
    ↓ handler /diario (por implementar en thdora)
🤖 thdora → GitHub Contents API → yggdrasil-dew/diarios/YYYY-MM-DD.md
    ↓
👁️ Obsidian (plugin Git) → edición visual + grafo de conocimiento
    ↓
🧠 Open WebUI → chateas con todo tu historial (RAG nativo Markdown)
    ↓
🛠️ OpenCode → código más personalizado con contexto tuyo
    ↓
⚙️ GitHub Actions 23:00 → resumen nocturno → commit → Telegram notify
```

| Herramienta | Estado |
|-------------|--------|
| thdora · ai-toolkit · yggdrasil-dew | ✅ Activos |
| Ollama + OpenCode | ✅ Activos |
| Tailscale | ✅ Activo |
| Obsidian v1.12.7 | ✅ Instalado hoy en varopc |
| plugin Git Obsidian | ⏳ Por configurar |
| Open WebUI | ⏳ Por instalar en Madre |
| n8n | ⏳ Por levantar en Docker |

---

## 8. PENDIENTES — 20 JUNIO 2026

### 🔴 Urgente
- [ ] Configurar plugin Git en Obsidian (auto pull/push)
- [ ] Verificar que el bot responde en Telegram (`/start`)
- [ ] Crear fichas en `proyectos/` para cada repo

### 🟡 Importante
- [ ] UFW + fail2ban en Madre
- [ ] PostgreSQL en Madre
- [ ] Handler `/diario` en thdora (escribe directo al repo)
- [ ] Corregir `CEREBRO.md` en ai-toolkit (referencia a `personal` → `yggdrasil-dew`)

### 🟢 Planificado
- [ ] Open WebUI en Madre
- [ ] n8n en Docker
- [ ] Headscale (alternativa open source a Tailscale)
- [ ] Rescate Redmi A5: EDL + test point
- [ ] Rescate HP: verificar cables SATA
- [ ] GitHub Actions resumen nocturno 23:00

---

_Documento mantenido por Perplexity (Claude Sonnet 4.6) vía MCP GitHub · 20 junio 2026_
