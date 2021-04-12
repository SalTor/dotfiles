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
        \ 'en1': 'setlocal nospell',
        \ 'en0': 'setlocal spell' }[&spelllang . &spell]
endfunction

" Cycle through relativenumber + norelativenumber
function! saltor#mappings#leader#cycle_numbering() abort
    if exists('+relativenumber')
        if &relativenumber == '0'
            let g:sal_norelativenumber = 0
            set relativenumber
        else
            let g:sal_norelativenumber = 1
            set norelativenumber
        end
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
