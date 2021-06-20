source $HOME/dotfiles/config/.secrets

export EDITOR="nvim"

export ARTIFACTORY_CREDENTIALS_USR=$SECRET_ARTIFACTORY_CREDENTIALS_USR
export ARTIFACTORY_CREDENTIALS_PSW=$SECRET_ARTIFACTORY_CREDENTIALS_PSW

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export LIBRARY_PATH=/usr/local/opt/openssl/lib
# export PIPENV_IGNORE_VIRTUALENVS=1
export BASE16_SHELL=$HOME/.config/base16-shell/
export VIM_PLUG_CONFIG=$HOME/.config/nvim/plug-config/
export NVIM=$HOME/.config/nvim/

export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/Cellar/python@3.7/3.7.9/bin/python3.7
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/Cellar
export PATH=$PATH:/usr/local/opt/mysql-client/bin
export PATH=$PATH:/Users/sal/Library/Python/3.8/bin

export PATH=$PATH:$HOME/dotfiles/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.rbenv/bin
export PATH=$PATH:$HOME/.rbenv/plugins/ruby-build/bin
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

export NVM_DIR=$XDG_CONFIG_HOME/nvm
export NVM_DEFAULT_ALIAS="$NVM_DIR/alias/default"
export PATH=$PATH:"$NVM_DIR/versions/node/v$(<$NVM_DEFAULT_ALIAS)/bin"

export ANSIBLE_NOCOWS=1
export BAT_THEME='base16'
export BAT_STYLE='numbers'
