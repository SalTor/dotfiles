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
