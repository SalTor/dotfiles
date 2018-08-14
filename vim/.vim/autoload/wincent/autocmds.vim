function! s:get_spell_settings() abort
  return {
  \   'spell': &l:spell,
  \   'spellcapcheck': &l:spellcapcheck,
  \   'spellfile': &l:spellfile,
  \   'spelllang': &l:spelllang
  \ }
endfunction

function! s:set_spell_settings(settings) abort
  let &l:spell=a:settings.spell
  let &l:spellcapcheck=a:settings.spellcapcheck
  let &l:spellfile=a:settings.spellfile
  let &l:spelllang=a:settings.spelllang
endfunction

function! wincent#autocmds#should_colorcolumn() abort
  return index(g:WincentColorColumnBlacklist, &filetype) == -1
endfunction

function! wincent#autocmds#should_cursorline() abort
  return index(g:WincentCursorlineBlacklist, &filetype) == -1
endfunction

function! wincent#autocmds#blur_window() abort
  if wincent#autocmds#should_colorcolumn()
    let l:settings=s:get_spell_settings()
    ownsyntax off
    call s:set_spell_settings(l:settings)
  endif
endfunction

function! wincent#autocmds#focus_window() abort
  if wincent#autocmds#should_colorcolumn()
    if !empty(&ft)
      let l:settings=s:get_spell_settings()
      ownsyntax on
      call s:set_spell_settings(l:settings)
    endif
  endif
endfunction

highlight ColorColumn ctermbg=0 guibg=#efefef
let &colorcolumn=join(range(81,999),",")

if exists('+colorcolumn')
    autocmd BufEnter,FocusGained,VimEnter,WinEnter * if autocmd#should_colorcolumn() | let &l:colorcolumn='+' . join(range(0, 254), ',+') | endif
    autocmd FocusLost,WinLeave * if autocmds#should_colorcolumn() | let &l:colorcolumn=join(range(1, 255), ',') | endif
endif
