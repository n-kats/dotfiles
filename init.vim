" PythonPath": {{{

let s:has_pipenv = system('type pipenv &>/dev/null && echo -n 1')
let s:has_pyenv = system('type pyenv &>/dev/null && echo -n 1')
let s:has_poetry = system('type poetry &>/dev/null && echo -n 1')
let s:has_pyenv_poetry = s:has_pyenv && system('pyenv prefix poetry &>/dev/null && echo -n 1')
let s:has_uv = system('type uv &>/dev/null && echo -n 1')

let g:is_poetry_active = s:has_poetry && system('poetry check &>/dev/null && echo -n 1')
let g:is_pipenv_active = s:has_pipenv && ! g:is_poetry_active && system('pipenv --venv &>/dev/null && echo -n 1')
let s:is_pyenv_poetry_active = s:has_pyenv_poetry && g:is_poetry_active
let s:is_pyenv_system = s:has_pyenv ? system('(pyenv version | grep system) &>/dev/null && echo -n 1') : 0
let g:is_uv_project = s:has_uv && filereadable('.use_uv')

let s:python_path_poetry = g:is_poetry_active ? system('echo -n $(poetry run which python)') : ""
let s:python_path_pipenv = g:is_pipenv_active ? system('echo -n $(pipenv --py)') : ""
let s:python_path_pyenv = (s:has_pyenv && ! s:is_pyenv_system) ? system('echo -n $(pyenv prefix)/bin/python') : ""
let s:python_path_pyenv_poetry = s:is_pyenv_poetry_active ? system('echo -n $(pyenv prefix poetry)/bin/python') : ""
let s:python_path_uv = g:is_uv_project ? system('uv python dir') : ""
let s:python_path_python3 = system('echo -n $(which python3)')
let g:is_pyenv_system = s:is_pyenv_system

if g:is_uv_project
  let g:python3_host_prog = s:python_path_uv
elseif s:is_pyenv_poetry_active
  let g:python3_host_prog = s:python_path_pyenv_poetry
elseif g:is_pipenv_active
  let g:python3_host_prog = s:python_path_pyenv
elseif s:has_pyenv && ! s:is_pyenv_system
  let g:python3_host_prog = s:python_path_pyenv
else
  let g:python3_host_prog = s:python_path_python3
endif

let s:has_openai = system('python3 -c "import openai" &>/dev/null && echo -n 1')

" }}}

" Package": {{{

let $MY_DEIN_TOML = '~/.config/nvim/dein.toml'
let $LOCAL_DEIN_TOML = '~/.config/nvim/dein.local.toml'
set runtimepath^=~/.cache/nvim/dein/repos/github.com/Shougo/dein.vim
let g:dein#types#git#default_protocol = 'ssh'
if !isdirectory(expand('~/.cache/nvim/dein/repos/github.com/Shougo/dein.vim'))
  system('mkdir -p ~/.cache/nvim/dein/repos/github.com/Shougo')
  system('git clone https://github.com/Shougo/dein.vim.git ~/.cache/nvim/dein/repos/github.com/Shougo/dein.vim')
endif

call dein#begin(expand('~/.cache/nvim/dein'))
call dein#load_toml($MY_DEIN_TOML)

if filereadable(expand($LOCAL_DEIN_TOML))
  call dein#load_toml($LOCAL_DEIN_TOML)
endif

call dein#end()

filetype plugin indent on
if dein#check_install()
  call dein#install()
endif

" }}}

" common": {{{

set notitle  "「Vimを使ってくれてありがとう」を消す
set autoindent  "新しい行のインデントを現在行と同じにする

set clipboard+=unnamedplus

set number
set wildmenu " コマンドライン補完を便利に
set mouse=a " 全モードでマウスを有効化
set showmatch " 括弧の対応をハイライト
set tabstop=4
set shiftwidth=4
set smarttab
set spelllang+=cjk " 日本語部分までスペルチェックされるのを除去
set spell " spell check

set guicursor=

inoremap <silent> jj <ESC>
nmap <silent> <ESC><ESC> :noh<CR>
set background=light
colorscheme retrobox

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" }}}

" ウィンドウ移動": {{{
""" Alt+{h,j,k,l}でウィンドウ移動
nnoremap <TAB> <C-w><C-w>
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
if has('nvim')
  tnoremap <ESC> <C-\><C-n>
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
  syntax on
endif
" }}}

" statusline": {{{
set laststatus=2
set statusline+=%r "ReadOnly?
set statusline+=%y "ファイルタイプ表示
set statusline+=%f "ファイル名
set statusline+=%m "Modified?
set statusline+=%= "これより右詰め
set statusline+=[%P,%c]
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}] "文字コード表示
" }}}

" c++": {{{
set cindent
set cinoptions=g-1
" }}}

" python": {{{
autocmd FileType python let b:did_ftplugin = 1
" }}}

" tex": {{{
let g:tex_conceal='' "うざい式表示を滅ぼす
if expand("%:e") == "tex"
  if has('win32')
    let ostype = "Win"
  elseif has('mac')
    filetype plugin on
    filetype indent on
    set shellslash
    set grepprg=grep\ -nH\ $*
    let g:tex_flavor='latex'
    let g:lamp_UsePlaceHolders = 1
    let g:lamp_DeleteEmptyPlaceHolders = 1
    let g:lamp_StickyPlaceHolders = 0
    let g:Tex_DefaultTargetFormat = 'pdf'
    let g:Tex_MultipleCompileFormats = 'dvi,pdf'
    let g:Tex_FormatDependency_pdf = 'dvi,pdf'
    let g:Tex_FormatDependency_ps = 'dvi,ps'

    let g:Tex_CompileRule_pdf = '/usr/texbin/ptex2pdf -u -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
    let g:Tex_CompileRule_ps = '/usr/texbin/dvips -Ppdf -o $*.ps $*.dvi'
    let g:Tex_CompileRule_dvi = '/usr/texbin/uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
    let g:Tex_BibtexFlavor = '/usr/texbin/upbibtex'
    let g:Tex_NakeIndexFlavor = '/usr/texbin/mendex -U $*.idx'
    let g:Tex_UseEditorSettingInDVIViewer = 1
    let g:Tex_ViewRule_pdf = '/usr/bin/open'
  else
    inoremap <silent> <C-S> $$<ESC>i

    filetype plugin on
    filetype indent on
    set shellslash
    set grepprg=grep\ -nH\ $*

    let g:tex_flavor='latex'
    let g:Imap_UsePlaceHolders = 1
    let g:Imap_DeleteEmptyPlaceHolders = 1
    let g:Imap_StickyPlaceHolders = 0
    let g:Tex_DefaultTargetFormat = 'pdf'
    let g:Tex_FormatDependency_ps = 'dvi,ps'
    let g:Tex_FormatDependency_pdf = 'dvi,pdf'

    let g:Tex_CompileRule_pdf = 'ptex2pdf -u -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
    let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
    let g:Tex_CompileRule_dvi = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
    let g:Tex_BibtexFlavor = 'upbibtex'
    let g:Tex_MakeIndexFlavor = 'upmendex $*.idx'
    let g:Tex_UseEditorSettingInDVIViewer = 1
    let g:Tex_ViewRule_pdf = 'xdg-open'
  endif
endif
" }}}

" vimrc.local": {{{
if has('nvim')
  if filereadable(expand("~/.nvimrc.local"))
    source ~/.nvimrc.local
  endif
else
  if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
  endif
endif

if filereadable(".vimrc")
  source .vimrc
endif
" }}}

" plugin test": {{{
command! -bang -nargs=* PluginTest call PluginTest(<bang>0, <q-args>, 0)
command! -bang -nargs=* PluginTestNoPlugin call PluginTest(<bang>0, <q-args>, 1)
function! PluginTest(is_vim, extraCommand, no_plugin) abort
  let cmd = a:is_vim ? 'terminal env VIMRUNTIME= vim' : 'terminal nvim'
  let extraCommand = empty(a:extraCommand) ? '' : ' -c"au VimEnter * ' . a:extraCommand . '"'
  let plugintestrc = empty(findfile('.plugintest.vimrc', getcwd())) ? '' : ' -S .plugintest.vimrc'
  vnew
  if a:no_plugin
    execute $"silent {cmd} -u NONE -i NONE -N --cmd \"set rtp+={getcwd()}\" {plugintestrc} {extraCommand}"
  else
    execute $"silent {cmd} -u .plugintest.vimrc -i NONE -N --cmd \"set rtp+={getcwd()}\" {extraCommand}"
  endif
  startinsert
endfunction
" }}}
