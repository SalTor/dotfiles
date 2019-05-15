" Fuzzy Finder For Files Using FZF
nnoremap <silent> <Leader>f :call functions#GFilesWithFallback(0)<CR>
nnoremap <silent> <Leader>g :call functions#GFilesWithFallback(1)<CR>
nnoremap <Leader>a :Ag<Space>
vnoremap <silent> <Leader>a y:Ag<Space><C-R>"<CR>
nnoremap <silent> <Leader>m :Marks<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>l :BLines

" NERDTree Sidebar
nnoremap <Leader>sf :NERDTreeFind<CR>
nnoremap <silent> <LocalLeader>f :call saltor#mappings#plugin_related#nerdtree_open()<CR>

" ALE Linter
nnoremap <silent> <LocalLeader>a :ALENextWrap<CR>
