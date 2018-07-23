" EasyMotion Maps
nmap / <Plug>(easymotion-sn)
nnoremap  n <Plug>(easymotion-nex)
nnoremap  N <Plug>(easymotion-prev)
map <Leader><Leader> <Plug>(easymotion-prefix)

" Buffers
nnoremap ]b <Esc>:bn<CR>
nnoremap [b <Esc>:bN<CR>
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
map <C-k> <C-w>k
map <C-j> <C-w>j
map <C-l> <C-w>l
map <C-h> <C-w>h

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
