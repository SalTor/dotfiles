export ZSH=$HOME/.oh-my-zsh

# ZSH_THEME='amuse'
plugins=(git zsh-autosuggestions starship)

DEFAULT_USER=`whoami`
ENABLE_CORRECTION='true'

source $ZSH/oh-my-zsh.sh

source $HOME/dotfiles/zsh/config/path.zsh

source $HOME/.aliases

source $HOME/dotfiles/zsh/config/colors.zsh
source $HOME/dotfiles/zsh/config/misc.zsh
source $HOME/dotfiles/zsh/config/fzf.zsh
source $HOME/dotfiles/zsh/config/zsh.zsh
source $HOME/dotfiles/zsh/config/custom_scripts.zsh

source $HOME/dotfiles/zsh/config/capsule.zsh

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(pyenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -t 0 ]] && [[ -r $NVM_DIR/bash_completion ]]; then
    . $NVM_DIR/bash_completion
fi

if [[ -t 0 ]] && [[ -s "$NVM_DIR/nvm.sh" ]]; then
    . $NVM_DIR/nvm.sh
fi

stty -ixon # Disable ctrl-s and ctrl-q.

if [[ -t 0 ]] && [[ -s $HOME/.avn/bin/avn.sh ]]; then
    # load avn
    # . $HOME/.avn/bin/avn.sh
fi

# Pull in env vars necessary for Capsule development
source /Users/sal/.config/cia/.cia_envvars

export PNPM_HOME="/Users/sal/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

eval "$(starship init zsh)"
