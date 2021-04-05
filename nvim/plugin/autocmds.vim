augroup Vim
    autocmd!

    autocmd VimEnter * call saltor#colors#CheckColorScheme()
augroup END

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
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
    autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc
augroup END

augroup Windows
    autocmd!

    autocmd VimResized * call saltor#autocmds#HandleResize()
augroup END

augroup Terminal
    autocmd!
    autocmd BufEnter * if &buftype == 'terminal' | setlocal signcolumn=no nonumber norelativenumber | endif
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

augroup EasyMotionWithCoC
    autocmd!
    autocmd User EasyMotionPromptBegin silent! CocDisable
    autocmd User EasyMotionPromptEnd silent! CocEnable
augroup END
