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

alias editit='vim ~/.zshrc'
alias saveit='source ~/.zshrc'
alias editvim='vim ~/.vimrc'

#GIT
alias st='git status'
alias add='git add'
alias ch='git checkout'
alias diff='git diff -w'
alias init='git init'
alias br='git branch'
alias branch='git branch'
alias remote='git remote -v'
alias fetch='git fetch origin'
alias merge='git merge origin/master'
alias commit='git commit'

#VIM
alias vi='nvim'
alias vim='nvim'
