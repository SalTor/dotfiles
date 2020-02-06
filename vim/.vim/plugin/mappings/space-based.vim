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

" [/] bi-directional mappings
    " Lines (whitespace) [emptyLineOnPreviousLine ]emptyLineOnNextLine
    nnoremap <silent> [<space> :pu! _<CR>:']+1<CR>
    nnoremap <silent> ]<space> :pu  _<CR>:'[-1<CR>

" Neumonic
    " Book_marks_
    nnoremap <silent> <Leader>Bl :Marks<CR>

    " Buffer / Tabs
    nnoremap <silent> <Leader>bp :bprevious<CR>
    nnoremap <silent> <Leader>bn :bnext<CR>
    nnoremap <silent> <Leader>bj :tabprevious<CR>
    nnoremap <silent> <Leader>bk :tabnext<CR>
    nnoremap <silent> <Leader>bd :bd<CR>
    nnoremap <silent> <Leader>bb :Buffers<CR>
    nnoremap <silent> <Leader>bY mkggVGY`k
    nnoremap <silent> <Leader>bh :Startify<CR>
    nnoremap <Leader>b <nop>

    " Comments
    nnoremap <Leader>cl :TComment<CR>
    vnoremap <Leader>cl :TComment<CR>

    " Colors
    nnoremap <silent> <Leader>Cl :Colors<CR>
    nnoremap <silent> <Leader>CR :syntax sync fromstart<CR>
    " ^ Fix (most) syntax highlighting problems in current buffer (mnemonic: coloring)
    nnoremap <Leader>C <nop>

    " Errors
    nnoremap <silent> <Leader>en :ALENextWrap<CR>
    nnoremap <silent> <Leader>ep :ALEPreviousWrap<CR>
    nnoremap <silent> <Leader>el :lopen<CR>
    nnoremap <Leader>e <nop>

    " File
    nnoremap <silent> <Leader>fs :wa<CR>
    nnoremap <silent> <Leader>ff :call saltor#functions#file_finder()<CR>
    nnoremap <silent> <Leader>f? :GFiles?<CR>
    nnoremap <silent> <Leader>fr :History<CR>
    nnoremap <silent> <Leader>ft :call saltor#mappings#plugin_related#nerdtree_open()<CR>
    nnoremap <silent> <Leader>f% :so %<CR>
    nnoremap <silent> <Leader>fj :NERDTreeFind<CR>
    nnoremap <silent> <Leader>fy :echo expand('%p')<CR>
    nnoremap <Leader>fR :call saltor#functions#rename()<CR>
    nnoremap <Leader>f <nop>

    nnoremap <silent> <Leader>f.f :execute 'Files ' . expand('%:p:h')<CR>
    nnoremap <silent> <Leader>f.s :w<CR>
    nnoremap <Leader>f. <nop>

    " Project
    nnoremap <Leader>p <nop>

    " Quit
    nnoremap <Leader>qq :q<CR>
    nnoremap <Leader>qQ :qa<CR>
    nnoremap <Leader>q <nop>

    " Search
    nnoremap <Leader>sp :Rg<Space>
    nnoremap <Leader>sP :DynamicRg<Space>
    vnoremap <silent> <Leader>sp y:Rg<Space><C-R>"<CR>
    vnoremap <silent> <Leader>sP y:DynamicRg<Space><C-R>"<CR>
    nnoremap <silent> <Leader>sc :nohl<CR>
    nnoremap <Leader>s <nop>

    " Spelling
    nnoremap <silent> <Leader>Sc :call saltor#functions#FzfSpell()<CR>
    nnoremap <silent> <Leader>Ss :call saltor#functions#FzfSpell()<CR>
    nnoremap <Leader>Sp [s
    nnoremap <Leader>Sn ]s
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
    nnoremap <silent> <Leader>w- :sp<CR>
    nnoremap <silent> <Leader>wd :q<CR>
    nnoremap <Leader>w <nop>
    nnoremap <silent> <C-h> <C-w>h
    nnoremap <silent> <C-l> <C-w>l
    nnoremap <silent> <C-j> <C-w>j
    nnoremap <silent> <C-k> <C-w>k

    " Text
    vnoremap <silent> <Leader>xs !sort<CR>
    vnoremap <Leader>xr y :%s/<C-r>"//gc<Left><Left><Left>
    nnoremap <Leader>xU gU
    vnoremap <Leader>xU gU
    nnoremap <Leader>xu gu
    vnoremap <Leader>xu gu
    nnoremap <Leader>x <nop>
    nnoremap <Leader>xt :%!column -t

    " Miscellaneous
    nnoremap <silent> <Leader>! :terminal<CR>
    nnoremap <Leader><Leader> :
    nnoremap <Leader><Tab> <C-^>
    nnoremap <Leader> <nop>
