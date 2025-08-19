#!/bin/sh
#
# Claude Code System Configuration
#
# This installs the system-level CLAUDE.md file for Claude Code
# to provide consistent development context across all projects.

set -e

# Determine the system-specific path for Claude Code configuration
if test "$(uname)" = "Darwin"; then
    CLAUDE_SYSTEM_DIR="/Library/Application Support/ClaudeCode"
    CLAUDE_SYSTEM_FILE="$CLAUDE_SYSTEM_DIR/CLAUDE.md"
elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
    CLAUDE_SYSTEM_DIR="/etc/claude-code"
    CLAUDE_SYSTEM_FILE="$CLAUDE_SYSTEM_DIR/CLAUDE.md"
else
    echo "  Unsupported operating system for Claude Code system configuration"
    exit 0
fi

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_FILE="$SCRIPT_DIR/CLAUDE.md.symlink"

echo "  Setting up Claude Code system configuration..."

# Check if source file exists
if [ ! -f "$SOURCE_FILE" ]; then
    echo "  Warning: Source file $SOURCE_FILE not found, skipping Claude Code setup"
    exit 0
fi

# Check if we have permission to create system directories
if [ ! -w "/Library/Application Support" ] && [ "$(uname)" = "Darwin" ]; then
    echo "  Creating Claude Code system directory requires sudo..."
    sudo mkdir -p "$CLAUDE_SYSTEM_DIR"
else
    mkdir -p "$CLAUDE_SYSTEM_DIR" 2>/dev/null || {
        echo "  Warning: Cannot create $CLAUDE_SYSTEM_DIR, skipping Claude Code setup"
        exit 0
    }
fi

# Remove existing file if it exists
if [ -f "$CLAUDE_SYSTEM_FILE" ] || [ -L "$CLAUDE_SYSTEM_FILE" ]; then
    if [ -w "$CLAUDE_SYSTEM_DIR" ]; then
        rm -f "$CLAUDE_SYSTEM_FILE"
    else
        sudo rm -f "$CLAUDE_SYSTEM_FILE"
    fi
fi

# Create symlink
if [ -w "$CLAUDE_SYSTEM_DIR" ]; then
    ln -sf "$SOURCE_FILE" "$CLAUDE_SYSTEM_FILE"
else
    sudo ln -sf "$SOURCE_FILE" "$CLAUDE_SYSTEM_FILE"
fi

# Verify the symlink was created successfully
if [ -L "$CLAUDE_SYSTEM_FILE" ]; then
    echo "  ✓ Claude Code system configuration installed"
else
    echo "  ✗ Failed to create Claude Code system configuration"
    exit 1
fi

exit 0