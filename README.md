# Clawtimizer 🗜️

> Compress your OpenClaw workspace files. Save tokens. Save money.

Clawtimizer optimizes your workspace bootstrap files (AGENTS.md, SOUL.md, TOOLS.md, USER.md) by compressing them with a free LLM while preserving all operational instructions. By default, all four files are optimized.

## Why it matters

OpenClaw injects workspace files into the system prompt of **every message**. Every token in those files is multiplied by every interaction. Reducing word count by 78% can save **~$117/month** at 100 Opus calls/day. See [issue #9157](https://github.com/openclaw/openclaw/issues/9157) for details.

## Installation

```bash
# Via ClawHub (if available)
clawhub install clawtimizer

# Manual
cd ~/.openclaw/workspace/skills
git clone https://github.com/plater7/clawtimizer.git
```

## Usage

```bash
# From the agent (chat)
"Optimize the workspace files"

# Manual
bash skills/clawtimizer/scripts/optimize.sh

# With a custom model
OPTIMIZER_MODEL="opencode/glm-4.7-free" bash skills/clawtimizer/scripts/optimize.sh

# Single file only (e.g., just AGENTS.md)
bash skills/clawtimizer/scripts/optimize.sh AGENTS.md
```

## Supported models

| Priority | Model | Notes |
|----------|-------|-------|
| 1 (default) | `openrouter/openai/gpt-oss-20b:free` | Free, 32K context |
| 2 | `opencode/glm-4.7-free` | Free, good for structured tasks |
| 3 | `opencode/kimi-k2.5-free` | Free, very long context |
| 4 | `openrouter/qwen/qwen3-coder:free` | Free, precise with markdown |
| 5 | `ollama/qwen3:14b` (local) | No API cost, offline, slower |

Avoid models with <7B parameters or <8K context window.

## How it works

1. **Backup** originals to `memory/workspace-backup-YYYY-MM-DD/`
2. **Compress** each file using a free LLM with a specialized prompt
3. **Show diff** with word count before/after
4. **User confirms** before applying — nothing changes automatically

## Example output

```
🗜️  Workspace Optimizer
━━━━━━━━━━━━━━━━━━━━━━━
📦 Backing up originals...
🔧 Optimizing AGENTS.md (1219 words)...
   ✓ 1219 → 198 words (-84%)
🔧 Optimizing SOUL.md (681 words)...
   ✓ 681 → 244 words (-64%)
🔧 Optimizing TOOLS.md (698 words)...
   ✓ 698 → 141 words (-80%)
━━━━━━━━━━━━━━━━━━━━━━━
📊 Summary
   Words:  2598 → 583 (-78%)
   Tokens: ~2619 fewer per message
   Monthly savings (100 Opus calls/day): ~$117/month
```

## Safety

- Always creates backups before optimizing
- Never applies changes without user confirmation
- Never removes OpenClaw conventions (`memory/`, `HEARTBEAT_OK`, etc.)

## Contributing

PRs welcome — especially for adding more models or improving the compression prompt.

## License

[MIT](LICENSE)
