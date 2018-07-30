#!/bin/bash

if [ ! -f ./vim/.vimrc ]; then
    echo "[!] Bad execution. Being run from incorrect directory."
    echo "[!] Execute this install script from within the correct directory."
    return
fi

# Install VIM
ln -s ~/dotfiles/vim/.vim/ ~/
ln -s ~/dotfiles/vim/.vimrc ~/
cd ~/.vim/bundle
git submodule update --init --recursive
cd ~/dotfiles
ln -s ~/dotfiles/vim/.vim/nvim/ ~/.config/
vim +PluginInstall

# Install OhMyZsh
if !(hash zsh>/dev/null); then
    brew install zsh zsh-completions
fi

# Pipe to sed in order to enable continuing with install script once OhMyZsh install script finishes; it otherwise ends this script pre-maturely
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh -l::g' | sed 's:chsh -s .*$::g')"

rm -rf ~/.oh-my-zsh/custom/
ln -s ~/dotfiles/zsh/.oh-my-zsh/custom/ ~/.oh-my-zsh/
rm -rf ~/.zshrc
ln -s ~/dotfiles/zsh/.zshrc ~/
curl -fsSL https://raw.github.com/win0err/aphrodite-terminal-theme/master/aphrodite.zsh-theme > ~/.oh-my-zsh/custom/themes/aphrodite.zsh-theme
env zsh -l
chsh -s $(which zsh)
