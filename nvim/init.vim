set termguicolors

source $NVIM/general/settings.vim
source $NVIM/vim-plug/plugins.vim

" source $VIM_PLUG_CONFIG/airline.vim
" source $VIM_PLUG_CONFIG/fzf.vim
" source $VIM_PLUG_CONFIG/neoterm.vim
" source $VIM_PLUG_CONFIG/nerdcommenter.vim
" source $VIM_PLUG_CONFIG/nerdtree.vim
" source $VIM_PLUG_CONFIG/easymotion.vim
" source $VIM_PLUG_CONFIG/start-screen.vim
" source $VIM_PLUG_CONFIG/which-key.vim

source $NVIM/keys/default-overrides.vim
source $NVIM/keys/modes/index.vim
source $NVIM/keys/leader.vim
source $NVIM/keys/local-leader.vim

source $NVIM/keys/challenge.vim

lua require('init')
