return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        always_show_bufferline = false,
        offsets = {
          { filetype = 'snacks_layout_box' },
        },
      },
    },
    keys = {
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = '前のバッファ' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = '次のバッファ' },
      { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = '前のバッファ' },
      { ']b', '<cmd>BufferLineCycleNext<cr>', desc = '次のバッファ' },
      { '[B', '<cmd>BufferLineMovePrev<cr>', desc = '前に移動' },
      { ']B', '<cmd>BufferLineMoveNext<cr>', desc = '後に移動' },
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'ピン留め切替 ([P]in)' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'ピン留め以外を閉じる ([P]inned)' },
      { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = '右のバッファを閉じる ([R]ight)' },
      { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = '左のバッファを閉じる ([L]eft)' },
    },
  },

  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'LspAttach',
    priority = 1000,
    opts = {},
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {},
  },

  { 'NMAC427/guess-indent.nvim', opts = {} },

  { 'brenoprata10/nvim-highlight-colors', opts = {} },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = require 'gitsigns'
        local map = require('util.keymap').buf_map(bufnr, 'Git')

        -- hunk ナビゲーション
        map('n', ']h', function() gs.nav_hunk 'next' end, '次の hunk')
        map('n', '[h', function() gs.nav_hunk 'prev' end, '前の hunk')

        -- hunk 操作
        map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk, 'hunk をステージ ([S]tage)')
        map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk, 'hunk をリセット ([R]eset)')
        map('n', '<leader>hu', gs.stage_hunk, 'ステージ取消 ([U]ndo)')
        map('n', '<leader>hp', gs.preview_hunk, 'hunk をプレビュー ([P]review)')
        map('n', '<leader>hb', function() gs.blame_line { full = true } end, 'blame 表示 ([B]lame)')
      end,
    },
  },

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { '<leader>b', group = 'バッファ ([B]uffer)' },
        { '<leader>s', group = '検索 ([S]earch)', mode = { 'n', 'v' } },
        { '<leader>t', group = '切替 ([T]oggle)' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>g', group = '[G]it' },
        { '<leader>q', group = 'セッション ([Q]uit)' },
        { 'gr', group = 'LSP 操作', mode = { 'n' } },
      },
    },
  },

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}
