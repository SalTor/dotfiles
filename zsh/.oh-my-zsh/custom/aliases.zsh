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

function is_git_repo() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        return 0
    else
        echo 'Not a git repo.'
        return 1
    fi
}

function fzf_git_checkout_branch() {
    if is_git_repo; then
        branch=$(git branch | fzf)
        if [[ $branch ]]; then
            fgchb="git checkout $branch"
            eval $fgchb
        fi
    fi
}

function fzf_git_changed_files() {
    git diff --name-only | fzf --multi --preview 'git diff {+1}'
}

function fzf_git_checkout_changed() {
    if is_git_repo; then
        for file in $(fzf_git_changed_files); do
            git checkout $@ $file
        done
    fi
}

function fzf_git_add_changed() {
    if is_git_repo; then
        for file in $(fzf_git_changed_files); do
            git add $@ $file
        done
    fi
}

alias g='git '
alias gs='git status'
alias ga='git add'
alias gch='git checkout'
alias gd='git diff -w'
alias gb='git branch'
alias gr='git remote -v'
alias gc='git commit'

alias gaf=fzf_git_add_changed
alias gchb=fzf_git_checkout_branch
alias gchf=fzf_git_checkout_file

#VIM
alias vi='nvim'
alias vim='nvim'
