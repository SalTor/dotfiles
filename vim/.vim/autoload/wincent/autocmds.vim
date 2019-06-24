let g:WincentColorColumnBufferNameBlacklist = ['__LanguageClient__']
let g:WincentColorColumnFileTypeBlacklist = ['diff', 'fugitiveblame', 'undotree', 'nerdtree', 'qf']
let g:WincentCursorlineBlacklist = []
let g:WincentMkviewFiletypeBlacklist = ['diff', 'hgcommit', 'gitcommit']

function! wincent#autocmds#attempt_select_last_file() abort
endfunction

function! wincent#autocmds#should_colorcolumn() abort
endfunction

function! wincent#autocmds#should_cursorline() abort
endfunction

" Loosely based on: http://vim.wikia.com/wiki/Make_views_automatic
function! wincent#autocmds#should_mkview() abort
endfunction

function! wincent#autocmds#mkview() abort
endfunction

function! wincent#autocmds#blur_window() abort
endfunction

function! wincent#autocmds#focus_window() abort
endfunction

function! wincent#autocmds#blur_statusline() abort
endfunction

function! wincent#autocmds#focus_statusline() abort
endfunction

function! s:update_statusline(default, action) abort
endfunction

function! s:get_custom_statusline(action) abort
endfunction

function! wincent#autocmds#idleboot() abort
endfunction

function! wincent#autocmds#format(motion) abort
endfunction
