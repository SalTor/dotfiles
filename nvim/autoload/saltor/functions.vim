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

function! saltor#functions#file_finder(...) abort
    let s:is_git_repo = system('git rev-parse --is-inside-work-tree')
    if v:shell_error
        :execute 'Files ' . getcwd()
    else
        :GFiles
    endif
endfunction

let s:bin_dir = expand('~/.config/nvim/autoload/plugged/fzf.vim/bin/')
let s:bin = { 'preview': s:bin_dir.'preview.sh' }

function! saltor#functions#file_explorer(path)
    let spec = {
    \ 'options': [
    \ '--preview', fzf#shellescape(s:bin.preview) . ' {}',
    \ '--prompt', 'Folder> ',
    \ ],
    \ }
    call fzf#vim#files(a:path, spec)
endfunction

let g:fzf_rg_fmt=join([
    \ "rg",
    \ "--hidden",
    \ "--line-number --column",
    \ "--smart-case %s || true",
\ ], ' ')

function! saltor#functions#FormatRipgrepFzf(query, fullscreen)
    let initial_command = printf(g:fzf_rg_fmt, shellescape(a:query))
    let spec = {
    \ 'options': [
    \ '--color', 'hl:#fb4934,hl+:#fb4934',
    \ '--preview', fzf#shellescape(s:bin.preview) . ' {}',
    \ '--prompt', 'Find in Files> ',
    \ ]}
    call fzf#vim#grep(initial_command, 1, spec, a:fullscreen)
endfunction

function! saltor#functions#DynamicRipgrepFzf(query, fullscreen)
    let initial_command = printf(g:fzf_rg_fmt, shellescape(a:query))
    let reload_command = printf(g:fzf_rg_fmt, '{q}')
    let spec = {
    \ 'options': [
    \ '--color', 'hl:#fb4934,hl+:#fb4934',
    \ '--query', a:query,
    \ '--bind', 'change:reload:'.reload_command,
    \ '--preview', fzf#shellescape(s:bin.preview) . ' {}',
    \ '--prompt', 'Find in Files> '
    \ ]}
    call fzf#vim#grep(initial_command, 1, spec, a:fullscreen)
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
