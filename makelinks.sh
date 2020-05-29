#!/bin/bash

brew install lazygit
brew install fzf
$(brew --prefix)/opt/fzf/install

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ln -s $HOME/dotfiles/vim/dot-vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/vim/dot-vim   $HOME/.vim
ln -s $HOME/dotfiles/nvim $XDG_CONFIG_HOME/nvim

ln -s $HOME/dotfiles/zsh/dot-zshrc    $HOME/.zshrc
ln -s $HOME/dotfiles/zsh/dot-zprofile $HOME/.zprofile
ln -s $HOME/dotfiles/zsh/dot-oh-my-zsh/custom $HOME/.oh-my-zsh/custom
