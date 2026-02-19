#!/usr/bin/env bash
# Test script for clawtimizer
# Run: bash tests/test_optimize.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
OPTIMIZE_SCRIPT="$SKILL_DIR/scripts/optimize.sh"

echo "🧪 Clawtimizer Test Suite"
echo "━━━━━━━━━━━━━━━━━━━━━━━━"

# Test 1: Script exists and is executable
echo "Test 1: Script exists..."
if [[ -f "$OPTIMIZE_SCRIPT" ]]; then
    echo "   ✓ optimize.sh found"
else
    echo "   ✗ optimize.sh not found"
    exit 1
fi

# Test 2: Shellcheck passes (if available)
echo "Test 2: Shellcheck validation..."
if command -v shellcheck &> /dev/null; then
    if shellcheck "$OPTIMIZE_SCRIPT"; then
        echo "   ✓ Shellcheck passed"
    else
        echo "   ✗ Shellcheck failed"
        exit 1
    fi
else
    echo "   ⚠ Shellcheck not installed (skipping)"
fi

# Test 3: Reference file exists
echo "Test 3: Reference file exists..."
REF_FILE="$SKILL_DIR/references/workspace-docs.md"
if [[ -f "$REF_FILE" ]]; then
    echo "   ✓ workspace-docs.md found"
else
    echo "   ✗ workspace-docs.md not found"
    exit 1
fi

# Test 4: SKILL.md is valid
echo "Test 4: SKILL.md validation..."
SKILL_FILE="$SKILL_DIR/SKILL.md"
if [[ -f "$SKILL_FILE" ]]; then
    if grep -q "name: clawtimizer" "$SKILL_FILE"; then
        echo "   ✓ SKILL.md has correct name"
    else
        echo "   ✗ SKILL.md missing name field"
        exit 1
    fi
else
    echo "   ✗ SKILL.md not found"
    exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ All tests passed!"
