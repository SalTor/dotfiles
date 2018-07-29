let b:ale_linters = ['pyflakes']
let b:ale_warn_about_trailing_whitespace=0
let b:ale_lint_on_enter=1
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
