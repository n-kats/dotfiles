#! /bin/bash
cd `dirname $0`

mkdir -p ~/.config/nvim
ln -sf `pwd`/.zshrc ~/.zshrc
ln -sf `pwd`/.editorconfig ~/.editorconfig
ln -sf `pwd`/init.vim ~/.config/nvim/init.vim
ln -sf `pwd`/dein.toml ~/.config/nvim/dein.toml
