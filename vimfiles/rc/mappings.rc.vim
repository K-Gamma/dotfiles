"-----------------------------------------------------------------------------------------------"
"     command     |  normal  | insert |  command line  | visual | select | waiting computation |
" map  / noremap  |    @     |        |                |   @    |   @    |          @          |
" nmap / nnoremap |    @     |        |                |        |        |                     |
" vmap / vnoremap |          |        |                |   @    |   @    |                     |
" omap / onoremap |          |        |                |        |        |          @          |
" xmap / xnoremap |          |        |                |   @    |        |                     |
" smap / snoremap |          |        |                |        |   @    |                     |
" map! / noremap! |          |   @    |       @        |        |        |                     |
" imap / inoremap |          |   @    |                |        |        |                     |
" cmap / cnoremap |          |        |       @        |        |        |                     |
"-----------------------------------------------------------------------------------------------"

" コロンとセミコロン入れ替え
noremap : ;
noremap ; :

" 保存/終了をスペースで
nnoremap <Space>w  :<C-u>w<CR>
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

" 行頭までカーソル移動
nnoremap <S-h> ^

" 行末までカーソル移動
nnoremap <S-l> $

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

" Escの2回押しでハイライト消去
nnoremap <silent> <ESC><ESC> :<C-u>noh<CR>

" 保存して閉じる, 保存せず閉じるを無効
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" EXモード無効
nnoremap Q <Nop>

" 入力中カーソルを移動
inoremap <C-f> <right>
inoremap <C-b> <left>

" 隣接した{}で改行したらインデント
inoremap {<CR> {}<Left><CR><Esc><S-o>
inoremap [<CR> []<Left><CR><Esc><S-o>
inoremap (<CR> ()<Left><CR><Esc><S-o>
