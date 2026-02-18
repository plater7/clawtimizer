#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# Clawtimizer — OpenClaw Workspace File Optimizer
# ============================================================

MODEL="${OPTIMIZER_MODEL:-openrouter/openai/gpt-oss-20b:free}"
FALLBACK_MODEL="opencode/glm-4.7-free"
DATE=$(date +%Y-%m-%d)

# Resolve workspace path
WORKSPACE="${OPENCLAW_WORKSPACE:-$HOME/.openclaw/workspace}"
if [[ ! -d "$WORKSPACE" ]]; then
  echo "ERROR: Workspace not found at $WORKSPACE"
  echo "Set OPENCLAW_WORKSPACE or ensure ~/.openclaw/workspace exists."
  exit 1
fi

# Resolve skill directory (where this script lives)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
REFERENCE_FILE="$SKILL_DIR/references/workspace-docs.md"

if [[ ! -f "$REFERENCE_FILE" ]]; then
  echo "ERROR: Reference file not found at $REFERENCE_FILE"
  exit 1
fi

REFERENCE_CONTENT=$(<"$REFERENCE_FILE")

# Files to optimize
if [[ $# -gt 0 ]]; then
  FILES=("$@")
else
  FILES=(AGENTS.md SOUL.md TOOLS.md USER.md)
fi

# Directories
BACKUP_DIR="$WORKSPACE/memory/workspace-backup-$DATE"
OUTPUT_DIR="$WORKSPACE/memory/workspace-optimized-$DATE"
mkdir -p "$BACKUP_DIR" "$OUTPUT_DIR"

# Word count helper
wc_words() {
  wc -w < "$1" | tr -d ' '
}

echo ""
echo "🗜️  Workspace Optimizer"
echo "━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Model:     $MODEL"
echo "  Workspace: $WORKSPACE"
echo "  Date:      $DATE"
echo ""

TOTAL_BEFORE=0
TOTAL_AFTER=0

for FILE in "${FILES[@]}"; do
  FILEPATH="$WORKSPACE/$FILE"

  if [[ ! -f "$FILEPATH" ]]; then
    echo "⚠️  Skipping $FILE (not found)"
    continue
  fi

  # Backup
  echo "📦 Backing up $FILE..."
  cp "$FILEPATH" "$BACKUP_DIR/$FILE"

  ORIGINAL_CONTENT=$(<"$FILEPATH")
  WORDS_BEFORE=$(wc_words "$FILEPATH")
  TOTAL_BEFORE=$((TOTAL_BEFORE + WORDS_BEFORE))

  echo "🔧 Optimizing $FILE ($WORDS_BEFORE words)..."

  # Build prompt
  PROMPT="You are an OpenClaw workspace file optimizer. Your ONLY job is to compress the given workspace file to minimize token count while preserving ALL operational instructions.

## Reference: What OpenClaw expects from workspace files
$REFERENCE_CONTENT

## Rules
1. Output ONLY the compressed file content. No explanations, no preamble, no code fences.
2. Preserve ALL operational instructions, security rules, patterns, and configs.
3. Remove: redundant explanations, verbose prose, examples the agent can infer, decorative formatting.
4. Merge overlapping sections.
5. Use terse language. One sentence where possible.
6. Target: <40% of original word count.
7. Keep markdown structure (headers, bullets) but minimize nesting.
8. Do NOT invent new instructions or change the meaning of existing ones.

## File to optimize: $FILE
$ORIGINAL_CONTENT"

  # Call model
  RESULT=""
  if RESULT=$(openclaw session run --model "$MODEL" --message "$PROMPT" --timeout 120 --no-tools 2>/dev/null); then
    : # success
  else
    echo "   ⚠️  Primary model failed, trying fallback ($FALLBACK_MODEL)..."
    if RESULT=$(openclaw session run --model "$FALLBACK_MODEL" --message "$PROMPT" --timeout 120 --no-tools 2>/dev/null); then
      : # fallback success
    else
      echo "   ✗ Both models failed for $FILE. Skipping."
      continue
    fi
  fi

  # Clean result: remove code fences if model added them
  RESULT=$(echo "$RESULT" | sed '/^```/d' | sed '/^```markdown$/d')

  if [[ -z "$RESULT" || -z "${RESULT// /}" ]]; then
    echo "   ✗ Empty result from model for $FILE. Skipping."
    continue
  fi

  printf '%s\n' "$RESULT" > "$OUTPUT_DIR/$FILE"

  WORDS_AFTER=$(wc_words "$OUTPUT_DIR/$FILE")
  TOTAL_AFTER=$((TOTAL_AFTER + WORDS_AFTER))

  if [[ $WORDS_BEFORE -gt 0 ]]; then
    REDUCTION=$(( (WORDS_BEFORE - WORDS_AFTER) * 100 / WORDS_BEFORE ))
  else
    REDUCTION=0
  fi

  echo "   ✓ $WORDS_BEFORE → $WORDS_AFTER words (-${REDUCTION}%)"
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Summary"

if [[ $TOTAL_BEFORE -gt 0 ]]; then
  TOTAL_REDUCTION=$(( (TOTAL_BEFORE - TOTAL_AFTER) * 100 / TOTAL_BEFORE ))
  TOKENS_SAVED=$(( (TOTAL_BEFORE - TOTAL_AFTER) ))  # ~1 word ≈ 1 token approx
  MONTHLY_SAVINGS=$(( TOKENS_SAVED * 45 / 1000 ))

  echo "   Words:  $TOTAL_BEFORE → $TOTAL_AFTER (-${TOTAL_REDUCTION}%)"
  echo "   Tokens: ~$TOKENS_SAVED fewer per message"
  echo "   Monthly savings (100 Opus calls/day): ~\$${MONTHLY_SAVINGS}/month"
else
  echo "   No files were processed."
fi

echo ""
echo "📁 Optimized files: $OUTPUT_DIR/"
echo "📁 Backups:         $BACKUP_DIR/"
echo ""
echo "To apply:"
echo "  cp \"$OUTPUT_DIR/\"* \"$WORKSPACE/\""
echo ""
echo "To revert:"
echo "  cp \"$BACKUP_DIR/\"* \"$WORKSPACE/\""
echo ""
