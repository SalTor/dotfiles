function s:CheckColorScheme()
    if !has('termguicolors')
        let g:base16colorspace=256
    endif

    let s:config_file = expand('~/.vim/.base16')

    if filereadable(s:config_file)
        let s:config = readfile(s:config_file, '', 2)

        if s:config[1] =~# '^dark\|light$'
            execute 'set background=' . s:config[1]
        else
            echoerr 'Bad background ' . s:config[1] . ' in ' . s:config_file
        endif

        if filereadable(expand('~/.vim/bundle/base16-vim/colors/base16-' . s:config[0] . '.vim'))
            execute 'color base16-' . s:config[0]
        else
            echoerr 'Bad scheme ' . s:config[0] . ' in ' . s:config_file
        endif
    else " default
        set background=dark
        color base16-default-dark
    endif

    " Sync with corresponding non-nvim 'highlight' settings in
    " ~/.vim/plugin/settings.vim:
    highlight clear NonText
    highlight link NonText Conceal
    highlight clear CursorLineNr
    highlight link CursorLineNr DiffText
    highlight clear VertSplit
    highlight link VertSplit LineNr

    " Resolve clashes with ColorColumn.
    " Instead of linking to Normal (which has a higher priority, link to nothing).
    highlight link vimUserFunc NONE
    highlight link NERDTreeFile NONE

    " For Git commits, suppress the background of these groups:
    for l:group in ['DiffAdded', 'DiffFile', 'DiffNewFile', 'DiffLine', 'DiffRemoved']
        let l:highlight=filter(pinnacle#dump(l:group), 'v:key != "bg"')
        execute 'highlight! clear ' . l:group
        execute 'highlight! ' . l:group . ' ' . pinnacle#highlight(l:highlight)
    endfor

    let l:highlight=pinnacle#italicize('ModeMsg')
    execute 'highlight User8 ' . l:highlight

    " Allow for overrides:
    " - `statusline.vim` will re-set User1, User2 etc.
    " - `after/plugin/loupe.vim` will override Search.
    doautocmd ColorScheme
endfunction

if v:progname !=# 'vi'
    if has('autocmd')
        augroup WincentAutocolor
            autocmd!
            autocmd FocusGained * call s:CheckColorScheme()
        augroup END
    endif

    call s:CheckColorScheme()
endif
