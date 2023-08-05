# ---- Colors: START ----
# Create a hash table for globally stashing variables without polluting main
# scope with a bunch of identifiers.
typeset -A __WINCENT

# Enable italics where applicable
__WINCENT[ITALIC_ON]=$'\e[3m'
__WINCENT[ITALIC_OFF]=$'\e[23m'

autoload -U colors && colors
source $HOME/dotfiles/zsh/colors.zsh
color gruvbox-dark-soft
# ---- Colors: END ----
