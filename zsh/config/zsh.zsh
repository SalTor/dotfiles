autoload -Uz compinit
if [[ -n ${ZDOTDIR:-${HOME}}/$ZSH_COMPDUMP(#qN.mh+24) ]]; then
    compinit -d $ZSH_COMPDUMP;
else
    compinit -C;
fi;

# Basic auto/tab complete:
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

bindkey '^X^X' edit-command-line
autoload edit-command-line; zle -N edit-command-line

bindkey '^l' autosuggest-accept
bindkey '^\' autosuggest-accept
bindkey '^X^ ' autosuggest-execute
