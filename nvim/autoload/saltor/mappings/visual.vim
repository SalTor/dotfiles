" All borrowed from wincent
function! s:Visual()
    return visualmode() == 'V'
endfunction

function! s:Move(address, at_limit)
    if s:Visual() && !a:at_limit
        execute "'<,'>move " . a:address
        call feedkeys('gv=', 'n')
    endif
    call feedkeys('gv', 'n')
endfunction

function! saltor#mappings#visual#move_up() abort range
    let l:at_top=a:firstline == 1
    call s:Move("'<-2", l:at_top)
endfunction

function! saltor#mappings#visual#move_down() abort range
    let l:at_bottom=a:lastline == line('$')
    call s:Move("'>+1", l:at_bottom)
endfunction

" Apply macro to selected lines
function! saltor#mappings#visual#ExecuteMacroOverVisualRange() abort
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction
