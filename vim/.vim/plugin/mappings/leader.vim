" Clear highlight
    nnoremap <silent> <LocalLeader>c :let @/ = ""<CR>

" Close buffer
    nnoremap <Leader>cb :bd<CR>

" Show the path of the current file (mnemonic: path; useful when you have a lot
" of splits and the status line gets truncated)
    nnoremap <LocalLeader>p :echo expand('%')<CR>

" Zap trailing whitespace in the current buffer
    nnoremap <silent> <Leader>zz :call saltor#mappings#leader#zap()<CR>

" Cycle through relative number + number, number (only), and no numbering
" (mnemonic: relative)
    nnoremap <silent> <LocalLeader>r :call saltor#mappings#leader#cycle_numbering()<CR>

" Cycle through spellcheck mode or not
" (mnemonic: spellcheck)
    nnoremap <silent> <LocalLeader>s :call saltor#mappings#leader#cycle_spellcheck()<CR>

" Fix (most) syntax highlighting problems in current buffer (mnemonic: coloring)
    nnoremap <silent> <LocalLeader><LocalLeader>c :syntax sync fromstart<CR>

" Open startify with leader l
    nnoremap <silent> <Leader>l :Startify<CR>
