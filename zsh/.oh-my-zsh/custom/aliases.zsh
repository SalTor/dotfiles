if [[ $OSTYPE == darwin* ]]; then
    alias lo='ls -1'
    alias ll='lo -l'
    alias la='lo -A'
else
    alias lo='ls -1 --group-directories-first'
    alias ll='lo -l'
    alias la='lo -A'
fi

alias c='clear'
alias psaux='ps aux | grep'
alias please='sudo !!'

alias ev='vim ~/vim/.vim'
alias ez='vim ~/zsh/'
alias sz='source ~/.zshrc'
alias et='vim ~/tmux/'
alias st='tmux source-file ~/.tmux.conf'

#GIT
alias g='git '
alias gs='git status'
alias ga='git add'
alias gch='git checkout'
alias gd='git diff -w'
alias gb='git branch'
alias gr='git remote -v'
alias gc='git commit'

#VIM
alias vi='nvim'
alias vim='nvim'
