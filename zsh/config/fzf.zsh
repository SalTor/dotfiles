export FZF_DEFAULT_COMMAND="rg --files --heading --hidden --follow --smart-case --sort path"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --no-ignore --iglob '!.git/*' --iglob '!.DS_Store'"

fzf_bat="bat --color=always --paging=never {}"
fzf_file="([[ -f {} ]] && (${fzf_bat} || cat {}))"
fzf_dir="([[ -d {} ]] && (tree -C {} | less))"
fzf_neither="echo {} 2> /dev/null | head -200"
export FZF_DEFAULT_OPTS="
--color='preview-bg:#282828'
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

# Run command history from <ctrlx><ctrl-r>
fzf-history-widget-accept() {
   fzf-history-widget
   zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
