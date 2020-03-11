let g:airline_theme = 'bubblegum'

let g:airline#extensions#tabline#tab_nr_type = 1

let g:airline_filetype_overrides = {
    \ 'nerdtree': [ get(g:, 'NerdTreeStatusline', 'File Explorer'), '' ],
    \ 'startify': [ get(g:, 'startify', 'Startify'), '' ],
    \ }

let g:airline_detect_spell=1

let g:airline_focuslost_inactive=0
let g:airline_inactive_collapse=0
let g:airline_inactive_alt_sep=1

let g:airline#extensions#default#layout = [
    \ ['b', 'a', 'warning', 'error', 'c'],
    \ ['x', 'y', 'z'],
    \ ]

call airline#parts#define_function('winnr', 'winnr')
call airline#parts#define_minwidth('winnr', 50)
function! Active(...)
    let g:airline_section_b = ''
endfunction
function! Inactive(...)
    let g:airline_section_b = airline#section#create(['winnr'])
endfunction
call airline#add_statusline_func('Active')
call airline#add_inactive_statusline_func('Inactive')
let g:airline_section_a = airline#section#create(['mode', 'crypt', 'paste', 'spell', 'iminsert'])
let g:airline_section_c = airline#section#create(['%t'])
let g:airline_section_x = airline#section#create(['branch'])
let g:airline_section_y = airline#section#create(['Ln %l, Col %c'])
let g:airline_section_z = airline#section#create(['filetype'])

let g:airline#extensions#ale#show_line_numbers=0

let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:airline#extensions#ale#error_symbol = 'E:'
let g:airline#extensions#ale#warning_symbol = 'W:'

let g:airline_symbols = {
    \ 'space': ' ',
    \ 'paste': 'PASTE',
    \ 'maxlinenr': ' ',
    \ 'dirty': ' [!]',
    \ 'crypt': '🔒',
    \ 'linenr': '☰ ',
    \ 'readonly': '',
    \ 'spell': 'SPELL',
    \ 'modified': '+',
    \ 'notexists': '?',
    \ 'keymap': 'Keymap:',
    \ 'ellipsis': '...',
    \ 'branch': '',
    \ 'whitespace': '☲',
    \ }

let g:airline_extensions=['tabline', 'ale', 'term']

let g:airline_skip_empty_sections = 1
