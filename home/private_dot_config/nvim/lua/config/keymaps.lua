local map = vim.keymap.set

-- ハイライト消去
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- ターミナルモード終了
map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- ウィンドウ移動
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- ウィンドウ分割
map('n', '<leader>-', '<cmd>split<CR>', { desc = 'Split window below' })
map('n', '<leader>|', '<cmd>vsplit<CR>', { desc = 'Split window right' })

-- ウィンドウサイズ調整
map('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

-- タブ操作
map('n', '<leader><tab><tab>', '<cmd>tabnew<CR>', { desc = 'New Tab' })
map('n', '<leader><tab>d', '<cmd>tabclose<CR>', { desc = 'Close Tab' })

-- 保存/終了
map('n', '<Space>w', '<cmd>w<CR>', { desc = 'Save' })
map('n', '<Space>W', '<cmd>wa<CR>', { desc = 'Save all' })
map('n', '<Space>q', '<cmd>q<CR>', { desc = 'Quit' })

-- 表示行移動
map('n', 'j', 'gj')
map('n', 'k', 'gk')
map('n', '<Down>', 'gj')
map('n', '<Up>', 'gk')

-- 無効化
map('n', 'ZZ', '<Nop>')
map('n', 'ZQ', '<Nop>')
map('n', 'Q', '<Nop>')

-- Emacs-like bindings (insert + command)
local ic = { 'i', 'c' }
map(ic, '<C-a>', '<Home>')
map(ic, '<C-b>', '<Left>')
map(ic, '<C-d>', '<Del>')
map(ic, '<C-e>', '<End>')
map(ic, '<C-f>', '<Right>')
map(ic, '<M-f>', '<S-Right>')
map('i', '<C-h>', '<BS>')
map('i', '<M-b>', '<S-Left>')
map('c', '<C-n>', '<Down>')
map('c', '<C-p>', '<Up>')
map('c', '%%', function() return vim.fn.getcmdtype() == ':' and vim.fn.expand '%:h' .. '/' or '%%' end, { expr = true })

-- Emacs-like bindings (terminal)
map('t', '<C-a>', '<Home>')
map('t', '<C-b>', '<Left>')
map('t', '<C-d>', '<Del>')
map('t', '<C-e>', '<End>')
map('t', '<C-f>', '<Right>')
map('t', '<M-b>', '<S-Left>')
map('t', '<M-f>', '<S-Right>')
map('t', '<C-n>', '<Down>')
map('t', '<C-p>', '<Up>')
