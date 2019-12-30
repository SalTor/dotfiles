" gd -- go to definition
nnoremap <LocalLeader>gd :call LanguageClient#textDocument_definition()<CR>

" K -- keyword lookup
nnoremap <Leader>k :call LanguageClient#textDocument_hover()<CR>

" LanguageClient context menu
nnoremap <LocalLeader>l :call LanguageClient_contextMenu()<CR>
