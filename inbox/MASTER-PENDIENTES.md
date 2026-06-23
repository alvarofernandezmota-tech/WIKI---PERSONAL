---
tags: [pendiente, master, planificacion, urgente, python, pentest, llm, ia-local]
fecha: 2026-06-23
revision: cada-domingo
owner: alvarofernandezmota-tech
perfil: dev-python · pentest-linux · ia-local · llm · ml
---

# 📋 MASTER PENDIENTES — Ecosistema completo

> Fuente única de verdad de TODO lo pendiente.
> Se revisa cada domingo. Se ejecuta cada día desde aquí.
> Cuando se completa una tarea → marcar con ✅ + fecha + mover al diario del día.

---

## 🟣 PERFIL PROFESIONAL — Enfoque y norte del sistema

> Este sistema está construido para soportar el crecimiento profesional de Álvaro
> como **desarrollador Python + pentester Linux + ingeniero de IA local**.
> Todo lo que se documenta, aprende o construye apunta a este perfil.

### Stack profesional objetivo
- **Lenguaje principal:** Python 3.x — scripting, automatización, bots, ML, APIs
- **Seguridad ofensiva:** pentesting Linux, OSINT, reconocimiento de redes, CTF
- **IA local:** Ollama, LLMs open source, RAG, fine-tuning, agentes autónomos
- **LLMs y ML:** arquitecturas transformer, entrenamiento, inferencia, despliegue
- **Chatbots:** Telegram bots (TOKI), integración LLM, handlers, memoria
- **Infraestructura:** Linux Arch/Hyprland, Docker, Tailscale, servidores caseros

### Formación activa
- Python: curso activo (módulo 05 pendiente) + práctica real en thdora
- OSINT: primeros scans con nmap + theHarvester pendientes
- LLMs: documentación exhaustiva en `agentes/` — ronda 2 pendiente
- Pentest: setup herramientas pendiente en Madre

---

## 🔴 AHORA — Próxima sesión

### 🦇 BATCUEVA — Fase 1 (instalación esta semana)
> Ver nota completa: `inbox/2026-06-23-batcueva-stack-definitivo.md`
- [ ] **Open WebUI** en Madre (:3001) — UI para Ollama
- [ ] **Uptime Kuma** en Madre (:3002) — vigilar servicios
- [ ] **SpiderFoot** en Madre (:5001) — OSINT (estaba a medias)
- [ ] **Portainer** en Madre (:9000) — UI Docker
- [ ] **UFW + fail2ban** en Madre — seguridad básica

### Ronda 2 LLM — Gemini Deep Research
- [ ] Copiar Prompt Maestro v2 de `inbox/2026-06-22-tarde-netdata-agentes-llm.md`
- [ ] Pegar en Gemini con Deep Research activado
- [ ] Esperar output (7 archivos nuevos):
  - `agentes/tecnicas-entrenamiento.md`
  - `agentes/parametros-inferencia.md`
  - `agentes/fine-tuning-local.md`
  - `agentes/erika-persona.md`
  - `agentes/arquitecturas-emergentes.md`
  - `agentes/seguridad-ataques-llm.md`
  - `agentes/etica-principios-por-modelo.md`
- [ ] Pegar output en Perplexity → subir 7 fichas al repo

### Auditoría inbox (sesión dedicada, ~60 min)
> Ver protocolo completo en `inbox/README.md` sección 4
- [ ] Ejecutar auditoría 1 a 1 de los 24 archivos `🟡 PENDIENTE` en inbox
- [ ] Orden: abrir → leer contenido real → decidir (✅/✏️/🔀/📦/🗑️) → ejecutar
- [ ] Actualizar inventario en `inbox/README.md` al finalizar
- [ ] Actualizar este MASTER-PENDIENTES con lo que salga

### SSH sin contraseña Madre → Acer
- [ ] `ssh-keygen -t ed25519 -C "varopc"` en Madre
- [ ] `ssh-copy-id varo@100.86.119.102`
- [ ] Verificar login sin contraseña
- [ ] Opcional: sudo sin contraseña en Acer para scripts remotos

---

## 🟡 ESTA SEMANA

### 🦇 BATCUEVA — Fase 2
- [ ] **Shadowbroker** — aviones militares + civiles, 25k barcos AIS, GPS jamming
- [ ] **OSIRIS** — globo 3D: satélites, cámaras CCTV, seísmos, nuclear
- [ ] **Kismet** — red local WiFi/Bluetooth
- [ ] **Pi-hole** — DNS + bloqueo anuncios
- [ ] **tmux** — sesiones persistentes en Madre

