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

# Plugin bootstrap helper (run `omz_bootstrap_plugins` or set ZSH_BOOTSTRAP=1)
omz_bootstrap_plugins() {
    local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    local -a specs=(
        "zsh-autosuggestions|https://github.com/zsh-users/zsh-autosuggestions"
        "fast-syntax-highlighting|https://github.com/zdharma-continuum/fast-syntax-highlighting"
        "fzf-tab|https://github.com/Aloxaf/fzf-tab"
    )
    local spec name repo
    if ! command -v git >/dev/null 2>&1; then
        echo "omz_bootstrap_plugins: git not found; skipping plugin install" >&2
        return 1
    fi
    mkdir -p "$zsh_custom/plugins"
    for spec in "${specs[@]}"; do
        name="${spec%%|*}"
        repo="${spec##*|}"
        if [[ ! -d "$zsh_custom/plugins/$name" ]]; then
            git clone "$repo" "$zsh_custom/plugins/$name"
        else
            git -C "$zsh_custom/plugins/$name" pull --ff-only
        fi
    done
}
if [[ -n "${ZSH_BOOTSTRAP:-}" ]]; then
    omz_bootstrap_plugins
fi

# Plugins
# Note: custom *.zsh files in ~/.oh-my-zsh/custom/ are auto-sourced
plugins=(
    git
    fzf
    fzf-tab
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
    zsh-autosuggestions
    fast-syntax-highlighting
)

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

# Accept autosuggestion on Tab, fallback to completion
_autosuggest_accept_or_complete() {
    if [[ -n "$POSTDISPLAY" ]]; then
        zle autosuggest-accept
    else
        zle expand-or-complete
    fi
}
zle -N _autosuggest_accept_or_complete
bindkey '^I' _autosuggest_accept_or_complete

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
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --exact --sort"

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
