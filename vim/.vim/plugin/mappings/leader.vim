let g:mapleader = ' '

let s:leader_map = {}
let s:leader_map['name'] = 'root'

nnoremap <silent> <Leader> :<c-u>WhichKey '<Space>'<CR>

" Applications
let s:leader_map['a'] = {
    \ 'name': '+applications',
    \ 'ss': 'save-session-as',
    \ 'sd': 'delete-session',
    \ 'sl': 'load-session',
    \ 'cd': 'coc-diagnostics',
    \ 'ce': 'coc-extensions',
    \ 'cc': 'coc-commands',
    \ 'co': 'coc-outline',
    \ 'cs': 'coc-symbols',
    \ 'cr': 'coc-restart',
    \ 'pi': 'plug-install',
    \ 'pc': 'plug-clean',
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
    nnoremap <silent> <Leader>api :so ~/.vimrc<CR>:PlugInstall<CR>
    nnoremap <silent> <Leader>apc :so ~/.vimrc<CR>:PlugClean<CR>

" Buffer / Tabs
let s:leader_map[';'] = 'fzf-buffers'
let s:leader_map['b'] = {
    \ 'name': '+buffers',
    \ ';': 'fzf-buffers',
    \ 'd': 'unload-buffer',
    \ 'h': 'home-buffer',
    \ }
    nnoremap <silent> <Leader>; :Buffers<CR>
    nnoremap <silent> <Leader>b; :Buffers<CR>
    nnoremap <silent> <Leader>bd :bd<CR>
    nnoremap <silent> <Leader>bh :Startify<CR>

" Colors
let s:leader_map['C'] = {
    \ 'name': '+colors',
    \ 'l': 'list',
    \ 'r': 'refresh',
    \ }
    nnoremap <silent> <Leader>Cl :Colors<CR>
    nnoremap <silent> <Leader>Cr :diffupdate<CR>:syntax sync fromstart<CR>:echo 'Syntax Refreshed'<CR>

" Jumps + EasyMotion.vim
let s:leader_map['j'] = {
    \ 'name': '+jumps/easymotion',
    \ 's': 'to-char',
    \ 'w': 'to-word',
    \ 'f': 'to-char (line-wise)',
    \ 't': 'to-char (line-wise)',
    \ 'n': 'next-easymotion-match',
    \ 'N': 'prev-easymotion-match',
    \ }
    nmap <Leader>js <Plug>(easymotion-s)
    nmap <Leader>jw <Plug>(easymotion-bd-w)
    nmap <Leader>jf <Plug>(easymotion-bd-fl)
    nmap <Leader>jt <Plug>(easymotion-bd-tl)
    nmap <Leader>jn <Plug>(easymotion-next)
    nmap <Leader>jN <Plug>(easymotion-prev)

    vmap <Leader>js <Plug>(easymotion-s)
    vmap <Leader>jw <Plug>(easymotion-bd-w)
    vmap <Leader>jf <Plug>(easymotion-bd-fl)
    vmap <Leader>jt <Plug>(easymotion-bd-tl)
    vmap <Leader>jn <Plug>(easymotion-next)
    vmap <Leader>jN <Plug>(easymotion-prev)

" Errors
let s:leader_map['e'] = {
    \ 'name': '+errors',
    \ 'n': 'next-error',
    \ 'p': 'prev-error',
    \ }
    nnoremap <silent> <Leader>en :ALENextWrap<CR>
    nnoremap <silent> <Leader>ep :ALEPreviousWrap<CR>

" File
let s:leader_map['f'] = {
    \ 'name': '+file',
    \ ',': 'which_key_ignore',
    \ '.': {
    \     'name': '+cwd/current-file',
    \     'f': 'fzf-cwd',
    \     's': 'save-current-file',
    \ },
    \ 'f': 'fzf-files',
    \ 'g': 'fzf-gfiles?',
    \ 'r': 'fzf-recent',
    \ 's': 'save-all-files',
    \ 'e': 'nerdtree',
    \ 'j': 'jump-to-current-file',
    \ '5': 'source-file',
    \ 'y': 'echo-file-path',
    \ 'R': 'rename-file',
    \ 'M': 'move-file',
    \ }
    nnoremap <silent> <Leader>fg :GFiles?<CR>
    nnoremap <silent> <Leader>ff :call saltor#functions#file_finder()<CR>
    nnoremap <silent> <Leader>fr :ProjectMru<CR>
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

let s:leader_map['g'] = {
    \ 'name': '+git/fugitive',
    \ 'd': 'git-diff',
    \ 'b': 'git-blame',
    \ 'c': 'git-commits',
    \ }
    nnoremap <silent> <Leader>gd :Gdiff<CR>
    nnoremap <silent> <Leader>gb :Gblame<CR>
    nnoremap <silent> <Leader>gc :Glog<CR>

" Quick-fix lists
let s:leader_map['o'] = {
    \ 'name': '+open',
    \ 'l': 'location-list',
    \ 'q': 'quick-fix-list',
    \ }
    nnoremap <silent> <Leader>ol :lopen<CR>
    nnoremap <silent> <Leader>oq :copen<CR>

" Search
let s:leader_map['s'] = {
    \ 'name': '+search',
    \ 'p': 'ripgrep',
    \ 'P': 'dynamic-ripgrep',
    \ 'r': 'replace',
    \ 'f': 'find-in-file',
    \ 'c': 'clear-highlights',
    \ 't': 'find-todos',
    \ }
    nnoremap <silent> <Leader>sc :nohlsearch<cr>
    nnoremap <silent> <Leader>st :Rg TODO<CR>
    nnoremap <Leader>sp :DynamicRg<CR>
    nnoremap <Leader>sP :Rg<Space>
    vnoremap <silent> <Leader>sp y:DynamicRg<Space><C-R>"<CR>
    vnoremap <silent> <Leader>sP y:Rg<Space><C-R>"<CR>
    vnoremap <Leader>sr y :%s/<C-r>"//gc<Left><Left><Left>
    vnoremap <silent> <Leader>sf y/<C-R>"<CR>

" Toggle
let s:leader_map['t'] = {
    \ 'name': '+toggle',
    \ 's': 'spell-check',
    \ 'n': 'cycle-line-numbering',
    \ 'g': 'goyo',
    \ }
    nnoremap <silent> <Leader>ts :call saltor#mappings#leader#cycle_spellcheck()<CR>
    nnoremap <silent> <Leader>tn :call saltor#mappings#leader#cycle_numbering()<CR>
    nnoremap <silent> <Leader>tg :Goyo<CR>

" Terminal
let s:leader_map['T'] = {
    \ 'name': '+terminal',
    \ '/': 'term-vertical',
    \ '-': 'term-horizontal',
    \ 't': 'new',
    \ 'c': 'close',
    \ }
    nnoremap <silent> <Leader>T/ :vertical Topen<CR><C-w>l:startinsert!<CR>
    nnoremap <silent> <Leader>T- :belowright Topen<CR><C-w>j:startinsert!<CR>
    nnoremap <silent> <Leader>Tt :tab Topen<CR>gt:startinsert!<CR>
    nnoremap <silent> <Leader>Tc :Tclose<CR>

" Text
let s:leader_map['x'] = {
    \ 'name': '+text',
    \ 's (visual)': 'sort-lines',
    \ 't (visual)': 'make-columns',
    \ 't (normal)': 'make-columns',
    \ 't': 'which_key_ignore',
    \ 'f': 'fold',
    \ }
    vnoremap <silent> <Leader>xs !sort<CR>
    vnoremap <silent> <Leader>xt :!column -t<CR>
    nnoremap <silent> <Leader>xt :%!column -t<CR>
    nnoremap <silent> <Leader>xf za

" Variable / method signatures
let s:leader_map['v'] = {
    \ 'name': '+variables',
    \ 'd': 'coc-definition',
    \ 'i': 'coc-implementation',
    \ 'r': 'coc-rename',
    \ 'R': 'coc-references',
    \ 'k': 'documentation',
    \ }
    nmap <silent> <Leader>vd <Plug>(coc-definition)
    nmap <silent> <Leader>vi <Plug>(coc-implementation)
    nmap <silent> <Leader>vR <Plug>(coc-references)
    nmap <Leader>vr <Plug>(coc-rename)
    nnoremap <silent> <Leader>vk :call saltor#functions#show_documentation()<CR>

" Windows
let s:leader_map['w'] = {
    \ 'name': '+windows',
    \ 'o': 'toggle-maximize-window',
    \ 'w': 'choosewin',
    \ 'q': 'quit',
    \ 'h': 'move-left',
    \ 'l': 'move-right',
    \ 'j': 'move-down',
    \ 'k': 'move-up',
    \ '/': 'split-vertical',
    \ '-': 'split-horizontal',
    \ 'r': 'rotate',
    \ '=': 'equalize',
    \ }
    nmap <silent> <Leader>ww <Plug>(choosewin)
    nnoremap <silent> <Leader>wq :q<CR>
    nnoremap <silent> <Leader>wh <C-w>h
    nnoremap <silent> <Leader>wl <C-w>l
    nnoremap <silent> <Leader>wj <C-w>j
    nnoremap <silent> <Leader>wk <C-w>k
    nnoremap <silent> <Leader>w/ :vsp<CR>
    nnoremap <silent> <Leader>w- :sp<CR>
    nnoremap <silent> <Leader>wo :call saltor#functions#MaximizeToggle()<CR>
    nnoremap <silent> <Leader>wr <C-w>r
    nnoremap <silent> <Leader>w= <C-w>=
    nnoremap <silent> <C-h> <C-w>h
    nnoremap <silent> <C-l> <C-w>l
    nnoremap <silent> <C-j> <C-w>j
    nnoremap <silent> <C-k> <C-w>k

" * Miscellaneous
let s:leader_map['<Tab>'] = 'alternate-file'
    nnoremap <Leader><Tab> <C-^>
    nnoremap <silent> <Leader>qv :qa<CR>

let g:saltor#map#leader#desc = s:leader_map
