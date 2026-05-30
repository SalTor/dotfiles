# vi: ft=fish
#
# Fish configuration — mirrors the zsh setup in ~/dotfiles/zsh.
# The prompt is Starship (see ~/dotfiles/zsh/config/starship.toml), which runs
# natively under fish, so the prompt here is identical to the zsh one. A
# fish-native port of the Aphrodite theme lives in functions/fish_prompt.fish
# and is used only when starship isn't on PATH.

# ── Environment (mirrors zsh/config/path.zsh) ───────────────────────────────
# These run for every shell (login, non-login, non-interactive) so PATH/env are
# consistent everywhere.

set -gx EDITOR nvim

set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.cache

set -gx STARSHIP_CONFIG $HOME/dotfiles/zsh/config/starship.toml
set -gx RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/.ripgreprc
set -gx BAT_THEME base16
set -gx BAT_STYLE numbers
set -gx ANSIBLE_NOCOWS 1
set -gx HOMEBREW_NO_AUTO_UPDATE 1

# Secrets, if present (sourced as POSIX env via a small helper).
if test -f $HOME/dotfiles/config/.secrets
    # .secrets is POSIX `export VAR=val`; pull it in without a bash subshell.
    for line in (string match -r '^\s*export\s+\S+=.*' < $HOME/dotfiles/config/.secrets)
        set -l kv (string replace -r '^\s*export\s+' '' -- $line)
        set -l key (string split -m1 '=' -- $kv)[1]
        set -l val (string split -m1 '=' -- $kv)[2]
        set -gx $key (string trim -c '"\'' -- $val)
    end
end

# ── PATH (fish_add_path dedupes and prepends/appends sanely) ─────────────────
fish_add_path $HOME/.opencode/bin
fish_add_path $HOME/dotfiles/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.rbenv/bin
fish_add_path $HOME/.rbenv/plugins/ruby-build/bin

# pnpm
set -gx PNPM_HOME $HOME/Library/pnpm
fish_add_path $PNPM_HOME

# ── Homebrew (macOS) ─────────────────────────────────────────────────────────
if test (uname) = Darwin; and test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv | source
end

# Everything below is for interactive shells only.
if not status is-interactive
    exit
end

# ── Tool integrations the prompt relies on (mirrors .zshrc) ─────────────────
if test -x $HOME/.local/bin/mise
    $HOME/.local/bin/mise activate fish | source
else if command -q mise
    mise activate fish | source
end

command -q zoxide; and zoxide init fish | source

# ── Plugins (fisher) ─────────────────────────────────────────────────────────
# Plugin list lives in fish_plugins (tracked in the repo). On a fresh machine,
# bootstrap fisher and install everything listed. `fisher update` reads
# fish_plugins, so this self-heals from the repo.
if not functions -q fisher; and command -q curl
    echo "Installing fisher + fish plugins…" >&2
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    and fisher update
end

# fzf.fish bindings: Ctrl+R = history, Ctrl+T = file/directory search.
# (git log/status, processes, variables stay on their Ctrl+Alt defaults.)
if functions -q fzf_configure_bindings
    fzf_configure_bindings --directory=\ct
end

# ── Prompt: Starship (primary), Aphrodite fish_prompt fallback otherwise ────
if command -q starship
    starship init fish | source

    # ── TEMPORARY: shell badge ───────────────────────────────────────────────
    # While trialing fish, prefix the prompt with a 🐟 so it's obvious at a
    # glance that this is fish and not zsh. starship.toml is shared with zsh, so
    # we wrap fish's prompt here instead of touching the config (keeps zsh's
    # prompt byte-for-byte unchanged). Delete this whole block to drop the badge.
    if not functions -q __starship_prompt_inner
        functions --copy fish_prompt __starship_prompt_inner
    end
    function __starship_badge_restore_status
        return $argv[1]
    end
    function fish_prompt
        set -l __badge_status $status
        # Re-render starship with the real exit status preserved (so the error
        # color on the prompt character still works).
        set -l __rendered (begin
            __starship_badge_restore_status $__badge_status
            __starship_prompt_inner
        end | string collect -N)
        set -l __badge (set_color brmagenta)"🐟 "(set_color normal)
        # starship leads with an erase sequence + a blank line (add_newline).
        # Insert the badge right after that newline so it sits at the start of
        # the actual prompt line; fall back to a plain prefix if there's no
        # newline (e.g. add_newline disabled).
        if string match -rq '\n' -- $__rendered
            printf '%s' (string replace \n \n$__badge $__rendered | string collect -N)
        else
            printf '%s' $__badge$__rendered
        end
    end
end

# ── Aliases (mirrors config/.aliases) ───────────────────────────────────────
alias e 'exit'
alias vim 'nvim'
alias j 'jj'

# File navigation. On macOS use GNU ls (coreutils) like zsh does.
if test (uname) = Darwin; and test -x /opt/homebrew/bin/gls
    alias ls '/opt/homebrew/bin/gls -h --group-directories-first'
    alias lo 'ls -1'
else
    alias lo 'ls -1 --group-directories-first'
end
alias ll 'lo -l'
alias la 'lo -A'

alias ta 'tmuxinator start'
alias ts 'tmuxinator stop'

# Show the jj stack for a given revision (mirrors the `expand` zsh function).
function expand --description 'jj log -r "stack(REV)"'
    jj log -r "stack($argv[1])"
end

# zsh's `where` builtin lists every definition/location of a command; fish has
# no equivalent, so wrap `type -a`.
function where --wraps type --description 'zsh-style where: all locations of a command'
    type -a $argv
end

# ── jj completions ──────────────────────────────────────────────────────────
# jj ships native fish completions via `COMPLETE=fish jj`.
if command -q jj
    set -l _jj_cache $XDG_CACHE_HOME/jj-completion.fish
    if not test -s $_jj_cache; or test (command -v jj) -nt $_jj_cache
        mkdir -p (dirname $_jj_cache)
        COMPLETE=fish jj >$_jj_cache 2>/dev/null
    end
    test -s $_jj_cache; and source $_jj_cache
end
