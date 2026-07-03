/**
 * YGGDRASIL LLM ROUTER
 * ## FUNCIÓN: Módulo que enruta llamadas a cualquier modelo LLM
 *             (local o remoto) desde el MCP server.
 *             Providers: Ollama, OpenAI, Anthropic, Groq, LM Studio
 *
 * Uso: import { routeLLM } from './mcp/llm-router.js';
 */

import { execSync } from 'child_process';

/**
 * Llama al modelo especificado con el prompt dado.
 * @param {string} model  - Prefijo:nombre. Ej: "ollama:llama3", "openai:gpt-4.1"
 * @param {string} prompt - El prompt a enviar al modelo
 * @param {object} opts   - Opciones opcionales: maxTokens, temperature, systemPrompt
 * @returns {Promise<string>} Respuesta del modelo
 */
export async function routeLLM(model, prompt, opts = {}) {
  const { maxTokens = 2048, temperature = 0.7, systemPrompt = null } = opts;

  // ─── OLLAMA (local) ──────────────────────────────────────────────────────
  if (model.startsWith('ollama:')) {
    const name = model.replace('ollama:', '');
    // Usa API REST de Ollama en lugar de CLI para mejor control
    const ollamaHost = process.env.OLLAMA_HOST || 'http://localhost:11434';
    const messages = [];
    if (systemPrompt) messages.push({ role: 'system', content: systemPrompt });
    messages.push({ role: 'user', content: prompt });

    const res = await fetch(`${ollamaHost}/api/chat`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        model: name,
        messages,
        stream: false,
        options: { temperature, num_predict: maxTokens },
      }),
    });
    if (!res.ok) throw new Error(`Ollama error ${res.status}: ${await res.text()}`);
    const data = await res.json();
    return data.message?.content || JSON.stringify(data);
  }

  // ─── LM STUDIO (local, compatible OpenAI API) ────────────────────────────
  if (model.startsWith('lmstudio:')) {
    const name = model.replace('lmstudio:', '');
    const lmHost = process.env.LMSTUDIO_HOST || 'http://localhost:1234';
    const messages = [];
    if (systemPrompt) messages.push({ role: 'system', content: systemPrompt });
    messages.push({ role: 'user', content: prompt });

    const res = await fetch(`${lmHost}/v1/chat/completions`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        model: name,
        messages,
        max_tokens: maxTokens,
        temperature,
      }),
    });
    if (!res.ok) throw new Error(`LM Studio error ${res.status}: ${await res.text()}`);
    const data = await res.json();
    return data.choices[0].message.content;
  }

  // ─── OPENAI ──────────────────────────────────────────────────────────────
  if (model.startsWith('openai:')) {
    const name = model.replace('openai:', '');
    const apiKey = process.env.OPENAI_API_KEY;
    if (!apiKey) throw new Error('OPENAI_API_KEY no configurada en .env');

    const messages = [];
    if (systemPrompt) messages.push({ role: 'system', content: systemPrompt });
    messages.push({ role: 'user', content: prompt });

    const res = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${apiKey}`,
      },
      body: JSON.stringify({
        model: name,
        messages,
        max_tokens: maxTokens,
        temperature,
      }),
    });
    if (!res.ok) throw new Error(`OpenAI error ${res.status}: ${await res.text()}`);
    const data = await res.json();
    return data.choices[0].message.content;
  }

  // ─── ANTHROPIC ───────────────────────────────────────────────────────────
  if (model.startsWith('anthropic:')) {
    const name = model.replace('anthropic:', '');
    const apiKey = process.env.ANTHROPIC_API_KEY;
    if (!apiKey) throw new Error('ANTHROPIC_API_KEY no configurada en .env');

    const body = {
      model: name,
      max_tokens: maxTokens,
      messages: [{ role: 'user', content: prompt }],
    };
    if (systemPrompt) body.system = systemPrompt;

    const res = await fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': apiKey,
        'anthropic-version': '2023-06-01',
      },
      body: JSON.stringify(body),
    });
    if (!res.ok) throw new Error(`Anthropic error ${res.status}: ${await res.text()}`);
    const data = await res.json();
    return data.content[0].text;
  }

  // ─── GROQ ────────────────────────────────────────────────────────────────
  if (model.startsWith('groq:')) {
    const name = model.replace('groq:', '');
    const apiKey = process.env.GROQ_API_KEY;
    if (!apiKey) throw new Error('GROQ_API_KEY no configurada en .env');

    const messages = [];
    if (systemPrompt) messages.push({ role: 'system', content: systemPrompt });
    messages.push({ role: 'user', content: prompt });

    const res = await fetch('https://api.groq.com/openai/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${apiKey}`,
      },
      body: JSON.stringify({
        model: name,
        messages,
        max_tokens: maxTokens,
        temperature,
      }),
    });
    if (!res.ok) throw new Error(`Groq error ${res.status}: ${await res.text()}`);
    const data = await res.json();
    return data.choices[0].message.content;
  }

  // ─── MODELO PROPIO / CUSTOM ──────────────────────────────────────────────
  if (model.startsWith('local:')) {
    // Para tu IA compilada en C u otro proceso local
    const name = model.replace('local:', '');
    const localBin = process.env.LOCAL_AI_BIN || `/usr/local/bin/${name}`;
    try {
      const out = execSync(`echo "${prompt.replace(/"/g, '\\"')}" | "${localBin}"`, {
        encoding: 'utf8',
        timeout: 30000,
      });
      return out;
    } catch (err) {
      throw new Error(`Error ejecutando modelo local ${name}: ${err.message}`);
    }
  }

  throw new Error(
    `Modelo no soportado: ${model}\n` +
    `Prefijos válidos: ollama:, lmstudio:, openai:, anthropic:, groq:, local:`
  );
}

/**
 * Lista los modelos disponibles en Ollama local
 */
export async function listOllamaModels() {
  const host = process.env.OLLAMA_HOST || 'http://localhost:11434';
  try {
    const res = await fetch(`${host}/api/tags`);
    const data = await res.json();
    return data.models?.map((m) => `ollama:${m.name}`) || [];
  } catch {
    return [];
  }
}
