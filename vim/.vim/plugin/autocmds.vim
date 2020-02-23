if has('autocmd')
    function! s:AutoCommands()
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

        augroup NeoVimTerminalEmulator
            autocmd VimEnter * if !empty($NVIM_LISTEN_ADDRESS) && $NVIM_LISTEN_ADDRESS !=# v:servername
                    \ |let g:r=jobstart(['nc', '-U', $NVIM_LISTEN_ADDRESS],{'rpc':v:true})
                    \ |let g:f=fnameescape(expand('%:p'))
                    \ |noau bwipe
                    \ |call rpcrequest(g:r, "nvim_command", "edit ".g:f)
                    \ |call rpcrequest(g:r, "nvim_command", "call lib#SetNumberDisplay()")
                    \ |qa
                    \ |endif
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
