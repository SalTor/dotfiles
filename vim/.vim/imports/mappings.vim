" EasyMotion Maps
map / <Plug>(easymotion-sn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader><Leader> <Plug>(easymotion-prefix)

" Search For Visually Selected Text: Recursively uses easymotion-sn /
vmap // y/<C-R>"<CR>

" Shared Clipboard
vnoremap <C-c> :w !pbcopy<CR><CR>
noremap <D-v> :r !pbpaste<CR><CR>

" Buffers
nnoremap [; <Esc>:bn<CR>
nnoremap [p <Esc>:bN<CR>
nnoremap <Leader>cb <Esc>:bd<CR>

" Create New Lines
nnoremap <silent> [<space> :pu! _<CR>:']+1<CR>
nnoremap <silent> ]<space> :pu  _<CR>:'[-1<CR>

" NERDTree sidebar
nnoremap <C-n> :NERDTreeToggle<CR>

" Save
nnoremap <C-s> :w<CR>

" FZF (Fuzzy Finder For Files)
nnoremap <space>f :GFiles<CR>
nnoremap <space>b :Buffers!<CR>
nnoremap <space>? :GFiles?<CR>
nnoremap <space>s :Files<CR>
nnoremap <space>a :Ag!<space>
nnoremap <space>m :Marks!<CR>

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
