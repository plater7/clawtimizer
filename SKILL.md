---
name: clawtimizer
description: Optimizes workspace bootstrap files (AGENTS.md, SOUL.md, TOOLS.md, USER.md) to minimize token injection cost per message.
user-invocable: true
disable-model-invocation: false
metadata:
  openclaw:
    emoji: "🗜️"
    requires:
      bins: ["openclaw"]
      env: []
    homepage: "https://github.com/plater7/clawtimizer"
---

# Clawtimizer

Compresses workspace bootstrap files to reduce token burn per message.

## When to use

- User says "optimize workspace", "compress files", "reduce tokens"
- Monthly maintenance to keep token costs low

## How it works

1. Backs up originals to `memory/workspace-backup-YYYY-MM-DD/`
2. Reads reference doc for OpenClaw file conventions
3. Calls a cheap/free LLM to compress each file
4. Shows diff with word count reduction
5. User confirms before applying

## Execution

```bash
bash skills/clawtimizer/scripts/optimize.sh
```

Override model:

```bash
OPTIMIZER_MODEL="opencode/glm-4.7-free" bash skills/clawtimizer/scripts/optimize.sh
```

## Recommended models (priority order)

| # | Model | Notes |
|---|-------|-------|
| 1 | `openrouter/openai/gpt-oss-20b:free` (default) | Free, 32K context |
| 2 | `opencode/glm-4.7-free` | Free, good for structured tasks |
| 3 | `opencode/kimi-k2.5-free` | Free, very long context |
| 4 | `openrouter/qwen/qwen3-coder:free` | Free, precise with markdown |
| 5 | `ollama/qwen3:14b` (local) | No API cost, offline, slow |

Avoid: models <7B or with <8K context.

## Rules

- Always backup before optimizing
- Never remove OpenClaw conventions (memory/, HEARTBEAT_OK, etc.)
- Target: <40% of original word count
- Never apply without user confirmation
