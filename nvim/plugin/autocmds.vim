augroup Vim
    autocmd!

    autocmd VimEnter * call saltor#colors#CheckColorScheme()
augroup END

augroup Buffers
    autocmd!

    autocmd BufWritePre * call saltor#utils#TrimWhitespace()
    autocmd BufNewFile,BufRead ~/capsule/consumer-web/{*.ts,*.js,*.tsx,*.jsx} call saltor#capsule#setup()
    autocmd BufNewFile,BufRead ~/capsule/** call saltor#capsule#whitespace()
    autocmd BufEnter github.com_*.txt set filetype=markdown

    autocmd UIEnter * call saltor#autocmds#OnUIEnter(deepcopy(v:event))

    autocmd InsertLeave * if pumvisible() == 0 | pclose | endif
    autocmd InsertLeave * set nopaste " Disable paste mode on leaving insert mode.

    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * call saltor#autocmds#userelativenumber()
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave * setlocal norelativenumber

    autocmd TermOpen * setlocal listchars= nonumber norelativenumber
augroup END

augroup Windows
    autocmd!

    autocmd VimResized * call saltor#autocmds#HandleResize()
augroup END

augroup CheckColorScheme
    autocmd!

    autocmd InsertLeave,WinEnter * set cursorline
    autocmd InsertEnter,WinLeave * set nocursorline
    autocmd ColorScheme * call saltor#colors#tweak_colors()
augroup END

augroup Startify
    autocmd!
    autocmd User StartifyReady let g:ale_enabled = 0
        \| autocmd BufLeave <buffer> let g:ale_enabled = 1
augroup END

augroup WhichKey
    autocmd!
    autocmd FileType which_key echo "\r"
        \| autocmd BufLeave <buffer> echo "\r"
augroup END
