let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 0

let g:Hexokinase_highlighters = ['virtual']
let g:Hexokinase_optInPatterns = [
\     'full_hex',
\     'triple_hex',
\     'rgb',
\     'rgba',
\     'hsl',
\     'hsla',
\     'colour_names'
\ ]
let g:Hexokinase_ftEnabled = ['scss', 'css', 'html', 'javascript', 'javascript.jsx']
let g:Hexokinase_optOutPatterns = [
    \ 'colour_names',
    \ ]

let g:ale_echo_cursor=0
let g:ale_virtualtext_cursor=1
let g:ale_virtualtext_delay=0
let g:ale_set_highlights=1
