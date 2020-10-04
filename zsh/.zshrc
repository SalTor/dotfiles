export ZSH=$HOME/.oh-my-zsh

ZSH_THEME='amuse'

plugins=(git zsh-autosuggestions)

DEFAULT_USER=`whoami`

ENABLE_CORRECTION='true'

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

export BAT_THEME='Dracula'
export BAT_STYLE='grid,numbers'

export FZF_DEFAULT_COMMAND="rg --files --heading --hidden --follow --smart-case --sort path"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --no-ignore --iglob '!.git/*'"

fzf_bat="bat --color=always --paging=never {}"
fzf_file="([[ -f {} ]] && (${fzf_bat} || cat {}))"
fzf_dir="([[ -d {} ]] && (tree -C {} | less))"
fzf_neither="echo {} 2> /dev/null | head -200"
export FZF_DEFAULT_OPTS="
--color='preview-bg:#72ea8a'
--layout=reverse
--bind 'esc:abort'
--bind 'ctrl-\\:toggle-preview'
--bind 'ctrl-s:select-all'
--bind 'ctrl-d:deselect-all'
--info inline
--cycle
--height 40%
--preview-window right:50%:hidden
--preview '${fzf_file} || ${fzf_dir} || ${fzf_neither}'"

# Load aliases and shortcuts
source $HOME/.aliases

[ -f $HOME/capsule/configs/env ] && source $HOME/capsule/configs/env

autoload -Uz compinit
if [[ -n ${ZDOTDIR:-${HOME}}/$ZSH_COMPDUMP(#qN.mh+24) ]]; then
    compinit -d $ZSH_COMPDUMP;
else
    compinit -C;
fi;

# Basic auto/tab complete:
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)

bindkey '^X^X' edit-command-line
autoload edit-command-line; zle -N edit-command-line

# Run command history from <ctrlx><ctrl-r>
fzf-history-widget-accept() {
   fzf-history-widget
   zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept

# Accept autosuggestion
bindkey '^\' autosuggest-accept
bindkey '^X^ ' autosuggest-execute

# set autoload path
fpath=(~/dotfiles/zsh/scripts "${fpath[@]}")
autoload kp bip bup bcp fp

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[[ -s $HOME/.avn/bin/avn.sh ]] && source $HOME/.avn/bin/avn.sh # load avn
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
