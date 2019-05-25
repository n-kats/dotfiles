#! /bin/bash
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

if [ ! -e $ANYENV_ROOT ]; then
  git clone https://github.com/anyenv/anyenv $ANYENV_ROOT
fi

if [ ! -e $ANYENV_PLUGINS ]; then
  mkdir -p $ANYENV_PLUGINS
fi

if [ ! -e $ANYENV_PLUGINS/anyenv-update ]; then
  git clone https://github.com/znz/anyenv-update.git $ANYENV_PLUGINS/anyenv-update
fi

anyenv init

if [ ! $(which pyenv > /dev/null && echo -n 1) ]; then
  anyenv install pyenv
  anyenv init
fi

if [ ! $(pyenv versions | grep 3.7.3 > /dev/null && echo 1) ]; then
  pyenv install 3.7.3
fi

./update.sh
