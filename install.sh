#! /bin/bash
set -eu
cd `dirname $0`

# zsh
ln -sf `pwd`/.zshrc ~/.zshrc

# editorconfig
ln -sf `pwd`/.editorconfig ~/.editorconfig

# nvim
if [ ! -e ~/.config/nvim ]; then
  mkdir -p ~/.config/nvim
fi

ln -sf `pwd`/init.vim ~/.config/nvim/init.vim
ln -sf `pwd`/dein.toml ~/.config/nvim/dein.toml

# anyenv
ANYENV_ROOT=~/.anyenv
ANYENV_PLUGINS=~/.anyenv/plugins
DOES_UPDATA_ANYENV=0
ANYENV=~/.anyenv/bin/anyenv
PYENV=~/.anyenv/envs/pyenv/bin/pyenv

if [ ! -e $ANYENV_ROOT ]; then
  git clone https://github.com/anyenv/anyenv $ANYENV_ROOT
  $ANYENV install --init
  eval "$($ANYENV init -)"
fi

if [ ! -e $ANYENV_PLUGINS ]; then
  mkdir -p $ANYENV_PLUGINS
fi

if [ ! -e $ANYENV_PLUGINS/anyenv-update ]; then
  git clone https://github.com/znz/anyenv-update.git $ANYENV_PLUGINS/anyenv-update
fi

if [ ! -e $PYENV ]; then
  $ANYENV install pyenv
fi

if [ ! $($PYENV versions | grep 3.7.3 > /dev/null && echo 1) ]; then
  $PYENV install 3.7.3
fi

./update.sh
