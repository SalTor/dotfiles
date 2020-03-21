" Cycle through spell-check mode
function! saltor#mappings#leader#cycle_spellcheck() abort
    execute {
        \ 'en_us1': 'set nospell',
        \ 'en_us0': 'set spell' }[&spelllang . &spell]
endfunction

" Cycle through relativenumber + number, number (only), and no numbering
function! saltor#mappings#leader#cycle_numbering() abort
    " Borrowed from wincent
    if exists('+relativenumber')
        execute {
            \ '00': 'set relativenumber   | set number',
            \ '01': 'set norelativenumber | set number',
            \ '10': 'set norelativenumber | set nonumber',
            \ '11': 'set norelativenumber | set number' }[&number . &relativenumber]
    else
        " No relative numbering, just toggle numbers on and off
        set number!<CR>
    endif
endfunction

" Cycle through highlighting keywords beneath cursor
function! saltor#mappings#leader#cycle_cursor_highlight() abort
    if exists('g:loaded_illuminate')
        IlluminationToggle
    else
        IlluminationEnable
    endif
endfunction
