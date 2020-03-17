" Vim. Live it.
nnoremap <up> <Nop>
inoremap <up> <Nop>
vnoremap <up> <Nop>
nnoremap <down> <Nop>
inoremap <down> <Nop>
vnoremap <down> <Nop>
inoremap <left> <Nop>
inoremap <right> <Nop>

" CoC.nvim
nmap <silent> gd <Plug>(coc-definition)

" Increment / decrement numerical values (Accepts counts)
nnoremap + <C-a>
nnoremap - <C-x>
vnoremap + <C-a>
vnoremap - <C-x>

" Make toggling upper/lower case easier
nmap gu g~
nmap gU g~
vmap gu g~
vmap gU g~

" May as well use these for scrolling, to avoid pinky pain
nnoremap <down> <C-d>
nnoremap <up> <C-u>
vnoremap <down> <C-d>
vnoremap <up> <C-u>

nnoremap <S-Tab> za

" Move to the start of line
nnoremap H ^

" Move to the end of line
nnoremap L $

" Redo
nnoremap U <C-r>

" Better yank operation
noremap Y y$

" Avoid unintentional switches to Ex mode
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

" Use sane regexes
nnoremap / /\v
vnoremap / /\v

" Don't move on *
nnoremap * *<C-o>

" Heresy
inoremap <C-a> <ESC>I
inoremap <C-e> <ESC>A

" Keep search matches in the middle of the window and pule the line when moving to them.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

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

nnoremap <C-W>o :call saltor#functions#MaximizeToggle()<CR>
nnoremap <C-W>O :call saltor#functions#MaximizeToggle()<CR>
nnoremap <C-W><C-O> :call  :call saltor#functions#MaximizeToggle()<CR>
