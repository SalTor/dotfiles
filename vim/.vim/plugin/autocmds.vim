if has('autocmd')
  function! s:SalTorAutocmds()
    augroup SalTorAutocmds
      autocmd!

      " Disable paste mode on leaving insert mode.
      autocmd InsertLeave * set nopaste

      autocmd InsertLeave,VimEnter,WinEnter * if saltor#autocmds#should_cursorline() | setlocal cursorline | endif
      autocmd InsertEnter,WinLeave * if saltor#autocmds#should_cursorline() | setlocal nocursorline | endif
      autocmd BufEnter,FocusGained,VimEnter,WinEnter * call saltor#autocmds#focus_window()
      autocmd FocusLost,WinLeave * call saltor#autocmds#blur_window()
    augroup END
  endfunction

  call s:SalTorAutocmds()

  " Wait until idle to run additional "boot" commands.
  augroup SalTorIdleboot
    autocmd!
    if has('vim_starting')
    autocmd CursorHold,CursorHoldI * call saltor#autocmds#idleboot()
    endif
  augroup END
endif
