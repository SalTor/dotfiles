let g:WincentColorColumnBufferNameBlacklist = ['__LanguageClient__']
let g:WincentColorColumnFileTypeBlacklist = ['command-t', 'diff', 'fugitiveblame', 'undotree', 'nerdtree', 'qf']
let g:WincentCursorlineBlacklist = ['command-t']
let g:WincentMkviewFiletypeBlacklist = ['diff', 'hgcommit', 'gitcommit']

function! wincent#autocmds#attempt_select_last_file() abort
  let l:previous=expand('#:t')
  if l:previous !=# ''
    call search('\v<' . l:previous . '>')
  endif
endfunction

function! wincent#autocmds#should_colorcolumn() abort
  if index(g:WincentColorColumnBufferNameBlacklist, bufname(bufnr('%'))) != -1
    return 0
  endif
  return index(g:WincentColorColumnFileTypeBlacklist, &filetype) == -1
endfunction

function! wincent#autocmds#should_cursorline() abort
  return index(g:WincentCursorlineBlacklist, &filetype) == -1
endfunction

" Loosely based on: http://vim.wikia.com/wiki/Make_views_automatic
function! wincent#autocmds#should_mkview() abort
  return
        \ &buftype ==# '' &&
        \ index(g:WincentMkviewFiletypeBlacklist, &filetype) == -1 &&
        \ !exists('$SUDO_USER') " Don't create root-owned files.
endfunction

function! wincent#autocmds#mkview() abort
  if exists('*haslocaldir') && haslocaldir()
    " We never want to save an :lcd command, so hack around it...
    cd -
    mkview
    lcd -
  else
    mkview
  endif
endfunction

function! wincent#autocmds#blur_window() abort
  if wincent#autocmds#should_colorcolumn()
    ownsyntax off
  endif
endfunction

function! wincent#autocmds#focus_window() abort
  if wincent#autocmds#should_colorcolumn()
    if !empty(&ft)
      ownsyntax on
    endif
  endif
endfunction

function! wincent#autocmds#blur_statusline() abort
  " Default blurred statusline (buffer number: filename).
  let l:blurred='%{wincent#statusline#gutterpadding()}'
  let l:blurred.='\ ' " space
  let l:blurred.='\ ' " space
  let l:blurred.='\ ' " space
  let l:blurred.='\ ' " space
  let l:blurred.='%<' " truncation point
  let l:blurred.='%f' " filename
  let l:blurred.='%=' " split left/right halves (makes background cover whole)
  call s:update_statusline(l:blurred, 'blur')
endfunction

function! wincent#autocmds#focus_statusline() abort
  " `setlocal statusline=` will revert to global 'statusline' setting.
  call s:update_statusline('', 'focus')
endfunction

function! s:update_statusline(default, action) abort
  let l:statusline = s:get_custom_statusline(a:action)
  if type(l:statusline) == type('')
    " Apply custom statusline.
    execute 'setlocal statusline=' . l:statusline
  elseif l:statusline == 0
    " Do nothing.
    "
    " Note that order matters here because of Vimscript's insane coercion rules:
    " when comparing a string to a number, the string gets coerced to 0, which
    " means that all strings `== 0`. So, we must check for string-ness first,
    " above.
    return
  else
    execute 'setlocal statusline=' . a:default
  endif
endfunction

function! s:get_custom_statusline(action) abort
  if &ft ==# 'command-t'
    " Will use Command-T-provided buffer name, but need to escape spaces.
    return '\ \ ' . substitute(bufname('%'), ' ', '\\ ', 'g')
  elseif &ft ==# 'diff' && exists('t:diffpanel') && t:diffpanel.bufname ==# bufname('%')
    return 'Undotree\ preview' " Less ugly, and nothing really useful to show.
  elseif &ft ==# 'undotree'
    return 0 " Don't override; undotree does its own thing.
  elseif &ft ==# 'nerdtree'
    return 0 " Don't override; NERDTree does its own thing.
  elseif &ft ==# 'qf'
    if a:action ==# 'blur'
      return
            \ '%{wincent#statusline#gutterpadding()}'
            \ . '\ '
            \ . '\ '
            \ . '\ '
            \ . '\ '
            \ . '%<'
            \ . '%q'
            \ . '\ '
            \ . '%{get(w:,\"quickfix_title\",\"\")}'
            \ . '%='
    else
      return g:WincentQuickfixStatusline
    endif
  endif

  return 1 " Use default.
endfunction

function! wincent#autocmds#idleboot() abort
  " Make sure we automatically call wincent#autocmds#idleboot() only once.
  augroup WincentIdleboot
    autocmd!
  augroup END

  " Make sure we run deferred tasks exactly once.
  doautocmd User WincentDefer
  autocmd! User WincentDefer
endfunction

function! wincent#autocmds#format(motion) abort
  if has('ex_extra')
    let l:v=operator#user#visual_command_from_wise_name(a:motion)
    silent execute 'normal!' '`[' . l:v . '`]gq'
    '[,']retab!
  endif
endfunction
