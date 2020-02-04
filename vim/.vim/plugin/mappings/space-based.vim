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

    " Search For Visually Selected Text
    vmap // y/<C-R>"<CR>

    " Toggle fold at current position
    nnoremap <Tab> za

    " Repeat last macro if in a normal buffer
    nnoremap <expr> <CR> empty(&buftype) ? '@@' : '<CR>'

    " Move lines around
    xnoremap <silent> K :call saltor#mappings#visual#move_up()<CR>
    xnoremap <silent> J :call saltor#mappings#visual#move_down()<CR>

    " Apply last-used macro to selected lines
    xnoremap @ :<C-u>call mappings#visual#ExecuteMacroOverVisualRange()<CR>

    " Fix (most) syntax highlighting problems in current buffer (mnemonic: coloring)
    nnoremap <silent> <LocalLeader><LocalLeader>c :syntax sync fromstart<CR>

" [/] bi-directional mappings
    " Tabs
    nnoremap [t gT
    nnoremap ]t gt

    " Lines (whitespace) [emptyLineOnPreviousLine ]emptyLineOnNextLine
    nnoremap <silent> [<space> :pu! _<CR>:']+1<CR>
    nnoremap <silent> ]<space> :pu  _<CR>:'[-1<CR>

" Neumonic
    " Buffer / Tabs
    nnoremap <silent> <Leader>bp :bprevious<CR>
    nnoremap <silent> <Leader>bn :bnext<CR>
    nnoremap <silent> <Leader>bd :bd<CR>
    nnoremap <silent> <Leader>bb :Buffers<CR>
    nnoremap <silent> <Leader>bh :Startify<CR>
    nnoremap <Leader>b <nop>

    " Comments
    nnoremap <Leader>cl :TComment<CR>
    vnoremap <Leader>cl :TComment<CR>

    " Errors
    nnoremap <silent> <Leader>en :ALENextWrap<CR>
    nnoremap <silent> <Leader>ep :ALEPreviousWrap<CR>
    nnoremap <silent> <Leader>el :lopen<CR>
    nnoremap <Leader>e <nop>

    " File
    nnoremap <silent> <Leader>fs :w<CR>
    nnoremap <silent> <Leader>fS :wa<CR>
    nnoremap <silent> <Leader>ff :call saltor#functions#file_finder()<CR>
    nnoremap <silent> <Leader>fr :History<CR>
    nnoremap <silent> <Leader>ft :call saltor#mappings#plugin_related#nerdtree_open()<CR>
    nnoremap <silent> <Leader>f/ :Lines<CR>
    nnoremap <silent> <Leader>f% :so %<CR>
    nnoremap <silent> <Leader>fl :NERDTreeFind<CR>
    nnoremap <Leader>f <nop>

    nnoremap <silent> <Leader>f.f :execute 'Files ' . expand('%:p:h')<CR>
    nnoremap <Leader>f. <nop>

    " Lines
    vnoremap <silent> <Leader>s !sort<CR>
    vnoremap <Leader>r y :%s/<C-r>"//gc<Left><Left><Left>

    " Project
    nnoremap <Leader>p/ :Rg<space>
    vnoremap <silent> <Leader>p/ y:Rg<Space><C-R>"<CR>
    nnoremap <Leader>p\ :DynamicRg<space>
    vnoremap <silent> <Leader>p\ y:DynamicRg<Space><C-R>"<CR>
    nnoremap <Leader>p <nop>

    " Quit
    nnoremap <Leader>qq :q<CR>

    " Search
    nnoremap <silent> <Leader>sc :let @/ = ""<CR>
    nnoremap <Leader>s <nop>

    " Spelling
    nnoremap <silent> <Leader>Sc :call saltor#functions#FzfSpell()<CR>
    nnoremap <silent> <Leader>Ss :call saltor#functions#FzfSpell()<CR>
    nnoremap <Leader>S <nop>

    " Toggle
    nnoremap <silent> <Leader>tS :call saltor#mappings#leader#cycle_spellcheck()<CR>
    nnoremap <silent> <Leader>tN :call saltor#mappings#leader#cycle_numbering()<CR>
    nnoremap <Leader>t <nop>

    " Windows
    nnoremap <silent> <Leader>wh <C-w>h
    nnoremap <silent> <Leader>wl <C-w>l
    nnoremap <silent> <Leader>wj <C-w>j
    nnoremap <silent> <Leader>wk <C-w>k
    nnoremap <silent> <Leader>w/ :vsp<CR>
    nnoremap <silent> <Leader>wd :q<CR>
    nnoremap <Leader>w <nop>
