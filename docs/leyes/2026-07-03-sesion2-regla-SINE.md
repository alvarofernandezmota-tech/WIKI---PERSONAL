---
fecha: "2026-07-03T05:20:00"
tags: ["inbox", "regla", "documentacion", "ecosistema"]
estado: "capturado"
---

# Captura: Regla SINE + Issues Maestros + Arquitectura Bots

## 💡 Idea clave de sesión

> "Todo lo que ocurre en el ecosistema se documenta a la vez en varios sitios donde corresponda.
> Cuando el archivo sea subido a la repo o al local, se le busca el hueco y se le etiqueta."

Esto es la **Regla SINE** — documentada en `docs/reglas/SINE.md`.

## 🔧 Issues maestros pendientes de crear

- [ ] `[ECOSISTEMA] thdora — deuda técnica crítica` → apunta a thdora#12, #10, #17
- [ ] `[ECOSISTEMA] thdora — fases F10-F16` → apunta a thdora#3-9
- [ ] `[ECOSISTEMA] bots — arquitectura Docker repos privadas`
- [ ] `[ECOSISTEMA] yggdrasil-research — crear repo`

## 🤖 Arquitectura bots decidida

- Una repo privada por bot
- Un Docker separado por bot
- Cada bot conectado a yggdrasil-dew
- Bots planeados: thdora-guardian, thdora-dew, thdora-research

## ⚡ Fix urgente Madre

```bash
cd ~/yggdrasil-dew && git pull
bash scripts/maintenance/setup-permissions.sh
bash scripts/maintenance/new-session.sh
```

## Estado
Procesar → docs/reglas/ + docs/arquitectura/ + issues yggdrasil-dew
