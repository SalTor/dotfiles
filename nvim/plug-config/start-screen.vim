let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_disable_at_vimenter = 0
let g:startify_relative_path = 0
let g:startify_change_to_dir = 0
let g:startify_session_autoload = 1
let g:startify_change_to_vcs_root = 1
let g:startify_session_persistence = 1
let g:startify_enable_special = 0
let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['        MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['        Sessions']  },
        \ { 'type': 'bookmarks', 'header': ['        Bookmarks'] },
        \ ]
let g:startify_bookmarks = [
        \ { 'i': '~/.config/nvim/init.vim' },
        \ { 'z': '~/.zshrc' },
        \ ]
