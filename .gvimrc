colorscheme desert

gui
"set transparency=200	"半透明220が標準説
"
""".gvimrc カラー設定
"カラー設定した後にCursorIMを定義する方法
if has('multi_byte_ime') || has('gui_macvim')
  set iminsert=2
  set imsearch=2
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
  highlight Cursor guifg=NONE guibg=Green
  highlight CursorIM guifg=NONE guibg=Purple
endif
