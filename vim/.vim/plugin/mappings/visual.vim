" Search For Visually Selected Text:
vmap // y/<c-r>"<cr>
vnoremap <leader>s !sort<cr>
xnoremap @ :<C-u>call mappings#ExecuteMacroOverVisualRange()<CR>

xnoremap <silent> K :call mappings#visual_move_up()<CR>
xnoremap <silent> J :call mappings#visual_move_down()<CR>
