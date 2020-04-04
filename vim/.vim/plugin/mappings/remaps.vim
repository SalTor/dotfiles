" Move a line of text using ALT+[jk] or Command+[jk] on mac
xmap J :m'>+<cr>`<my`>mzgv`yo`z
xmap K :m'<-2<cr>`>my`<mzgv`yo`z

" Simpler defaults / replacements
nnoremap H ^
xnoremap H ^
nnoremap L $
xnoremap L $
nnoremap Y y$
nnoremap U <C-r>

" Command mode line-movements
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Insert mode line-movements
inoremap <C-a> <ESC>I
inoremap <C-e> <ESC>A

" Make toggling upper/lower case easier
nmap gu g~
nmap gU g~
vmap gu g~
vmap gU g~

" Folding
nnoremap <S-Tab> za

" Terminal
tnoremap <A-[> <Esc>
tnoremap <C-\> <C-\><C-\>

" I don't use the default behavior of gm and felt this made more sense.
" mnemonic: Go (to) Match
nnoremap gm *

" Local remaps
iabbrev almashell alma_start_django_shell
