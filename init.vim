" Package": {{{

let $MY_DEIN_TOML = '~/.config/nvim/dein.toml'
let $LOCAL_DEIN_TOML = '~/.config/nvim/dein.toml'

set runtimepath^=~/.cache/nvim/dein/repos/github.com/Shougo/dein.vim
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
nmap <silent> <ESC><ESC> :noh<CR>

""""""""""""quickrun""""""""""""""""""""""""""""""
let g:quickrun_config={'*': {'split': ''}}
set splitright
let g:quickrun_config = {'*': {'hook/time/enable': '1'},}

let g:quickrun_config['cuda'] = {
      \'command' : 'nvcc',
      \}
let g:quickrun_config['cpp'] = {
      \'command' : 'g++',
      \'cmdopt' : '-std=c++14',
      \}
"cjsxでcoffeeを処理する
let g:quickrun_config['coffee'] = {
      \'command' : 'cjsx',
      \'exec' : ['%c -cbp %s']
      \}
let g:quickrun_config['python'] = {
      \'command' : 'python'
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
    let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
    let g:Tex_CompileRule_dvi = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
    let g:Tex_BibtexFlavor = 'upbibtex'
    let g:Tex_MakeIndexFlavor = 'upmendex $*.idx'
    let g:Tex_UseEditorSettingInDVIViewer = 1
    let g:Tex_ViewRule_pdf = 'xdg-open'
  endif
endif

""""""""""""""""""""""""""""""
" set cursorline

""" statusline
set laststatus=2
set statusline+=%r "ReadOnly?
set statusline+=%y "ファイルタイプ表示
set statusline+=%f "ファイル名
set statusline+=%m "Modified?
set statusline+=%= "これより右詰め
set statusline+=[%P,%c]
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}] "文字コード表示


""" python
autocmd FileType python let b:did_ftplugin = 1

""" json
let g:vim_json_syntax_conceal = 0

""" neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

let g:neosnippet#snippets_directory='~/snippets/neosnippet'

imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

""" sonictemplate
let g:sonictemplate_vim_template_dir = [
      \ '~/git/template'
      \]

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
