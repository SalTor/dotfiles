" Use letter equivalent
" ) === b
" } === B
" ] === r
" > === a
function! MotionTargets()
    echo '[!] Run cs with bBra instead of )}]>'
endfunction

nnoremap cs) :call MotionTargets()<CR>
nnoremap cs} :call MotionTargets()<CR>
nnoremap cs] :call MotionTargets()<CR>
nnoremap cs> :call MotionTargets()<CR>

xnoremap cs} :call MotionTargets()<CR>
xnoremap cs) :call MotionTargets()<CR>
xnoremap cs] :call MotionTargets()<CR>
xnoremap cs> :call MotionTargets()<CR>

function! SneakTargets()
    echo '[!] Navigate up/down with the <C-u>,<C-d>,<C-b><C-f>,or "s"!'
endfunction

nnoremap { :call SneakTargets()<CR>
nnoremap } :call SneakTargets()<CR>
