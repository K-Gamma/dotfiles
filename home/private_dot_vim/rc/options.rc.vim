""" Options

" + ファイル {{{
set hidden
set autoread
" set browsedir=buffer

set nowritebackup
set nobackup
set backupdir-=.
set noswapfile
set directory-=.
" + }}}

" + 表示 {{{
set display=lastline
set number relativenumber
set modeline                    " モードラインを有効にする
set modelines=1                 " モードライン行数を設定
set list                        " 不可視文字を表示する
set listchars=tab:»-,trail:.,extends:»,precedes:«,nbsp:% ",eol:↲

if exists('+breakindent')
  set breakindent
  set wrap
else
  set nowrap
endif
set whichwrap=b,s,h,l,<,>,[,]       " カーソルを行頭、行末で止まらないようにする
set cursorline                  " カーソル行をハイライト
augroup MyAutoCmd               " カレントウィンドウにのみ罫線を引く
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END
highlight clear CursorLine
highlight CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black
" + }}}

" + 入力 {{{
set cindent                         " 詳細は-> ':help cinoptions-values'
set cinoptions+=:0,l1,g0
set smarttab expandtab
set tabstop=4 shiftwidth=0 softtabstop=-1
set backspace=indent,eol,start      " バックスペースを押した時の挙動
if has('nvim')                      " ヤンクをクリップボードにコピーする
  set clipboard=unnamed
else
  set clipboard=unnamed,autoselect
endif

set showmatch                       " 括弧の対応を表示する（対となる括弧に一瞬飛ぶ）
set matchtime=1                     " 括弧の対応を表示する時間
set completeopt=menuone             " 補完候補が1つでも表示
set pumheight=10                    " 補完メニューの高さ
set wildmenu                        " 入力コマンドの補完
set wildmode=longest:full,full      " 入力コマンドの補完オプション
set history=1000                    " 入力コマンドの履歴数

" ++ マウス {{{
if has('mouse')
  set mouse=a
  if has('nvim')
    " do nothing
  elseif has('mouse_sgr')
    set ttymouse=sgr
  elseif v:version > 703 || v:version is 703 && has('patch632')
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif
" ++ }}}
" + }}}

" + 検索 "{{{
set noincsearch " インクリメンタルサーチを行わない
set hlsearch    " 検索結果をハイライトする
set ignorecase  " 検索時に文字の大小を区別しない
set smartcase   " 検索時に大文字を含んでいたら大小を区別する
set wrapscan
set magic       " 正規表現使用時に magic モードにする
" + }}}

" vim: fdm=marker
