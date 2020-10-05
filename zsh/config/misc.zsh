export ANSIBLE_NOCOWS=1
export BAT_THEME='base16'
export BAT_STYLE='numbers'

stty -ixon # Disable ctrl-s and ctrl-q.

[[ -s $HOME/.avn/bin/avn.sh ]] && source $HOME/.avn/bin/avn.sh # load avn
