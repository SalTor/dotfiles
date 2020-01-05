let g:ale_linters_explicit=1
let g:ale_linters = {
    \ 'javascript': ['eslint'],
    \ 'javascript.jsx': ['eslint'],
    \ 'python': ['pyflakes'],
    \ 'css': ['stylelint'],
    \ 'scss': ['stylelint'],
    \ }

let g:ale_lint_delay=0
let g:ale_lint_on_enter=1
let g:ale_lint_on_save=1
let g:ale_lint_on_text_changed=1
let g:ale_lint_on_insert_leave=1

let g:ale_completion_enabled=0

let g:ale_warn_about_trailing_whitespace=0

autocmd ColorScheme * highlight MyALEErrorColors guifg=#fb4934
highlight link ALEVirtualTextError MyALEErrorColors
highlight link ALEVirtualTextWarning Todo
highlight link ALEErrorSign MyALEErrorColors
