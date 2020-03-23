" Vim. Live it.
nnoremap <up> <Nop>
inoremap <up> <Nop>
vnoremap <up> <Nop>
nnoremap <down> <Nop>
inoremap <down> <Nop>
vnoremap <down> <Nop>
inoremap <left> <Nop>
inoremap <right> <Nop>

" May as well use these for scrolling, to avoid pinky pain
nnoremap <down> <C-d>
nnoremap <up> <C-u>
vnoremap <down> <C-d>
vnoremap <up> <C-u>

" Avoid unintentional switches to Ex mode
map Q <Nop>

" Simpler defaults / replacements
nnoremap H ^
nnoremap L $
nnoremap Y y$
nnoremap U <C-r>

" Increment / decrement numerical values (Accepts counts)
nnoremap + <C-a>
nnoremap - <C-x>
vnoremap + <C-a>
vnoremap - <C-x>

" Command mode line-movements
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Insert mode line-movements
inoremap <C-a> <ESC>I
inoremap <C-e> <ESC>A

" Make toggling upper/lower case easier
nmap gu g~
nmap gU g~
vmap gu g~
vmap gU g~

" Folding
nnoremap <S-Tab> za

" Don't move on *
nnoremap * *<C-o>

" Use sane regexes
nnoremap / /\v
vnoremap / /\v

" Terminal
tnoremap <A-[> <Esc>
tnoremap <C-\> <C-\><C-\>

" Spelling
nnoremap <silent> z= :call saltor#functions#FzfSpell()<CR>

" Nicer 'only window' operation
nnoremap <silent> <C-W>o :call saltor#functions#MaximizeToggle()<CR>
nnoremap <silent> <C-W>O :call saltor#functions#MaximizeToggle()<CR>
nnoremap <silent> <C-W><C-O> :call saltor#functions#MaximizeToggle()<CR>

" Add empty lines
nnoremap <silent> [<space> :pu! _<cr>:']+1<CR>
nnoremap <silent> ]<space> :pu _<cr>:'[-1<CR>

" Buffer navigation
nnoremap <silent> [b :bNext<CR>
nnoremap <silent> ]b :bnext<CR>

nmap <silent> [c <Plug>(GitGutterPrevHunk)
nmap <silent> ]c <Plug>(GitGutterNextHunk)

" coc - Goto definition
nmap <silent> gd <Plug>(coc-definition)

" coc - Diagnostics
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)
