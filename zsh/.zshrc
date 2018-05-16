export PATH=$PATH:/home/sal/bin
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="aphrodite"
DEFAULT_USER="saltor"
ENABLE_CORRECTION="true"

bindkey "[C" forward-word
bindkey "[D" backward-word

source ~/.oh-my-zsh/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
