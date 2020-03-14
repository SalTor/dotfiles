export ZSH=$HOME/.oh-my-zsh

ZSH_THEME='agnoster'

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

export BAT_THEME="zenburn"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --no-heading --iglob "!.DS_Store" --iglob "!.git"'
export FZF_DEFAULT_OPTS='--bind "esc:abort,\\:toggle-preview,[:up,]:down,ctrl-a:select-all,ctrl-d:deselect-all" --layout=reverse --info=inline --cycle --height=40% --preview-window bottom:25:hidden --preview="bat --theme="zenburn" --color=always --line-range :50 --paging=never --style=grid,numbers,changes,header {}"'
export FZF_CTRL_R_OPTS="--preview=''"

# Load aliases and shortcuts
source $HOME/.aliases

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

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

prompt_end() {
    if [[ -n $CURRENT_BG ]]; then
        print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
    else
        print -n "%{%k%}"
    fi

    print -n "%{%f%}"
    CURRENT_BG=''

    printf "\n$";
}

# set autoload path
fpath=(~/dotfiles/zsh/scripts "${fpath[@]}")
autoload kp bip bup bcp fp

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
