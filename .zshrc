export LANG=ja_JP.UTF-8
export LC_CTYPE=en_US.UTF-8
# 色
autoload -Uz colors
colors


############################
### かわいくなる
# もしかして機能
setopt correct

# PCRE互換の正規表現
setopt re_match_pcre

# プロンプト文字列の評価・置換
setopt prompt_subst
# プロンプト指定
PROMPT="[%n] %{${fg[yellow]}%}%~%{${reset_color}%}
%(?.%{$fg[green]%}.%{$fg[blue]%})%(?!(*'-') <!(*;-;%)? <)%{${reset_color}%} "
# プロンプト指定（コマンドの続き）
PROMPT2='[%n]> '

# プロンプト指定（もしかして）
SPROMPT="%{$fg[cyan]%}%{$suggest%}(*'~'%)? < もしかして %{$fg[magenta]%}%B%r%b %{$fg[cyan]%}かな？ [そう！(y), 違う！(n), a, e]:${reset_color} "

############################
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
function history-all { history -E 1 }
# PROMPT="%{${fg[red]}%}[%n@%m]%{${reset_color}%} %~
# %# "

############################

autoload -Uz select-word-style
select-word-style default

zstyle ':zle:*' word-chars "/=;@:{},|"
zstyle ':zle:*' word-style unspecified

############################
fpath=(/usr/local/share/zsh-completions $fpath)
fpath=(~/.zsh/completion $fpath)
fpath=(~/.zfunc $fpath)
autoload -Uz compinit && compinit -u

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
  /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

############################

autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{green}{%s}-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}{%s}-[%b|%a]%f'

function _update_vcs_info_msg() {
  LANG=en_US.UTF-8 vcs_info
  RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg

############################

setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt interactive_comments
##setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt extended_glob
function history-all { history -E 1 }

############################

### anyenv
if [ -d "$HOME/.anyenv/bin" ]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init - zsh)"
fi

### pipenv
export PIPENV_COLORBLIND=1  # pipenvの色を無効化
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

### poetry
if [[ -e $HOME/.poetry/bin ]]; then
  export PATH="$HOME/.poetry/bin:$PATH"
fi

## uv
if command -v uv &>/dev/null; then
  eval "$(uv generate-shell-completion zsh)"
fi

### go
export GOPATH=$HOME/.go
export PATH="$GOPATH/bin:$PATH"

### rust
if [ -f $HOME/.cargo/env ]; then
  source $HOME/.cargo/env
fi

### node
if command -v npm &>/dev/null; then
  export PATH="$(npm prefix -g)/bin:$PATH"
fi


if [ -d "$HOME/.yarn/bin" ]; then
  export PATH="$HOME/.yarn/bin:$PATH"
fi

### deno
if [ -d "$HOME/.deno" ]; then
  export DENO_INSTALL="$HOME/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"
fi

### bun
if [ -d "$HOME/.bun" ]; then
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
fi

# bun completions
[ -s "/home/user/.bun/_bun" ] && source "/home/user/.bun/_bun"

### pnpm
export PNPM_HOME="/home/user/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac


# travis
if [ ! -e "$HOME/.travis/travis.sh" ]; then
  source /home/user/.travis/travis.sh
fi

# 補間
## poetory
if [ ! -e "$HOME/.zfunc/_poetry" ] ; then
  if type poetry > /dev/null 2>&1; then
    mkdir -p $HOME/.zfunc
    poetry completions zsh > $HOME/.zfunc/_poetry
  fi
fi

## rye
if [ ! -e "$HOME/.zfunc/_rye" ] ; then
  if type rye > /dev/null 2>&1; then
    mkdir -p $HOME/.zfunc
    rye self completion -s zsh > $HOME/.zfunc/_rye
  fi
fi

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

alias sudo='sudo '
alias c_='cd $-'
alias :e=nvim
alias :r="nvim -R"
alias pp='pipenv run'
alias pps='pipenv shell'
alias ppp='pipenv run python'
alias psh='pipenv run bash'
alias ppm='pipenv run python -m'
alias ppu='pipenv run python -m unittest'
alias ppip='pipenv run ipython'
alias pos='poetry shell'
alias por='poetry run'
alias popy='poetry run python'
alias posip='poetry run ipython'
alias posh='poetry run bash'
alias vsh="source .venv/bin/activate"
alias e_sh='exec $SHELL -l'
alias duh='du -d 1 . -h | sort -h'
alias cline_template='pipx run cookiecutter git@github.com:n-kats/cline_template.git'
bindkey -v

pyenv_poetry()
{
  poetry env use "$(pyenv prefix $1)/bin/python"
}

xopen()
{
  xdg-open "$1" 2>/dev/null
}

if [ -e "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi


. "$HOME/.local/bin/env"
