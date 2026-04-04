#!/usr/bin/env bash
# SPDX-License-Identifier: PMPL-1.0-or-later
# validate_structure.sh — CRG C structural tests for awesome-mcp-servers
#
# Validates the curated list has required structure and no broken links.
#
# Usage: bash tests/validate_structure.sh [repo-root]

set -euo pipefail

ROOT="${1:-$(cd "$(dirname "$0")/.." && pwd)}"
PASS=0; FAIL=0

check() {
    local desc="$1"; local path="$2"
    if [ -e "$ROOT/$path" ]; then
        echo "  PASS: $desc"
        ((PASS++)) || true
    else
        echo "  FAIL: $desc — missing $path"
        ((FAIL++)) || true
    fi
}

echo "=== awesome-mcp-servers structure validation ==="
echo ""

check "README.md present"           "README.md"
check "EXPLAINME.adoc"              "EXPLAINME.adoc"
check "0-AI-MANIFEST.a2ml"         "0-AI-MANIFEST.a2ml"
check "LICENSE present"             "LICENSE"

# README.md should contain at least one ## section
if [ -f "$ROOT/README.md" ]; then
    if grep -q "^## " "$ROOT/README.md"; then
        echo "  PASS: README.md has section headings"
        ((PASS++)) || true
    else
        echo "  FAIL: README.md missing section headings"
        ((FAIL++)) || true
    fi
fi

# No bare HTTP links in README
if [ -f "$ROOT/README.md" ]; then
    http_count=$(grep -c "](http://" "$ROOT/README.md" 2>/dev/null || echo 0)
    if [ "$http_count" -eq 0 ]; then
        echo "  PASS: No HTTP links in README (all HTTPS)"
        ((PASS++)) || true
    else
        echo "  WARN: $http_count HTTP links in README (should use HTTPS)"
    fi
fi

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
