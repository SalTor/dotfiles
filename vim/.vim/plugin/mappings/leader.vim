let g:mapleader = ' '

let s:leader_map = {}
let s:leader_map['name'] = 'root'

nnoremap <silent> <Leader> :<c-u>WhichKey '<Space>'<CR>

for s:i in range(1, 9)
    let s:leader_map[s:i] = 'window-'.s:i
    execute 'nnoremap <silent> <Leader>'.s:i ' :'.s:i.'wincmd w<CR>'
endfor

" Misc / one character
let s:leader_map['<Tab>'] = 'alternate-file'
let s:leader_map[';'] = 'fzf-buffers'
let s:leader_map[','] = 'file-finder'
nnoremap <Leader><Tab> <C-^>
nnoremap <silent> <Leader>; :Buffers<CR>
nnoremap <silent> <Leader>, :call saltor#functions#file_finder()<CR>

" Applications
let s:leader_map['a'] = {
    \ 'name': '+applications',
    \ 'ss': 'save-session-as',
    \ 'sd': 'delete-session',
    \ 'sl': 'load-session',
    \ 's': {
        \ 'name': '+sessions',
        \ 's': 'save-session-as',
        \ 'd': 'delete-session',
        \ 'l': 'load-session',
    \ },
    \ 'cd': 'coc-diagnostics',
    \ 'ce': 'coc-extensions',
    \ 'cc': 'coc-commands',
    \ 'co': 'coc-outline',
    \ 'cs': 'coc-symbols',
    \ 'cr': 'coc-restart',
    \ 'cl': 'coc-list',
    \ 'c': {
        \ 'name': '+coc',
        \ 'd': 'coc-diagnostics',
        \ 'e': 'coc-extensions',
        \ 'c': 'coc-commands',
        \ 'o': 'coc-outline',
        \ 's': 'coc-symbols',
        \ 'r': 'coc-restart',
        \ 'l': 'coc-list',
    \ },
    \ 'pi': 'plug-install',
    \ 'pc': 'plug-clean',
    \ 'p': {
        \ 'name': '+vim-plug',
        \ 'i': 'plug-install',
        \ 'c': 'plug-clean',
    \ }
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
    nnoremap <silent> <Leader>acl :CocList --normal<CR>
    nnoremap <silent> <Leader>api :so ~/.vimrc<CR>:PlugInstall<CR>
    nnoremap <silent> <Leader>apc :so ~/.vimrc<CR>:PlugClean<CR>

" Buffer / Tabs
let s:leader_map['b'] = {
    \ 'name': '+buffers',
    \ ';': 'fzf-buffers',
    \ 'd': 'unload-buffer',
    \ 'h': 'home-buffer',
    \ }
    nnoremap <silent> <Leader>b; :Buffers<CR>
    nnoremap <silent> <Leader>bd :bd<CR>
    nnoremap <silent> <Leader>bh :Startify<CR>

" comments
let s:leader_map['c'] = {
            \ 'name': '+comments',
            \ ' ': 'toggle',
            \ '$': 'to-eol',
            \ }

" Colors
let s:leader_map['C'] = {
    \ 'name': '+colors',
    \ 'l': 'list',
    \ 'r': 'refresh',
    \ }
    nnoremap <silent> <Leader>Cl :Colors<CR>
    nnoremap <silent> <Leader>Cr :diffupdate<CR>:syntax sync fromstart<CR>:echo 'Syntax Refreshed'<CR>

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

let s:leader_map['g'] = {
    \ 'name': '+git',
    \ 'd': 'git-diff',
    \ 'b': 'git-blame',
    \ 'c': 'git-commits',
    \ }
    nnoremap <silent> <Leader>gd :Gdiff<CR>
    nnoremap <silent> <Leader>gb :Gblame<CR>
    nnoremap <silent> <Leader>gc :Glog<CR>

" Jumps + EasyMotion.vim
let s:leader_map['j'] = {
    \ 'name': '+jumps/easymoion',
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
    nmap <Leader>jk <Plug>(easymotion-k)
    nmap <Leader>jj <Plug>(easymotion-j)
    nmap <Leader>jn <Plug>(easymotion-next)
    nmap <Leader>jN <Plug>(easymotion-prev)

    vmap <Leader>js <Plug>(easymotion-s)
    vmap <Leader>jw <Plug>(easymotion-bd-w)
    vmap <Leader>jf <Plug>(easymotion-bd-fl)
    vmap <Leader>jt <Plug>(easymotion-bd-tl)
    vmap <Leader>jk <Plug>(easymotion-k)
    vmap <Leader>jj <Plug>(easymotion-j)
    vmap <Leader>jn <Plug>(easymotion-next)
    vmap <Leader>jN <Plug>(easymotion-prev)

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
    nnoremap <silent> <Leader>sf *<C-o>

" Terminal
let s:leader_map['t'] = {
    \ 'name': '+terminal',
    \ '/': 'term-vertical',
    \ '-': 'term-horizontal',
    \ 'n': 'new',
    \ 'c': 'close',
    \ }
    nnoremap <silent> <Leader>t/ :vertical Topen<CR><C-w>l:startinsert!<CR>
    nnoremap <silent> <Leader>t- :belowright Topen<CR><C-w>j:startinsert!<CR>
    nnoremap <silent> <Leader>tn :tab Topen<CR>gt:startinsert!<CR>
    nnoremap <silent> <Leader>tc :Tclose<CR>

" Toggle
let s:leader_map['T'] = {
    \ 'name': '+toggle',
    \ 's': 'spell-check',
    \ 'n': 'cycle-line-numbering',
    \ 'f': 'focus-goyo',
    \ 'h': 'highlight',
    \ 'c': 'colorcolumn',
    \ 'g': 'git-gutter',
    \ }
    nnoremap <silent> <Leader>Ts :call saltor#mappings#leader#cycle_spellcheck()<CR>
    nnoremap <silent> <Leader>Tn :call saltor#mappings#leader#cycle_numbering()<CR>
    nnoremap <silent> <Leader>Tf :Goyo<CR>
    nnoremap <silent> <Leader>Th :call saltor#mappings#leader#cycle_cursor_highlight()<CR>
    nnoremap <silent> <Leader>Tc :call saltor#mappings#leader#cycle_color_column()<CR>
    nnoremap <silent> <Leader>Tg :call saltor#mappings#leader#cycle_git_gutter()<CR>

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
    \ 'a': 'coc-code-action',
    \ 'i': 'coc-implementation',
    \ 'r': 'coc-rename',
    \ 'R': 'coc-references',
    \ 'k': 'documentation',
    \ }
    nmap <silent> <Leader>va <Plug>(coc-codeaction)
    nmap <silent> <Leader>vi <Plug>(coc-implementation)
    nmap <silent> <Leader>vR <Plug>(coc-references)
    nmap <Leader>vr <Plug>(coc-rename)
    nnoremap <silent> <Leader>vk :call saltor#functions#show_documentation()<CR>

" Windows
let s:leader_map['w'] = {
    \ 'name': '+windows',
    \ 'o': 'toggle-maximize-window',
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
let s:leader_map['q'] = {
            \ 'name': '+quit',
            \ 'v': 'quit-vim',
            \ 'w': 'quit-window',
            \ }
    nnoremap <silent> <Leader>qv :qa<CR>
    nnoremap <silent> <Leader>qw :q<CR>

let g:saltor#map#leader#desc = s:leader_map
