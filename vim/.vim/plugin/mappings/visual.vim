" Move a line of text using ALT+[jk] or Command+[jk] on mac
xmap J :m'>+<cr>`<my`>mzgv`yo`z
xmap K :m'<-2<cr>`>my`<mzgv`yo`z

" Make toggling upper/lower case easier
xmap gu g~
xmap gU g~

" Simpler defaults / replacements
xnoremap H ^
xnoremap L $

" Increment / decrement numerical values (Accepts counts)
xnoremap + <C-a>
xnoremap - <C-x>
