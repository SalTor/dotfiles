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
nnoremap <silent> <Leader>, :Telescope git_files<CR>

let s:leader_map['h'] = {
    \ 'name': '+help',
    \ 'i': '<Plug>(fzf-maps-i)',
    \ 'x': '<Plug>(fzf-maps-x)',
    \ 'o': '<Plug>(fzf-maps-o)',
    \ }
nnoremap <silent> <Leader>hh :Helptags<CR>
nmap <Leader>hn <Plug>(fzf-maps-n)
nnoremap <Leader>hi :call fzf#vim#maps('i', 0)<CR>
nnoremap <Leader>hx :call fzf#vim#maps('x', 0)<CR>
nnoremap <Leader>ho :call fzf#vim#maps('o', 0)<CR>

" Applications
let s:leader_map['a'] = {
    \ 'name': '+applications',
    \ 'c': {
        \ 'name': '+coc',
        \ 'd': [':CocList diagnostics'   , 'diagnostics'],
        \ 'e': [':CocList extensions'    , 'extensions'],
        \ 'c': [':CocList commands'      , 'commands'],
        \ 'o': [':CocList outline'       , 'outline'],
        \ 's': [':CocList -I symbols'    , 'symbols'],
        \ },
    \ 'p': {
        \ 'name': '+vim-plug',
        \ 'c': 'plug-clean',
        \ 'i': 'plug-install',
        \ 'u': [':PlugUpdate', 'plug-update'],
        \ },
    \ 's': {
        \ 'name': '+sessions',
        \ 's': [':SSave'         , 'save-session-as'],
        \ 'd': [':SDelete'       , 'delete-session'],
        \ 'l': [':SLoad'         , 'load-session'],
        \ },
    \ }
    nnoremap <silent> <Leader>api :so $MYVIMRC<CR>:PlugInstall<CR>
    nnoremap <silent> <Leader>apc :so $MYVIMRC<CR>:PlugClean<CR>

" Buffer / Tabs
let s:leader_map['b'] = {
    \ 'name': '+buffers',
    \ 'd': 'close-buffer',
    \ 'h': [':Startify'      , 'home-buffer'],
    \ ';': [':Buffers'       , 'list-buffers']
    \ }
    nnoremap <silent> <Leader>bd :bp<bar>sp<bar>bn<bar>bd<CR>

let s:leader_map['c'] = {
    \ 'name': '+comments',
    \ 'c': 'toggle-comment'
    \ }
    nmap <leader>cc <plug>NERDCommenterToggle
    xmap <leader>cc <plug>NERDCommenterToggle

" Colors
let s:leader_map['C'] = {
    \ 'name': '+colors',
    \ 'l': [':Colors', 'list'],
    \ 'r': 'refresh',
    \ }
    nnoremap <silent> <Leader>Cr :diffupdate<CR>:syntax sync fromstart<CR>:echo 'Syntax Refreshed'<CR>

" File
let s:leader_map['f'] = {
    \ 'name': '+file',
    \ '.': {
    \     'name': '+cwd/current-file',
    \     'f': [':call saltor#functions#file_explorer(expand("%:p:h"))', 'fzf-cwd'],
    \     's': [':w', 'save-current-file'],
    \ },
    \ 'g': [':GFiles?', 'fzf-gfiles?'],
    \ 'e': [':call saltor#mappings#plugin_related#nerdtree_open()', 'nerdtree'],
    \ 'j': [':NERDTreeFind', 'jump-to-current-file'],
    \ '5': [':so %', 'source-file'],
    \ 'R': [':call saltor#functions#file_rename()', 'rename-file'],
    \ 'M': [':call saltor#functions#file_move()', 'move-file'],
    \ 'Y': ['mzggVGy`z', 'copy-contents'],
    \ 't': [':Telescope builtin', 'telescope-commands'],
    \ 's': 'save-all-files',
    \ 'y': 'echo-file-path',
    \ }
    nnoremap <silent> <Leader>fs :w<CR>:wa<CR>
    nnoremap <silent> <Leader>fy :echo expand('%p')<CR>

" Quick-fix lists
let s:leader_map['o'] = {
    \ 'name': '+open',
    \ 'l': 'location-list',
    \ 'q': 'quick-fix-list',
    \ }
    nnoremap <silent> <Leader>ol :lopen<CR>
    nnoremap <silent> <Leader>oq :copen<CR>

let s:leader_map['r'] = {
    \ 'name': '+repl',
    \ 'f': 'repl-send-file',
    \ 's': 'repl-send-region',
    \ 'l': 'repl-send-line',
    \ }
    nnoremap <Leader>rf :TREPLSendFile<CR>
    xnoremap <Leader>rs :TREPLSendSelection<CR>
    nnoremap <Leader>rl :TREPLSendLine<CR>

