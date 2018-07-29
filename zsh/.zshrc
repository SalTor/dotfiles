ZSH_THEME="aphrodite"
DEFAULT_USER="saltor"
ENABLE_CORRECTION="true"

bindkey "[C" forward-word
bindkey "[D" backward-word

# So as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon

# Ctrl+s will not hault terminal interactions
stty -ixon

if [[ -a ~/.localrc ]]; then
    # Local config that doesn't need to get tracked in repo history
    source ~/.localrc
fi

export PATH=/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/sbin:/sbin:$PATH
export PATH=/usr/bin/npm:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.rbenv/bin:$PATH
export PATH=$HOME/.rbenv/plugins/ruby-build/bin:$PATH
eval "$(rbenv init -)"

export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export FZF_DEFAULT_COMMAND='ag -g --hidden --file-search-regex ""'
export FZF_DEFAULT_OPTS='--height 10% --border'
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Make sure this is the last PATH variable change.
export PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting. 

export ZSH=$HOME/.oh-my-zsh
source ~/.oh-my-zsh/oh-my-zsh.sh


if hash cowsay>/dev/null && hash fortune>/dev/null; then
    cowsay $(fortune)!
else
    if [[ $OSTYPE == darwin* ]]; then
        brew install cowsay fortune
    else
        sudo apt-get install cowsay fortune
    fi

    cowsay $(fortune)!
fi
