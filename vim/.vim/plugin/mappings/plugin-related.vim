" Fuzzy Finder For Files Using FZF
nnoremap <Leader>f :call functions#GFilesWithFallback(0)<CR>
nnoremap <Leader>g :call functions#GFilesWithFallback(1)<CR>
nnoremap <Leader>a :Ag!<Space>
nnoremap <Leader>m :Marks<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <C-f>c  :Commands<CR>

" NERDTree Sidebar
nnoremap <Leader>sf :NERDTreeFind<CR>
nnoremap <LocalLeader>f :call saltor#mappings#plugin_related#nerdtree_open()<CR>

" ALE Linter
nnoremap <LocalLeader>a :ALENextWrap<CR>
