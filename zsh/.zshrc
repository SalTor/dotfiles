plugins=(git)

ZSH_THEME='aphrodite-custom'
DEFAULT_USER='saltor'
ENABLE_CORRECTION='true'

stty -ixon # Disable ctrl-s and ctrl-q.

# Local config that doesn't need to get tracked in repo history
if [[ -a $HOME/.localrc ]]; then
    source $HOME/.localrc
fi

if [[ -f $HOME/.aliases ]]; then
    source $HOME/.aliases
fi

export ZSH=$HOME/.oh-my-zsh
source $HOME/.oh-my-zsh/oh-my-zsh.sh

export ANSIBLE_NOCOWS=1

export FZF_TMUX=1
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-heading --glob "!.git/*"'
export FZF_DEFAULT_OPTS='--bind "?:toggle-preview" --border --cycle --height=40% --preview="bat --color=always --line-range :75 --style=grid,numbers,changes,header {}" --preview-window=right:60%'
# export FZF_CTRL_R_OPTS='--preview=""'
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# Run command history from <ctrlx><ctrl-r>
fzf-history-widget-accept() {
   fzf-history-widget
   zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept


# ---- Colors ----
# Create a hash table for globally stashing variables without polluting main
# scope with a bunch of identifiers.
typeset -A __WINCENT

# Enable italics where applicable
__WINCENT[ITALIC_ON]=$'\e[3m'
__WINCENT[ITALIC_OFF]=$'\e[23m'

autoload -U colors
colors
source $HOME/dotfiles/zsh/colors
