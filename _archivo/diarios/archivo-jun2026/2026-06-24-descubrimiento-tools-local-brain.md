# Descubrimiento tools/local-brain — 24 jun 2026 03:10

> Encontrado en git pull de Madre. No estaba documentado en ESTADO-SISTEMA ni en MASTER-PENDIENTES.

---

## Qué hay en tools/ que no teníamos mapeado

```
tools/
├── README.md
├── 2026-06-23-script-vaciado-inbox-gemini.md
├── pull-stack-robusto.sh            ← script robusto para pull de imágenes
├── local-brain/                     ← PROYECTO ACTIVO — cerebro IA local
│   ├── README.md
│   ├── TROUBLESHOOTING.md
│   ├── main.py                      ← script principal
│   ├── deploy_brain.sh              ← script de deploy
│   ├── requirements.txt
│   └── .env.example
└── local-brain-claude/              ← variante con Claude
    ├── README.md
    ├── main_claude.py
    └── deploy_brain_claude.sh
```

## Acción pendiente
- [ ] Auditar `tools/local-brain/` — ¿qué hace main.py?
- [ ] Mover `tools/local-brain/` a `proyectos/local-brain/` si es proyecto activo
- [ ] Añadir a ESTADO-SISTEMA.md
- [ ] `pull-stack-robusto.sh` — ¿reemplaza pre-descarga-todo.sh?

## Estado descarga Madre
- PID: 186734
- Log: /tmp/pre-descarga.log
- Iniciado: 24 jun 2026 03:10 CEST
