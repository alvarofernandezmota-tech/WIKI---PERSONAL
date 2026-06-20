---
tags: [pendiente, master, planificacion, urgente]
fecha: 2026-06-20
revision: cada-domingo
---

# 📋 MASTER PENDIENTES — Ecosistema completo

> Fuente única de verdad de TODO lo pendiente.
> Se revisa cada domingo. Se ejecuta cada día desde aquí.
> Cuando se completa una tarea → mover al diario del día.

---

## 🔴 HOY — Sábado 20 jun (antes de dormir)

- [ ] `git pull` en varopc → ver los ~25 archivos nuevos en Obsidian
- [ ] Abrir `Ctrl+G` → verificar grafo conectado
- [ ] Instalar plugin **Obsidian Git** → auto-sync permanente
- [ ] Elegir IA para Obsidian (Local GPT + Ollama recomendado)
- [ ] Verificar `/start` en Telegram → confirmar que TOKI responde

---

## 🟡 ESTA SEMANA

### varopc — git sync automático
- [ ] `git pull` en local para traer la tarde9 y todo lo nuevo
- [ ] Instalar plugin **Obsidian Git** → configurar auto-commit cada X minutos
- [ ] Verificar que los commits son instantáneos (push automático al guardar)
- [ ] Probar flujo completo: editar en Obsidian → commit automático → push a GitHub

### varopc — setup local
- [ ] Instalar nmap: `yay -S nmap`
- [ ] Instalar theHarvester: `yay -S theharvester`
- [ ] Configurar Local GPT en Obsidian → apuntar a Ollama Madre (`100.91.112.32:11434`)
- [ ] Configurar `inbox/` como carpeta por defecto nuevas notas en Obsidian
- [ ] Verificar contenido `~/dev/` — qué hay ahí

### varopc — escritorio (sesión tarde9)
- [ ] **Volumen** → mapear `XF86AudioRaiseVolume` / `XF86AudioLowerVolume` en Hyprland · usa PipeWire 1.6.5
- [ ] **Tercera pantalla** → comprar adaptador DVI-D (macho) → HDMI (hembra) ~3-5€, luego conectar y añadir línea en monitors.conf
- [ ] **Setup completo madre** → documentar hardware, particiones y servicios en `setup/madre.md`
- [ ] ✅ ~~Monitores DP-1 + HDMI-A-1 scale 1~~ → resuelto
- [ ] ✅ ~~Sony Bravia overscan~~ → Full Pixel activado desde menú TV
- [ ] ✅ ~~Salvapantallas hypridle~~ → listeners comentados

### Madre — servidor
- [ ] ✅ ~~UFW: regla SSH añadida~~ → puerto 22 ALLOW · firewall recargado
- [ ] ✅ ~~fail2ban~~ → active (running) desde 18:23 · enabled
- [ ] SSH: documentar ruta repo thdora (`find ~ -name docker-compose.yml`)
- [ ] Documentar OS actual: `uname -a` + `cat /etc/os-release`
- [ ] Instalar tmux en Madre
- [ ] `df -h` + `free -h` → actualizar ficha [[setup/madre]]

### thdora — bot TOKI
- [ ] Verificar `/start` en Telegram → TOKI responde
- [ ] Crear `docs/DEPLOY.md` — guía deploy paso a paso
- [ ] Crear `docs/SERVIDOR_MADRE.md` — IP, usuario, rutas
- [ ] Crear `docs/TROUBLESHOOTING.md` — errores conocidos

### yggdrasil-dew — segundo cerebro
- [ ] Cerrar nota `inbox/segundo-cerebro-fix-gordo.md` → mover a diario 20 jun
- [ ] Crear `yo/objetivos-2026.md` — lista detallada de objetivos
- [ ] Crear fichas pendientes: `proyectos/ai-toolkit.md` · `proyectos/impresion-3d.md` · `proyectos/redmi-a5.md`

---

## 🟢 PRÓXIMAS 2 SEMANAS

### thdora — handlers TOKI (por orden)
- [ ] `/diario <texto>` — escribe en `diarios/YYYY-MM-DD.md` vía GitHub API
- [ ] `/inbox <texto>` — crea nota en `inbox/` con tags automáticos
- [ ] `/tarea <texto>` — añade tarea al diario del día
- [ ] `/estado` — muestra estado Docker en Madre
- [ ] `/deploy` — git pull + rebuild desde Telegram

### Madre — seguridad (Fase 2)
- [ ] PostgreSQL en Docker (sustituir SQLite en thdora)

### personal — migración
- [ ] Leer `01_traking_diario/01_diarios/2025/` → migrar diarios 2025 a `diarios/2025/`
- [ ] Leer `04_curiosidad/` → migrar lo útil a `inbox/`
- [ ] Leer `00_yo/` → migrar a `yo/`
- [ ] Leer `00_sistema/PROMPTS-DICCIONARIO.md` → migrar a `agentes/prompts.md`
- [ ] Marcar `personal/README.md` como archivado

### formación
- [ ] Leer `src/bot/handlers/menu.py` en thdora → documentar en `formacion/python.md`
- [ ] Terminar módulo 05 del curso Python en personal
- [ ] Primer scan OSINT: `nmap -sV 10.134.31.0/24`
- [ ] Input Leap — terminar conexión MacBook ↔ Acer

---

## 🔵 FUTURO (cuando haya tiempo/presupuesto)

### Madre — servicios nuevos
- [ ] Open WebUI → RAG sobre yggdrasil-dew desde navegador
- [ ] Uptime Kuma → monitoreo servicios
- [ ] Pi-hole → DNS + bloqueo anuncios
- [ ] n8n → automatización (diario nocturno automático)
- [ ] wayvnc autostart

### Hardware (cuando haya presupuesto)
- [ ] RAM 16GB DDR4 SO-DIMM para varopc (~40-50€) 🔴 máximo impacto
- [ ] RTX 3060 12GB para Madre (~200-250€ 2ª mano)
- [ ] HP TouchSmart → instalar Linux Mint + configurar como dashboard
- [ ] Workstation IA futura: Ryzen 7 + 32GB + RTX 3060 (~400€ 2ª mano)
- [ ] Adaptador DVI-D → HDMI para tercer monitor (~3-5€)

### Proyectos
- [ ] ai-toolkit → crear ficha + arrancar
- [ ] impresión 3D → crear ficha + plan
- [ ] Redmi A5 → crear ficha + plan
- [ ] HP rescate → Linux Mint + dashboard
- [ ] personal-analytics → arrancar en Madre

---

## 🗓️ Planificación semanal — cómo usar el inbox por días

> Cada mañana: abrir esta nota → elegir 3 tareas → moverlas al diario del día.
> Cada noche: cerrar el diario → marcar las completadas aquí.
> Cada domingo: revisar esta nota completa → reordenar prioridades.

```
Lunes    → thdora + Madre (día técnico)
Martes   → formación Python o Linux
Miércoles → thdora handlers TOKI
Jueves   → OSINT + seguridad
Viernes  → proyectos secundarios
Sábado   → libre / exploración / curiosidad
Domingo  → revisión semanal + actualizar este archivo
```

---

_Actualizado: 20 jun 2026 · Próxima revisión: domingo 22 jun 2026_
_Ver también: [[diarios/2026-06-20]] · [[inbox/auditoria-ecosistema-2026-06-20]] · [[HOME]]_
