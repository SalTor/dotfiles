command! -bang -nargs=? Rg call saltor#functions#FormatRipgrepFzf(<q-args>, <bang>0)

command! -bang -nargs=* DynamicRg call saltor#functions#DynamicRipgrepFzf(<q-args>, <bang>0)

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    try
        let l:currentBufNum = bufnr("%")
        let l:alternateBufNum = bufnr("#")

        if buflisted(l:alternateBufNum)
            buffer #
        else
            bnext
        endif

        if bufnr("%") == l:currentBufNum
            new
        endif

        if buflisted(l:currentBufNum)
            execute("bdelete! ".l:currentBufNum)
        endif
    catch
        echo 'Trouble closing buffer. Check :messages'
    endtry
endfunction

command! Wclose call <SID>WinClose()
function! <SID>WinClose()
    try
        let l:open_windows = len(nvim_list_wins())

        if &filetype == 'NERDTree'
            :NERDTreeClose
        elseif l:open_windows > 1
            close
        else
            echo 'Not a split.'
        endif
    catch
        echo 'Could not close any further. Check :messages'
    endtry
endfunction
