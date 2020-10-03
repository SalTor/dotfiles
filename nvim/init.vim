set runtimepath^=~/.vim runtimepath+=~/.config/nvim runtimepath+=~/.config/nvim/autoload
let &packpath=&runtimepath

set termguicolors

source $NVIM/general/settings.vim
source $NVIM/vim-plug/plugins.vim
source $NVIM/theme.vim

source $VIM_PLUG_CONFIG/airline.vim
source $VIM_PLUG_CONFIG/ale.vim
source $VIM_PLUG_CONFIG/easymotion.vim
source $VIM_PLUG_CONFIG/fzf.vim
source $VIM_PLUG_CONFIG/nerdcommenter.vim
source $VIM_PLUG_CONFIG/nerdtree.vim
source $VIM_PLUG_CONFIG/quickscope.vim
source $VIM_PLUG_CONFIG/sneak.vim
source $VIM_PLUG_CONFIG/start-screen.vim
source $VIM_PLUG_CONFIG/which-key.vim
source $VIM_PLUG_CONFIG/neoterm.vim
luafile $VIM_PLUG_CONFIG/nvim-colorizer.lua
