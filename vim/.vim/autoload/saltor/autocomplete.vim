if exists('*shiftwidth')
    function! s:ShiftWidth()
        if &softtabstop <= 0
            return shiftwidth()
        else
            return &softtabstop
        endif
    endfunction
else
    function! s:ShiftWidth()
        if &softtabstop <= 0
            if &shiftwidth == 0
                return &tabstop
            else
                return &shiftwidth
            endif
        else
            return &softtabstop
        endif
    endfunction
endif

" Use <Tab> for leading indent (when 'noexpandtab'), spaces for everything else
" (even when 'noexpandtab').
function! saltor#autocomplete#smart_tab() abort
    if &l:expandtab
        return "\<Tab>"
    else
        let l:prefix=strpart(getline('.'), 0, col('.') -1)
        if l:prefix =~# '^\s*$'
            return "\<Tab>"
        else
            " virtcol() returns last column occupied, so if cursor is on a tab it will
            " report `actual column + tabstop` instead of `actual column`. So, get
            " last column of previous character instead, and add 1 to it.
            let l:sw=s:ShiftWidth()
            let l:previous_char=matchstr(l:prefix, '.$')
            let l:previous_column=strlen(l:prefix) - strlen(l:previous_char) + 1
            let l:current_column=virtcol([line('.'), l:previous_column]) + 1
            let l:remainder=(l:current_column - 1) % l:sw
            let l:move=(l:remainder == 0 ? l:sw : l:sw - l:remainder)
            return repeat(' ', l:move)
        endif
    endif
endfunction

" Mirror of saltor#autocomplete#smart_tab().
function! saltor#autocomplete#smart_bs() abort
    if &l:expandtab
        return "\<BS>"
    else
        let l:col=col('.')
        let l:prefix=strpart(getline('.'), 0, l:col - 1)
        if l:prefix =~# '^\s*$'
            return "\<BS>"
        endif
        let l:previous_char=matchstr(l:prefix, '.$')
        if l:previous_char !=# ' '
            return "\<BS>"
        else
            " Delete enough spaces to take us back to the previous tabstop.
            "
            " Originally I was calculating the number of <BS> to send, but Vim
            " has some special casing that causes one <BS> to delete multiple
            " characters even when 'expandtab' is off (eg. if you hit <BS> after
            " pressing <CR> on a line with trailing whitespace and Vim inserts
            " whitespace to match.
            "
            " So, turn 'expandtab' on temporarily and let Vim figure out what
            " a single <BS> should do.
            return "\<C-\>\<C-o>:set expandtab\<CR>" .
                        \ "\<C-\>\<C-o>:set noexpandtab\<CR>\<BS>"
    endif
endfunction
