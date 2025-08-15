# Node.js and npm configuration
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
export PATH="$PATH:$HOME/.npm-global/bin"

# fnm (Fast Node Manager) - just add to PATH, lazy load the env
if command -v fnm &> /dev/null; then
  export PATH="$HOME/.fnm:$PATH"
  # Don't initialize fnm here - it will be done in zshrc or lazily
fi

# Yarn global bin path
export PATH="$PATH:$(yarn global bin 2>/dev/null || echo '')"

# Bun (fast package manager and runtime)
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"