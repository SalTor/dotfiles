stty -ixon # Disable ctrl-s and ctrl-q.
DEFAULT_USER=`whoami`

export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
plugins=(zsh-autosuggestions vi-mode mise)

eval "$(/Users/storcivia/.local/bin/mise activate zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

source $HOME/dotfiles/config/.aliases
source $HOME/dotfiles/zsh/config/colors.zsh
source $HOME/dotfiles/zsh/config/misc.zsh
source $HOME/dotfiles/zsh/config/fzf.zsh
source $HOME/dotfiles/zsh/config/zsh.zsh
source $HOME/dotfiles/zsh/config/custom_scripts.zsh
source $HOME/dotfiles/zsh/config/path.zsh

if [ -f ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# if [[ "$OSTYPE" == "darwin"* ]]; then
#     eval "$(/opt/homebrew/bin/brew shellenv)"
# fi

# if [ -f "/Users/storcivia/.ghcup/env" ]; then
#   source "/Users/storcivia/.ghcup/env" # ghcup-env
# fi

# export PATH="$PATH:/opt/nvim-linux64/bin"
