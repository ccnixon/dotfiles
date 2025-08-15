# Node.js and TypeScript development aliases
alias npm-list='npm list --depth=0'
alias npm-global='npm list -g --depth=0'
alias npm-outdated='npm outdated'
alias npm-update='npm update'
alias npm-clean='rm -rf node_modules package-lock.json && npm install'

# TypeScript shortcuts
alias tsc-watch='tsc --watch'
alias ts-node='npx ts-node'
alias type-check='tsc --noEmit'

# Package management shortcuts
alias ni='npm install'
alias nid='npm install --save-dev'
alias nu='npm uninstall'
alias nr='npm run'
alias nrs='npm run start'
alias nrt='npm run test'
alias nrb='npm run build'
alias nrd='npm run dev'

# Yarn shortcuts
alias ya='yarn add'
alias yad='yarn add --dev'
alias yr='yarn remove'
alias ys='yarn start'
alias yt='yarn test'
alias yb='yarn build'
alias yd='yarn dev'

# pnpm shortcuts
alias pn='pnpm'
alias pni='pnpm install'
alias pna='pnpm add'
alias pnad='pnpm add --save-dev'
alias pnr='pnpm remove'
alias pnx='pnpm dlx'  # pnpm's npx equivalent
alias pnrun='pnpm run'
alias pns='pnpm start'
alias pnt='pnpm test'
alias pnb='pnpm build'
alias pnd='pnpm dev'
alias pnup='pnpm update'
alias pnout='pnpm outdated'

# Lazy load fnm when needed
fnm-init() {
  if command -v fnm &> /dev/null; then
    eval "$(fnm env --use-on-cd)"
    echo "✓ fnm initialized with auto-switching"
  else
    echo "fnm is not installed"
  fi
}

# Initialize fnm on first Node.js command if not already initialized
node() {
  if ! command -v node &> /dev/null && command -v fnm &> /dev/null; then
    eval "$(fnm env)"
  fi
  command node "$@"
}

npm() {
  if ! command -v npm &> /dev/null && command -v fnm &> /dev/null; then
    eval "$(fnm env)"
  fi
  command npm "$@"
}

npx() {
  if ! command -v npx &> /dev/null && command -v fnm &> /dev/null; then
    eval "$(fnm env)"
  fi
  command npx "$@"
}

pnpm() {
  if ! command -v node &> /dev/null && command -v fnm &> /dev/null; then
    eval "$(fnm env)"
  fi
  command pnpm "$@"
}

# fnm shortcuts
alias node-list='fnm list'
alias node-use='fnm use'
alias node-install='fnm install'
alias node-default='fnm default'

# Modern web development shortcuts
alias create-app='npm create'
alias create-vite='npm create vite@latest'
alias create-remix='npx create-remix@latest'

# Package management workflow helpers
alias fresh='rm -rf node_modules package-lock.json && npm install'
alias fresh-yarn='rm -rf node_modules yarn.lock && yarn install'
alias fresh-pnpm='rm -rf node_modules pnpm-lock.yaml && pnpm install'

# Quick project setup
init-project() {
  if [ -z "$1" ]; then
    echo "Usage: init-project <project-name>"
    return 1
  fi
  
  mkdir "$1"
  cd "$1"
  npm init -y
  echo "Project $1 initialized!"
}