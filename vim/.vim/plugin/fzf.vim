function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_buffers_jump = 1 " Jump to the existing window if possible
let g:fzf_action = {
            \ 'ctrl-q': function('s:build_quickfix_list'),
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

command! -bang -nargs=? -complete=dir GFiles
            \ call fzf#vim#gitfiles(<q-args>, {}, <bang>0)

command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, {}, <bang>0)

command! -bang -nargs=? -complete=dir GFilesOnlyChanged
            \ call fzf#vim#gitfiles(<q-args>,
                \ {
                \ 'source': 'git status -s | cut -c4-',
                \ }, <bang>0)

function! FormatRipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview({}), a:fullscreen)
endfunction

function! DynamicRipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -bang -nargs=? Rg
            \ call FormatRipgrepFzf(<q-args>, <bang>0)

command! -bang -nargs=* DynamicRg
            \ call DynamicRipgrepFzf(<q-args>, <bang>0)

function! FzfSpellSink(word)
    exe 'normal! "_ciw'.a:word
endfunction
function! FzfSpell()
    let suggestions = spellsuggest(expand("<cword>"))
    return fzf#run({ 'source': suggestions, 'sink': function("FzfSpellSink"), 'down': '25%', 'options': '--preview ""' })
endfunction
nnoremap z= :call FzfSpell()<CR>
