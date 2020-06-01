#!/bin/bash

brew install cowsay
brew install fortune
brew install tig
brew install bat
brew install neovim
brew install lazygit
brew install tmuxinator
brew install zsh-syntax-highlighting
brew install ripgrep
brew install the_silver_searcher
brew install fzf
$(brew --prefix)/opt/fzf/install

echo 'Installing nvm (node version manager)...'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

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
