let mapleader = ','

" <Leader><Leader> -- Open last buffer
nnoremap <Leader><Leader> <C-^>

nnoremap <Leader>o :only<CR>

" Show the path of the current file (mnemonic: path; useful when you have a lot
" of splits and the status line gets truncated)
nnoremap <Leader>p :echo expand('%')<CR>

nnoremap <Leader>q :quit<CR>

" Cycle through relative number + number, number (only), and no numbering
" (mnemonic: relative)
nnoremap <silent> <LocalLeader>r :call mappings#cycle_numbering()<CR>

nnoremap <Leader>w :write<CR>
nnoremap <Leader>x :xit<CR>

" Zap trailing whitespace in the current buffer
nnoremap <silent> <Leader>zz :call mappings#zap()<CR>

" Fix (most) syntax highlighting problems in current buffer (mnemonic: coloring)
nnoremap <silent> <LocalLeader>c :syntax sync fromstart<CR>

" Edit file, starting in same directory as current file
nnoremap <LocalLeader>e :edit <C-R>=expand('%:p:h') . '/'<CR>

" Buffers:
nnoremap <Leader>cb <esc>:bd<cr>

" NERDTree Sidebar:
nnoremap <Leader>sf :NERDTreeFind<cr>

" ALE Linter:
nnoremap <Leader>a :ALENextWrap<cr>
nnoremap <Leader>A :ALEPreviousWrap<cr>

" Replace:
nnoremap <Leader>r :%s/\v
vnoremap <Leader>r y:%s/\v<c-r>"

" Misc:
nnoremap <Leader>h :nohl

" Smooth Scrolling:
nnoremap <Leader>k 5<c-e>
nnoremap <Leader>j 5<c-y>
