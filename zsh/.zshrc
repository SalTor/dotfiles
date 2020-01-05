export ZSH=$HOME/.oh-my-zsh

ZSH_THEME='aphrodite-custom'

plugins=(git zsh-autosuggestions)

DEFAULT_USER='saltor'

ENABLE_CORRECTION='true'
COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh

# ---- Colors: START ----
# Create a hash table for globally stashing variables without polluting main
# scope with a bunch of identifiers.
typeset -A __WINCENT

# Enable italics where applicable
__WINCENT[ITALIC_ON]=$'\e[3m'
__WINCENT[ITALIC_OFF]=$'\e[23m'

autoload -U colors && colors
source $HOME/dotfiles/zsh/colors
# ---- Colors: END ----

stty -ixon # Disable ctrl-s and ctrl-q.

export ANSIBLE_NOCOWS=1

export FZF_TMUX=1
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-heading --glob "!.git/*"'
export FZF_DEFAULT_OPTS='--bind "?:toggle-preview" --border --cycle --height=40% --preview="bat --color=always --line-range :75 --style=grid,numbers,changes,header {}" --preview-window=right:60%'
# export FZF_CTRL_R_OPTS='--preview=""'
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# Load aliases and shortcuts
source $HOME/.localrc # Local config that doesn't need to get tracked in repo history
source $HOME/.aliases

# FZF completions
source $HOME/.fzf.zsh

# Run command history from <ctrlx><ctrl-r>
fzf-history-widget-accept() {
   fzf-history-widget
   zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept

# Edit line in vim with <ctrl-e>
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Accept autosuggestion
bindkey '^ ' autosuggest-accept
bindkey '^X^ ' autosuggest-execute
