nnoremap <Leader>a :Rg<space>
nnoremap <LocalLeader>a :DynamicRg<space>
nnoremap <silent> <Leader>f :call functions#GFilesWithFallback(0)<CR>
nnoremap <silent> <Leader>g :call functions#GFilesWithFallback(1)<CR>
nnoremap <silent> <Leader>b :Buffers<CR>

vnoremap <silent> <Leader>a y:Rg<Space><C-R>"<CR>

inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')
