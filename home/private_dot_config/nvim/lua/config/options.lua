local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = 'a'
opt.showmode = false

-- クリップボードの同期（起動時間への影響を避けるため遅延設定）
vim.schedule(function() opt.clipboard = 'unnamedplus' end)

opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = 'yes'
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.inccommand = 'split'
opt.cursorline = true
opt.scrolloff = 10
opt.confirm = true

-- 検索
opt.hlsearch = true
opt.incsearch = false
opt.wrapscan = true
opt.magic = true

-- エンコーディング
opt.fileencodings = { 'ucs-bom', 'iso-2022-jp-3', 'utf-8', 'euc-jp', 'cp932' }

-- ターミナル
opt.termguicolors = true
