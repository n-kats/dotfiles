if &compatible
  set nocompatible
endif

set runtimepath^=/home/user/.config/nvim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('/home/user/.config/nvim/dein'))
call dein#add('Shougo/dein.vim')

call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')

call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler')
call dein#add('Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ })
call dein#add('Shougo/vimshell')
call dein#add('mattn/sonictemplate-vim')
call dein#add('thinca/vim-quickrun')
call dein#add('grep.vim')
call dein#add('majutsushi/tagbar')
"call dein#add('tomtom/tcomment_vim')
call dein#add('editorconfig/editorconfig-vim')

""" html
call dein#add('mattn/emmet-vim')
call dein#add('slim-template/vim-slim')

""" tex
call dein#add('vim-latex/vim-latex')

""" ruby
call dein#add('tpope/vim-rails')
call dein#add('tpope/vim-endwise')
"call dein#add('alpaca-tc/alpaca_tags')
"call dein#add('vim-scripts/ruby-matchit')

""" javascript
call dein#add('Yggdroot/indentLine')
call dein#add('leafgarland/typescript-vim')
call dein#add('jason0x43/vim-js-indent')
call dein#add('mxw/vim-jsx')

"call dein#add('claco/jasmine.vim')
"call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('kchmck/vim-coffee-script')
call dein#add('mtscout6/vim-cjsx')

""" scala
call dein#add('derekwyatt/vim-scala')

""" go
call dein#add('fatih/vim-go')
call dein#add('vim-jp/vim-go-extra')
call dein#add('scrooloose/syntastic')

""" python
call dein#add('nvie/vim-flake8')

""" coq
"call dein#add('jvoorhis/coq.vim')
"call dein#add('vim-scripts/CoqIDE', {
"      \ 'autoload' : {
"      \   'filetypes' : 'coq'
"      \ }})
"""

"""neovim plugins
if has('nvim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('zchee/deoplete-go', {'build': {'unix': 'make'}})
endif

"""local plugins
if has('nvim')
  if filereadable(expand("~/.nvimrc.plugin.local"))
    source ~/.nvimrc.plugin.local
  endif
else
  if filereadable(expand("~/.vimrc.plugin.local"))
    source ~/.vimrc.plugin.local
  endif
endif

call dein#end()

filetype plugin indent on
if dein#check_install()
  call dein#install()
endif


""" common

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

inoremap <silent> jj <ESC>

""" deoplete
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

""""""""""""""c++"""""""""""""""""""""""""""""""
set cindent
set cinoptions=g-1
""""""""""""""vim-latex"""""""""""""""""""""""""""""""""""""""
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

  endif
endif

""""""""""""""""""""""""""""""
set cursorline

""" statusline
set laststatus=2
set statusline+=%r "ReadOnly?
set statusline+=%y "ファイルタイプ表示
set statusline+=%f "ファイル名
set statusline+=%m "Modified?
set statusline+=%= "これより右詰め
set statusline+=[%P,%c]
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}] "文字コード表示


""" go
let g:syntastic_mode_map = { 'mode': 'passive',
    \ 'active_filetypes': ['go'] }
let g:syntastic_go_checkers = ['go', 'golint']

""" neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

""" vimshell
nnoremap <silent> ,is :VimShell<CR>
nnoremap <silent> ,irb :VimShellInteractive pry<CR>

""" vimfiler
nnoremap <leader>e :VimFilerExplore -split -winwidth=30 -find -no-quit<Cr>
let g:vimfiler_as_default_explorer=1
let g:vimfiler_ignore_pattern='\(^\.\|\~$\|\.pyc$\|\.[oad]$\)'

""" tagbar
nnoremap <leader>t :TagbarToggle<CR>

""" indentLine
let g:indentLine_fileTypeExclude = ['help']
set list lcs=tab:\|\ ""
let g:indentLine_color_term = 239

""" vimrc.local
if has('nvim')
  if filereadable(expand("~/.nvimrc.local"))
    source ~/.nvimrc.local
  endif
else
  if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
  endif
endif

""" Alt+{h,j,k,l}でウィンドウ移動
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

