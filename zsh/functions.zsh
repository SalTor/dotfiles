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

function fzf_git_diff_changed() {
    if is_git_repo; then
        git diff $@ $(fzf_git_changed_files)
    fi
}

function fzf_tmux_switch_or_attach() {
    if [ -n "$TMUX" ]; then
        TMUX_SESSION=$(tmux list-sessions -F "#S" | fzf-tmux --prompt="Session: " -m -1 -q "$1" --reverse --exit-0 --height 50% --preview=""%)
        if [ -n "$TMUX_SESSION" ]; then
            tmux switch-client -t "$TMUX_SESSION"
        fi
    else
        TMUX_PROJECT=$(tmux list-sessions -F "#S" | fzf-tmux --prompt="Project: " -m -1 -q "$1" --reverse --exit-0 --height 50% --preview=""%)
        if [ -n "$TMUX_PROJECT" ]; then
            tmux attach-session -t "$TMUX_PROJECT"
        fi
    fi
}
