let g:mapleader = ' '

let s:leader_map = {}
let s:leader_map['name'] = 'root'

nnoremap <Leader> :<c-u>WhichKey '<Space>'<CR>

for s:i in range(1, 9)
    let s:leader_map[s:i] = 'window-'.s:i
    execute 'nnoremap <Leader>'.s:i ' :'.s:i.'wincmd w<CR>'
endfor

" Misc / one character
let s:leader_map['<Tab>'] = 'alternate-file'
let s:leader_map[';'] = 'fzf-buffers'
let s:leader_map[','] = 'file-finder'
nnoremap <Leader><Tab> <C-^>
if g:sal_use_telescope == 1
    nnoremap <Leader>; :Telescope buffers<CR>
    nnoremap <Leader>, :Telescope find_files<CR>
else
    nnoremap <Leader>; :Buffers<CR>
    nnoremap <Leader>, :call saltor#functions#file_finder()<CR>
endif

let s:leader_map['h'] = {
    \ 'name': '+help',
    \ 'i': '<Plug>(fzf-maps-i)',
    \ 'x': '<Plug>(fzf-maps-x)',
    \ 'o': '<Plug>(fzf-maps-o)',
    \ }
if g:sal_use_telescope
    nnoremap <Leader>hh :Telescope help_tags<CR>
    nnoremap <Leader>hn :Telescope keymaps<CR>
else
    nnoremap <Leader>hh :Helptags<CR>
    nmap <Leader>hn <Plug>(fzf-maps-n)
    nnoremap <Leader>hi :call fzf#vim#maps('i', 0)<CR>
    nnoremap <Leader>hx :call fzf#vim#maps('x', 0)<CR>
    nnoremap <Leader>ho :call fzf#vim#maps('o', 0)<CR>
endif

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
    nnoremap <Leader>api :so $MYVIMRC<CR>:PlugInstall<CR>
    nnoremap <Leader>apc :so $MYVIMRC<CR>:PlugClean<CR>

" Buffer / Tabs
let s:leader_map['b'] = {
    \ 'name': '+buffers',
    \ 'd': 'close-buffer',
    \ 'h': [':Startify'      , 'home-buffer'],
    \ ';': [':Buffers'       , 'list-buffers']
    \ }
    nnoremap <Leader>bd :bp<bar>sp<bar>bn<bar>bd<CR>

let s:leader_map['c'] = {
    \ 'name': '+comments',
    \ 'c': 'toggle-comment'
    \ }
    nmap <leader>cc <plug>NERDCommenterToggle
    xmap <leader>cc <plug>NERDCommenterToggle
    nmap <leader>ci <plug>NERDCommenterInvert
    xmap <leader>ci <plug>NERDCommenterInvert

" Colors
let s:leader_map['C'] = {
    \ 'name': '+colors',
    \ 'l': [':Colors', 'list'],
    \ 'r': 'refresh',
    \ }
    nnoremap <Leader>Cr :diffupdate<CR>:syntax sync fromstart<CR>:echo 'Syntax Refreshed'<CR>

" File
let s:leader_map['f'] = {
    \ 'name': '+file',
    \ '.': {
    \     'name': '+cwd/current-file',
    \     'f': [':call saltor#functions#file_explorer(expand("%:p:h"))', 'fzf-cwd'],
    \     's': [':w', 'save-current-file'],
    \ },
    \ 'g': 'fzf-gfiles?',
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
    nnoremap <Leader>fs :w<CR>:wa<CR>
    nnoremap <Leader>fy :echo expand('%p')<CR>
    if g:sal_use_telescope
       nnoremap <Leader>fg :Telescope git_files
    else
       nnoremap <Leader>fg :GFiles?<CR>
    endif

" Quick-fix lists
let s:leader_map['o'] = {
    \ 'name': '+open',
    \ 'l': 'location-list',
    \ 'q': 'quick-fix-list',
    \ }
    nnoremap <Leader>ol :call OpenDiagnostics()<CR>
    nnoremap <Leader>oq :copen<CR>

function OpenDiagnostics()
    lua vim.lsp.diagnostic.set_loclist()
    lopen
endfunction

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
    \ 'p': 'project-search dynamic',
    \ 'P': 'project-search static',
    \ 'r': 'replace-cword global ',
    \ 'f': 'replace-cword local ',
    \ 'c': 'clear-highlights',
    \ 't': 'find-todos',
    \ }
    nnoremap <Leader>sp :DynamicRg<CR>
    xnoremap <Leader>sp :lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })<CR>

    nnoremap <Leader>sc :nohlsearch<cr>
    nnoremap <Leader>st :Rg TODO<CR>

    nnoremap <Leader>sf y:%s/<C-R>=expand("<cword>")<CR>//gc<Left><Left><Left>
    xnoremap <Leader>sf y:%s/<C-R>"//gc<Left><Left><Left>

" Terminal
let s:leader_map['t'] = {
    \ 'name': '+terminal/tmux',
    \ '/': 'new-terminal-vertical',
    \ '-': 'new-terminal-horizontal',
    \ 't': 'new-terminal-window',
    \ }
    nnoremap <Leader>t/ :vertical Topen<CR><C-w>l:startinsert!<CR>
    nnoremap <Leader>t- :belowright Topen<CR><C-w>j:startinsert!<CR>
    nnoremap <Leader>tt :Topen<CR>i

" Toggle
let s:leader_map['T'] = {
    \ 'name': '+toggle',
    \ 's': 'spell-check',
    \ 'n': 'cycle-line-numbering',
    \ 'c': 'colorcolumn',
    \ }
    nnoremap <Leader>Ts :call saltor#mappings#leader#cycle_spellcheck()<CR>
    nnoremap <Leader>Tn :call saltor#mappings#leader#cycle_numbering()<CR>
    nnoremap <Leader>Tc :call saltor#mappings#leader#cycle_color_column()<CR>

" Windows
let s:leader_map['w'] = {
    \ 'name': '+windows',
    \ 'o': 'toggle-maximize-window',
    \ 'q': 'quit',
    \ '/': 'split-vertical',
    \ '-': 'split-horizontal',
    \ 'r': 'rotate',
    \ '=': 'equalize',
    \ 'w': 'last-window',
    \ }
    nnoremap <Leader>wh <C-w>h
    nnoremap <Leader>wm <C-w>h
    nnoremap <Leader>wl <C-w>l
    nnoremap <Leader>wi <C-w>l
    nnoremap <Leader>wj <C-w>j
    nnoremap <Leader>wn <C-w>j
    nnoremap <Leader>wk <C-w>k
    nnoremap <Leader>we <C-w>k

    nnoremap <Leader>wq :q<CR>
    nnoremap <Leader>ww <C-w>w
    nnoremap <Leader>w/ :vsp<CR>
    nnoremap <Leader>w- :sp<CR>
    nnoremap <Leader>wo :call saltor#functions#MaximizeToggle()<CR>
    nnoremap <Leader>wr <C-w>r
    nnoremap <Leader>w= <C-w>=

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
    \ 's': 'sort-lines',
    \ 't': 'make-columns',
    \ 'j': 'format-json',
    \ }
    xnoremap <Leader>xs !sort<CR>
    xnoremap <Leader>xt :!column -t<CR>
    nnoremap <Leader>xt :%!column -t<CR>
    nnoremap <Leader>xj :%!python -m json.tool<CR>

let g:saltor#map#leader#desc = s:leader_map
call which_key#register('<Space>', 'g:saltor#map#leader#desc')
" Using <Leader> here instead of <Space> renders the menu diferently
