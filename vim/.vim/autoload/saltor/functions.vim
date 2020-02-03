function! saltor#functions#file_finder(...) abort
    let s:is_git_repo = system('git rev-parse --is-inside-work-tree')
    if v:shell_error
        :execute 'Files ' . getcwd()
    else
        :GFiles
    endif
endfunction

function! saltor#functions#FzfSpellSink(word)
    exe 'normal! "_ciw'.a:word
endfunction

function! saltor#functions#FzfSpell()
    let suggestions = spellsuggest(expand("<cword>"))
    return fzf#run({ 'source': suggestions, 'sink': function("saltor#functions#FzfSpellSink"), 'down': '25%', 'options': '--preview ""' })
endfunction

function! saltor#functions#FormatRipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --iglob "!.DS_Store" --iglob "!.git" --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview({}), a:fullscreen)
endfunction

function! saltor#functions#DynamicRipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --iglob "!.DS_Store" --iglob "!.git" --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

function! saltor#functions#CheckColorScheme ()
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

    " Fix base16-vim coloring of xml for my preference. This makes it so
    " ending tag matches color of starting tag. I came across this when
    " editing JSX files
    highlight link xmlEndTag Function

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
