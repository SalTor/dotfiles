" Vim. Live it.
nnoremap <up> <Nop>
inoremap <up> <Nop>
vnoremap <up> <Nop>
nnoremap <down> <Nop>
inoremap <down> <Nop>
vnoremap <down> <Nop>
nnoremap <left> <Nop>
inoremap <left> <Nop>
vnoremap <left> <Nop>
nnoremap <right> <Nop>
inoremap <right> <Nop>
vnoremap <right> <Nop>

" Move to the start of line
nnoremap H ^

" Move to the end of line
nnoremap L $

" Redo
nnoremap U <C-r>

" Better yank operation
noremap Y y$

" Disable Ex mode
map Q <Nop>

" Command mode line-movements
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Move along wrapped lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Move lines around
xnoremap <silent> K :call saltor#mappings#visual#move_up()<CR>
xnoremap <silent> J :call saltor#mappings#visual#move_down()<CR>

" Apply last-used macro to selected lines
xnoremap @ :<C-u>call saltor#mappings#visual#ExecuteMacroOverVisualRange()<CR>

" Remap n and N so that they go forward + backward respectively regardless
" of whether you searched with ? or /
nnoremap <expr> n 'Nn'[v:searchforward]
xnoremap <expr> n 'Nn'[v:searchforward]
onoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]
xnoremap <expr> N 'nN'[v:searchforward]
onoremap <expr> N 'nN'[v:searchforward]

" Add empty lines
nnoremap <silent> [<space> :<c-u>pu! =repeat(nr2char(10), v:count1)<CR>:']+=v:count1-1<CR>
nnoremap <silent> ]<space> :<c-u>pu  =repeat(nr2char(10), v:count1)<CR>:'[-=v:count1-1<CR>

" Terminal
tnoremap <A-[> <Esc>
tnoremap <C-\> <C-\><C-\>

" Spelling
nnoremap <silent> z= :call saltor#functions#FzfSpell()<CR>

" Page (scrolling)
nnoremap [p <C-u>
nnoremap ]p <C-d>

" Errors
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Buffers
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
