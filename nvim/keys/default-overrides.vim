" Vim. Live it.
nnoremap <up> <Nop>
inoremap <up> <Nop>
vnoremap <up> <Nop>
nnoremap <down> <Nop>
inoremap <down> <Nop>
vnoremap <down> <Nop>
inoremap <left> <Nop>
inoremap <right> <Nop>

" well ... May as well use these for scrolling, to avoid pinky pain
nnoremap <down> <C-d>
nnoremap <up> <C-u>
vnoremap <down> <C-d>
vnoremap <up> <C-u>

" Avoid unintentional switches to Ex mode
map Q <Nop>

" Use sane regexes
nnoremap / /\v
vnoremap / /\v

" Documentation
nnoremap <silent> K :call saltor#functions#show_documentation()<CR>
