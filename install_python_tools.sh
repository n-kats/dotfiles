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

add_command()
{
  command="$1"
  env_="$2"
  shell_="$3"
  cat <<EOS > "$HOME/bin/$command"
#! /bin/${shell_}
eval "\$(pyenv init -)"
pyenv shell "$env_"
pyenv exec $command \$*
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
# poetry
setup poetry \
  3.11.5 \
  poetry~=1.8.0 poetry-core~=1.9.0 pynvim python-language-server poetry-dynamic-versioning \
  webencodings python-lsp-server pylsp-mypy openai

add_command poetry poetry zsh
add_command poetry-dynamic-versioning poetry zsh
add_command dunamai poetry zsh

poetry config experimental.new-installer false

update_bin
