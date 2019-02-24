function! functions#GFilesWithFallback(...) abort
    let output = system('git rev-parse --show-toplevel') " Is there a faster way?
    let prefix = get(g:, 'fzf_command_prefix', '')
    if v:shell_error == 0
        if a:1 == 0
            :GFiles --exclude-standard
        else
            :GFiles?
        endif
    else
        :Files
    endif
    return 0
endfunction

function! functions#change_branch(e) abort
    let res = system("git checkout " . a:e)
    :e!
    echom "Changed branch to" . a:e
endfunction
