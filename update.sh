ANYENV=~/.anyenv/bin/anyenv
PYENV=~/.anyenv/envs/pyenv/bin/pyenv
$ANYENV update
exec "$($ANYENV init -)"
$PYENV shell 3.7.3
pip install -U pip
pip install -U setuptools pipenv neovim
