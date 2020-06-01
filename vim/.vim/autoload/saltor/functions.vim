function! saltor#functions#tweak_colors()
    highlight clear SpellBad
    highlight SpellBad cterm=underline gui=undercurl guifg=#fb4934

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

    " illuminated-word
    highlight illuminatedWord guibg=#414141

    " Resolve clashes with ColorColumn.
    " Instead of linking to Normal (which has a higher priority, link to nothing).
    highlight link vimUserFunc NONE
    highlight link NERDTreeFile NONE
endfunction

function! saltor#functions#MaximizeToggle()
    if exists("s:maximize_session")
        exec "source " . s:maximize_session
        call delete(s:maximize_session)
        unlet s:maximize_session
        let &hidden=s:maximize_hidden_save
        unlet s:maximize_hidden_save
    else
        let s:maximize_hidden_save = &hidden
        let s:maximize_session = tempname()
        set hidden
        exec "mksession! " . s:maximize_session
        only
    endif
endfunction

function! saltor#functions#show_documentation() abort
    try
        if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        else
            call CocAction('doHover')
        endif
    catch
        echo 'No docs found for that.'
    endtry
endfunction

function! saltor#functions#file_explorer(path)
    let spec = {
        \ 'options': [
        \ '--prompt',
        \ 'Folder>'
        \ ]}
    call fzf#vim#files(a:path, spec)
endfunction

function! saltor#functions#file_finder(...) abort
    let s:is_git_repo = system('git rev-parse --is-inside-work-tree')
    if v:shell_error
        :execute 'Files ' . getcwd()
    else
        :GFiles
    endif
endfunction

function! saltor#functions#FzfSpell()
    function! s:FzfSpellSink(word)
        exe 'normal! "_ciw'.a:word
    endfunction

    let l:suggestions = spellsuggest(expand("<cword>"))
    return fzf#run({ 'source': l:suggestions, 'sink': function("s:FzfSpellSink"), 'window': {
        \     'height': 0.5,
        \     'width': 1,
        \     'yoffset': 0,
        \     'highlight': 'PreProc',
        \ }, 'options': '--preview "" --prompt="Spell> " --info=inline' })
endfunction

let s:bin_dir = expand('~/.vim/plugged/fzf.vim/bin/')
let s:bin = {
\ 'preview': s:bin_dir.'preview.sh' }

function! saltor#functions#FormatRipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --iglob "!.DS_Store" --iglob "!.git" --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let spec = {
    \ 'options': [
    \ '--info=inline',
    \ '--preview', fzf#shellescape(s:bin.preview) . ' {}',
    \ '--prompt', 'Find in Files> '
    \ ]}
    call fzf#vim#grep(initial_command, 1, spec, a:fullscreen)
endfunction

function! saltor#functions#DynamicRipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --iglob "!.DS_Store" --iglob "!.git" --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {
    \ 'options': [
    \ '--phony',
    \ '--info=inline',
    \ '--query', a:query,
    \ '--bind', 'change:reload:'.reload_command,
    \ '--preview', fzf#shellescape(s:bin.preview) . ' {}',
    \ '--prompt', 'Find in Files> '
    \ ]}
    call fzf#vim#grep(initial_command, 1, spec, a:fullscreen)
endfunction

function! saltor#functions#CheckColorScheme ()
    if !has('termguicolors')
        let g:base16colorspace=256
    endif

    let s:config_file = expand('$HOME/.vim/.base16')

    if filereadable(s:config_file)
        let s:config = readfile(s:config_file, '', 2)

        if s:config[1] =~# '^dark\|light$'
            execute 'set background=' . s:config[1]
        else
            echoerr 'Bad background ' . s:config[1] . ' in ' . s:config_file
        endif

        if filereadable(expand('$HOME/.vim/plugged/base16-vim/colors/base16-' . s:config[0] . '.vim'))
            execute 'color base16-' . s:config[0]
        else
            echoerr 'Bad scheme ' . s:config[0] . ' in ' . s:config_file
        endif
    else
        set background=dark
        color base16-default-dark
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

function! saltor#functions#file_move()
    :NERDTreeFind
    :call NERDTreeMoveNode()
    :NERDTreeClose
    :filetype detect
endfunction

function! saltor#functions#file_rename()
    let s:is_git_repo = system('git rev-parse --is-inside-work-tree')
    if v:shell_error
        call saltor#functions#file_move()
    else
        let curline = getline('.')
        call inputsave()
        let name = input('Rename file to: ')
        call inputrestore()
        if len(name) > 0
            execute 'Grename ' . name
        else
            echo 'No filename provided.'
        endif
    endif
endfunction

function! saltor#functions#check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction

function! saltor#functions#build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction

function! saltor#functions#CreateFloatingWindow()
    let width = &columns
    let height = &lines / 2
    let top = 0
    let left = 0
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction
