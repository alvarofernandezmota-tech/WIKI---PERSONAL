# Prompt de Investigación — Gemini / IA

> Usa este prompt con Gemini, ChatGPT o cualquier LLM para investigar
> cómo escalar el ecosistema Yggdrasil de forma sistemática.

---

## PROMPT COMPLETO (copiar y pegar)

```
Soy un desarrollador que gestiona un ecosistema homelab personal llamado Yggdrasil.
Quiero que actúes como mi arquitecto de sistemas y asesor técnico.

Mi setup actual:
- Servidor principal ("Madre"): PC sobremesa Ubuntu con GTX 1060, 16GB RAM
- Acceso remoto: iPhone 11 via Blink Shell + Tailscale + SSH
- IA local: Ollama con modelos llama3.1:8b, mistral:7b, codellama:7b
- Repositorio de conocimiento: GitHub (yggdrasil-dew)
- Herramientas: tmux, git, bash scripts de mantenimiento
- Seguridad: SSH hardening (pubkey only, no root, no password)

Mi visión: Construir un ecosistema donde agentes de IA locales gestionen
automaicamente tareas de mantenimiento, documentación, OSINT y desarrollo.
El inbox/ del repo es la entrada de datos; docs/ es el conocimiento procesado;
los scripts son la automatización.

Quiero investigar:

1. ARQUITECTURA AGENTES:
   - ¿Cómo diseñar un agente IA local (con Ollama + Python) que procese
     el inbox/ del repo automáticamente?
   - ¿Qué frameworks son mejores para esto? (LangChain, AutoGen, CrewAI, LlamaIndex)
   - ¿Cómo hacer que el agente use git commit/push automáticamente?

2. PIPELINE DE AUTOMATIZACIÓN:
   - ¿Cómo crear un cron job en Linux que ejecute scripts bash + Python
     de forma encadenada y registre logs?
   - ¿Cómo hacer que Ollama responda a triggers de archivos nuevos en inbox/?
   - ¿Cómo integrar GitHub Actions para automatizar documentación desde CI/CD?

3. OSINT Y VIGILANCIA:
   - ¿Qué herramientas OSINT open source puedo correr en mi servidor?
     (Maltego CE, SpiderFoot, TheHarvester, Recon-ng)
   - ¿Cómo construir un dashboard local para monitorizar activos?
   - ¿Cómo automatizar informes OSINT con IA local?

4. SEGURIDAD CONTINUA:
   - ¿Cómo configurar Wazuh + Suricata en mi servidor para SIEM local?
   - ¿Cómo hacer auditorías de seguridad automáticas con scripts bash?
   - ¿Qué alertas críticas debería monitorizar en un homelab?

5. ESCALABILIDAD:
   - ¿Cómo pasar de scripts bash a un sistema orquestado (Ansible, Docker Compose)?
   - ¿Cuándo tiene sentido añadir un segundo nodo al homelab?
   - ¿Cómo versionar la infraestructura como código (IaC) desde cero?

Para cada punto dame:
- Recomendación concreta y razonada
- Ejemplo de implementación mínima
- Recursos/links para profundizar
- Riesgos o limitaciones a tener en cuenta

Prioriza soluciones que funcionen offline o con modelos locales.
Mi presupuesto es 0 — solo herramientas open source.
```

---

## Variante corta (para sesiones rápidas)

```
Soy desarrollador con homelab Ubuntu + Ollama + GitHub. Quiero construir
un agente IA local que procese archivos de un inbox/ en git y los documente
automáticamente. ¿Qué stack recomiendas? Dame un plan de 3 fases con
código de ejemplo para la fase 1 (lector de inbox con LlamaIndex + Ollama).
```

---

_Creado por Perplexity MCP — 03-jul-2026 04:31 CEST_
