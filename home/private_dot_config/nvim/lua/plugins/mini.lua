return {
  {
    'nvim-mini/mini.nvim',
    config = function()
      -- テキストオブジェクトの拡張 (va), yinq, ci' etc.)
      require('mini.ai').setup { n_lines = 500 }

      -- 括弧・クォートの追加/削除/変更 (saiw), sd', sr)' etc.)
      require('mini.surround').setup()

      -- ステータスライン
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function() return '%2l:%-2v' end
    end,
  },
}
