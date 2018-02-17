export LANG=ja_JP.UTF-8
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
autoload -Uz compinit
compinit
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
  eval "$(anyenv init -)"
fi

### Added by the Heroku Toolbelt
# export PATH="/usr/local/heroku/bin:$PATH"

### go
export GOPATH=$HOME/.go
export PATH="$GOPATH/bin:$PATH"

### FIXME
case ${OSTYPE} in
  darwin*)
    ### VIM
    alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
    alias gvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim -g "$@"'
    ###

    ### cling
    # export CLING_PATH=~/tools/cling_2016-07-06_mac1011/bin
    # export PATH=$CLING_PATH:$PATH

    ### Rust
    export PATH="$HOME/.cargo/bin:$PATH"
  ;;
  linux*)
    ### cuda
    export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
    export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
    export CUDA_HOME=/usr/local/cuda
    export CUDA_PATH=/usr/local/cuda

    ### cocos
    # Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
    # export COCOS_CONSOLE_ROOT=/home/user/git/cocos2d-x/tools/cocos2d-console/bin
    # export PATH=$COCOS_CONSOLE_ROOT:$PATH

    # Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
    # export COCOS_TEMPLATES_ROOT=/home/user/git/cocos2d-x/templates
    # export PATH=$COCOS_TEMPLATES_ROOT:$PATH

    ### torch
    # . /home/user/git/torch/install/bin/torch-activate

    ### rust
    if [ -f $HOME/.cargo/env ]; then
      source $HOME/.cargo/env
    fi
  ;;
esac

#export LD_LIBRARY_PATH="/usr/local/lib"

if [ -e "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi

export PATH="$HOME/bin:$PATH"

alias sudo='sudo '
alias c_='cd $_'
alias :e=nvim
alias :r="nvim -R"
