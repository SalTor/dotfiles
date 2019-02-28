" Normal mode mappings

" Toggle fold at current position
nnoremap <Tab> za

" Repeat last macro if in a normal buffer
nnoremap <expr> <CR> empty(&buftype) ? '@@' : '<CR>'

" Avoid unintentional switches to Ex mode
nmap Q q

" Multi-mode mappings (Normal, Visual, Operating-pending modes)
noremap Y y$

" Window Switching
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" Open File Viewer For Sibling Files
nnoremap <silent> - :silent edit <C-R>=empty(expand('%')) ? '.' : expand('%:p:h')<CR><CR>

" No Need For Documentation Heybinding
nnoremap K <nop>

" Store relative line number jumps in the jumplist if they exceed a threshold.
" AKA Only store meaningful ones.
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : ') . 'k')
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : ') . 'j')

" Line Movement Remaps
nnoremap B ^
nnoremap E $
" And unbind their original actions
nnoremap ^ <nop>
nnoremap $ <nop>

" Buffers
nnoremap ;] <esc>:bn<CR>
nnoremap ;[ <esc>:bN<CR>

" Create New Lines
nnoremap <silent> [<space> :pu! _<cr>:']+1<CR>
nnoremap <silent> ]<space> :pu  _<cr>:'[-1<CR>

" Command-mode, rather than <S-;>
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
noremap ;; ;

" Move Between Wrapped Lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Disable Arrow Key Usage
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

" Misc
nnoremap <space>j <nop>
nnoremap <space>k <nop>
