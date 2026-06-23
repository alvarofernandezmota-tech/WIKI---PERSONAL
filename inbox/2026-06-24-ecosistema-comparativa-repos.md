# Comparativa Ecosistema — yggdrasil-dew vs mejores repos open source
**Fecha:** 2026-06-24  
**Fuente:** GitHub search, dev.to homelab AI 2026, virtualizationhowto

---

## Repos open source de referencia analizados

| Repo | Stars | Stack destacado | URL |
|---|---|---|---|
| jctots/home-lab-iac | activo | Proxmox+Docker+Vaultwarden+Ollama+Kopia+SOPS+LiteLLM+Paperless | https://github.com/jctots/home-lab-iac |
| cyberguard-ai/local-llm-server | 1 | Ollama+FastAPI+Docker | https://github.com/cyberguard-ai/local-llm-server |
| Pouzor/homelable | activo | Visualizador de red homelab live | https://github.com/Pouzor/homelable |
| barminetech/Must-Have-Self-Hosted-2026 | activo | Guia completa self-hosted 2026 | https://github.com/barminetech/Must-Have-Self-Hosted-2026 |

---

## Comparativa: Qué tenemos vs qué tienen ellos

| Componente | yggdrasil-dew | jctots/home-lab-iac | Prioridad |
|---|---|---|---|
| Ollama + Open WebUI | ✅ | ✅ | — |
| Qdrant (vector store) | ✅ | ❌ | VENTAJA |
| Gitea | ✅ | ✅ | — |
| Vaultwarden | ✅ | ✅ | — |
| n8n (automatización) | ✅ | ❌ | VENTAJA |
| SpiderFoot OSINT | ✅ | ❌ | VENTAJA |
| Nginx Proxy Manager | ✅ | ✅ | — |
| Portainer | ✅ | ❌ | VENTAJA |
| Uptime Kuma | ✅ | ❌ | VENTAJA |
| Watchtower | ✅ | ❌ | VENTAJA |
| Agentes IA (Erika/TOKI) | ✅ | ❌ | VENTAJA |
| RAG sobre vault personal | ✅ | ❌ | VENTAJA |
| **LiteLLM proxy** | ❌ | ✅ | 🔥 AÑADIR |
| **SOPS secretos cifrados** | ❌ | ✅ | 🔥 AÑADIR |
| **Paperless-NGX** | ❌ | ✅ | MEDIA |
| **Kopia backups** | restic | Kopia | EVALUAR |
| Sistema PKM cerebro | ✅ | ❌ | VENTAJA |
| Protocolo agentes IA | ✅ | ❌ | VENTAJA |

**Conclusión: yggdrasil-dew es más avanzado en IA y cerebro. Solo faltan 2 piezas críticas: LiteLLM y SOPS.**

---

## ¿Migrar a otro ecosistema?

**NO.** Ninguno de los repos analizados tiene todo lo que tenemos. La arquitectura actual es correcta.
Lo que hay que hacer es AMPLIAR, no migrar.

El homelab AI stack 2026 según dev.to confirma que nuestro stack (Ollama + Open WebUI + n8n + Qdrant + Vaultwarden + Gitea) es exactamente lo que los self-hosters avanzados están corriendo.
