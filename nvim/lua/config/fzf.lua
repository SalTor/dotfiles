vim.g.fzf_buffers_jump = 1
vim.g.fzf_layout = {
    window = {
        height = 0.5,
        width = 1,
        yoffset = 0,
        highlight = 'PreProc',
    }
}
vim.cmd [[
    let g:fzf_action = { 'ctrl-q': function('saltor#functions#build_quickfix_list'), 'ctrl-t': 'tab split', 'ctrl-x': 'split', 'ctrl-v': 'vsplit' }
]]
