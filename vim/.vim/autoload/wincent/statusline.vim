scriptencoding utf-8

function! wincent#statusline#gutterpadding() abort
endfunction

function! wincent#statusline#fileprefix() abort
endfunction

function! wincent#statusline#ft() abort
endfunction

function! wincent#statusline#fenc() abort
endfunction

function! wincent#statusline#lhs() abort
endfunction

function! wincent#statusline#rhs() abort
endfunction

let s:default_lhs_color='Identifier'
let s:async_lhs_color='Constant'
let s:modified_lhs_color='ModeMsg'
let s:wincent_statusline_status_highlight=s:default_lhs_color
let s:async=0

function! wincent#statusline#async_start() abort
endfunction

function! wincent#statusline#async_finish() abort
endfunction

function! wincent#statusline#check_modified() abort
endfunction

function! wincent#statusline#update_highlight() abort
endfunction
