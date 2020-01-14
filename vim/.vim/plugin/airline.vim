let g:airline_theme = 'bubblegum'

let g:airline_filetype_overrides = {
    \ 'nerdtree': [ get(g:, 'NerdTreeStatusline', 'File Explorer'), '' ],
    \ 'startify': [ get(g:, 'startify', 'Startify'), '' ],
    \ }

let g:airline_detect_spell=1

let g:airline_inactive_collapse=1
let g:airline_inactive_alt_sep=0

let g:airline#extensions#default#layout = [
    \ ['a', 'b', 'warning', 'error', 'c'],
    \ ['x', 'y', 'z'],
    \ ]

function! InactiveSectionC(...)
    let g:airline_section_c = airline#section#create(['%f'])
endfunction
function! ActiveSectionC(...)
    let g:airline_section_c = airline#section#create(['%t'])
endfunction
call airline#add_statusline_func('ActiveSectionC')
call airline#add_inactive_statusline_func('InactiveSectionC')
let g:airline_section_b = ''
let g:airline_section_c = airline#section#create(['%{ActiveSectionC()}'])
let g:airline_section_x = airline#section#create(['branch'])
let g:airline_section_y = airline#section#create(['%l/%L : %c'])
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

let g:airline_extensions=['tabline', 'ale', 'branch', 'term']

let g:airline_skip_empty_sections = 1

autocmd ColorScheme * highlight airline_error guibg=#b20c0c guifg=#ffffff