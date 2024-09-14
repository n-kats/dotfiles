#! /bin/zsh
source "$HOME/.zshrc"

setup()
{
  name="$1"
  python_version="$2"
  shift 2
  if [[ "$(pyenv versions | grep -E "^\s*${python_version}$")" == "" ]]; then
    echo "[I] install ${python_version}."
    pyenv install "$python_version"
  else
    echo "[I] ${python_version} is installed."
  fi
  if [[ "$(pyenv versions | grep -E "^\s*${name}$")" == "" ]]; then
    echo "[I] install ${env}."
    pyenv virtualenv "$python_version" "$name"
  else
    echo "[I] ${name} is installed."
  fi
  pyenv shell "$name"
  python -m pip install -U pip setuptools wheel
  echo "[I] install $@."
  python -m pip install -U $*
  echo "[I] done."
}

add_poetry_command()
{
  cat <<EOS > "$HOME/bin/poetry"
#! /bin/zsh
eval "\$(pyenv init -)"

# 現在のpyenv 環境名に poetry がなければ poetry 環境で実行
if [ "\$(pyenv version-name | grep poetry)" = "" ]; then
  pyenv shell "poetry"
fi
pyenv exec poetry "\$@"
EOS
}

add_command()
{
  command="$1"
  default_env="$2"
  expected_env_condition="$3"
  shell_="$4"
  cat <<EOS > "$HOME/bin/$command"
#! /bin/zsh
eval "\$(pyenv init -)"

if [ "\$(pyenv version-name | grep ${expected_env_condition})" = "" ]; then
  pyenv shell ${default_env}
fi
pyenv exec "${command}" "\$@"
EOS
}

add_command_update()
{
  env_="$1"
  shell_="$2"
  shift 2
  cat <<EOS > "$HOME/bin/${command}_update"
#! /bin/${shell_}
source "\$HOME/.${shell_}rc"
pyenv shell "$env_"
pip install -U $@
EOS
}

install_poetry_env()
{
  python_version="$1"
  poetry_version="$2"
  addtional_packages="${@:3}"

  setup poetry_${poetry_version}_py_${python_version} \
    "$python_version" "poetry==$poetry_version" \
    pynvim python-language-server poetry-dynamic-versioning \
    python-lsp-server pylsp-mypy openai \
    "$addtional_packages"
}

# poetry
setup poetry \
  3.11.5 \
  poetry~=1.8.0 poetry-core~=1.9.0 pynvim python-language-server poetry-dynamic-versioning \
  webencodings python-lsp-server pylsp-mypy openai

install_poetry_env 3.11.5 1.8.3

add_command poetry poetry poetry zsh
add_command poetry-dynamic-versioning poetry poetry zsh
add_command dunamai poetry poetry zsh

poetry config experimental.new-installer false

update_bin
