-- ヤンク時にハイライト
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- カレントウィンドウのみ cursorline
local cursorline_group = vim.api.nvim_create_augroup('cursorline', { clear = true })
vim.api.nvim_create_autocmd('WinLeave', {
  group = cursorline_group,
  callback = function() vim.opt_local.cursorline = false end,
})
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufRead' }, {
  group = cursorline_group,
  callback = function() vim.opt_local.cursorline = true end,
})

-- ターミナル
local terminal_group = vim.api.nvim_create_augroup('terminal', { clear = true })
vim.api.nvim_create_autocmd('TermOpen', {
  group = terminal_group,
  callback = function() vim.opt_local.modifiable = true end,
})
vim.api.nvim_create_autocmd('TermClose', {
  group = terminal_group,
  command = 'buffer #',
})
