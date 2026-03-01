local map = vim.keymap.set

-- カーソル移動（カウント対応: count=0 のときだけ表示行単位で動く）
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = '下へ移動' })
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = '下へ移動' })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = '上へ移動' })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = '上へ移動' })

-- ウィンドウ移動
map('n', '<C-h>', '<C-w>h', { desc = '左のウィンドウへ移動', remap = true })
map('n', '<C-j>', '<C-w>j', { desc = '下のウィンドウへ移動', remap = true })
map('n', '<C-k>', '<C-w>k', { desc = '上のウィンドウへ移動', remap = true })
map('n', '<C-l>', '<C-w>l', { desc = '右のウィンドウへ移動', remap = true })

-- ウィンドウサイズ調整
map('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'ウィンドウの高さを増やす' })
map('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'ウィンドウの高さを減らす' })
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'ウィンドウの幅を減らす' })
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'ウィンドウの幅を増やす' })

-- 行を上下に移動
map('n', '<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = '行を下へ移動' })
map('n', '<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = '行を上へ移動' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = '行を下へ移動' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = '行を上へ移動' })
map('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = '行を下へ移動' })
map('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = '行を上へ移動' })

-- バッファ操作
map('n', '<leader>bb', '<cmd>e #<cr>', { desc = '直前のバッファへ切り替え' })
map('n', '<leader>`', '<cmd>e #<cr>', { desc = '直前のバッファへ切り替え' })
map('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = 'バッファを削除' })
map('n', '<leader>bo', function() Snacks.bufdelete.other() end, { desc = '他のバッファをすべて削除' })
map('n', '<leader>bD', '<cmd>:bd<cr>', { desc = 'バッファを削除してウィンドウも閉じる' })

-- ハイライト消去
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- 画面リフレッシュ（ハイライト消去 + diff 更新 + 再描画）
map('n', '<leader>ur', '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>', { desc = '画面リフレッシュ / ハイライト消去 / diff 更新' })

-- n/N を常に「次/前」方向に統一（検索方向によらず一貫した動作）
map('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = '次の検索結果' })
map({ 'x', 'o' }, 'n', "'Nn'[v:searchforward]", { expr = true, desc = '次の検索結果' })
map('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = '前の検索結果' })
map({ 'x', 'o' }, 'N', "'nN'[v:searchforward]", { expr = true, desc = '前の検索結果' })

-- アンドゥブレークポイント（これらの文字を入力するたびに undo の境界を作る）
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')
map('i', '、', '、<c-g>u')
map('i', '。', '。<c-g>u')

-- keywordprg（LSP に上書きされた K を強制実行）
map('n', '<leader>K', '<cmd>norm! K<cr>', { desc = 'Keywordprg を実行' })

-- インデント後に visual モードを維持
map('x', '<', '<gv', { desc = 'インデントを減らす' })
map('x', '>', '>gv', { desc = 'インデントを増やす' })

-- コメント行を追加（Neovim ビルトイン gc オペレーターを利用）
map('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'カーソル下にコメント行を追加' })
map('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'カーソル上にコメント行を追加' })

-- Lazy UI
map('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy を開く' })

-- 新規ファイルを作成
map('n', '<leader>fn', '<cmd>enew<cr>', { desc = '新規ファイルを作成' })

-- location list
map('n', '<leader>xl', function()
  local ok, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not ok and err then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = 'Location list をトグル' })

-- quickfix list
map('n', '[q', vim.cmd.cprev, { desc = '前の quickfix へ' })
map('n', ']q', vim.cmd.cnext, { desc = '次の quickfix へ' })
map('n', '<leader>xq', function()
  local ok, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not ok and err then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = 'Quickfix list をトグル' })

-- diagnostic
local diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump {
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
      float = true,
    }
  end
end
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = '行の診断を表示' })
map('n', ']d', diagnostic_goto(true), { desc = '次の診断へ' })
map('n', '[d', diagnostic_goto(false), { desc = '前の診断へ' })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = '次のエラーへ' })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = '前のエラーへ' })
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = '次の警告へ' })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = '前の警告へ' })

-- すべて終了
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'すべて終了' })

-- ウィンドウ分割
map('n', '<leader>-', '<C-W>s', { desc = 'ウィンドウを下に分割', remap = true })
map('n', '<leader>|', '<C-W>v', { desc = 'ウィンドウを右に分割', remap = true })

-- タブ操作
map('n', '<leader><tab>l', '<cmd>tablast<CR>', { desc = '最後のタブ' })
map('n', '<leader><tab>o', '<cmd>tabonly<CR>', { desc = '他のタブをすべて閉じる' })
map('n', '<leader><tab>f', '<cmd>tabfirst<CR>', { desc = '最初のタブ' })
map('n', '<leader><tab><tab>', '<cmd>tabnew<CR>', { desc = 'タブを新規作成' })
map('n', '<leader><tab>]', '<cmd>tabnext<CR>', { desc = '次のタブ' })
map('n', '<leader><tab>d', '<cmd>tabclose<CR>', { desc = 'タブを閉じる' })
map('n', '<leader><tab>[', '<cmd>tabprevious<CR>', { desc = '前のタブ' })

-- ===========================================================================
-- LazyVim にない設定
-- ===========================================================================

-- ターミナルモード終了
map('t', '<Esc>', '<C-\\><C-n>', { desc = 'ターミナルモード終了' })

-- 保存
map('n', '<leader>w', '<cmd>w<CR>', { desc = '保存' })
map('n', '<leader>W', '<cmd>wa<CR>', { desc = 'すべて保存' })

-- 誤操作防止（ZZ / ZQ / Q を無効化）
map('n', 'ZZ', '<Nop>')
map('n', 'ZQ', '<Nop>')
map('n', 'Q', '<Nop>')

-- Emacs-like bindings（insert / command）
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

-- Emacs-like bindings（terminal）
map('t', '<C-a>', '<Home>')
map('t', '<C-b>', '<Left>')
map('t', '<C-d>', '<Del>')
map('t', '<C-e>', '<End>')
map('t', '<C-f>', '<Right>')
map('t', '<M-b>', '<S-Left>')
map('t', '<M-f>', '<S-Right>')
map('t', '<C-n>', '<Down>')
map('t', '<C-p>', '<Up>')
