# 📋 Rutina Diaria de Operaciones

> Checklist diario para mantener el ecosistema sano y mi vida como empresa funcionando.

---

## ☀️ Mañana (5-10 min)

- [ ] Ver estado de Madre: `ssh madre "docker ps && df -h"`
- [ ] Revisar inbox de tareas pendientes
- [ ] Definir 1-3 objetivos del día
- [ ] Actualizar estado en `ESTADO-SISTEMA.md` si algo cambió

---

## 🌙 Noche — Cierre de sesión (5-10 min)

- [ ] Commit de lo que se documentó/cambió: `git add -A && git commit -m "cierre-$(date +%Y%m%d)" && git push`
- [ ] Crear entrada en `diarios/cierre-$(date +%Y%m%dT%H%M%S).md`
- [ ] Anotar bloqueos o tareas para mañana

---

## 📅 Semanal (30 min, domingos)

- [ ] Revisar `proyectos/activos.md` — ¿qué avanzó?
- [ ] Revisar `vida/objetivos.md` — ¿voy bien?
- [ ] Limpiar `inbox/` — procesar o archivar
- [ ] Verificar backups funcionando
- [ ] Actualizar `ROADMAP-MASTER.md`
