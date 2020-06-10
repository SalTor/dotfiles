export EDITOR="nvim"

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export LIBRARY_PATH=/usr/local/opt/openssl/lib
export PYTHONPATH=$HOME/Library/Python/2.7/bin
export PYTHONPATH=$PYTHONPATH:$HOME/Library/Python/3.7/bin
export PYTHONPATH=$PYTHONPATH:$HOME/Library/Python/3.8/bin
export NVM_DIR=$HOME/.nvm
export BASE16_SHELL=$HOME/.config/base16-shell/

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

lazy_load() {
    # Act as a stub to another shell function/command. When first run, it will load the actual function/command then execute it.
    # E.g. This made my zsh load 0.8 seconds faster by loading `nvm` when "nvm", "npm" or "node" is used for the first time
    # $1: space separated list of alias to release after the first load
    # $2: file to source
    # $3: name of the command to run after it's loaded
    # $4+: argv to be passed to $3
    echo "Lazy loading $1 ..."

    # $1.split(' ') using the s flag. In bash, this can be simply ($1) #http://unix.stackexchange.com/questions/28854/list-elements-with-spaces-in-zsh
    # Single line won't work: local names=("${(@s: :)${1}}"). Due to http://stackoverflow.com/questions/14917501/local-arrays-in-zsh   (zsh 5.0.8 (x86_64-apple-darwin15.0))
    local -a names
    if [[ -n "$ZSH_VERSION" ]]; then
        names=("${(@s: :)${1}}")
    else
        names=($1)
    fi
    unalias "${names[@]}"
    . $2
    shift 2
    $*
}
group_lazy_load() {
    local script
    script=$1
    shift 1
    for cmd in "$@"; do
        alias $cmd="lazy_load \"$*\" $script $cmd"
    done
}
group_lazy_load $HOME/.rvm/scripts/rvm
group_lazy_load $NVM_DIR/nvm.sh nvm node nvim
# group_lazy_load $NVM_DIR/bash_completion
unset -f group_lazy_load
