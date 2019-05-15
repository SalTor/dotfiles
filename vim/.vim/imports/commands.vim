command! Gbranch call fzf#run(
        \ {
        \ 'source': 'git branch',
        \ 'sink': function('functions#change_branch'),
        \ 'options': '-m',
        \ 'down': '30%'
        \ })

let s:__fzf_ag_options='--filename --only-matching --max-count 1 --silent' " Only show files which contain match(es)
command! -bang -nargs=* Ag
    \ call fzf#vim#ag(<q-args>, s:__fzf_ag_options, fzf#vim#with_preview('right:50%', '?'), <bang>0)

command! -bang -nargs=? GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)

command! -bang -nargs=? Buffers
    \ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
