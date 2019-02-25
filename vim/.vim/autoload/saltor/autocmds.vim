let g:SalTorColorColumnBufferNameBlacklist = ['__LanguageClient__']
let g:SalTorColorColumnFileTypeBlacklist = ['command-t', 'diff', 'fugitiveblame', 'undotree', 'nerdtree', 'qf']
let g:SalTorCursorlineBlacklist = ['']

function! saltor#autocmds#idleboot() abort
    " Make sure we automatically call saltor#autocmds#idleboot() only once.
    augroup SalTorIdleboot
        autocmd!
    augroup END

    " Make sure we run deferred tasks exactly once.
    doautocmd User SalTorDefer
    autocmd! User SalTorDefer
endfunction

function! saltor#autocmds#should_cursorline() abort
  return index(g:SalTorCursorlineBlacklist, &filetype) == -1
endfunction

function! saltor#autocmds#should_colorcolumn() abort
  if index(g:SalTorColorColumnBufferNameBlacklist, bufname(bufnr('%'))) != -1
    return 0
  endif
  return index(g:SalTorColorColumnFileTypeBlacklist, &filetype) == -1
endfunction

function! saltor#autocmds#blur_window() abort
  if saltor#autocmds#should_colorcolumn()
    ownsyntax off
  endif
endfunction

function! saltor#autocmds#focus_window() abort
  if saltor#autocmds#should_colorcolumn()
    if !empty(&ft)
      ownsyntax on
    endif
  endif
endfunction
