# OpenClaw Workspace Files Reference

## File Map

### AGENTS.md
- **Purpose**: Operational instructions for the agent. Loaded at session start.
- **Must contain**: Rules, priorities, behavioral guidelines, workflow instructions.
- **Must NOT contain**: Persona/tone (belongs in SOUL.md), user info (belongs in USER.md).

### SOUL.md
- **Purpose**: Agent persona, tone, and boundaries. Loaded every session.
- **Must contain**: Character traits, communication style, boundaries.
- **Must NOT contain**: Operational rules (belongs in AGENTS.md).

### USER.md
- **Purpose**: User identity and preferred address form. Loaded each session.
- **Must contain**: User name, preferences, how to address them.
- **Must NOT contain**: Agent instructions or persona.

### TOOLS.md
- **Purpose**: Guidance notes about local tools and conventions. Documentation only — does not control tool availability.
- **Must contain**: Tool usage notes, local conventions, integration details.
- **Must NOT contain**: Agent behavior rules.

### MEMORY.md (Optional)
- **Purpose**: Curated long-term memory.
- **Loaded**: Only in main private session — NOT in shared or group contexts.
- **Must contain**: Persistent facts, learned preferences, key decisions.

### HEARTBEAT.md (Optional)
- **Purpose**: Minimal checklist for heartbeat runs.
- **Must be**: Brief to minimize token consumption during periodic executions.

### BOOT.md (Optional)
- **Purpose**: Startup checklist triggered on gateway restart when internal hooks are enabled.
- **Must be**: Concise. Use message tool for outbound communications.

## Key Conventions to Preserve

- `memory/YYYY-MM-DD.md` — daily memory log (one file per day). Read today's and yesterday's at session start.
- `HEARTBEAT_OK` — heartbeat success marker.
- MEMORY.md loaded only in main session.
- Use `trash` instead of `rm` for file deletion.
- Require user approval for external actions.
- Group session rules apply separately.

## Token Optimization Rules

- `bootstrapMaxChars` default: 20,000 characters. Files exceeding this get truncated.
- Bootstrap injection range: ~3,000–14,000 tokens per message.
- Savings formula: ~$45/month per 1,000 tokens reduced (at 100 Opus calls/day).
- Target: <40% of original word count.
- Use concise language. One sentence where possible.
- Avoid markdown tables (high token cost for low information density).
- Merge overlapping sections.
- Remove redundant explanations, verbose prose, inferable examples, decorative formatting.
