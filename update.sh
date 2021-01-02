ANYENV=~/.anyenv/bin/anyenv
PYENV=~/.anyenv/envs/pyenv/bin/pyenv
$ANYENV update

eval "$($ANYENV init - $(basename $SHELL))"
eval "$($PYENV init - $(basename $SHELL))"
pyenv shell 3.8.5 \
  && pip install -U pip \
  && pip install -U \
    setuptools pipenv pynvim \
    yapf pylint flake8 autopep8 mypy \
    python-language-server
