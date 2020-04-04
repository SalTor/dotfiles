function! s:AutoCommands()
    augroup YCMOrCOC
        autocmd!
        autocmd FileType javascript :call saltor#functions#tools_use_ycm()
        autocmd FileType scss,sass,css,json :call saltor#functions#tools_use_coc()
    augroup END

    augroup BufPosOfLastEdit
        autocmd!
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    augroup END

    augroup Startify
        autocmd!
        autocmd User StartifyReady let g:ale_enabled = 0
            \| autocmd BufLeave <buffer> let g:ale_enabled = 1
    augroup END

    augroup AutoNumberToggle
        autocmd!
        function! s:relative_check()
            let l:ignored_buffers = {
                \ 'help': 1,
                \ 'neoterm': 1,
                \ 'nerdtree': 1,
                \ 'startify': 1,
                \ 'fzf': 1,
                \ }
            if !has_key(l:ignored_buffers, &filetype)
                set relativenumber
            endif
        endfunction
        autocmd BufEnter,FocusGained,InsertLeave,WinEnter * call <SID>relative_check()
        autocmd BufLeave,FocusLost,InsertEnter,WinLeave * setlocal norelativenumber
    augroup END

    augroup WhichKey
        function! s:init_which_key()
            call which_key#register('<Space>', 'g:saltor#map#leader#desc')
            call which_key#register('\', 'g:saltor#map#localleader#desc')
        endfunction
        autocmd! User vim-which-key call s:init_which_key()
        autocmd! FileType which_key echo "\r"
            \| autocmd BufLeave <buffer> echo "\r"
    augroup END

    augroup CheckColorScheme
        autocmd!
        autocmd FocusGained * call saltor#functions#CheckColorScheme()
        autocmd InsertLeave,WinEnter * set cursorline
        autocmd InsertEnter,WinLeave * set nocursorline
    augroup END

    function! s:handle_resize(...)
        execute "normal! \<c-w>="
        AirlineRefresh!
    endfunction
    " Resize splits when vim container resizes
    autocmd VimResized * call s:handle_resive()

    " Disable paste mode on leaving insert mode.
    autocmd InsertLeave * set nopaste

    " Change default spelling highlights
    autocmd ColorScheme * call saltor#functions#tweak_colors()

    " Turn off line numbers etc
    autocmd TermOpen * setlocal listchars= nonumber norelativenumber

    " deoplete tab-complete
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

    function! s:TrimWhitespace() abort
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfunction
    autocmd BufWritePre * :call <SID>TrimWhitespace()
endfunction

call saltor#functions#CheckColorScheme()
call s:AutoCommands()
