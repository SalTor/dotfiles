export EDITOR="nvim"

export LIBRARY_PATH=/usr/local/opt/openssl/lib/
export PYTHONPATH=$HOME/Library/Python/3.8/bin
export NVM_DIR="/Users/saltorcivia/.nvm"

export PATH=$PATH:$PYTHONPATH
export PATH=$PATH:/usr/local/Cellar/node/13.2.0/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/Cellar
export PATH=$PATH:/usr/bin/npm
export PATH=$PATH:/usr/bin/python
export PATH=$PATH:/usr/local/opt/mysql-client/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.rbenv/bin
export PATH=$PATH:$HOME/.rbenv/plugins/ruby-build/bin
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

if [[ -s $HOME/.rvm/scripts/rvm ]]; then
    # Load RVM into a shell session *as a function*
    source $HOME/.rvm/scripts/rvm
fi

export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
