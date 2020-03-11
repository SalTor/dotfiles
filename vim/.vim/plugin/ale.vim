let g:ale_linters_explicit=1
let g:ale_linters = {
    \ 'javascript': ['eslint'],
    \ 'javascript.jsx': ['eslint'],
    \ 'javascriptreact': ['eslint'],
    \ 'css': ['stylelint'],
    \ 'scss': ['stylelint'],
    \ }
let g:ale_fixers = {
    \ 'javascript': ['prettier'],
    \ 'javascript.jsx': ['prettier'],
    \ 'javascriptreact': ['prettier'],
    \ 'css': ['prettier'],
    \ 'scss': ['prettier'],
    \ }
let g:ale_fix_on_save=1

let g:ale_sign_error=''
let g:ale_sign_warning=''
let g:ale_lint_delay=0
let g:ale_lint_on_enter=1
let g:ale_lint_on_save=1
let g:ale_lint_on_text_changed=1
let g:ale_lint_on_insert_leave=1

let g:ale_completion_enabled=0

let g:ale_warn_about_trailing_whitespace=0
