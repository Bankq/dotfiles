#!/bin/sh

# Get the directory where this script is located
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# Install Homebrew if missing
if ! command -v brew >/dev/null 2>&1; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install packages from Brewfile
echo "Installing Homebrew packages..."
brew bundle --file="$DOTFILES/Brewfile"

# Install Claude Code
echo "Installing Claude Code..."
npm install -g @anthropic-ai/claude-code

# macOS keyboard settings
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

# Create required directories
mkdir -p "$HOME/.config/alacritty"
mkdir -p "$HOME/.claude"

# Create symlinks
ln -sf "$DOTFILES/zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
ln -sf "$DOTFILES/starship.toml" "$HOME/.config/starship.toml"
ln -sf "$DOTFILES/claude/settings.json" "$HOME/.claude/settings.json"

echo "Dotfiles linked. Start a new zsh shell to bootstrap oh-my-zsh and plugins."
