# Sesión Noche — Investigación 3 Pilares
**Fecha:** 2026-06-24 ~01:50 CEST  
**Estado:** Investigación completa, documentada

---

## Qué se investigó esta noche

1. **Arch Linux optimización** → `2026-06-24-arch-linux-optimizacion-completa.md`
2. **LangChain + Ollama local** → `2026-06-24-langchain-ollama-optimizacion.md`  
3. **OSINT Visual personas/cámaras** → `2026-06-24-osint-visual-personas-camaras.md`

---

## Conclusiones clave

### Arch Linux
- El i5-8400 en mode powersave usa ~1.8GHz, en performance usa 3.6GHz boost
- ZRAM obligatorio con 16GB cuando Ollama carga modelos
- El sysctl ya documentado en `ssh-hardening` necesita ampliarse con las IAs opciones
- Kernel Zen para mejorar latencia bajo carga IA

### LangChain
- El código de optimización ya está listo para copiar/pegar en Gitea
- La estructura de proyecto `batcueva-ai/` está definida
- RAG completo con Qdrant + LangChain + Ollama documentado

### OSINT
- SpiderFoot (ya en stack) cubre el 70% automáticamente
- Falta: Sherlock + Maigret (instalar en Fase 4)
- El flujo n8n + Telegram + OSINT está diseñado
- Cámaras: IVRE + nmap es suficiente para red local

---

## Pendiente de esta sesión

- [ ] Actualizar MASTER-PENDIENTES con estas 3 investigaciones
- [ ] Crear repositorio `batcueva-ai` en Gitea cuando Madre esté activa
- [ ] Aplicar optimizaciones Arch en varopc antes de instalar Ollama
- [ ] Instalar Sherlock/Maigret post-Fase 2
