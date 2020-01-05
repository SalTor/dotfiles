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
        git status -s | cut -c4- | fzf --multi --preview 'bat --color=always --line-range :75 --style=grid,numbers,changes,header {}'
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
    tmux a -t $(tmux list-sessions -F '#S' | fzf-tmux --no-preview)
}

function fzf_git_add() {
    local files=$(git ls-files --modified | fzf --ansi)
    if [[ -n $files ]]; then
        git add --verbose $files
    fi
}
