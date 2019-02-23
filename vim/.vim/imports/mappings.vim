" EasyMotion Maps:
" map / <plug>(easymotion-sn)
" map <leader>n <plug>(easymotion-next)
" map <leader>N <plug>(easymotion-prev)
" map <leader><leader>j <plug>(easymotion-j)
" map <leader><leader>k <plug>(easymotion-k)
" map <leader><leader> <plug>(easymotion-prefix)
" map <leader><leader>f <plug>(easymotion-f)
" map <leader><leader>w <plug>(easymotion-w)
" map <leader><leader>t <plug>(easymotion-T)

" Search For Visually Selected Text:
vmap // y/<c-r>"<cr>

" Line Movement Remaps:
nnoremap B ^
nnoremap E $
" And unbind their original actions
nnoremap ^ <nop>
nnoremap $ <nop>

" Edit Vimrc And Zshrc: and load vimrc bindings
nnoremap <leader>ev :tabe ~/.vimrc<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>
nnoremap <leader>ez :tabe ~/.zshrc<cr>
nnoremap <leader>sz :source ~/.zshrc<cr>

" Buffers:
nnoremap ;] <esc>:bn<cr>
nnoremap ;[ <esc>:bN<cr>
nnoremap <leader>cb <esc>:bd<cr>

" Create New Lines:
nnoremap <silent> [<space> :pu! _<cr>:']+1<cr>
nnoremap <silent> ]<space> :pu  _<cr>:'[-1<cr>

" NERDTree Sidebar:
nnoremap <c-n> :NERDTreeToggle<cr>
nnoremap <leader>sf :NERDTreeFind<cr>

" ALE Linter:
nnoremap <leader>a :ALENextWrap<cr>
nnoremap <leader>A :ALEPreviousWrap<cr>

" Fuzzy Finder For Files Using FZF:
nnoremap <space>f :GFiles<cr>
nnoremap <space>b :Buffers!<cr>
nnoremap <space>? :GFiles?<cr>
nnoremap <space>s :Files<cr>
nnoremap <space>a :Ag!<space>
nnoremap <space>m :Marks<cr>

" Command-mode, rather than <S-;>
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
noremap ;; ;

" Move Between Wrapped Lines:
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Window Switching:
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h

" :terminal escape
:tnoremap <esc> <c-\><c-n>

" Disable Arrow Key Usage:
no <down> ddp
no <left> <nop>
no <right> <nop>
no <up> ddkP

ino <down> <esc>ddpi
ino <left> <nop>
ino <right> <nop>
ino <up> <esc>ddkPi

vno <down> <nop>
vno <left> <nop>
vno <right> <nop>
vno <up> <nop>

" Replace:
nnoremap <leader>r :%s/
vnoremap <leader>r y:%s/<c-r>"

" Misc:
vnoremap <leader>s !sort<cr>
nnoremap <leader>h :nohl
nnoremap <leader>d :Dash<space>
nnoremap <space>j <nop>
nnoremap <space>k <nop>

" Marks:
nnoremap <leader>m `

" Smooth Scrolling:
nnoremap <leader>k 5<c-e>
nnoremap <leader>j 5<c-y>
nnoremap <c-u> :call smooth_scroll#up(&scroll*2, 0, 1)<cr>
nnoremap <c-d> :call smooth_scroll#down(&scroll*2, 0, 1)<cr>
