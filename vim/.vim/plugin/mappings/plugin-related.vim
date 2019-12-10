" Fuzzy Finder For Files Using FZF
    nnoremap <silent> <Leader>c :Rg<CR>
    nnoremap <silent> <Leader>f :call functions#GFilesWithFallback(0)<CR>
    nnoremap <silent> <Leader>g :call functions#GFilesWithFallback(1)<CR>
    vnoremap <silent> <Leader>c y:Rg<Space><C-R>"<CR>

" NERDTree Sidebar
    nnoremap <Leader>sf :NERDTreeFind<CR>
    nnoremap <silent> <LocalLeader>f :call saltor#mappings#plugin_related#nerdtree_open()<CR>

" ALE Linter
    nnoremap <silent> <LocalLeader>a :ALENextWrap<CR>
