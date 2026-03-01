return {
  {
    'sindrets/diffview.nvim',
    cmd = {
      'DiffviewOpen',
      'DiffviewClose',
      'DiffviewToggleFiles',
      'DiffviewFocusFiles',
      'DiffviewFileHistory',
    },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<CR>', desc = '差分ビュー ([D]iff)' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', desc = 'ファイル履歴: 現在 ([H]istory)' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<CR>', desc = 'ファイル履歴: リポジトリ ([H]istory)' },
      { '<leader>gc', '<cmd>DiffviewClose<CR>', desc = '差分ビューを閉じる ([C]lose)' },
    },
  },
}
