" Normal mode mappings

" Arrow Keys - Disable Usage
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

" Window Switching
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

" Remap gT with gr to avoid using shift for gT
    no gt <nop>
    nnoremap [t gT
    nnoremap ]t gt

" Switch buffers!
    nnoremap <silent> [b :bprevious<CR>
    nnoremap <silent> ]b :bnext<CR>

" Command-mode, rather than <S-;>
    nnoremap ; :
    nnoremap : ;
    vnoremap ; :
    vnoremap : ;
    noremap ;; ;

" Horizontal Line Movement Remaps - And then unbind their original actions
    nnoremap B ^
    nnoremap E $
    nnoremap ^ <nop>
    nnoremap $ <nop>

" Create New Lines
    nnoremap <silent> [<space> :pu! _<cr>:']+1<CR>
    nnoremap <silent> ]<space> :pu  _<cr>:'[-1<CR>

" Move Between Wrapped Lines
nnoremap <silent><expr> j v:count ? 'j' : 'gj'
nnoremap <silent><expr> k v:count ? 'k' : 'gk'

" Toggle fold at current position
    nnoremap <Tab> za

" Multi-mode mappings (Normal, Visual, Operating-pending modes)
    noremap Y y$

" Repeat last macro if in a normal buffer
    nnoremap <expr> <CR> empty(&buftype) ? '@@' : '<CR>'

" No Need For Documentation Heybinding
    nnoremap K <nop>

" Avoid unintentional switches to Ex mode
    nmap Q q
