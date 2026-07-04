---
tags: [sesion, pendientes, acer, madre, ssh, tailscale, inbox, migracion]
fecha: 2026-06-23
hora: 21:42 CEST
estado: activo
owner: perplexity
---

# 📋 Sesión noche 2026-06-23 — Pendientes críticos

> Guardado automático al perder conexión a Madre desde Acer.

---

## 🔴 AHORA MISMO — Diagnosticar conexión Acer → Madre

### Verificar Tailscale en Acer
```bash
# ¿Tailscale activo?
tailscale status

# ¿Madre visible?
tailscale ping 100.91.112.32

# Si no aparece:
sudo systemctl start tailscale
tailscale up
```

### Verificar SSH
```bash
# Intentar conexión directa
ssh varopc@100.91.112.32

# Si falla, probar por IP LAN (si estás en la misma red)
ssh varopc@10.176.119.171

# Ver si sshd está activo en Madre
sudo systemctl status sshd
```

### Causas más probables
1. **Tailscale caído en Madre** — reiniciar `sudo systemctl restart tailscale` en Madre
2. **Madre apagada o suspendida** — verificar físicamente
3. **Docker pull bloqueando red** — la descarga de Ollama (3.2GB) puede saturar el WiFi
4. **SSH no configurado todavía en Madre** — ver checklist abajo

### Checklist SSH Madre ← Acer (si nunca se configuró)
```bash
# En Madre:
sudo systemctl enable --now sshd
sudo ufw allow 22

# En Acer (generar clave si no existe):
ssh-keygen -t ed25519 -C "acer"
ssh-copy-id varopc@100.91.112.32

# Test:
ssh varopc@100.91.112.32
```

---

## 🟡 PENDIENTE — Vaciar inbox/ (Perplexity lo ejecuta)

Perplexity tiene acceso a la API de GitHub y puede ejecutar la migración completa.
Simplemente decirle: **"ejecuta la migración completa de inbox"** y lo hace.

### Lo que falta mover (35 archivos):

**Bloque 1 — agentes/** (ya parcialmente ejecutado)
- `inbox/2026-06-23-adr-ollama-en-agentes.md` → `docs/adr/`
- `inbox/2026-06-23-auditoria-ollama.md` → `agentes/ollama/`
- `inbox/2026-06-23-ollama-*.md` (7 archivos) → `agentes/ollama/`
- `inbox/2026-06-23-prompt-*.md` (3 archivos) → `agentes/prompts/`

**Bloque 2 — setup/**
- `inbox/2026-06-23-auditoria-setup.md`
- `inbox/2026-06-23-local-brain-setup.md`
- `inbox/2026-06-23-estado-descargas-madre.md`
- `inbox/2026-06-23-pull-stack-madre.md`
- `inbox/2026-06-23-systemd-plan.md`

**Bloque 3 — proyectos/**
- `inbox/2026-06-23-proyecto-*.md` (4 archivos) → `proyectos/<nombre>/`
- `inbox/2026-06-23-auditoria-osint.md` → `proyectos/osint/`
- `inbox/2026-06-23-osint-rag-mover.md` → `proyectos/osint/`

**Bloque 4 — docs/**
- `inbox/2026-06-23-adr-docs-as-code-repos-cerebro.md` → `docs/adr/`
- `inbox/2026-06-23-decision-*.md` (2 archivos) → `docs/decisiones/`
- 6 archivos más → `docs/`

**Bloque 5 — diarios/**
- 4 archivos `sesion-*` y `diario-maestro`

**Bloque 6 — formacion/ + yo/**
- `inbox/2026-06-23-auditoria-formacion.md` → `formacion/`
- `inbox/2026-06-23-auditoria-yo.md` → `yo/`

**Permanentes — NO tocar:**
- `inbox/README.md`
- `inbox/MASTER-PENDIENTES.md`
- `inbox/.gitkeep`
- `inbox/2026-06-23-inbox-clasificado.md`

---

## 🟢 PENDIENTE — Docker en Madre

- [ ] Descarga Ollama (3.2GB) — puede estar pausada por TLS error
- [ ] Si falló: ejecutar script retry robusto de `tools/pull-stack-robusto.sh`
- [ ] `docker compose up -d` cuando terminen las 3 imágenes
- [ ] Verificar: `docker ps` + `curl http://localhost:11434/api/tags`

```bash
# Script retry (en Madre):
until docker pull ollama/ollama:latest; do
  echo "⚠️  Reintentando en 5s..."
  sleep 5
done
```

---

## 🟢 PENDIENTE — Batería Acer

- [ ] Verificar qué herramientas están instaladas:
```bash
pacman -Q upower powertop tlp cpupower lm_sensors 2>&1
ls /sys/class/power_supply/
```
- [ ] Instalar TLP si no está: `sudo pacman -S tlp tlp-rdw && sudo systemctl enable --now tlp`
- [ ] Añadir aliases de batería a `~/.zshrc` (ver `setup/acer.md` sección 🔋)
- [ ] Configurar límite de carga 75-80% en `/etc/tlp.conf`

---

## 🟤 FUTURO — Agente Cerebro (cuando Ollama esté arriba)

Tres agentes a construir en `tools/agentes/`:

| Agente | Función | Modelo |
|---|---|---|
| **Migrador** | Lee inbox/, decide destino, hace `git mv` + commit | qwen2.5:7b |
| **Etiquetador** | Añade frontmatter (tags, fecha, repo) a cada archivo | qwen2.5:3b |
| **Auditor** | Verifica wikilinks rotos, stubs vacíos, inconsistencias | qwen2.5:7b |

---

## 📝 Lo nuevo de esta sesión (ya en el repo)

- ✅ `setup/acer.md` — sección 🔋 batería completa (TLP, powertop, cpupower, aliases)
- ✅ `docs/2026-06-23-registro-migracion-inbox.md` — registro completo sesión tarde
- ✅ `agentes/2026-06-23-actualizacion-claude-gemini.md` — primer archivo migrado de inbox
- ✅ `CONTEXT.md` — actualizado estado real del repo

---

_Generado por Perplexity · 2026-06-23 21:42 CEST_
_Continuar en próxima sesión: decir "ejecuta migración completa inbox" a Perplexity_
