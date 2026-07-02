# Terminal en iPhone — a-Shell
#herramientas #iphone #terminal #mobile-ok #fase0

**Fecha:** 2026-07-03  
**Estado:** 🟡 EN PROCESO — pendiente instalar y configurar
**Por qué:** Operar sin ordenador hasta que MCP Cursor esté configurado

---

## Situación

El Acer no es accesible hasta que el MCP de Cursor esté operativo con token `repo` full.
Mientras tanto, desde iPhone podemos operar el repo con:
- **Perplexity** (app) — MCP GitHub activo ✅ ya funcionando
- **a-Shell** — terminal iOS con Python, SSH, git nativo

---

## a-Shell — Qué es

- Terminal Unix completa para iOS (App Store, gratuita)
- Incluye: `python3`, `pip`, `git`, `ssh`, `curl`, `vim`, `lua`
- Soporte SSH nativo → conexión directa a Madre vía Tailscale
- No necesita jailbreak
- Alternativa: **iSH Shell** (emulación Alpine Linux, más lento)

---

## Instalación

1. App Store → buscar **"a-Shell"** (desarrollador: Nicolas Holzschuch)
2. Abrir la app → ya tienes terminal funcional
3. Configurar SSH a Madre:

```bash
# En a-Shell:
ssh-keygen -t ed25519 -C "iphone-ashell"
# Copiar clave pública a Madre:
ssh-copy-id -i ~/.ssh/id_ed25519.pub alvaro@[ip-tailscale-madre]
```

---

## Uso con GitHub

```bash
# Clonar repo (solo lectura o con token):
git clone https://[TOKEN]@github.com/alvarofernandezmota-tech/yggdrasil-dew.git

# O configurar git con token:
git config --global credential.helper store
git config --global user.email "tu@email.com"
git config --global user.name "Alvaro"
```

---

## Capacidades desde iPhone con esta setup

| Acción | Perplexity MCP | a-Shell |
|---|---|---|
| Crear/editar ficheros repo | ✅ | ✅ |
| Commits y push | ✅ (vía MCP) | ✅ (git) |
| SSH a Madre | ❌ | ✅ |
| Ejecutar scripts en Madre | ❌ | ✅ |
| Docker en Madre | ❌ | ✅ (vía SSH) |
| Labels/milestones GitHub | ❌ | ❌ (necesita token full) |
| Comandos Tailscale | ❌ | ❌ (no root) |

---

## Pendiente configurar

- [ ] Instalar a-Shell en iPhone
- [ ] Generar clave SSH en a-Shell
- [ ] Añadir clave al `authorized_keys` de Madre
- [ ] Test conexión SSH vía Tailscale
- [ ] Clonar repo en a-Shell con token

> **Nota:** Con Tailscale activo en iPhone, el SSH a Madre funciona directamente aunque el iPhone esté en otra red. Instalar Tailscale en iPhone también.
