#!/bin/bash

echo 'Installing Neovim...'
brew install neovim

echo 'Installing ripgrep...'
brew install ripgrep

echo 'Installing fzf...'
brew install fzf
$(brew --prefix)/opt/fzf/install

echo 'Installing lazygit...'
brew install lazygit

echo 'Installing tmuxinator...'
brew install tmuxinator

echo 'Installing OhMyZsh...'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo 'Be sure to change shell to zsh by using "chsh -s $(which zsh)"'

echo 'Creating sym links to common config files'
ln -s $HOME/dotfiles/vim/.vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/vim/.vim   $HOME/.vim
ln -s $HOME/dotfiles/nvim $XDG_CONFIG_HOME/nvim

ln -s $HOME/dotfiles/zsh/.zshrc    $HOME/.zshrc
ln -s $HOME/dotfiles/zsh/.zprofile $HOME/.zprofile
ln -s $HOME/dotfiles/zsh/.oh-my-zsh/custom $HOME/.oh-my-zsh/custom

echo 'Install Alfred at: https://www.alfredapp.com/'
echo 'Install Magnet (window management) at: https://magnet.crowdcafe.com/'
