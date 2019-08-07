let g:airline_theme = 'bubblegum'
let g:airline_section_b = ''
let g:airline_section_c = '%t'
let g:airline_filetype_overrides = {
    \ 'nerdtree': [ get(g:, 'NerdTreeStatusline', 'File Explorer'), '' ],
    \ }
