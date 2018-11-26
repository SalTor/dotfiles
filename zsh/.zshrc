ZSH_THEME="aphrodite"
DEFAULT_USER="saltor"
ENABLE_CORRECTION="true"

bindkey "[C" forward-word
bindkey "[D" backward-word

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
export PYTHONPATH=/
eval "$(rbenv init -)"

export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export FZF_DEFAULT_OPTS='--border'
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Make sure this is the last PATH variable change.
export PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting.

export ZSH=$HOME/.oh-my-zsh
source ~/.oh-my-zsh/oh-my-zsh.sh

export ANSIBLE_NOCOWS=1

req_cowsay=false
req_fortune=false
command -v cowsay >/dev/null 2>&1 || { echo >&2 "[!] Command not found: cowsay"; req_cowsay=true }
command -v fortune >/dev/null 2>&1 || { echo >&2 "[!] Command not found: fortune"; req_fortune=true }
if $req_cowsay && $req_fortune; then
    echo >&2 "[ ] Installing missing commands..."
    echo >&2 ""
    if [[ $OSTYPE == darwin* ]]; then
        brew install cowsay fortune
    else
        sudo apt-get install cowsay fortune
    fi

    echo >&2 ""
    echo >&2 "[!] Here's an example of combining cowsay and fortune! (aka: cowsay \$(fortune))"
fi

cowsay $(fortune)!
