stty -ixon # Disable ctrl-s and ctrl-q.
DEFAULT_USER=`whoami`

export ZSH=$HOME/.oh-my-zsh
plugins=(zsh-autosuggestions vi-mode mise)
source $ZSH/oh-my-zsh.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

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

# if [ -f "/Users/storcivia/.ghcup/env" ]; then
#   source "/Users/storcivia/.ghcup/env" # ghcup-env
# fi

source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

_jj_completion_cache="${XDG_CACHE_HOME:-$HOME/.cache}/jj-completion.zsh"
if [[ ! -s $_jj_completion_cache || $(command -v jj) -nt $_jj_completion_cache ]]; then
  mkdir -p "${_jj_completion_cache:h}"
  COMPLETE=zsh jj > "$_jj_completion_cache" 2>/dev/null
fi
source "$_jj_completion_cache"
unset _jj_completion_cache

# pnpm
export PNPM_HOME="/Users/storcivia/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
# eval "$(mise activate zsh)"
#
# export NVM_DIR="$HOME/.config/nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
