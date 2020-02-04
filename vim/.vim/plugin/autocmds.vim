if has('autocmd')
    function! s:AutoCommands()
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

        autocmd ColorScheme * highlight clear SpellBad
        autocmd ColorScheme * highlight SpellBad cterm=underline gui=undercurl guibg=#fb4934 guifg=#000000

        " When term starts, auto go into insert mode
        autocmd TermOpen * startinsert

        " Turn off line numbers etc
        autocmd TermOpen * setlocal listchars= nonumber norelativenumber

        autocmd ColorScheme * highlight MyALEErrorColors guifg=#fb4934 guibg=#3c3836
        highlight link ALEVirtualTextError MyALEErrorColors
        highlight link ALEVirtualTextWarning Todo
        highlight link ALEErrorSign MyALEErrorColors

        " deoplete tab-complete
        autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
        inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
        inoremap <silent><expr> <TAB>
                    \ pumvisible() ? "\<C-n>" :
                    \ <SID>check_back_space() ? "\<TAB>" :
                    \ deoplete#manual_complete()
        function! s:check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1] =~ '\s'
        endfunction"}}}
    endfunction

    call saltor#functions#CheckColorScheme()
    call s:AutoCommands()
endif
