" EasyMotion Maps
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

map <Leader> <Plug>(easymotion-prefix)

" Toggle NERDTree sidebar
nnoremap <C-n> :NERDTreeToggle<CR>

" Save
nnoremap <C-s> :w<CR>

" FZF (Fuzzy Finder For Files)
nnoremap <C-p> :Files<CR>

" Use ; to enter Command-mode, rather than Shift-;
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
noremap ;; ;

" Move between wrapped lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

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
