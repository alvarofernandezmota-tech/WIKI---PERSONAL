---
modelo: 
empresa: 
tipo: # cloud / local
version: 
fecha_lanzamiento: 
arquitectura: # Transformer / MoE / otro
parametros_aprox: 
context_window: 
knowledge_cutoff: 
modalidades: []
entrenamiento:
  datos: []
  tecnica: # RLHF / RLAIF / Constitutional AI / otro
  fine_tuning: 
etica:
  valores: []
  limites_hard: []
  limites_soft: []
  sesgos_conocidos: []
  robustez_jailbreak: # alta / media / baja
skills:
  excelente: []
  bueno: []
  regular: []
  malo: []
parametros_optimos:
  rag:         {temperature: , top_p: , top_k: , max_tokens: }
  codigo:      {temperature: , top_p: , top_k: , max_tokens: }
  osint:       {temperature: , top_p: , top_k: , max_tokens: }
  chat:        {temperature: , top_p: , top_k: , max_tokens: }
  estadistica: {temperature: , top_p: , top_k: , max_tokens: }
  creativo:    {temperature: , top_p: , top_k: , max_tokens: }
casos_uso_optimos: []
casos_uso_evitar: []
personalidad:
  tecnica: []
  humana: []
hardware_cpu_only: # solo para modelos locales
  tokens_por_segundo: 
  ram_necesaria: 
  funciona_16gb: 
api:
  endpoint: 
  modelos_familia: []
  precio_input_1M_tokens: 
  precio_output_1M_tokens: 
  rate_limit_free: 
  rate_limit_paid: 
litellm_config: |
notas: ""
fecha_ficha: 
fuente: # autoentrevista / documentacion-oficial / debate-multi-ia
---

# 🤖 [NOMBRE DEL MODELO]

## Identidad

| Campo | Valor |
|-------|-------|
| Empresa | |
| Versión | |
| Lanzamiento | |
| Arquitectura | |
| Parámetros | |
| Context window | |
| Knowledge cutoff | |
| Modalidades | |

## Entrenamiento

## Ética y Alineación

## Parámetros de Inferencia

| Parámetro   | RAG | Código | OSINT | Chat | Estadística |
|-------------|-----|--------|-------|------|-------------|
| temperature |     |        |       |      |             |
| top_p       |     |        |       |      |             |
| top_k       |     |        |       |      |             |
| max_tokens  |     |        |       |      |             |

## Skills

### ✅ Excelente en

### ⚠️ Regular en

### ❌ Malo en

## Casos de Uso

### Óptimo para

### Evitar para

## Integración LiteLLM

```yaml
# litellm_config.yaml
```

## Notas de sesión

_Extraído de: autoentrevista / debate multi-IA / documentación oficial_
