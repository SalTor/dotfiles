vim.g.airline_theme = 'bubblegum'
vim.g.airline_solarized_bg = 'light'
vim.g.airline_powerline_fonts = false
vim.g.airline_detect_spell = true
vim.g.airline_skip_empty_sections = true
vim.g.airline_inactive_collapse = false
vim.g['airline#extensions#default#section_use_groupitems'] = true
vim.g['airline#extensions#default#layout'] = {
     { 'b', 'a', 'warning', 'error', 'c' },
     { 'x', 'y', 'z' },
}
vim.g['airline#extensions#tabline#enabled'] = true
vim.g['airline#extensions#tabline#tab_nr_type'] = true
vim.g['airline#extensions#tabline#show_tab_nr'] = false
vim.g['airline#extensions#tabline#show_tab_type'] = false
vim.g['airline#extensions#tabline#fnamemod'] = ':t'
vim.g['airline#extensions#tabline#show_close_button'] = false

vim.g.airline_symbols = {
    space = ' ',
    paste = 'PASTE',
    maxlinenr = '',
    dirty = ' [!]',
    crypt = '🔒',
    linenr = '☰ ',
    readonly = '',
    spell = 'SPELL',
    modified = '+',
    notexists = '?',
    keymap = 'Keymap:',
    ellipsis = '...',
    branch = '',
    whitespace = '☲',
    colnr = 'ln'
}
vim.g.airline_filetype_overrides = {
    startify = {'', ''},
}

vim.g['airline#extensions#term#enabled'] = true
vim.g['airline#extensions#nerdtree_status'] = false
vim.g['airline#extensions#scrollbar#enabled'] = false

vim.cmd [[
    function! GetWinnrSymbol(...) abort
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
            let l:fname = l:parent . '/' . expand('%:t')
            return l:fname
        endif
    endfunction

    call airline#parts#define_function('saltor_file', 'GetParentDirWithFile')
    let g:airline_section_c = airline#section#create(['saltor_file'])

    call airline#parts#define_function('winnr', 'GetWinnrSymbol')
    call airline#parts#define_minwidth('winnr', 10)
    let g:airline_section_b = airline#section#create(['winnr'])
]]
