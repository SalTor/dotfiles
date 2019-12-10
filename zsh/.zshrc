#
# Global
#

# Create a hash table for globally stashing variables without polluting main
# scope with a bunch of identifiers.
typeset -A __WINCENT

__WINCENT[ITALIC_ON]=$'\e[3m'
__WINCENT[ITALIC_OFF]=$'\e[23m'

ZSH_THEME="aphrodite-custom"
DEFAULT_USER="saltor"
ENABLE_CORRECTION="true"

plugins=(git)

. ~/.zsh_aliases

#VIM
alias vi='nvim'
alias vim='nvim'

bindkey "[C" forward-word
bindkey "[D" backward-word

# Ctrl+s will not hault terminal interactions
stty -ixon

if [[ -a ~/.localrc ]]; then
    # Local config that doesn't need to get tracked in repo history
    source ~/.localrc
fi

export PATH=/usr/local/Cellar/node/10.7.0/bin/:$PATH
export PATH=/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/Cellar:$PATH
export PATH=/sbin:/sbin:$PATH
export PATH=/usr/bin/npm:$PATH
export PATH=/usr/bin/python:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.rbenv/bin:$PATH
export PATH=$HOME/.rbenv/plugins/ruby-build/bin:$PATH
export PATH=$HOME/Library/Python/3.6/bin:$PATH
export PYTHONPATH=/
eval "$(rbenv init -)"

export FZF_DEFAULT_OPTS='--border --cycle --height=50% --preview="bat --color=always --line-range :75 {}"'
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-heading --glob "!.git/*"'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export ZSH=$HOME/.oh-my-zsh
source ~/.oh-my-zsh/oh-my-zsh.sh

export ANSIBLE_NOCOWS=1

autoload -U colors
colors
source $HOME/dotfiles/zsh/colors
