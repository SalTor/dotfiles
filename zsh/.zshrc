export ZSH=$HOME/.oh-my-zsh

# ZSH_THEME='amuse'
plugins=(git zsh-autosuggestions vi-mode)

DEFAULT_USER=`whoami`

source $ZSH/oh-my-zsh.sh
source $HOME/dotfiles/config/.aliases
source $HOME/dotfiles/zsh/config/colors.zsh
source $HOME/dotfiles/zsh/config/misc.zsh
source $HOME/dotfiles/zsh/config/fzf.zsh
source $HOME/dotfiles/zsh/config/zsh.zsh
source $HOME/dotfiles/zsh/config/custom_scripts.zsh

source $HOME/dotfiles/zsh/config/capsule.zsh

[ -f ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if [[ -t 0 ]] && [[ -r $NVM_DIR/bash_completion ]]; then
    . $NVM_DIR/bash_completion
fi

if [[ -t 0 ]] && [[ -s "$NVM_DIR/nvm.sh" ]]; then
    . $NVM_DIR/nvm.sh
fi

# eval "$(fnm env --use-on-cd)"

stty -ixon # Disable ctrl-s and ctrl-q.

if [[ -t 0 ]] && [[ -s $HOME/.avn/bin/avn.sh ]]; then
    # load avn
    # . $HOME/.avn/bin/avn.sh
fi

# Pull in env vars necessary for Capsule development
# source /Users/sal/.config/cia/.cia_envvars

eval "$(starship init zsh)"

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

source "$HOME/.cargo/env"

if [[ "$OSTYPE" == "darwin"* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# pnpm
export PNPM_HOME="/Users/storcivia/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[ -f "/Users/storcivia/.ghcup/env" ] && source "/Users/storcivia/.ghcup/env" # ghcup-env

export PATH="$PATH:/root/.local/bin"
eval "$(zoxide init zsh)"

export PATH="$PATH:/opt/nvim-linux64/bin"
source $HOME/dotfiles/zsh/config/path.zsh

# opencode
export PATH=/Users/storcivia/.opencode/bin:$PATH
