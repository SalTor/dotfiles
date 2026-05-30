# Aphrodite-style prompt, ported to fish.
#
# This is the FALLBACK prompt. When starship is on PATH, config.fish runs
# `starship init fish` which overrides this function at startup, so you only
# see this when starship is unavailable. It mirrors the zsh Aphrodite theme:
#   user:dir ‹branch›
#   $
# username in cyan, ':' in grey, full path (~ for $HOME), git branch in green
# when clean / yellow when dirty, then a newline and a prompt symbol that turns
# red after a non-zero exit.

function fish_prompt
    set -l last_status $status

    # user
    set_color cyan
    echo -n (whoami)

    # ':' separator
    set_color brblack
    echo -n ':'

    # directory (full path, $HOME abbreviated to ~ — like zsh's %~)
    set_color normal
    echo -n (string replace -r '^'(string escape --style=regex $HOME) '~' $PWD)

    # git branch ‹branch›: green when clean, yellow when dirty
    set -l branch (command git symbolic-ref --short HEAD 2>/dev/null; or command git rev-parse --short HEAD 2>/dev/null)
    if test -n "$branch"
        echo -n ' '
        if test -n "(command git status --porcelain 2>/dev/null | string collect)"
            set_color yellow
        else
            set_color green
        end
        echo -n "‹$branch›"
    end

    set_color normal
    echo

    # prompt symbol: red on non-zero exit
    if test $last_status -ne 0
        set_color red
    end
    if test (id -u) -eq 0
        echo -n '# '
    else
        echo -n '$ '
    end
    set_color normal
end
