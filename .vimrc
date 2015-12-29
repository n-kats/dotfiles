if has('nvim')
  if has('vim_starting')
    set runtimepath+=~/.config/nvim/bundle/neobundle.vim
  endif
  call neobundle#begin(expand('~/.config/nvim/bundle'))
else
  filetype plugin indent on
  set nocompatible  "Vi互換をオフ
  filetype plugin indent off
  if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
  endif
  call neobundle#begin(expand('~/.vim/bundle'))
endif

NeoBundleFetch 'Shougo/neobundle.vim'

""""""""""""""""
"list of plugin"
"""""""""""""""""
NeoBundle 'Shougo/unite.vim'

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'Shougo/vimshell'

NeoBundle 'mattn/sonictemplate-vim'

"NeoBundle 'Townk/vim-autoclose'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'vim-latex/vim-latex'
NeoBundle 'grep.vim'
NeoBundle 'slim-template/vim-slim'
"NeoBundle 'tyru/eskk.vim'
"NeoBundle 'fuenor/im_control.vim'
"NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
"NeoBundle 'alpaca-tc/alpaca_tags'

NeoBundle 'Yggdroot/indentLine'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'jason0x43/vim-js-indent'
NeoBundle 'mxw/vim-jsx'
""NeoBundle 'claco/jasmine.vim'
""NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'mtscout6/vim-cjsx'
NeoBundle 'majutsushi/tagbar'
""NeoBundle 'vim-scripts/ruby-matchit'
""NeoBundle 'tomtom/tcomment_vim'
"
NeoBundle 'derekwyatt/vim-scala'

NeoBundle 'fatih/vim-go'
NeoBundle 'vim-jp/vim-go-extra'
NeoBundle 'scrooloose/syntastic'

NeoBundle 'editorconfig/editorconfig-vim'

NeoBundle 'nvie/vim-flake8'
NeoBundle 'jvoorhis/coq.vim'
NeoBundleLazy 'vim-scripts/CoqIDE', {
      \ 'autoload' : {
      \   'filetypes' : 'coq'
      \ }}
"""

"""neovim plugins
if has('nvim')
  NeoBundle 'Shougo/deoplete.nvim'
endif

"""local plugins
if has('nvim')
  if filereadable(expand("~/.nvimrc.neobundle.local"))
    source ~/.nvimrc.neobundle.local
  endif
else
  if filereadable(expand("~/.vimrc.neobundle.local"))
    source ~/.vimrc.neobundle.local
  endif
endif

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

"""common""""""""""""""""""""""""""""""""

set notitle "「Vimを使ってくれてありがとう」を消す
set autoindent	"新しい行のインデントを現在行と同じにする
if has('nvim')
  set backupdir=$HOME/Documents/nvim/backup
  set directory=$HOME/Documents/nvim/swap
  set clipboard+=unnamedplus
else
  set backupdir=$HOME/Documents/vim/backup
  ""バックアップファイルを作るディレクトリ
  set directory=$HOME/Documents/vim/swap
  ""スワップファイル用のディレクトリ
  set clipboard=unnamed	"クリップボードを連携
endif
set number
set wildmenu 	" コマンドライン補完を便利に
set mouse=a 	" 全モードでマウスを有効化
set showmatch	" 括弧の対応をハイライト
set smarttab

"""""""""""""""""""""""""""""""""
"neocomplcache
""let
"g:neocomplcache_enable_at_startup = 2
"let
"g:neocomplcache_auto_completion_start_length
"= 3 ""補完しだす文字数
"
"
let g:deoplete#enable_at_startup = 1
""""""""""""quickrun""""""""""""""""""""""""""""""
let g:quickrun_config={'*': {'split': ''}}
set splitright
let g:quickrun_config = {'*': {'hook/time/enable': '1'},}

let g:quickrun_config['cpp'] = {
      \'command' : 'clang++',
      \'cmdopt' : '-std=c++14',
      \}
"cjsxでcoffeeを処理する
let g:quickrun_config['coffee'] = {
      \'command' : 'cjsx',
      \'exec' : ['%c -cbp %s']
      \}

"""""""""""""""""tagexplorer"""""""""""""""""""""""""""""""""""

set tags=./tags


""""""""""""""""netrwの文句"""""""""""""""""""""
let g:netrw_localcopycmd=''

""""""""""""""c++"""""""""""""""""""""""""""""""
set cindent
set cinoptions=g-1
""""""""""""""vim-latex"""""""""""""""""""""""""""""""""""""""
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
    filetype plugin on
    filetype indent on
    "set shellslash		""削ったけど大丈夫かな？
    set grepprg=grep\ -nH\ $*

    let g:tex_flavor='latex'
    let g:Imap_UsePlaceHolders = 1
    let g:Imap_DeleteEmptyPlaceHolders = 1
    let g:Imap_StickyPlaceHolders = 0
    let g:Tex_DefaultTargetFormat = 'pdf'
    let g:Tex_FormatDependency_ps = 'dvi,ps'
    let g:Tex_FormatDependency_pdf = 'dvi,pdf'

    let g:Tex_CompileRule_pdf = 'ptex2pdf -u -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
    "let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
    "let g:Tex_CompileRule_pdf = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
    "let g:Tex_CompileRule_pdf = 'luajitlatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
    "let g:Tex_CompileRule_pdf = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
    "let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps'
    let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
    let g:Tex_CompileRule_dvi = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
    let g:Tex_BibtexFlavor = 'upbibtex'
    let g:Tex_MakeIndexFlavor = 'upmendex $*.idx'
    let g:Tex_UseEditorSettingInDVIViewer = 1
    let g:Tex_ViewRule_pdf = 'xdg-open'

    "let g:Tex_CompileRule_dvi = 'platex -kanji=sjis -guess-input-enc -synctex=1 -interaction=nonstopmode $*'
    "let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
    "let g:Tex_CompileRule_pdf = 'dvipdfmx $*.dvi'
    "let g:Tex_BibtexFlavor = 'pbibtex -kanji=sjis'
    "let g:Tex_MakeIndexFlavor = 'mendex -U $*.idx'

    set noshellslash
  endif
endif

""""""""""""""""""""""""""""""
set laststatus=2
"set list
"set listchars=tab:>.,eol:↲,extends:>,precedes:<,nbsp:%
set cursorline

"文字コード表示
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]
""ファイルタイプ表示
set statusline+=%y

"""
let IM_CtrlMode = 4
inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>

"""go
if $GOROOT != ''
  set rtp += $GOROOT/misc/vim
endif

let g:syntastic_mode_map = { 'mode': 'passive',
    \ 'active_filetypes': ['go'] }
let g:syntastic_go_checkers = ['go', 'golint']

"""vimshell
nnoremap <silent> ,is :VimShell<CR>
nnoremap <silent> ,irb :VimShellInteractive pry<CR>

"""vimfiler
nnoremap <leader>e :VimFilerExplore -split -winwidth=30 -find -no-quit<Cr>
let g:vimfiler_as_default_explorer=1
let g:vimfiler_ignore_pattern='\(^\.\|\~$\|\.pyc$\|\.[oad]$\)'

"""indentLine
let g:indentLine_fileTypeExclude = ['help', 'nerdtree']
set list lcs=tab:\|\ ""
let g:indentLine_color_term = 239

"""vimrc.local
if has('nvim')
  if filereadable(expand("~/.nvimrc.local"))
    source ~/.nvimrc.local
  endif
else
  if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
  endif
endif

if has('nvim')
  tnoremap <ESC> <C-\><C-n>
  syntax on
endif

