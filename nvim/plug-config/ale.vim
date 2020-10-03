let g:ale_sign_warning=''
let g:ale_sign_error=''
let g:ale_completion_enabled=0

let g:ale_linters_explicit=1
let g:aliases={
    \ 'javascript': ['javascript', 'javascript.jsx', 'javascriptreact'],
    \ 'css': ['css', 'scss', 'sass'],
    \ }
let g:ale_linters = {
    \ 'javascript': ['eslint'],
    \ 'typescript': ['eslint'],
    \ }

let g:ale_fix_on_save=1
let g:ale_fixers = {
    \ 'javascript': ['prettier'],
    \ 'javascriptreact': ['prettier'],
    \ 'typescript': ['prettier'],
    \ 'css': ['prettier'],
    \ }

let g:ale_lint_delay=0
let g:ale_lint_on_enter=0
let g:ale_lint_on_save=1
let g:ale_lint_on_insert_leave=1
let g:ale_lint_on_text_changed='normal'

let g:ale_echo_cursor=0
let g:ale_virtualtext_cursor=1
