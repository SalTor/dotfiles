[ -f $HOME/dotfiles/config/.secrets ] && source $HOME/dotfiles/config/.secrets

export EDITOR="nvim"

export ARTIFACTORY_CREDENTIALS_USR=$SECRET_ARTIFACTORY_CREDENTIALS_USR
export ARTIFACTORY_CREDENTIALS_PSW=$SECRET_ARTIFACTORY_CREDENTIALS_PSW

export HOMEBREW_GITHUB_API_TOKEN=$HOMEBREW_GITHUB_API_TOKEN

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/.ripgreprc
export LIBRARY_PATH=/usr/local/opt/openssl/lib
export BASE16_SHELL=$XDG_CONFIG_HOME/base16-shell/
export VIM_PLUG_CONFIG=$XDG_CONFIG_HOME/nvim/plug-config/
export NVIM=$XDG_CONFIG_HOME/nvim/
export STARSHIP_CONFIG=~/dotfiles/zsh/config/starship.toml
export PYENV_ROOT=$HOME/.pyenv
export NVM_DIR=$XDG_CONFIG_HOME/nvm
export NVM_DEFAULT_ALIAS=$NVM_DIR/alias/default
export ANSIBLE_NOCOWS=1
export BAT_THEME="base16"
export BAT_STYLE="numbers"

export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/Cellar
export PATH=$PATH:/usr/local/opt/mysql-client/bin
export PATH=$HOME/.opencode/bin:$PATH

export PATH=$PATH:$HOME/dotfiles/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.rbenv/bin
export PATH=$PATH:$HOME/.rbenv/plugins/ruby-build/bin
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH=$PATH:/usr/homebrew/bin/python3
export PATH=$PATH:/opt/homebrew/bin/pip3
export PATH=$PATH:/opt/homebrew/opt/php@8.3/bin
export PATH=$PATH:$NVM_DIR/versions/node/v$(<$NVM_DEFAULT_ALIAS)/bin
