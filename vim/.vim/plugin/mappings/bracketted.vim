" Add empty lines
nnoremap <silent> [<space> :put!=nr2char(10)<CR>j
nnoremap <silent> ]<space> :put=nr2char(10)<CR>k

" Buffer navigation
nnoremap <silent> [b :bNext<CR>
nnoremap <silent> ]b :bnext<CR>

" Git chunk navigation
nmap <silent> [c <Plug>(GitGutterPrevHunk)
nmap <silent> ]c <Plug>(GitGutterNextHunk)
