if has('autocmd')
    function! s:AutoCommands()
        augroup CommandMode
            " Quick command mode nnoremap
            nnoremap <CR> :

            " In the quickfix window, <CR> is used to jump to the
            " error under the cursor, so undefine the mapping there.
            autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
        augroup END

        augroup WhichKey
            function! s:init_which_key()
                call which_key#register('<Space>', 'g:saltor#map#leader#desc')
                call which_key#register('\', 'g:saltor#map#localleader#desc')
            endfunction
            autocmd! User vim-which-key call s:init_which_key()
        augroup END

        augroup EscapeStuff
            autocmd!
            autocmd FileType nerdtree nnoremap <silent> <buffer> <Esc> :NERDTreeClose<CR>
            autocmd FileType fzf tnoremap <silent> <buffer> <Esc> <C-\><C-c>
            autocmd FileType neoterm tnoremap <silent> <buffer> <Esc> <C-\><C-n>
            autocmd FileType help nnoremap <silent> <buffer> <Esc> :q<CR>
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
        autocmd ColorScheme * highlight clear SpellBad
        autocmd ColorScheme * highlight SpellBad cterm=underline gui=undercurl guibg=#fb4934 guifg=#000000

        " Turn off line numbers etc
        autocmd TermOpen * setlocal listchars= nonumber norelativenumber

        " deoplete tab-complete
        autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    endfunction

    call saltor#functions#CheckColorScheme()
    call s:AutoCommands()
endif
