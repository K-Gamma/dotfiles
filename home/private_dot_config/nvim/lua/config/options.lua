local opt = vim.opt

-- クリップボードの同期（SSH 接続時は OSC 52 の自動統合を妨げないよう無効化）
opt.clipboard = vim.env.SSH_CONNECTION and '' or 'unnamedplus'

-- 変更バッファを閉じる前に保存確認
opt.confirm = true

-- カーソル行のハイライト
opt.cursorline = true

-- 大文字小文字を区別しない検索
opt.ignorecase = true

-- 置換のプレビューをインライン表示（分割ウィンドウ）
opt.inccommand = 'split'

-- ジャンプ時に画面内の相対位置を維持
opt.jumpoptions = 'view'

-- 折り返しを単語の区切り位置で行う
opt.linebreak = true

-- 不可視文字を表示
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- マウス操作を有効化
opt.mouse = 'a'

-- 行番号の表示
opt.number = true

-- ポップアップの透過度
opt.pumblend = 10

-- ポップアップの最大表示件数
opt.pumheight = 10

-- 相対行番号の表示
opt.relativenumber = true

-- デフォルトのルーラーを非表示（ステータスラインに委ねる）
opt.ruler = false

-- スクロール時に上下に確保するコンテキスト行数
opt.scrolloff = 10

-- セッション保存の対象
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }

-- インデント量を shiftwidth の倍数に丸める
opt.shiftround = true

-- サインカラムを常に表示（テキストがずれないよう固定）
opt.signcolumn = 'yes'

-- 大文字を含む検索では大文字小文字を区別する
opt.smartcase = true

-- モード表示を非表示（ステータスラインに表示するため）
opt.showmode = false

-- スムーズスクロール（snacks.scroll の代わりに使用）
opt.smoothscroll = true

-- 新しいウィンドウを下に開く
opt.splitbelow = true

-- 分割時にカーソルの画面内位置を維持
opt.splitkeep = 'screen'

-- 新しいウィンドウを右に開く
opt.splitright = true

-- True color サポート
opt.termguicolors = true

-- キーシーケンスのタイムアウト（which-key を素早くトリガーするため短く設定）
opt.timeoutlen = 300

-- セッションをまたいだ Undo 履歴の保存
opt.undofile = true
opt.undolevels = 10000

-- スワップファイルの保存間隔と CursorHold のトリガー間隔
opt.updatetime = 200

-- ビジュアルブロックモードでテキストのない位置にもカーソルを移動可能にする
opt.virtualedit = 'block'

-- コマンドライン補完のモード（1回目は最長共通プレフィックス、以降は候補を順に選択）
opt.wildmode = 'longest:full,full'

-- ウィンドウの最小幅
opt.winminwidth = 5

-- LazyVim にない設定 --

-- 折り返し時にインデントを維持
opt.breakindent = true

-- エンコーディング（日本語ファイルの自動認識）
opt.fileencodings = { 'ucs-bom', 'iso-2022-jp-3', 'utf-8', 'euc-jp', 'cp932' }
