# PATH - homebrew first, then system paths
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

# Oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh
ZSH_THEME=""  # Disabled - using Starship instead
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 14
ZSH_DISABLE_COMPFIX=true

# Completion tuning
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Built-in oh-my-zsh plugins
plugins=(
    git fzf emacs brew macos sudo copypath copyfile
    extract colored-man-pages dirhistory history-substring-search
)

# Custom plugins: add to this list to auto-install and load
# Format: "name|https://github.com/..."
_custom_plugins=(
    "fzf-tab|https://github.com/Aloxaf/fzf-tab"
    "zsh-autosuggestions|https://github.com/zsh-users/zsh-autosuggestions"
    "fast-syntax-highlighting|https://github.com/zdharma-continuum/fast-syntax-highlighting"
    "you-should-use|https://github.com/MichaelAquilina/zsh-you-should-use"
)

# Bootstrap oh-my-zsh and custom plugins (idempotent)
_zsh_bootstrap() {
    if [[ ! -d "$ZSH" ]]; then
        echo "Installing oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
    fi
    local zsh_custom="${ZSH_CUSTOM:-$ZSH/custom}"
    for spec in "${_custom_plugins[@]}"; do
        local name="${spec%%|*}" repo="${spec##*|}"
        if [[ ! -d "$zsh_custom/plugins/$name" ]]; then
            echo "Installing $name..."
            git clone --depth=1 "$repo" "$zsh_custom/plugins/$name"
        fi
    done
}
_zsh_bootstrap

# Add custom plugin names to plugins array
for spec in "${_custom_plugins[@]}"; do plugins+=("${spec%%|*}"); done

source $ZSH/oh-my-zsh.sh

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt inc_append_history share_history hist_ignore_all_dups hist_reduce_blanks
setopt extended_history
setopt hist_ignore_space hist_verify hist_expire_dups_first

# History substring search keybinds
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Environment
export EDITOR="emacsclient -c"
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib/

# PATH additions
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# FZF defaults
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!{.git,node_modules}/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "bat --style=numbers --color=always {} 2>/dev/null | head -200"'
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview,ctrl-n:down,ctrl-p:up,ctrl-k:kill-line' --exact --sort"

# Aliases
alias ll='ls -l'
em() {
  local args=()
  for f in "$@"; do args+=("${f:A}"); done
  emacsclient -t -a "" "${args[@]}"
}

# Shell options
unsetopt autocd
setopt noflowcontrol nobeep interactive_comments

# Prompt
eval "$(starship init zsh)"

# Zoxide (modern replacement for z)
eval "$(zoxide init zsh)"
