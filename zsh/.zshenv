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
        git checkout $(git branch $@ | fzf)
    fi
}

function fzf_git_changed_files() {
    if is_git_repo; then
        git ls-files -d -m -o --directory --exclude-standard | fzf --multi --preview 'git status -s {+1}'
    fi
}

function fzf_git_checkout_changed() {
    if is_git_repo; then
        git checkout $@ $(fzf_git_changed_files)
    fi
}

function fzf_git_add_changed() {
    if is_git_repo; then
        git add $@ $(fzf_git_changed_files)
    fi
}

function fzf_tmux_attach() {
    tmux a -t $(tmux list-sessions -F '#S' | fzf --no-preview)
}

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
alias gchf=fzf_git_checkout_changed

alias fmuxa=fzf_tmux_attach

#VIM
alias vi='nvim'
alias vim='nvim'
