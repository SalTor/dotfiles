" Quick command mode nnoremap, this is unbound in ftplugin/qf.vim
nnoremap <CR> :

" Add empty lines
nnoremap <silent> [<space> :put!=nr2char(10)<CR>j
nnoremap <silent> ]<space> :put=nr2char(10)<CR>k

" Buffer navigation
nnoremap <silent> [b :bNext<CR>
nnoremap <silent> ]b :bnext<CR>

" Make toggling upper/lower case easier
nmap gu g~
nmap gU g~

" Easier matching / line navigation
nnoremap gm *
nnoremap gM #
nnoremap g5 %
nnoremap gh ^
nnoremap gl $

" I think Y should behave like D or C
nnoremap Y y$

" Undo and redo are easier together
nnoremap U <C-r>

" Increment / decrement numerical values (Accepts counts)
nnoremap + <C-a>
nnoremap - <C-x>

" Spelling
nnoremap <silent> z= :call saltor#functions#FzfSpell()<CR>

" Nicer 'only window' operation
nnoremap <silent> <C-W>o :call saltor#functions#MaximizeToggle()<CR>
nnoremap <silent> <C-W>O :call saltor#functions#MaximizeToggle()<CR>
nnoremap <silent> <C-W><C-O> :call saltor#functions#MaximizeToggle()<CR>
