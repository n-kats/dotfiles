filetype plugin indent on
set nocompatible  "Vi互換をオフ
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#begin(expand('~/.vim/bundle'))
endif

NeoBundleFetch 'Shougo/neobundle.vim'

""""""""""""""""
"list of plugin"
"""""""""""""""""
NeoBundle 'Shougo/unite.vim'

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'

"NeoBundle 'Townk/vim-autoclose'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex'
NeoBundle 'grep.vim'
NeoBundle 'slim-template/vim-slim'
"NeoBundle 'tyru/eskk.vim'
"NeoBundle 'fuenor/im_control.vim'
"NeoBundle 'Shougo/neocomplcache.vim'
"NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
"NeoBundle 'alpaca-tc/alpaca_tags'

NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'jason0x43/vim-js-indent'
""NeoBundle 'claco/jasmine.vim'
""NeoBundle 'nathanaelkane/vim-indent-guides'
""NeoBundle 'vim-scripts/ruby-matchit'
""NeoBundle 'tomtom/tcomment_vim'
"
NeoBundle 'derekwyatt/vim-scala'

NeoBundle 'fatih/vim-go'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'editorconfig/editorconfig-vim'
"""

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

"""common""""""""""""""""""""""""""""""""


set autoindent	"新しい行のインデントを現在行と同じにする
set backupdir=~/Documents/vim/backup
""バックアップファイルを作るディレクトリ
set directory=~/Documents/vim/swap
""スワップファイル用のディレクトリ
set clipboard=unnamed	"クリップボードを連携
set number
set wildmenu 	" コマンドライン補完を便利に
set mouse=a 	" 全モードでマウスを有効化
set showmatch	" 括弧の対応をハイライト
set smarttab

if expand("%:e") == "rb" || expand("%:e") == "erb" || expand("%:e") == "haml" || expand("%:e") == "slim" || expand("%:e") == "yml" || expand("%:e") == "jade" || expand("%:e") == "js"
  set tabstop=2
  set shiftwidth=2
  set expandtab
else
  set tabstop=4	" タブを表示するときの幅
  set shiftwidth=4	" タブを挿入するときの幅
  set noexpandtab	" タブをタブとして扱う(スペースに展開しない)
endif

"""""""""""""""""""""""""""""""""
"neocomplcache
""let
"g:neocomplcache_enable_at_startup = 2
"let
"g:neocomplcache_auto_completion_start_length
"= 3 ""補完しだす文字数
"
"
"
""""""""""""quickrun""""""""""""""""""""""""""""""
let g:quickrun_config={'*': {'split': ''}}
set splitright
let g:quickrun_config = {'*': {'hook/time/enable': '1'},}

let g:quickrun_config['coffee'] = {
      \'command' : 'coffee',
      \'exec' : ['%c -cbp %s']
      \}

"""""""""""""""""tagexplorer"""""""""""""""""""""""""""""""""""

:set tags=tags


""""""""""""""""netrwの文句"""""""""""""""""""""
let g:netrw_localcopycmd=''

"""coffeescript
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et

"使い方
""makeでコンパイル
""""""""""""""vim-latex"""""""""""""""""""""""""""""""""""""""
if expand("%:e") == "tex"
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
endif

""""""""""""""""""""""""""""""
set list
set listchars=tab:>.,eol:↲,extends:>,precedes:<,nbsp:%
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
