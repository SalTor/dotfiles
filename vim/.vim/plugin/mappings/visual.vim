" Search For Visually Selected Text:
vmap // y/<c-r>"<cr>
vnoremap <leader>s !sort<cr>
xnoremap @ :<C-u>call mappings#ExecuteMacroOverVisualRange()<CR>

xnoremap K :move '<-2<CR>gv=gv
xnoremap J :move '>+1<CR>gv=gv