### Auditoría repo completo (después de vaciar inbox)
> Solo hacer después de completar la auditoría inbox — ver razón en `inbox/README.md`
- [ ] Explorar y auditar: `diarios/` `docs/` `formacion/` `osint/` `proyectos/` `setup/` `templates/` `tools/` `yo/`
- [ ] Verificar que `CONTEXT.md` refleja estado real del ecosistema
- [ ] Verificar que `HOME.md` tiene todas las secciones actuales
- [ ] Verificar que `ECOSISTEMA.md` está actualizado con batcueva stack
- [ ] Identificar carpetas vacías o con contenido obsoleto

### Netdata — post-configuración
- [ ] Conexión persistente Acer→Madre con autossh (no depender del reboot)
- [ ] Dashboard HTML personalizado del ecosistema
- [ ] Documentar configuración final en `setup/netdata.md`

### varopc — git sync automático
- [ ] `git pull` en local para traer todos los archivos nuevos
- [ ] Instalar plugin **Obsidian Git** → configurar auto-commit
- [ ] Configurar `inbox/` como carpeta por defecto nuevas notas en Obsidian
- [ ] Probar flujo completo: editar en Obsidian → commit → push a GitHub

### varopc — escritorio (pendientes marcados como TODO)
- [ ] Audio sistema — mapear teclas volumen en Hyprland (⚠️ pendiente de hoy 23/06)
- [ ] Salvapantallas Hyprland (⚠️ pendiente de hoy 23/06)
- [ ] Tercer monitor → comprar adaptador DVI-D (macho) → HDMI (hembra) ~3-5€

### Madre — servidor base
- [ ] Instalar tmux en Madre
- [ ] Documentar OS actual: `uname -a` + `cat /etc/os-release`
- [ ] `df -h` + `free -h` → actualizar `setup/madre.md`
- [ ] SSH: documentar ruta repo thdora (`find ~ -name docker-compose.yml`)

### thdora — bot TOKI
- [ ] Verificar `/start` en Telegram → TOKI responde
- [ ] Crear `docs/DEPLOY.md` — guía deploy paso a paso
- [ ] Crear `docs/SERVIDOR_MADRE.md` — IP, usuario, rutas
- [ ] Crear `docs/TROUBLESHOOTING.md` — errores conocidos

### yggdrasil-dew — segundo cerebro
- [ ] Migrar fichas antiguas: sustituir `gemini.md` y `grok.md` (stubs) por versiones completas
- [ ] Ampliar `agentes/perplexity.md` con estructura nueva
- [ ] Actualizar `agentes/README.md` con tabla completa de todos los modelos
- [ ] Crear `yo/objetivos-2026.md` — objetivos profesionales y personales

---

## 🟢 PRÓXIMAS 2 SEMANAS

### Python — desarrollo profesional
- [ ] Terminar módulo 05 del curso Python
- [ ] Leer `src/bot/handlers/menu.py` en thdora → documentar patrones en `formacion/python/handlers.md`
- [ ] Crear `formacion/python/roadmap.md` — ruta desde nivel actual hasta dev profesional
- [ ] Práctica: crear un script Python que haga query a Ollama API local
- [ ] Práctica: crear un script Python de reconocimiento de red básico

### OSINT + Pentest — setup herramientas en Madre
- [ ] Instalar nmap: `yay -S nmap` (o `pacman -S nmap` en Madre)
- [ ] Instalar theHarvester: `yay -S theharvester`
- [ ] Primer scan real: `nmap -sV 10.134.31.0/24`
- [ ] Documentar herramientas instaladas en `osint/herramientas.md`
- [ ] Crear `osint/README.md` — metodología y flujo de trabajo OSINT

### IA local — integración con sistema
- [ ] Configurar Local GPT en Obsidian → apuntar a Ollama Madre (`100.91.112.32:11434`)
- [ ] Open WebUI → RAG sobre yggdrasil-dew desde navegador
- [ ] Crear Modelfile Erika en Ollama → primer agente local con personalidad
- [ ] Fine-tuning LoRA básico → primer experimento con Unsloth en Madre

