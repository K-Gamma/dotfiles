return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      animate = {},
      picker = {},
      explorer = {},
      terminal = {},
      dashboard = {},
      indent = {},
      toggle = {},
    },
    keys = {
      -- picker
      { '<leader>sh', function() Snacks.picker.help() end, desc = 'ヘルプ検索 ([H]elp)' },
      { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'キーマップ検索 ([K]eymaps)' },
      { '<leader>sf', function() Snacks.picker.files() end, desc = 'ファイル検索 ([F]iles)' },
      { '<leader>ss', function() Snacks.picker.pickers() end, desc = 'Picker 一覧 ([S]elect)' },
      { '<leader>sw', function() Snacks.picker.grep_word() end, desc = 'カーソル下の単語を検索 ([W]ord)', mode = { 'n', 'v' } },
      { '<leader>sg', function() Snacks.picker.grep() end, desc = 'Grep 検索 ([G]rep)' },
      { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = '診断検索 ([D]iagnostics)' },
      { '<leader>sr', function() Snacks.picker.resume() end, desc = '前回の検索を再開 ([R]esume)' },
      { '<leader>s.', function() Snacks.picker.recent() end, desc = '最近のファイル' },
      { '<leader>sc', function() Snacks.picker.commands() end, desc = 'コマンド検索 ([C]ommands)' },
      { '<leader><leader>', function() Snacks.picker.buffers() end, desc = 'バッファ一覧' },
      { '<leader>/', function() Snacks.picker.lines() end, desc = 'バッファ内検索' },
      { '<leader>s/', function() Snacks.picker.grep { buf = true } end, desc = '開いているファイル内を検索' },
      { '<leader>sn', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, desc = 'Neovim 設定ファイル検索 ([N]eovim)' },

      -- explorer
      { '<leader>e', function() Snacks.explorer() end, desc = 'ファイルエクスプローラ ([E]xplorer)' },

      -- terminal
      { '<C-/>', function() Snacks.terminal() end, desc = 'ターミナル切替', mode = { 'n', 't' } },
      { '<C-_>', function() Snacks.terminal() end, desc = 'which_key_ignore', mode = { 'n', 't' } },

      -- window
      { '<C-w>m', function() Snacks.toggle.zoom() end, desc = 'ズーム切替' },

      -- autoformat
      {
        '<leader>tf',
        function()
          Snacks.toggle({
            name = '自動フォーマット (グローバル)',
            get = function() return vim.g.autoformat ~= false end,
            set = function(state) vim.g.autoformat = state end,
          }):toggle()
        end,
        desc = '自動フォーマット切替 (グローバル) ([F]ormat)',
      },
      {
        '<leader>tF',
        function()
          Snacks.toggle({
            name = '自動フォーマット (バッファ)',
            get = function()
              if vim.b.autoformat == nil then return vim.g.autoformat ~= false end
              return vim.b.autoformat
            end,
            set = function(state) vim.b.autoformat = state end,
          }):toggle()
        end,
        desc = '自動フォーマット切替 (バッファ) ([F]ormat)',
      },
    },
  },
}
