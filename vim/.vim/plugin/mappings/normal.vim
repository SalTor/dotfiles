" Quick command mode nnoremap, this is unbound in ftplugin/qf.vim
nnoremap <CR> :

" Add empty lines
nnoremap <silent> [<space> :put!=nr2char(10)<CR>j
nnoremap <silent> ]<space> :put=nr2char(10)<CR>k

" Buffer navigation
nnoremap <silent> [b :bNext<CR>
nnoremap <silent> ]b :bnext<CR>

" Git chunk navigation
nmap <silent> [c <Plug>(GitGutterPrevHunk)
nmap <silent> ]c <Plug>(GitGutterNextHunk)

" Make toggling upper/lower case easier
nmap gu g~
nmap gU g~

" Simpler defaults / replacements
map gh ^
map gl $
nnoremap Y y$
nnoremap U <C-r>

" Folding
nnoremap <S-Tab> za

" mnemonic: Go (to) Match
nnoremap gm *

" Increment / decrement numerical values (Accepts counts)
nnoremap + <C-a>
nnoremap - <C-x>

" Spelling
nnoremap <silent> z= :call saltor#functions#FzfSpell()<CR>

" Nicer 'only window' operation
nnoremap <silent> <C-W>o :call saltor#functions#MaximizeToggle()<CR>
nnoremap <silent> <C-W>O :call saltor#functions#MaximizeToggle()<CR>
nnoremap <silent> <C-W><C-O> :call saltor#functions#MaximizeToggle()<CR>
