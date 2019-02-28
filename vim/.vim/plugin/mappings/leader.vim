let mapleader = ','

" <Leader><Leader> -- Open last buffer
nnoremap <Leader><Leader> <C-^>

nnoremap <Leader>o :only<CR>

nnoremap <Leader>q :q<CR>

" Show the path of the current file (mnemonic: path; useful when you have a lot
" of splits and the status line gets truncated)
nnoremap <Leader>p :echo expand('%')<CR>

" Cycle through relative number + number, number (only), and no numbering
" (mnemonic: relative)
nnoremap <silent> <LocalLeader>r :call wincent#mappings#leader#cycle_numbering()<CR>

nnoremap <Leader>w :write<CR>
nnoremap <Leader>x :xit<CR>

" Zap trailing whitespace in the current buffer
nnoremap <silent> <Leader>zz :call wincent#mappings#leader#zap()<CR>

" Fix (most) syntax highlighting problems in current buffer (mnemonic: coloring)
nnoremap <silent> <LocalLeader>c :syntax sync fromstart<CR>

" Edit file, starting in same directory as current file
nnoremap <LocalLeader>e :edit <C-R>=expand('%:p:h') . '/'<CR>

" Buffers
nnoremap <Leader>cb <ESC>:bd<CR>

" Replace
nnoremap <Leader>r :%s/\v
vnoremap <Leader>r y:%s/\v<C-R>"

" Misc
nnoremap <Leader>h :nohl

" Accelerated Vertical Scrolling
nnoremap <Leader>k 5<C-e>
nnoremap <Leader>j 5<C-y>
