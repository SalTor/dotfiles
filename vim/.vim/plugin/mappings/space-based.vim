" Not neumonic. More like config.
    " Ergonomic horizontal line-movements
    nnoremap B ^
    nnoremap E $

    " Better yank operation
    noremap Y y$

    " Move along wrapped lines
    nnoremap <expr> j v:count ? 'j' : 'gj'
    nnoremap <expr> k v:count ? 'k' : 'gk'

    " Toggle fold at current position
    nnoremap <Tab> za

    " Repeat last macro if in a normal buffer
    nnoremap <expr> <CR> empty(&buftype) ? '@@' : '<CR>'

" Neumonic
    " Windows
    nnoremap <Leader>wh <C-w>h
    nnoremap <Leader>wl <C-w>l
    nnoremap <Leader>wj <C-w>j
    nnoremap <Leader>wk <C-w>k

    " Buffer
    nnoremap <Leader>bp :bprevious<CR>
    nnoremap <Leader>bn :bnext<CR>
    nnoremap <Leader>bd :bd<CR>
    nnoremap <Leader>bb :Buffers

    " Bi-directional via [ and ]
        " ALE diagnostics
        nnoremap [a :ALEPreviousWrap<CR>
        nnoremap ]a :ALENextWrap<CR>
        " Tabs
        nnoremap [t gT
        nnoremap ]t gt
        " Lines (whitespace) [emptyLineOnPreviousLine ]emptyLineOnNextLine
        nnoremap [<space> :pu! _<CR>:']+1<CR>
        nnoremap ]<space> :pu  _<CR>:'[-1<CR>
