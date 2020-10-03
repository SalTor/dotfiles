function! saltor#mappings#plugin_related#nerdtree_open() abort
    if exists("g:NERDTree")
        if g:NERDTree.IsOpen()
            :NERDTreeClose
        else
            :NERDTreeFocus
        endif
    else
        :NERDTreeToggle
    endif
endfunction
