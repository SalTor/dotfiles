let g:mapleader = ' '
let g:maplocalleader = '\'

" Not neumonic. More like config.
    " Disable Ex mode
    map Q <Nop>

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

    " Remap ; to : for easier command access
    nnoremap ; :
    nnoremap : ;
    vnoremap ; :
    vnoremap : ;

" [/] bi-directional mappings
    " Lines (whitespace)
        " [emptyLineOnPreviousLine
        nnoremap <silent> [<space> :pu! _<CR>:']+1<CR>
        " ]emptyLineOnNextLine
        nnoremap <silent> ]<space> :pu  _<CR>:'[-1<CR>

" Neumonic
    " Applications
    nnoremap <silent> <Leader>ass :SSave<CR>
    nnoremap <silent> <Leader>asd :SDelete<CR>
    nnoremap <silent> <Leader>asl :SLoad<CR>

    " Book_marks_
    nnoremap <silent> <Leader>Bl :Marks<CR>

    " Buffer / Tabs
    nnoremap <silent> [b :bprevious<CR>
    nnoremap <silent> ]b :bnext<CR>
    nnoremap <silent> <Leader>bp :bprevious<CR>
    nnoremap <silent> <Leader>bn :bnext<CR>
    nnoremap <silent> <Leader>bj :tabprevious<CR>
    nnoremap <silent> <Leader>bk :tabnext<CR>
    nnoremap <silent> <Leader>bd :bd<CR>
    nnoremap <silent> <Leader>bb :Buffers<CR>
    nnoremap <silent> <Leader>bY mkggVGY`k
    nnoremap <silent> <Leader>bh :Startify<CR>

    " Colors
    nnoremap <silent> <Leader>Cl :Colors<CR>
    nnoremap <silent> <Leader>CR :syntax sync fromstart<CR>
    " ^ Fix (most) syntax highlighting problems in current buffer (mnemonic: coloring)

    " Errors
    nnoremap <silent> <Leader>en :ALENextWrap<CR>
    nnoremap <silent> <Leader>ep :ALEPreviousWrap<CR>
    nnoremap <silent> <Leader>el :lopen<CR>

    " File
    nnoremap <silent> <Leader>fs :wa<CR>
    nnoremap <silent> <Leader>ff :call saltor#functions#file_finder()<CR>
    nnoremap <silent> <Leader>f? :GFiles?<CR>
    nnoremap <silent> <Leader>fr :History<CR>
    nnoremap <silent> <Leader>fe :call saltor#mappings#plugin_related#nerdtree_open()<CR>
    nnoremap <silent> <Leader>fj :NERDTreeFind<CR>
    nnoremap <silent> <Leader>f5 :so %<CR>
    nnoremap <silent> <Leader>fy :echo expand('%p')<CR>
    nnoremap <Leader>fR :call saltor#functions#file_rename()<CR>
    nnoremap <Leader>fM :call saltor#functions#file_move()<CR>

    nnoremap <silent> <Leader>f.f :call saltor#functions#file_explorer(expand('%:p:h'))<CR>
    nnoremap <silent> <Leader>f.s :w<CR>
    nnoremap <Leader>f. <nop>


    " Page (scrolling)
    nnoremap [p <C-u>
    nnoremap ]p <C-d>

    " Quit
    nnoremap <Leader>qq :q<CR>
    nnoremap <Leader>qQ :qa<CR>

    " Quickfix list
    nnoremap <silent> [q :cprevious<CR>
    nnoremap <silent> ]q :cnext<CR>
    nnoremap <Leader>qo :copen<CR>
    nnoremap <Leader>qc :cclose<CR>

    " Search
    nnoremap <Leader>sp :DynamicRg<CR>
    nnoremap <Leader>sP :Rg<Space>
    vnoremap <silent> <Leader>sp y/<C-R>"<CR>:Rg<Space><C-R>"<CR>
    vnoremap <silent> <Leader>sP y/<C-R>"<CR>:DynamicRg<Space><C-R>"<CR>
    vnoremap <Leader>sr y :%s/<C-r>"//gc<Left><Left><Left>
    nnoremap <silent> <Leader>sf :Lines<CR>
    vnoremap <silent> <Leader>sf y/<C-R>"<CR>
    nnoremap <silent> <Leader>sc :nohl<CR>
    nnoremap <silent> <Leader>sot :Rg TODO<CR>

    " Spelling
    nnoremap <silent> z= :call saltor#functions#FzfSpell()<CR>

    " Terminal
    tnoremap <A-[> <Esc>
    tnoremap <C-\> <C-\><C-\>
    nnoremap <silent> <Leader>T/ :vertical Topen<CR><C-w>l:startinsert!<CR>
    nnoremap <silent> <Leader>T- :belowright Topen<CR><C-w>j:startinsert!<CR>
    nnoremap <silent> <Leader>Tt :tab Topen<CR>gt:startinsert!<CR>
    nnoremap <silent> <Leader>Tc :Tclose<CR>

    " Text
    vnoremap <silent> <Leader>xs !sort<CR>
    nnoremap <silent> <Leader>xt :%!column -t<CR>
    vnoremap <silent> <Leader>xt :!column -t<CR>

    " Toggle
    nnoremap <silent> <Leader>tS :call saltor#mappings#leader#cycle_spellcheck()<CR>
    nnoremap <silent> <Leader>tN :call saltor#mappings#leader#cycle_numbering()<CR>

    " Windows
    nnoremap <silent> <Leader>wh <C-w>h
    nnoremap <silent> <Leader>wl <C-w>l
    nnoremap <silent> <Leader>wj <C-w>j
    nnoremap <silent> <Leader>wk <C-w>k
    nnoremap <silent> <Leader>w/ :vsp<CR>
    nnoremap <silent> <Leader>w- :sp<CR>
    nnoremap <silent> <Leader>wd :q<CR>
    nnoremap <silent> <Leader>wr <C-w>r
    nnoremap <silent> <Leader>w= <C-w>=
    nnoremap <silent> <C-h> <C-w>h
    nnoremap <silent> <C-l> <C-w>l
    nnoremap <silent> <C-j> <C-w>j
    nnoremap <silent> <C-k> <C-w>k

    " * Miscellaneous
    nnoremap <silent> <Leader>u :undo<CR>
    nnoremap <silent> <Leader>r :redo<CR>
    nnoremap <Leader><Tab> <C-^>
