<div align="center">

# 🗜️ Clawtimizer

**Compress your OpenClaw workspace files. Save tokens. Save money.**

[![Version](https://img.shields.io/badge/version-1.1.0-blue.svg)](https://github.com/plater7/clawtimizer/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![OpenClaw Compatible](https://img.shields.io/badge/OpenClaw-Compatible-brightgreen.svg)](https://docs.openclaw.ai)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

</div>

---

## ✨ What it does

Clawtimizer optimizes your workspace bootstrap files (`AGENTS.md`, `SOUL.md`, `TOOLS.md`, `USER.md`) by compressing them with a free LLM while preserving all operational instructions.

### 💰 Why it matters

OpenClaw injects workspace files into the system prompt of **every message**. Every token in those files is multiplied by every interaction.

| Metric | Value |
|--------|-------|
| Typical reduction | **78%** fewer words |
| Monthly savings | **~$117/month** at 100 Opus calls/day |

> See [issue #9157](https://github.com/openclaw/openclaw/issues/9157) for details.

---

## 📦 Installation

### Prerequisites

- [OpenClaw](https://docs.openclaw.ai/install) CLI installed and configured
- An LLM provider (OpenRouter, OpenCode, or local Ollama)

### Install the skill

```bash
# Via ClawHub (recommended)
clawhub install clawtimizer

# Manual installation
cd ~/.openclaw/workspace/skills
git clone https://github.com/plater7/clawtimizer.git
```

---

## 🚀 Usage

### From the agent (chat)

```
"Optimize the workspace files"
```

### Manual execution

```bash
# Default optimization
bash skills/clawtimizer/scripts/optimize.sh

# With a custom model
OPTIMIZER_MODEL="opencode/glm-4.7-free" bash skills/clawtimizer/scripts/optimize.sh

# Single file only
bash skills/clawtimizer/scripts/optimize.sh AGENTS.md
```

---

## 🤖 Supported Models

| Priority | Model | Notes |
|:--------:|-------|-------|
| 1️⃣ | `openrouter/openai/gpt-oss-20b:free` | **Default**, Free, 32K context |
| 2️⃣ | `opencode/glm-4.7-free` | Free, good for structured tasks |
| 3️⃣ | `opencode/kimi-k2.5-free` | Free, very long context |
| 4️⃣ | `openrouter/qwen/qwen3-coder:free` | Free, precise with markdown |
| 5️⃣ | `ollama/qwen3:14b` (local) | No API cost, offline, slower |

> ⚠️ Avoid models with <7B parameters or <8K context window.

---

## 🔧 How it works

```
┌─────────────────────────────────────────────────────┐
│  1. 📦 Backup  originals to memory/workspace-backup/ │
│  2. 🔧 Compress each file with free LLM             │
│  3. 📊 Show   diff with word count before/after     │
│  4. ✅ Confirm user approval before applying        │
└─────────────────────────────────────────────────────┘
```

Nothing changes automatically — you're always in control.

---

## 📊 Example Output

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

---

## 🛡️ Safety

- ✅ Always creates backups before optimizing
- ✅ Never applies changes without user confirmation
- ✅ Never removes OpenClaw conventions (`memory/`, `HEARTBEAT_OK`, etc.)

---

## 📚 Documentation

- [OpenClaw Documentation](https://docs.openclaw.ai)
- [Workspace Files Reference](https://docs.openclaw.ai/workspace/files)
- [Skill Development Guide](https://docs.openclaw.ai/skills)

---

## 🤝 Contributing

PRs welcome — especially for:
- Adding more models
- Improving the compression prompt
- Bug fixes and documentation

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## 📄 License

[MIT](LICENSE) © 2026 plater7

---

<div align="center">

**🤖 This project was developed with AI assistance by [OpenCode](https://opencode.ai)**

*Co-authored-by: OpenCode 🤖 <opencode@anomaly.la>*

</div>
