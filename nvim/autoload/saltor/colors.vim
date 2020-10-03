function! saltor#colors#tweak_colors()
    highlight clear SpellBad
    highlight SpellBad cterm=underline gui=undercurl guifg=#fb4934

    highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
    highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

    highlight LineNr    guibg=bg
    highlight VertSplit guibg=bg

    highlight Comment cterm=italic gui=italic

    highlight EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg
    highlight SignColumn  ctermbg=bg ctermfg=bg guibg=bg guifg=bg

    highlight NonText guifg=#83a598
    highlight Whitespace guifg=#83a598

    highlight GitGutterAdd guibg=NONE
    highlight GitGutterChange guibg=NONE
    highlight GitGutterChangeDelete guibg=NONE
    highlight GitGutterDelete guibg=NONE

    " coc.nvim
    highlight CocInfoSign    guifg=#fabd2f guibg=NONE
    highlight CocWarningSign guifg=#fabd2f guibg=NONE
    highlight CocErrorSign   guifg=#fb4934 guibg=NONE

    " ALE
    highlight ALEWarningSign        guifg=#fabd2f guibg=NONE
    highlight ALEErrorSign          guifg=#fb4934 guibg=NONE
    highlight ALEVirtualTextWarning guifg=#fabd2f guibg=NONE
    highlight link ALEVirtualTextError DiffDelete
    highlight link YcmWarningSign ALEWarningSign
    highlight link YcmErrorSign ALEErrorSign

    " vim-which-key
    highlight default WhichKey          guifg=#CEB37E gui=bold
    highlight default WhichKeySeperator guifg=#67B21D
    highlight default WhichKeyGroup     guifg=#A5AEBD gui=italic
    highlight default WhichKeyDesc      guifg=#E38639

    " Resolve clashes with ColorColumn.
    " Instead of linking to Normal (which has a higher priority, link to nothing).
    highlight link vimUserFunc NONE
    highlight link NERDTreeFile NONE
endfunction

function! saltor#colors#CheckColorScheme()
    if !has('termguicolors')
        let g:base16colorspace=256
    endif

    let s:config_file = expand('$NVIM/.base16')

    if filereadable(s:config_file)
        let s:config = readfile(s:config_file, '', 2)

        if s:config[1] =~# '^dark\|light$'
            execute 'set background=' . s:config[1]
        else
            echoerr 'Bad background ' . s:config[1] . ' in ' . s:config_file
        endif

        if filereadable(expand('$NVIM/autoload/plugged/base16-vim/colors/base16-' . s:config[0] . '.vim'))
            execute 'color base16-' . s:config[0]
        else
            echoerr 'Bad scheme ' . s:config[0] . ' in ' . s:config_file
        endif
    else
        set background=dark
        color base16-default-dark
        echo "Config file not found" . s:config
    endif

    " For Git commits, suppress the background of these groups:
    for l:group in ['DiffAdded', 'DiffFile', 'DiffNewFile', 'DiffLine', 'DiffRemoved']
        let l:highlight=filter(pinnacle#dump(l:group), 'v:key != "bg"')
        execute 'highlight! clear ' . l:group
        execute 'highlight! ' . l:group . ' ' . pinnacle#highlight(l:highlight)
    endfor

    let l:highlight=pinnacle#italicize('ModeMsg')
    execute 'highlight User8 ' . l:highlight

    doautocmd ColorScheme
endfunction
