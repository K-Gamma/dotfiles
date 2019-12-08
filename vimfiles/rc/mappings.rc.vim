" Key Mappings

" help: map-overview map-modes
"|---+---+---+---+---+---+---+---+---|
"|map| n | v | s | o | i | l | c | t |
"|---+---+---+---+---+---+---+---+---|
"| m | @ | @ | @ | @ |   |   |   |   |
"| n | @ |   |   |   |   |   |   |   |
"| v |   | @ | @ |   |   |   |   |   |
"| s |   |   | @ |   |   |   |   |   |
"| x |   | @ |   |   |   |   |   |   |
"| o |   |   |   | @ |   |   |   |   |
"| ! |   |   |   |   | @ |   | @ |   |
"| i |   |   |   |   | @ |   |   |   |
"| l |   |   |   |   | @ | @ | @ |   |
"| c |   |   |   |   |   |   | @ |   |
"| t |   |   |   |   |   |   |   | @ |
"|---+---+---+---+---+---+---+---+---|

" コロンとセミコロン入れ替え
noremap : ;
noremap ; :

" 保存/終了をスペースで
nnoremap <space>w  :<c-u>w<cr>
nnoremap <Space>W  :<C-u>wa<CR>
nnoremap <Space>q  :<C-u>q<CR>
"nnoremap <Space>Q  :<C-u>q!<CR>

" カーソルを表示行で移動する
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap <Down> gj
nnoremap <Up>   gk

" 行末までのヤンクにする
nnoremap Y y$

" インデント
nnoremap <silent> == gg=G''

" CTRL-hjklでウィンドウ間のカーソル移動
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" バッファの移動
nnoremap <C-p> :<C-u>bp<CR>
nnoremap <C-n> :<C-u>bn<CR>

" 行頭・行末までカーソル移動
nnoremap <S-h> g^
vnoremap <S-h> g^
nnoremap <S-l> g$
vnoremap <S-l> g$

" インクリメント・デクリメント
nnoremap + <C-a>
nnoremap - <C-x>

" その場でインクリメント・デクリメント
"nmap + <SID>(increment)
"nmap - <SID>(decrement)
"nmap <C-a> <SID>(increment)
"nmap <C-x> <SID>(decrement)
"nnoremap <silent> <SID>(increment)    :AddNumbers 1<CR>
"nnoremap <silent> <SID>(decrement)   :AddNumbers -1<CR>
"command! -range -nargs=1 AddNumbers
"      \ call vimrc#add_numbers((<line2>-<line1>+1) * eval(<args>))

" Esc2回押しでハイライト消去
nnoremap <silent> <ESC><ESC> :<C-u>noh<CR>

" 保存して閉じる, 保存せず閉じるを無効
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" EXモード無効
nnoremap Q <Nop>

" 入力中カーソルを移動
inoremap <C-f> <right>
inoremap <C-b> <left>

" 
inoremap <C-d> <Del>
imap <C-h> <BS>

" 検索時の / を簡単に
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'

" 単語境界を付与
cnoremap <C-o> <C-\>e(getcmdtype() == '/' <Bar><Bar> getcmdtype() == '?') ? '\<' . getcmdline() . '\>' : getcmdline()<CR>

" ファイルのあるディレクトリを %% で表示
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" ターミナルジョブモードからESCで戻る
tnoremap <ESC> <C-\><C-n>

" Use termianl key-binding in (i, c, t) mode {{{
noremap! <C-a> <Home>
tnoremap <C-a> <Home>

noremap! <C-b> <Left>
tnoremap <C-b> <Left>

noremap! <C-d> <Del>
tnoremap <C-d> <Del>

noremap! <C-e> <End>
tnoremap <C-e> <End>

noremap! <C-f> <Right>
tnoremap <C-f> <Right>

inoremap <M-b> <S-Left>
tnoremap <M-b> <S-Left>

noremap! <M-f> <S-Right>
tnoremap <M-f> <S-Right>

cnoremap <C-n> <Down>
tnoremap <C-n> <Down>

cnoremap <C-p> <Up>
tnoremap <C-p> <Up>
" }}}


" vim: fdm=marker
