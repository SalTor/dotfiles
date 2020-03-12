if has('autocmd')
    function! s:AutoCommands()
        augroup Goyo
            function! s:goyo_enter()
                silent !tmux set status off
                silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
                set noshowmode noshowcmd scrolloff=999
                Limelight
            endfunction

            function! s:goyo_leave()
                silent !tmux set status on
                silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
                set showmode showcmd scrolloff=3
                Limelight!
            endfunction

            autocmd! User GoyoEnter nested call <SID>goyo_enter()
            autocmd! User GoyoLeave nested call <SID>goyo_leave()
        augroup END

        augroup CommandMode
            " Quick command mode nnoremap, this is unbound in ftplugin/qf.vim
            nnoremap <CR> :
        augroup END


        augroup AutoNumberToggle
            autocmd!
            function! s:relative_check()
                let l:ignored_buffers = {
                    \ 'help': 1,
                    \ 'neoterm': 1,
                    \ 'nerdtree': 1,
                    \ 'startify': 1,
                    \ }
                if !has_key(l:ignored_buffers, &filetype)
                    setlocal relativenumber
                endif
            endfunction
            autocmd BufEnter,FocusGained,InsertLeave * call <SID>relative_check()
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

        augroup EscapeStuff
            autocmd!
            autocmd FileType fzf tnoremap <silent> <buffer> <Esc> <C-\><C-c>
            autocmd FileType neoterm tnoremap <silent> <buffer> <Esc> <C-\><C-n>
        augroup END

        augroup Buffers
            autocmd!
            autocmd BufNewFile,BufRead * let g:ale_enabled = 1
            autocmd BufNewFile,BufRead *.email set filetype=html
        augroup END

        augroup Spelling
            autocmd!
            autocmd BufNewFile,BufRead *.md setlocal spell spelllang=en_us
            autocmd FileType gitcommit setlocal spell spelllang=en_us
            set complete+=kspell
        augroup END

        augroup Startify
            autocmd!
            autocmd User StartifyReady let g:ale_enabled = 0
        augroup END

        augroup CheckColorScheme
            autocmd!
            autocmd FocusGained * call saltor#functions#CheckColorScheme()
            autocmd InsertLeave,WinEnter * set cursorline
            autocmd InsertEnter,WinLeave * set nocursorline
        augroup END

        " Resize splits when vim container resizes
        autocmd VimResized * execute "normal! \<c-w>="

        " Disable paste mode on leaving insert mode.
        autocmd InsertLeave * set nopaste

        " Change default spelling highlights
        autocmd ColorScheme * call saltor#functions#tweak_colors()

        " Turn off line numbers etc
        autocmd TermOpen * setlocal listchars= nonumber norelativenumber

        " deoplete tab-complete
        autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    endfunction

    call saltor#functions#CheckColorScheme()
    call s:AutoCommands()
endif
