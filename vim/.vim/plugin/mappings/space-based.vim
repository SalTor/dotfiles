let g:mapleader = ' '
let g:maplocalleader = '\'

let s:local_leader_map = {}

let s:leader_map = {}
let s:leader_map['name'] = 'root'

nnoremap <silent> <Leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <LocalLeader> :<c-u>WhichKey  ','<CR>

" Not neumonic. More like config.
    " Disable Ex mode
    map Q <Nop>

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

    " Disable horizontal line movement -- for the challenge!
    nmap h :echo "Don't use \|h\| for line-wise movement!"<CR>
    nmap l :echo "Don't use \|l\| for line-wise movement!"<CR>

    " Command mode line-movements
    cnoremap <C-a> <Home>
    cnoremap <C-e> <End>

    " Ergonomic horizontal line-movements
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

" Neumonic
    " Applications
    let s:leader_map['a'] = {
        \ 'name': '+applications',
        \ 's': {
        \     'name': '+session',
        \     's': 'save-session-as',
        \     'd': 'delete-session',
        \     'l': 'load-session',
        \ },
        \ 'c': {
        \     'name': '+coc',
        \     'd': 'coc-diagnostics',
        \     'e': 'coc-extensions',
        \     'c': 'coc-commands',
        \     'o': 'coc-outline',
        \     's': 'coc-symbols',
        \     'r': 'coc-restart',
        \ },
        \ }

    nnoremap <silent> <Leader>ass :SSave<CR>
    nnoremap <silent> <Leader>asd :SDelete<CR>
    nnoremap <silent> <Leader>asl :SLoad<CR>
    nnoremap <silent> <Leader>acd :<C-u>CocList diagnostics<CR>
    nnoremap <silent> <Leader>ace :<C-u>CocList extensions<CR>
    nnoremap <silent> <Leader>acc :<C-u>CocList commands<CR>
    nnoremap <silent> <Leader>aco :<C-u>CocList outline<CR>
    nnoremap <silent> <Leader>acs :<C-u>CocList -I symbols<CR>
    nnoremap <silent> <Leader>acr :CocRestart<CR>

    " Buffer / Tabs
    let s:leader_map[';'] = 'buffer-list'
    let s:leader_map['b'] = {
        \ 'name': '+buffers',
        \ ';': 'buffers-list',
        \ 'd': 'unload-buffer',
        \ 'h': 'home-buffer',
        \ }
    nnoremap <silent> [b :bprevious<CR>
    nnoremap <silent> ]b :bnext<CR>
    nnoremap <silent> <Leader>; :Buffers<CR>
    nnoremap <silent> <Leader>b; :Buffers<CR>
    nnoremap <silent> <Leader>bd :bd<CR>
    nnoremap <silent> <Leader>bh :Startify<CR>

    " Colors
    nnoremap <silent> <Leader>Cl :Colors<CR>

    " Jumps + EasyMotion.vim
    let s:leader_map['j'] = {
        \ 'name': '+jumps/easymotion',
        \ 's': 'to-char',
        \ 'w': 'to-word',
        \ 'f': 'to-char (line-wise)',
        \ 't': 'to-char (line-wise)',
        \ 'n': 'next',
        \ 'N': 'prev',
        \ }
    nmap <Leader>js <Plug>(easymotion-s)
    nmap <Leader>jw <Plug>(easymotion-bd-w)
    nmap <Leader>jf <Plug>(easymotion-bd-fl)
    nmap <Leader>jt <Plug>(easymotion-bd-tl)
    nmap <Leader>jn <Plug>(easymotion-next)
    nmap <Leader>jN <Plug>(easymotion-prev)

    " Errors
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)
    nnoremap <silent> <Leader>en :ALENextWrap<CR>
    nnoremap <silent> <Leader>ep :ALEPreviousWrap<CR>

    " File
    let s:leader_map['f'] = {
        \ 'name': '+file',
        \ ',': 'which_key_ignore',
        \ '.': {
        \     'name': '+cwd',
        \     'f': 'explore-files-current-dir-in-gui',
        \     's': 'save-current-file',
        \ },
        \ 'f': 'file-finder',
        \ 'g': 'git-status-list',
        \ 'r': 'recent-files',
        \ 's': 'save-all-files',
        \ 'e': 'explore-files-in-gui',
        \ 'j': 'jump-to-current-file',
        \ '5': 'source-file',
        \ 'y': 'echo-file-path',
        \ 'R': 'rename-file',
        \ 'M': 'move-file',
        \ }

    nnoremap <silent> <Leader>fg :GFiles?<CR>
    nnoremap <silent> <Leader>ff :call saltor#functions#file_finder()<CR>
    nnoremap <silent> <Leader>fr :History<CR>
    nnoremap <silent> <Leader>fs :wa<CR>
    nnoremap <silent> <Leader>fe :call saltor#mappings#plugin_related#nerdtree_open()<CR>
    nnoremap <silent> <Leader>fj :NERDTreeFind<CR>
    nnoremap <silent> <Leader>f5 :so %<CR>
    nnoremap <silent> <Leader>fy :echo expand('%p')<CR>
    nnoremap <Leader>fR :call saltor#functions#file_rename()<CR>
    nnoremap <Leader>fM :call saltor#functions#file_move()<CR>
    nnoremap <silent> <Leader>f.f :call saltor#functions#file_explorer(expand('%:p:h'))<CR>
    nnoremap <silent> <Leader>f.s :w<CR>

    let s:leader_map[','] = 'file-finder'
    nnoremap <silent> <Leader>, :call saltor#functions#file_finder()<CR>

    " Location list
    nnoremap <silent> [l :lprev<CR>
    nnoremap <silent> ]l :lnext<CR>
    nnoremap <silent> <Leader>lo :lopen<CR>
    nnoremap <silent> <Leader>lc :lclose<CR>

    " Page (scrolling)
    nnoremap [p <C-u>
    nnoremap ]p <C-d>

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
    vnoremap <silent> <Leader>sf y/<C-R>"<CR>
    nnoremap <silent> <leader>sc :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
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

    " Variable / method signatures
    nmap <silent> <Leader>vd <Plug>(coc-definition)
    nmap <silent> <Leader>vy <Plug>(coc-type-definition)
    nmap <silent> <Leader>vi <Plug>(coc-implementation)
    nmap <silent> <Leader>vR <Plug>(coc-references)
    nmap <Leader>vr <Plug>(coc-rename)
    nnoremap <silent> <Leader>vk :call saltor#functions#show_documentation()<CR>

    " Windows
    nmap <silent> <Leader>ww <Plug>(choosewin)
    nnoremap <silent> <Leader>wq :q<CR>
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
    let s:leader_map['<Tab>'] = 'alternate-file'
    nnoremap <silent> <Leader>qv :qa<CR>
    nnoremap <Leader><Tab> <C-^>

let g:saltor#map#leader#desc = s:leader_map
let g:saltor#map#localleader#desc = s:local_leader_map
