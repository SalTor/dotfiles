let g:airline_theme = 'bubblegum'

let g:airline_section_b = airline#section#create(['filetype', 'hunks'])
let g:airline_section_c = airline#section#create([])
let g:airline_section_x = airline#section#create([])
let g:airline_section_z = airline#section#create(['%l/%L:%c'])

let g:airline_filetype_overrides = {
    \ 'nerdtree': [ get(g:, 'NerdTreeStatusline', 'File Explorer'), '' ],
    \ 'startify': [ get(g:, 'startify', 'Startify'), '' ],
    \ }

let g:airline_detect_spell=1

let g:airline_inactive_collapse=1
let g:airline_inactive_alt_sep=1

let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#ale#error_symbol = 'E:'
let g:airline#extensions#ale#warning_symbol = 'W:'
let g:airline_symbols = {
    \ 'space': ' ',
    \ 'paste': 'PASTE',
    \ 'maxlinenr': ' ',
    \ 'dirty': '⚡',
    \ 'crypt': '🔒',
    \ 'linenr': '☰ ',
    \ 'readonly': '',
    \ 'spell': 'SPELL',
    \ 'modified': '+',
    \ 'notexists': '?',
    \ 'keymap': 'Keymap:',
    \ 'ellipsis': '...',
    \ 'branch': '',
    \ 'whitespace': '☲',
    \ }
