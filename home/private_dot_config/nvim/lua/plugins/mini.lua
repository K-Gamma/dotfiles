return {
  {
    'nvim-mini/mini.nvim',
    config = function()
      -- アイコン (nvim-web-devicons の代替)
      require('mini.icons').setup()
      MiniIcons.mock_nvim_web_devicons()

      -- テキストオブジェクトの拡張 (va), yinq, ci' etc.)
      local ai = require 'mini.ai'
      ai.setup {
        n_lines = 500,
        custom_textobjects = {
          f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },
          c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' },
        },
      }

      -- テーブル・コードの整列 (ga, gA)
      require('mini.align').setup()

      -- 括弧・クォートの追加/削除/変更 (saiw), sd', sr)' etc.)
      require('mini.surround').setup {
        mappings = {
          add = { lhs = 'sa', desc = '囲みを追加 ([A]dd)' },
          delete = { lhs = 'sd', desc = '囲みを削除 ([D]elete)' },
          replace = { lhs = 'sr', desc = '囲みを変更 ([R]eplace)' },
          find = { lhs = 'sf', desc = '囲みを右検索 ([F]ind →)' },
          find_left = { lhs = 'sF', desc = '囲みを左検索 ([F]ind ←)' },
          highlight = { lhs = 'sh', desc = '囲みをハイライト ([H]ighlight)' },
          update_n_lines = { lhs = 'sn', desc = '検索行数を更新 ([N]_lines)' },
        },
      }
    end,
  },
}
