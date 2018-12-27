" EasyMotion Maps
map / <Plug>(easymotion-sn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)
map <Leader>l <Plug>(easymotion-sl)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader><Leader> <Plug>(easymotion-prefix)

" Search For Visually Selected Text: Recursively uses easymotion-sn /
vmap // y/<C-R>"<CR>

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

" Misc
vnoremap <leader>s !sort<cr>
