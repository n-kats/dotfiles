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
fpath=(~/.zsh/completion $fpath)

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
  eval "$(anyenv init -)"
fi

### pipenv
export PIPENV_COLORBLIND=1  # pipenvの色を無効化

### go
export GOPATH=$HOME/.go
export PATH="$GOPATH/bin:$PATH"

###
case ${OSTYPE} in
  darwin*)
    ### VIM
    alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
    alias gvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim -g "$@"'

    ### Rust
    export PATH="$HOME/.cargo/bin:$PATH"
  ;;
esac

if [ -f $HOME/.cargo/env ]; then
  source $HOME/.cargo/env
fi

if [ -e "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi

export PATH="$HOME/bin:$PATH"

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
alias xopen='xdg-open'
alias e_sh='exec $SHELL -l'
