# Basic auto/tab complete (compinit is handled by oh-my-zsh)
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)

bindkey '^X^X' edit-command-line
autoload edit-command-line; zle -N edit-command-line

bindkey '^y' autosuggest-accept
bindkey '^\' autosuggest-accept
