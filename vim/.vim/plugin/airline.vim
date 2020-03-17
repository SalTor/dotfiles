let g:airline_theme = 'bubblegum'

let g:airline#extensions#default#layout = [
    \ ['b', 'a', 'warning', 'error', 'c'],
    \ ['x', 'y', 'z'],
    \ ]

function! GetWinnrSymbol(...)
    let l:small = ['➊', '➋', '➌', '➍', '➎', '➏', '➐', '➑', '➒', '➓']
    let l:med   = ['➀', '➁', '➂', '➃', '➄', '➅', '➆', '➇', '➈', '➉']
    let l:large = ['⓵', '⓶', '⓷', '⓸', '⓹', '⓺', '⓻', '⓼', '⓽', '⓾']
    let l:chinese = ['一', '二', '三', '四', '五', '六', '七', '八', '九', '十']
    let l:not_found = 'NOT_FOUND'
    let l:winnr = winnr()
    let l:val = get(l:chinese, l:winnr - 1, l:not_found)
    if l:val == l:not_found
        return l:winnr
    else
        return l:val
    endif
endfunction

call airline#parts#define_function('winnr', 'GetWinnrSymbol')
call airline#parts#define_minwidth('winnr', 50)

let g:airline_section_b = airline#section#create(['winnr'])
let g:airline_section_c = airline#section#create(['%t'])
let g:airline_section_x = airline#section#create(['branch'])
let g:airline_section_y = airline#section#create(['Ln %l, Col %c'])
let g:airline_section_z = airline#section#create(['filetype'])

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

let g:airline_filetype_overrides = {
    \ 'nerdtree': [ get(g:, 'NerdTreeStatusline', GetWinnrSymbol()), 'File Explorer' ],
    \ 'startify': [ get(g:, 'startify', 'Startify'), '' ],
    \ 'help': [
        \ airline#section#create_left(['Help', '%f']),
        \ airline#section#create(['winnr']),
    \ ],
    \ }
" \ 'help': [airline#section#create_left(['Help', '%f']), get(g:, 'NerdTreeStatusline', GetWinnrSymbol())],

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1

let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:airline#extensions#coc#warning_symbol = 'W:'
let g:airline#extensions#coc#error_symbol = 'E:'
let g:airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'
let g:airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
