# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install git
brew install git
brew install zsh

# Initialize dev directory
cd ~ && mkdir -p dev/github.com/ccnixon && cd dev/github.com/ccnixon

# Clone and bootstrap
git clone https://github.com/ccnixon/dotfiles.git && cd dotfiles && source bootstrap.sh
