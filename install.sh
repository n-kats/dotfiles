#! /bin/bash
set -eu
cd "$(dirname "$0")"

# zsh
ln -sf "$PWD/.zshrc" "$HOME/.zshrc"

# editorconfig
ln -sf "$PWD/.editorconfig" "$HOME/.editorconfig"

# nvim
mkdir -p "$HOME/.config/nvim"
ln -sf "$PWD/init.vim" "$HOME/.config/nvim/init.vim"
ln -sf "$PWD/dein.toml" "$HOME/.config/nvim/dein.toml"

# procs
mkdir -p "$HOME/.config/procs"
ln -sf "$PWD/procs/config.toml" "$HOME/.config/procs/config.toml"

# Tig
ln -sf "$PWD/.tigrc" "$HOME/.tigrc"

# anyenv
ANYENV_ROOT="$HOME/.anyenv"
ANYENV_PLUGINS="$HOME/.anyenv/plugins"
ANYENV="$HOME/.anyenv/bin/anyenv"
PYENV="$HOME/.anyenv/envs/pyenv/bin/pyenv"

if [[ ! -e "$ANYENV_ROOT" ]]; then
  git clone https://github.com/anyenv/anyenv "$ANYENV_ROOT"
  yes | "$ANYENV" install --init
  eval "$($ANYENV init -)"
  "$ANYENV" install pyenv
  eval "$($ANYENV init -)"
fi

if [[ ! -e "$ANYENV_PLUGINS" ]]; then
  mkdir -p "$ANYENV_PLUGINS"
fi

if [ ! -e "$ANYENV_PLUGINS/anyenv-update" ]; then
  mkdir -p "$ANYENV_PLUGINS"
  git clone https://github.com/znz/anyenv-update.git "$ANYENV_PLUGINS/anyenv-update"
fi

if [[ ! "$($PYENV versions | grep 3.8.5 > /dev/null && echo 1)" ]]; then
  "$PYENV" install 3.8.5
fi

./update.sh
