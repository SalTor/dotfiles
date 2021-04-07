function! saltor#autocmds#HandleResize(...) abort
    " Resize splits when vim container resizes
    execute "normal! \<c-w>="
    AirlineRefresh!
    echo 'Handle Resize'
endfunction

function! saltor#autocmds#OnUIEnter(event) abort
    if saltor#utils#FirenvimIsActive(a:event)
        :AirlineToggle
        nnoremap <buffer> j gj
        nnoremap <buffer> k gk
    endif
endfunction

function! saltor#autocmds#userelativenumber()
    let l:ignored_buffers = {
        \ 'help': 1,
        \ 'neoterm': 1,
        \ 'nerdtree': 1,
        \ 'startify': 1,
        \ 'fzf': 1,
        \ }
    let l:stop = exists('g:sal_norelativenumber') && g:sal_norelativenumber == 1
    if !has_key(l:ignored_buffers, &filetype) && !l:stop
        setlocal relativenumber
    endif
endfunction
