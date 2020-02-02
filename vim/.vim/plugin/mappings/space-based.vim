let g:mapleader = ' '
let g:maplocalleader = '\'

" Not neumonic. More like config.
    " Command mode line-movements
    cnoremap <C-a> <Home>
    cnoremap <C-e> <End>

    " Ergonomic horizontal line-movements
    nnoremap B ^
    nnoremap E $

    " Better yank operation
    noremap Y y$

    " Move along wrapped lines
    nnoremap <expr> j v:count ? 'j' : 'gj'
    nnoremap <expr> k v:count ? 'k' : 'gk'

    " Terminal mode escape remaps
    if has('nvim')
        tnoremap <Esc> <C-\><C-n>
        tnoremap <A-[> <Esc>
    endif

    " Toggle fold at current position
    nnoremap <Tab> za

    " Repeat last macro if in a normal buffer
    nnoremap <expr> <CR> empty(&buftype) ? '@@' : '<CR>'

    " Move lines around
    xnoremap <silent> K :call saltor#mappings#visual#move_up()<CR>
    xnoremap <silent> J :call saltor#mappings#visual#move_down()<CR>

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
    nnoremap <Leader>bb :Buffers<CR>

    " File
    nnoremap <Leader>fs :w<CR>
    nnoremap <Leader>fS :wa<CR>
    nnoremap <Leader>ff :execute 'Files ' . getcwd()<CR>
    nnoremap <Leader>fr :History<CR>
    nnoremap <Leader>ft :call saltor#mappings#plugin_related#nerdtree_open()<CR>
    nnoremap <Leader>f/ :Lines<CR>
    nnoremap <Leader>f% :so %<CR>
    nnoremap <Leader>fl :NERDTreeFind<CR>

    " Project
    nnoremap <Leader>pf :GFiles<CR>
    nnoremap <Leader>p/ :Rg<space>
    nnoremap <Leader>p\ :DynamidRg<space>
    vnoremap <Leader>p/ y:Rg<Space><C-R>"<CR>
    vnoremap <Leader>p\ y:DynamicRg<Space><C-R>"<CR>

    " Toggle
    nnoremap <Leader>ts :call saltor#mappings#leader#cycle_spellcheck()<CR>
