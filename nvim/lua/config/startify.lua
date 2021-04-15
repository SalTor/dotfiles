vim.g.startify_disable_at_vimenter = 0
vim.g.startify_relative_path = 0
vim.g.startify_change_to_dir = 0
vim.g.startify_session_autoload = 1
vim.g.startify_change_to_vcs_root = 1
vim.g.startify_session_persistence = 1
vim.g.startify_enable_special = 0
vim.cmd [[ let g:startify_session_dir = '~/.config/nvim/session' ]]

vim.g.startify_lists = {
    {
        type = 'dir',
        header = { '        MRU ' .. vim.fn.getcwd() }
    },
    {
        type = 'sessions',
        header = { '        Sessions' }
    },
    {
        type = 'bookmarks',
        header = { '        Bookmarks' }
    }
}

vim.g.startify_bookmarks = {
    { i = '~/.config/nvim/init.vim' },
    { z = '~/.zshrc' }
}
