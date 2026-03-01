-- フォーカス復帰・ターミナル終了時にファイルの外部変更を確認してリロード
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = vim.api.nvim_create_augroup('checktime', { clear = true }),
  callback = function()
    if vim.o.buftype ~= 'nofile' then vim.cmd 'checktime' end
  end,
})

-- ヤンク時にハイライト
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'ヤンク時にハイライト',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- ウィンドウリサイズ時に全タブの分割を均等化
vim.api.nvim_create_autocmd('VimResized', {
  group = vim.api.nvim_create_augroup('resize_splits', { clear = true }),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd 'tabdo wincmd ='
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- バッファを開いたとき前回の編集位置にカーソルを移動
vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('last_loc', { clear = true }),
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then return end
    vim.b[buf].last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
  end,
})

-- 補助バッファを q で閉じる
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('close_with_q', { clear = true }),
  pattern = {
    'PlenaryTestPopup',
    'checkhealth',
    'dbout',
    'gitsigns-blame',
    'grug-far',
    'help',
    'lspinfo',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd 'close'
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'バッファを閉じる',
      })
    end)
  end,
})

-- man ファイルをバッファリストから除外
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('man_unlisted', { clear = true }),
  pattern = { 'man' },
  callback = function(event) vim.bo[event.buf].buflisted = false end,
})

-- テキスト系ファイルタイプで折り返しとスペルチェックを有効化
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('wrap_spell', { clear = true }),
  pattern = { 'text', 'plaintex', 'typst', 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- JSON ファイルで conceallevel を 0 にして文字が隠れないようにする
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('json_conceal', { clear = true }),
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function() vim.opt_local.conceallevel = 0 end,
})

-- ファイル保存前に存在しない中間ディレクトリを自動作成
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('auto_create_dir', { clear = true }),
  callback = function(event)
    if event.match:match '^%w%w+:[/\\][/\\]' then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- ===========================================================================
-- LazyVim にない設定
-- ===========================================================================

-- カレントウィンドウのみ cursorline を表示
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
