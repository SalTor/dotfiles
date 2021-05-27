set termguicolors

let g:sal_use_telescope = 0

source $NVIM/general/settings.vim
source $NVIM/vim-plug/plugins.vim

source $NVIM/keys/default-overrides.vim
source $NVIM/keys/modes/index.vim
source $NVIM/keys/leader.vim
source $NVIM/keys/local-leader.vim

source $NVIM/keys/challenge.vim

lua require('init')
