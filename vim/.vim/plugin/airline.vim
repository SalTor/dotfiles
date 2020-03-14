let g:airline_theme = 'bubblegum'

let g:airline_filetype_overrides = {
    \ 'nerdtree': [ get(g:, 'NerdTreeStatusline', 'File Explorer'), '' ],
    \ 'startify': [ get(g:, 'startify', 'Startify'), '' ],
    \ 'help': ['Help', '%f'],
    \ }

let g:airline#extensions#term#enabled = 0

let g:airline_detect_spell=1

let g:airline_focuslost_inactive=0
let g:airline_inactive_collapse=0
let g:airline_inactive_alt_sep=1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:airline#extensions#default#layout = [
    \ ['b', 'a', 'warning', 'error', 'c'],
    \ ['x', 'y', 'z'],
    \ ]

function! GetWinnrSymbol(...)
    let l:small = ['➊', '➋', '➌', '➍', '➎', '➏', '➐', '➑', '➒', '➓']
    let l:med   = ['➀', '➁', '➂', '➃', '➄', '➅', '➆', '➇', '➈', '➉']
    let l:large = ['⓵', '⓶', '⓷', '⓸', '⓹', '⓺', '⓻', '⓼', '⓽', '⓾']
    let l:chinese = ['一', '二', '三', '四', '五', '六', '七', '八', '九']
    return l:chinese[winnr()-1]
endfunction

call airline#parts#define_function('winnr', 'GetWinnrSymbol')
call airline#parts#define_minwidth('winnr', 50)

let g:airline_section_b = airline#section#create(['winnr'])
let g:airline_section_c = airline#section#create(['%t'])
let g:airline_section_x = airline#section#create(['branch'])
let g:airline_section_y = airline#section#create(['Ln %l, Col %c'])
let g:airline_section_z = airline#section#create(['filetype'])

let g:airline#extensions#ale#show_line_numbers=0

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

let g:airline_extensions=['tabline', 'ale']

let g:airline_skip_empty_sections = 1
