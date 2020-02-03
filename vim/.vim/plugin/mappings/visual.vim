" Visual-mode mappings
    " Search For Visually Selected Text
    vmap // y/<C-R>"<CR>

    vnoremap <Leader>s !sort<CR>
    vnoremap <Leader>r y :%s/<C-r>"//gc<Left><Left><Left>

" Select-mode mappings
    xnoremap @ :<C-u>call saltor#mappings#visual#ExecuteMacroOverVisualRange()<CR>

    xnoremap <silent> K :call saltor#mappings#visual#move_up()<CR>
    xnoremap <silent> J :call saltor#mappings#visual#move_down()<CR>
