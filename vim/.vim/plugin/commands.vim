command! -bang -nargs=? Rg call saltor#functions#FormatRipgrepFzf(<q-args>, <bang>0)

command! -bang -nargs=* DynamicRg call saltor#functions#DynamicRipgrepFzf(<q-args>, <bang>0)