" Search
let s:leader_map['s'] = {
    \ 'name': '+search',
    \ 'p': '[NV] project-search dynamic',
    \ 'P': '[NV] project-search static',
    \ 'r': '[NV] replace-cword global ',
    \ 'f': '[NV] replace-cword local ',
    \ 'c': '[N-] clear-highlights',
    \ 't': '[N-] find-todos',
    \ }
    nnoremap <silent> <Leader>sp :DynamicRg <CR>
    xnoremap <silent> <Leader>sp y:Rg<Space><C-R>"<CR>
    nnoremap <Leader>sP :Rg<Space>
    xnoremap <silent> <Leader>sP y:DynamicRg<Space><C-R>"<CR>

    nnoremap <silent> <Leader>sc :nohlsearch<cr>
    nnoremap <silent> <Leader>st :Rg TODO<CR>

    nnoremap <silent> <Leader>sr :CocSearch <C-R>=expand("<cword>")<CR><CR>
    xnoremap <Leader>sr y:CocSearch <C-R>"<CR>
    nnoremap <Leader>sf y:%s/<C-R>=expand("<cword>")<CR>//gc<Left><Left><Left>
    xnoremap <Leader>sf y:%s/<C-R>"//gc<Left><Left><Left>

" Terminal
let s:leader_map['t'] = {
    \ 'name': '+terminal/tmux',
    \ '/': 'new-terminal-vertical',
    \ '-': 'new-terminal-horizontal',
    \ 't': 'new-terminal-window',
    \ 'n': 'new-tmux-window',
    \ 's': 'new-tmux-split-vertical',
    \ 'v': 'new-tmux-split-horizontal',
    \ }
    nnoremap <silent> <Leader>t/ :vertical Topen<CR><C-w>l:startinsert!<CR>
    nnoremap <silent> <Leader>t- :belowright Topen<CR><C-w>j:startinsert!<CR>
    nnoremap <silent> <Leader>tt :Topen<CR>i
    nnoremap <Leader>tn :!tmux new-window<CR><CR>
    nnoremap <Leader>ts :!tmux split-window -v<CR><CR>
    nnoremap <Leader>tv :!tmux split-window -h<CR><CR>

" Toggle
let s:leader_map['T'] = {
    \ 'name': '+toggle',
    \ 's': 'spell-check',
    \ 'n': 'cycle-line-numbering',
    \ 'h': 'highlight',
    \ 'c': 'colorcolumn',
    \ 'g': 'git-gutter',
    \ }
    nnoremap <silent> <Leader>Ts :call saltor#mappings#leader#cycle_spellcheck()<CR>
    nnoremap <silent> <Leader>Tn :call saltor#mappings#leader#cycle_numbering()<CR>
    nnoremap <silent> <Leader>Th :call saltor#mappings#leader#cycle_cursor_highlight()<CR>
    nnoremap <silent> <Leader>Tc :call saltor#mappings#leader#cycle_color_column()<CR>
    nnoremap <silent> <Leader>Tg :call saltor#mappings#leader#cycle_git_gutter()<CR>

" Variable / method signatures
let s:leader_map['v'] = {
    \ 'name': '+variables',
    \ 'r': 'rename (local)',
    \ 'p': {
        \ 'r': 'rename (project)',
    \ },
    \ }
    nmap <Leader>vr <Plug>(coc-rename)
    nnoremap <leader>vpr :CocSearch <C-R>=expand("<cword>")<CR><CR>

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
    \ 'w': 'last-window',
    \ }
    nnoremap <silent> <Leader>wq :q<CR>
    nnoremap <silent> <Leader>ww <C-w>w
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
    \ 'w': 'quit-window',
    \ 'q': 'quit-all',
    \ }
    nnoremap <Leader>qw :Wclose<CR>
    nnoremap <Leader>qq :qa<CR>

" Text
let s:leader_map['x'] = {
    \ 'name': '+text',
    \ 's': 'sort-lines [v]',
    \ 't': 'make-columns [nv]',
    \ 'j': 'format-json',
    \ 'f': 'fold',
    \ 'mp': 'markdown-preview',
    \ }
    xnoremap <silent> <Leader>xs !sort<CR>
    xnoremap <silent> <Leader>xt :!column -t<CR>
    nnoremap <silent> <Leader>xt :%!column -t<CR>
    nnoremap <silent> <Leader>xj :%!python -m json.tool<CR>
    nnoremap <silent> <Leader>xmp :InstantMarkdownPreview<CR>
    nnoremap <silent> <Leader>xf za

let g:saltor#map#leader#desc = s:leader_map
call which_key#register('<Space>', 'g:saltor#map#leader#desc')
" Using <Leader> here instead of <Space> renders the menu diferently

" LSP config (the mappings used in the default file don't quite work right)
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <C-n> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <C-p> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
