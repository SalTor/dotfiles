function! saltor#mappings#leader#cycle_color_column() abort
    if &colorcolumn == 80
        set colorcolumn=""
    else
        set colorcolumn=80
    endif
endfunction

" Cycle through spell-check mode
function! saltor#mappings#leader#cycle_spellcheck() abort
    execute {
        \ 'en_us1': 'setlocal nospell',
        \ 'en_us0': 'setlocal spell' }[&spelllang . &spell]
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

" Cycle through showing git gutter highlights
function! saltor#mappings#leader#cycle_git_gutter() abort
    if exists('g:loaded_gitgutter')
        GitGutterToggle
        echo '[GitGutter] Toggled'
    else
        GitGutterEnable
        echo '[GitGutter] Enabled'
    endif
endfunction
