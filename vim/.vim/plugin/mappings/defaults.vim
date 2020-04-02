" Avoid unintentional switches to Ex mode
map Q <Nop>

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

" Increment / decrement numerical values (Accepts counts)
nnoremap + <C-a>
nnoremap - <C-x>
vnoremap + <C-a>
vnoremap - <C-x>

" Use sane regexes
nnoremap / /\v
vnoremap / /\v

" Spelling
nnoremap <silent> z= :call saltor#functions#FzfSpell()<CR>

" Don't move on *
nnoremap * *<C-o>

" Nicer 'only window' operation
nnoremap <silent> <C-W>o :call saltor#functions#MaximizeToggle()<CR>
nnoremap <silent> <C-W>O :call saltor#functions#MaximizeToggle()<CR>
nnoremap <silent> <C-W><C-O> :call saltor#functions#MaximizeToggle()<CR>
