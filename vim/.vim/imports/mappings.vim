" EasyMotion Maps
map / <plug>(easymotion-sn)
map n <plug>(easymotion-next)
map N <plug>(easymotion-prev)
map <leader>l <plug>(easymotion-sl)
map <leader>j <plug>(easymotion-j)
map <leader>k <plug>(easymotion-k)
map <leader><leader> <plug>(easymotion-prefix)

" Search For Visually Selected Text: Recursively uses easymotion-sn /
vmap // y/<c-r>"<cr>

" move to beginning/end of line
nnoremap B ^
nnoremap E $
" $/^ doesn't do anything
nnoremap ^ <nop>
nnoremap $ <nop>

" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp ~/.vimrc<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>
nnoremap <leader>ez :vsp ~/.zshrc<cr>
nnoremap <leader>sz :source ~/.zshrc<cr>

" Shared Clipboard
vnoremap <c-c> "*y
noremap <c-p> "*p

" Buffers
nnoremap ;[ <esc>:bn<cr>
nnoremap ;] <esc>:bN<cr>
nnoremap <leader>cb <esc>:bd<cr>

" Create New Lines
nnoremap <silent> [<space> :pu! _<cr>:']+1<cr>
nnoremap <silent> ]<space> :pu  _<cr>:'[-1<cr>

" NERDTree sidebar
nnoremap <c-n> :NERDTreeToggle<cr>
nnoremap <leader>sf :NERDTreeFind<cr>

" FZF (Fuzzy Finder For Files)
nnoremap <space>f :GFiles<cr>
nnoremap <space>b :Buffers!<cr>
nnoremap <space>? :GFiles?<cr>
nnoremap <space>s :Files<cr>
nnoremap <space>a :Ag!<space>
nnoremap <space>m :Marks!<cr>

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
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h

" :terminal escape
:tnoremap <esc> <c-\><c-n>

" More or less disable arrow key usage
no <down> ddp
no <left> <nop>
no <right> <nop>
no <up> ddkP

ino <down> <esc>ddpi
ino <left> <nop>
ino <right> <nop>
ino <up> <esc>ddkPi

vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>

" Misc
vnoremap <leader>s !sort<cr>
