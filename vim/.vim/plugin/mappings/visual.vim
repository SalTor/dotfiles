" Search For Visually Selected Text:
vmap // y/<c-r>"<cr>
vnoremap <leader>s !sort<cr>
vnoremap <Leader>r y:%s/\v<C-R>"
xnoremap @ :<C-u>call mappings#ExecuteMacroOverVisualRange()<CR>

xnoremap <silent> K :call wincent#mappings#visual#move_up()<CR>
xnoremap <silent> J :call wincent#mappings#visual#move_down()<CR>
