export ZSH=$HOME/.oh-my-zsh

ZSH_THEME='amuse'
plugins=(git zsh-autosuggestions)

DEFAULT_USER=`whoami`
ENABLE_CORRECTION='true'

source $ZSH/oh-my-zsh.sh

source $HOME/.aliases

source $HOME/dotfiles/zsh/config/colors.zsh
source $HOME/dotfiles/zsh/config/misc.zsh
source $HOME/dotfiles/zsh/config/fzf.zsh
source $HOME/dotfiles/zsh/config/zsh.zsh
source $HOME/dotfiles/zsh/config/custom_scripts.zsh

source $HOME/dotfiles/zsh/config/capsule.zsh

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
