" EasyMotion Maps
map / <Plug>(easymotion-sn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader><Leader> <Plug>(easymotion-prefix)

" Buffers
nnoremap [] <Esc>:bn<CR>
nnoremap [p <Esc>:bN<CR>
nnoremap <Leader>cb <Esc>:bd<CR>

" NERDTree sidebar
nnoremap <C-n> :NERDTreeToggle<CR>

" Save
nnoremap <C-s> :w<CR>

" FZF (Fuzzy Finder For Files)
nnoremap <space>f :GFiles<CR>
nnoremap <space>b :Buffers<CR>
nnoremap <space>fs :GFiles?<cr>

" Command-mode, rather than <S-;>
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
noremap ;; ;

" Move between wrapped lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Map ctrl-movement keys to window switching
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" :terminal escape
:tnoremap <Esc> <C-\><C-n>

" More or less disable arrow key usage
no <down> ddp
no <left> <Nop>
no <right> <Nop>
no <up> ddkP

ino <down> <ESC>ddpi
ino <left> <Nop>
ino <right> <Nop>
ino <up> <ESC>ddkPi

vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>
