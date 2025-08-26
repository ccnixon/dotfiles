#!/bin/sh
#
# Claude Code Configuration
#
# This installs the CLAUDE.md file for Claude Code in both:
# - User-level: ~/.claude/CLAUDE.md (always installed)
# - System-level: /Library/Application Support/ClaudeCode/CLAUDE.md (optional, requires sudo)

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

# Use the CLAUDE.md.symlink file from the claude directory (global config)
SOURCE_FILE="$SCRIPT_DIR/CLAUDE.md.symlink"

# User-level configuration
USER_CLAUDE_DIR="$HOME/.claude"
USER_CLAUDE_FILE="$USER_CLAUDE_DIR/CLAUDE.md"

echo "  Setting up Claude Code configuration..."

# First, set up user-level configuration (always do this)
echo "  Installing user-level CLAUDE.md..."
mkdir -p "$USER_CLAUDE_DIR"

# Remove existing file/symlink if it exists
if [ -f "$USER_CLAUDE_FILE" ] || [ -L "$USER_CLAUDE_FILE" ]; then
    rm -f "$USER_CLAUDE_FILE"
fi

# Create symlink to the main CLAUDE.md file
ln -sf "$SOURCE_FILE" "$USER_CLAUDE_FILE"

if [ -L "$USER_CLAUDE_FILE" ]; then
    echo "  ✓ User-level CLAUDE.md installed at ~/.claude/CLAUDE.md"
else
    echo "  ✗ Failed to create user-level CLAUDE.md"
fi

# Now attempt system-level configuration (optional)
echo "  Attempting system-level configuration (may require sudo)..."

# Check if source file exists
if [ ! -f "$SOURCE_FILE" ]; then
    echo "  Warning: Source file $SOURCE_FILE not found"
    exit 1
fi

# Try to create system directory without sudo first
mkdir -p "$CLAUDE_SYSTEM_DIR" 2>/dev/null || {
    echo "  Note: System-level configuration requires sudo permissions"
    echo "  Skipping system-level setup (user-level configuration is sufficient)"
    exit 0
}

# If we can write to the system directory, set up system-level config
if [ -w "$CLAUDE_SYSTEM_DIR" ]; then
    # Remove existing file if it exists
    if [ -f "$CLAUDE_SYSTEM_FILE" ] || [ -L "$CLAUDE_SYSTEM_FILE" ]; then
        rm -f "$CLAUDE_SYSTEM_FILE"
    fi
    
    # Create symlink
    ln -sf "$SOURCE_FILE" "$CLAUDE_SYSTEM_FILE"
    
    # Verify the symlink was created successfully
    if [ -L "$CLAUDE_SYSTEM_FILE" ]; then
        echo "  ✓ System-level CLAUDE.md also installed"
    else
        echo "  Note: Could not create system-level configuration"
    fi
else
    echo "  Note: System directory exists but is not writable"
    echo "  Run with sudo if you want system-level configuration"
fi

exit 0