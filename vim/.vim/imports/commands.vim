command! Gbranch call fzf#run(
            \ {
            \ 'source': 'git branch',
            \ 'sink': function('functions#change_branch'),
            \ 'options': '-m',
            \ 'down': '30%'
            \ })

let s:__fzf_ag_options='--only-matching' " Don't match folder/file names
command! -bang -nargs=* Ag
    \ call fzf#vim#ag(<q-args>, s:__fzf_ag_options, fzf#vim#with_preview('right:50%', '?'))

command! -bang -nargs=? GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)

command! -bang -nargs=? Buffers
    \ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