### thdora — handlers TOKI (por orden)
- [ ] `/diario <texto>` — escribe en `diarios/YYYY-MM-DD.md` vía GitHub API
- [ ] `/inbox <texto>` — crea nota en `inbox/` con tags automáticos
- [ ] `/tarea <texto>` — añade tarea al diario del día
- [ ] `/estado` — muestra estado Docker en Madre
- [ ] `/deploy` — git pull + rebuild desde Telegram

### personal — migración
- [ ] `01_traking_diario/01_diarios/2025/` → migrar diarios 2025 a `diarios/2025/`
- [ ] `04_curiosidad/` → migrar lo útil a `inbox/`
- [ ] `00_yo/` → migrar a `yo/`
- [ ] `00_sistema/PROMPTS-DICCIONARIO.md` → migrar a `agentes/prompts.md`

---

## 🔵 FUTURO (cuando haya tiempo/presupuesto)

### 🦇 BATCUEVA — Fase 3
- [ ] **n8n** → automatización workflows (reemplaza Zapier, 100% gratis OS)
- [ ] **Homepage/Homarr** → dashboard central que une TODO
- [ ] **Headscale** → reemplaza Tailscale cloud (self-hosted, más control)
- [ ] **Gitea** → GitHub propio self-hosted
- [ ] **Code Server** → VSCode en el browser desde cualquier sitio

### IA local — proyectos avanzados
- [ ] Desplegar pipeline RAG completo: documento → embeddings → búsqueda → respuesta
- [ ] Agente autónomo Python que use herramientas (nmap, whois, etc.) vía LLM
- [ ] personal-analytics → dashboard de hábitos y productividad
- [ ] Sistema de notas con LLM integrado (mejor que Obsidian para dev)

### Hardware (cuando haya presupuesto)
- [ ] RAM 16GB DDR4 SO-DIMM para varopc (~40-50€) 🔴 máximo impacto
- [ ] RTX 3060 12GB para Madre (~200-250€ 2ª mano) — para fine-tuning y modelos grandes
- [ ] HP TouchSmart → instalar Linux Mint + configurar como dashboard
- [ ] Workstation IA futura: Ryzen 7 + 32GB + RTX 3060 (~400€ 2ª mano)
- [ ] Adaptador DVI-D → HDMI para tercer monitor (~3-5€)

### Proyectos personales
- [ ] ai-toolkit → crear ficha + arrancar
- [ ] Impresión 3D → crear ficha + plan
- [ ] Redmi A5 → crear ficha + plan
- [ ] HP rescate → Linux Mint + dashboard

---

## ✅ COMPLETADO (histórico)

| Fecha | Tarea |
|---|---|
| 2026-06-23 | Stack batcueva definitivo documentado (todo OS, coste 0€) |
| 2026-06-23 | Maltego eliminado → sustituido por SpiderFoot |
| 2026-06-23 | Zapier eliminado → sustituido por n8n |
| 2026-06-20 | UFW: regla SSH añadida — puerto 22 ALLOW |
| 2026-06-20 | fail2ban — active (running) + enabled |
| 2026-06-20 | Monitores DP-1 + HDMI-A-1 scale 1 |
| 2026-06-20 | Sony Bravia overscan — Full Pixel activado |
| 2026-06-20 | Salvapantallas hypridle — listeners comentados |
| 2026-06-22 | Netdata multi-nodo — Madre + Acer conectados |
| 2026-06-22 | 15 fichas LLM creadas en `agentes/` |
| 2026-06-22 | inbox/README.md elevado a estándar de ingeniería v2.0 |
| 2026-06-22 | Prompt Maestro v2 documentado en inbox |

---

## 🗓️ Planificación semanal

> Cada mañana: abrir esta nota → elegir 3 tareas → moverlas al diario del día.
> Cada noche: cerrar el diario → marcar las completadas aquí.
> Cada domingo: revisar esta nota completa → reordenar prioridades.

```
Lunes     → thdora + Madre (día técnico)
Martes    → formación Python — curso + práctica
Miércoles → thdora handlers TOKI + Python bots
Jueves    → OSINT + pentest + seguridad Linux
Viernes   → LLM + IA local + Ollama + experimentos ML
Sábado    → libre / exploración / proyectos secundarios
Domingo   → revisión semanal + auditoría inbox + actualizar este archivo
```

---

_Actualizado: 23 jun 2026 · Próxima revisión: domingo 28 jun 2026_
_Perfil: dev Python · pentest Linux · IA local · LLMs · ML_
_Ver: [[HOME]] · [[CONTEXT]] · [[ECOSISTEMA]] · [[inbox/README]]_
