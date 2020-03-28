let g:airline_theme = 'bubblegum'
let g:airline_powerline_fonts = 1
let g:airline_detect_spell = 1
let g:airline_skip_empty_sections = 1
let g:airline_inactive_collapse=0

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

function! GetParentDirWithFile(...) abort
    let l:cwd = split(expand('%:h'), '/')
    let l:cfl = expand('%:t')
    if l:cfl == ''
        return '[No Name]'
    else
        let l:parent = l:cwd[-1]
        return l:parent . '/' . expand('%:t')
    endif
endfunction

call airline#parts#define_function('winnr', 'GetWinnrSymbol')
call airline#parts#define_minwidth('winnr', 50)
call airline#parts#define_function('saltor_file', 'GetParentDirWithFile')
call airline#parts#define_minwidth('saltor_file', 50)

let g:airline_section_b = airline#section#create(['winnr'])
let g:airline_section_c = airline#section#create(['saltor_file'])
let g:airline_section_x = airline#section#create_right(['filetype'])
let g:airline_section_y = ''
let g:airline_section_z = ''

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

let g:airline#extensions#term#enabled = 0
let g:airline#extensions#nerdtree_status = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1

let g:airline_filetype_overrides = {
    \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'File Explorer'), '' ],
    \ 'startify': [ 'Startify', '' ],
    \ 'help': [
        \ airline#section#create_left(['Help', '%f']),
        \ airline#section#create(['winnr']),
    \ ],
    \ }

let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_close_button = 0

let g:airline#extensions#coc#warning_symbol = 'W:'
let g:airline#extensions#coc#error_symbol = 'E:'
let g:airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'
let g:airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
