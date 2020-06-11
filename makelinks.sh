#!/bin/bash

git submodule init

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

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

brew tap homebrew/cask-fonts

echo 'Installing nvm (node version manager)...'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

nvm install --lts

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
pip install --user pynvim neovim
python3 -m pip install --user pynvim

curl -sSL https://get.rvm.io | bash -s stable

sudo gem install neovim trash

echo 'Creating sym links to common config files'
ln -s $HOME/dotfiles/config/.aliases
ln -s $HOME/dotfiles/config/.profile

ln -s $HOME/dotfiles/tmux/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/dotfiles/config/.tmuxinator $XDG_CONFIG_HOME/.tmuxinator

ln -s $HOME/dotfiles/vim/.vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/vim/.vim   $HOME/.vim
ln -s $HOME/dotfiles/nvim $XDG_CONFIG_HOME/nvim

ln -s $HOME/dotfiles/vim/.vim
ln -s $HOME/dotfiles/vim/.vimrc
ln -s $HOME/dotfiles/zsh/.zshrc    $HOME/.zshrc
ln -s $HOME/dotfiles/zsh/.zprofile $HOME/.zprofile
ln -s $HOME/dotfiles/zsh/.oh-my-zsh/custom $HOME/.oh-my-zsh/custom

echo 'Install Alfred at: https://www.alfredapp.com/'
echo 'Install Magnet (window management) at: https://magnet.crowdcafe.com/'
echo 'Install Source Code Pro fonts'
