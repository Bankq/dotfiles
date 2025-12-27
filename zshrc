# PATH - homebrew first, then system paths
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

# Oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh
ZSH_THEME=""  # Disabled - using Starship instead
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

# Plugins
# Note: custom *.zsh files in ~/.oh-my-zsh/custom/ are auto-sourced
plugins=(
    git
    fzf
    emacs
    brew
    macos
    sudo
    copypath
    copyfile
    extract
    colored-man-pages
    dirhistory
    history-substring-search
)

source $ZSH/oh-my-zsh.sh

# Environment
export EDITOR="emacsclient -c"
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib/

# PATH additions
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Aliases
alias ll='ls -l'

# Shell options
unsetopt autocd

# Prompt
eval "$(starship init zsh)"

# Zoxide (modern replacement for z)
eval "$(zoxide init zsh)"
