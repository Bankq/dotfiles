# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#ZSH_THEME="gallois"
ZSH_THEME="kennethreitz"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh
#source /usr/local/Cellar/autoenv/0.1.0/activate.sh
# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/share/python:/usr/texbin:/usr/local/mysql/bin:~/bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$HOME/Documents/personal/snippets:$PATH
export PATH=$HOME/Documents/hulu/kraken/binaries:$HOME/bin:$PATH

export DYLD_LIBRARY_PATH=/usr/local/mysql/lib/
export HULU=$HOME/Documents/hulu
export HANG=$HOME/Documents/personal
export ORG=$HOME/Dropbox/Org
export CROSS_COMPILE=i686-linux-android-
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

export X10_HOME=/Applications/x10dt/plugins/x10.dist.macosx.x86.fragment_2.4.0.201309271722
export X10_NTHREADS=8

# Alias
alias emx=/Applications/Emacs.app/Contents/MacOS/Emacs
alias ll=ls -l
alias em='emacsclient -nw'
alias i='ipython'
alias krakend="ssh root@kraken-director"