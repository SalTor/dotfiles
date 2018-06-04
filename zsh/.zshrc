export ZSH=$HOME/.oh-my-zsh
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/usr/bin/npm
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.rbenv/bin
    eval "$(rbenv init -)"
export PATH=$PATH:$HOME/.rbenv/plugins/ruby-build/bin

ZSH_THEME="aphrodite"
DEFAULT_USER="saltor"
ENABLE_CORRECTION="true"

bindkey "[C" forward-word
bindkey "[D" backward-word

# So as not to be disturbed by Ctrl-S ctrl-Q in terminals:
    stty -ixon

export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export FZF_DEFAULT_COMMAND='ag -g --hidden --file-search-regex ""'
export FZF_DEFAULT_OPTS='--height 10% --border'
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.oh-my-zsh/oh-my-zsh.sh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
