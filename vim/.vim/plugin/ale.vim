let g:ale_linters_explicit=1
let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'javascript.jsx': ['eslint'],
\ }

let g:ale_lint_delay=0
let g:ale_lint_on_enter=1
let g:ale_lint_on_save=1
let g:ale_lint_on_text_changed=1

let g:ale_completion_enabled=0

let g:ale_warn_about_trailing_whitespace=0

autocmd ColorScheme * highlight MyErrorColor guifg=#fb4934
highlight link ALEVirtualTextError MyErrorColor
highlight link ALEVirtualTextWarning Todo
