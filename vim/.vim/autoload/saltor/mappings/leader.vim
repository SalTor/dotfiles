function! saltor#mappings#leader#cycle_spellcheck() abort
    execute {
        \ 'en_us1': 'set nospell',
        \ 'en_us0': 'set spell' }[&spelllang . &spell]
endfunction
