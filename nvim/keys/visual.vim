" Move VISUAL LINE selection within buffer
xnoremap <silent> K :call saltor#mappings#visual#move_up()<CR>
xnoremap <silent> J :call saltor#mappings#visual#move_down()<CR>

" Make toggling upper/lower case easier
xmap gu g~
xmap gU g~

" Simpler defaults / replacements
xnoremap gh ^
xnoremap gl $

" Increment / decrement numerical values (Accepts counts)
xnoremap + <C-a>
xnoremap - <C-x>
